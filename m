From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 14/19] Support cached application models in a Config
Date: Sat, 25 Jul 2009 11:52:57 -0700
Message-ID: <1248547982-4003-15-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
 <1248547982-4003-7-git-send-email-spearce@spearce.org>
 <1248547982-4003-8-git-send-email-spearce@spearce.org>
 <1248547982-4003-9-git-send-email-spearce@spearce.org>
 <1248547982-4003-10-git-send-email-spearce@spearce.org>
 <1248547982-4003-11-git-send-email-spearce@spearce.org>
 <1248547982-4003-12-git-send-email-spearce@spearce.org>
 <1248547982-4003-13-git-send-email-spearce@spearce.org>
 <1248547982-4003-14-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmOA-0002ZF-4R
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbZGYSxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbZGYSxh
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:37 -0400
Received: from george.spearce.org ([209.20.77.23]:35575 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbZGYSxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:12 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4AC1A381FE; Sat, 25 Jul 2009 18:53:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3A97638200;
	Sat, 25 Jul 2009 18:53:07 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-14-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124047>

The Config.SectionParser acts as a key into a cache of model object
instances, but also knows how to create its model instance if the
cache does not contain the corresponding instance.

Because we don't keep track of which keys were accessed by a parser
when it created its model, we discard the entire cache anytime any
key is modified, forcing all models to reparse on the next access.

Both CoreConfig and TransferConfig are trivial to switch to this
method of access, although the typical get path is quite a bit longer
as we now need to do a hash lookup instead of a getfield instruction.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../src/org/spearce/jgit/lib/Config.java           |   92 +++++++++++++++++++-
 .../src/org/spearce/jgit/lib/CoreConfig.java       |   16 +++-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   20 +----
 .../src/org/spearce/jgit/lib/TransferConfig.java   |   11 ++-
 4 files changed, 112 insertions(+), 27 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 4d4b315..6036c4c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -45,7 +45,9 @@
 import java.util.Collections;
 import java.util.HashSet;
 import java.util.List;
+import java.util.Map;
 import java.util.Set;
+import java.util.concurrent.ConcurrentHashMap;
 import java.util.concurrent.atomic.AtomicReference;
 
 import org.spearce.jgit.errors.ConfigInvalidException;
@@ -375,6 +377,43 @@ public String getString(final String section, String subsection,
 		return result;
 	}
 
+	/**
+	 * Obtain a handle to a parsed set of configuration values.
+	 *
+	 * @param <T>
+	 *            type of configuration model to return.
+	 * @param parser
+	 *            parser which can create the model if it is not already
+	 *            available in this configuration file. The parser is also used
+	 *            as the key into a cache and must obey the hashCode and equals
+	 *            contract in order to reuse a parsed model.
+	 * @return the parsed object instance, which is cached inside this config.
+	 */
+	@SuppressWarnings("unchecked")
+	public <T> T get(final SectionParser<T> parser) {
+		final State myState = getState();
+		T obj = (T) myState.cache.get(parser);
+		if (obj == null) {
+			obj = parser.parse(this);
+			myState.cache.put(parser, obj);
+		}
+		return obj;
+	}
+
+	/**
+	 * Remove a cached configuration object.
+	 * <p>
+	 * If the associated configuration object has not yet been cached, this
+	 * method has no effect.
+	 *
+	 * @param parser
+	 *            parser used to obtain the configuration object.
+	 * @see #get(SectionParser)
+	 */
+	public void uncache(final SectionParser<?> parser) {
+		state.get().cache.remove(parser);
+	}
+
 	private String getRawString(final String section, final String subsection,
 			final String name) {
 		final List<String> lst = getRawStringList(section, subsection, name);
@@ -409,6 +448,22 @@ else if (baseConfig != null)
 		return curr;
 	}
 
+	private State getState() {
+		State cur, upd;
+		do {
+			cur = state.get();
+			final State base = getBaseState();
+			if (cur.baseState == base)
+				return cur;
+			upd = new State(cur.entryList, base);
+		} while (!state.compareAndSet(cur, upd));
+		return upd;
+	}
+
+	private State getBaseState() {
+		return baseConfig != null ? baseConfig.getState() : null;
+	}
+
 	/**
 	 * Add or modify a configuration value. The parameters will result in a
 	 * configuration entry like this.
@@ -757,11 +812,11 @@ public void fromText(final String text) throws ConfigInvalidException {
 	}
 
 	private State newState() {
-		return new State(Collections.<Entry> emptyList());
+		return new State(Collections.<Entry> emptyList(), getBaseState());
 	}
 
 	private State newState(final List<Entry> entries) {
-		return new State(Collections.unmodifiableList(entries));
+		return new State(Collections.unmodifiableList(entries), getBaseState());
 	}
 
 	/**
@@ -933,11 +988,42 @@ private static String readValue(final StringReader in, boolean quote,
 		return value.length() > 0 ? value.toString() : null;
 	}
 
+	/**
+	 * Parses a section of the configuration into an application model object.
+	 * <p>
+	 * Instances must implement hashCode and equals such that model objects can
+	 * be cached by using the {@code SectionParser} as a key of a HashMap.
+	 * <p>
+	 * As the {@code SectionParser} itself is used as the key of the internal
+	 * HashMap applications should be careful to ensure the SectionParser key
+	 * does not retain unnecessary application state which may cause memory to
+	 * be held longer than expected.
+	 *
+	 * @param <T>
+	 *            type of the application model created by the parser.
+	 */
+	public static interface SectionParser<T> {
+		/**
+		 * Create a model object from a configuration.
+		 *
+		 * @param cfg
+		 *            the configuration to read values from.
+		 * @return the application model instance.
+		 */
+		T parse(Config cfg);
+	}
+
 	private static class State {
 		final List<Entry> entryList;
 
-		State(List<Entry> entries) {
+		final Map<Object, Object> cache;
+
+		final State baseState;
+
+		State(List<Entry> entries, State base) {
 			entryList = entries;
+			cache = new ConcurrentHashMap<Object, Object>(16, 0.75f, 1);
+			baseState = base;
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
index e98e0bc..ed3827b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/CoreConfig.java
@@ -38,22 +38,28 @@
 
 package org.spearce.jgit.lib;
 
-import java.util.zip.Deflater;
+import static java.util.zip.Deflater.DEFAULT_COMPRESSION;
+
+import org.spearce.jgit.lib.Config.SectionParser;
 
 /**
  * This class keeps git repository core parameters.
  */
 public class CoreConfig {
-	private static final int DEFAULT_COMPRESSION = Deflater.DEFAULT_COMPRESSION;
-	private static final int DEFAULT_INDEXVERSION = 2;
+	/** Key for {@link Config#get(SectionParser)}. */
+	public static final Config.SectionParser<CoreConfig> KEY = new SectionParser<CoreConfig>() {
+		public CoreConfig parse(final Config cfg) {
+			return new CoreConfig(cfg);
+		}
+	};
 
 	private final int compression;
 
 	private final int packIndexVersion;
 
-	CoreConfig(final RepositoryConfig rc) {
+	private CoreConfig(final Config rc) {
 		compression = rc.getInt("core", "compression", DEFAULT_COMPRESSION);
-		packIndexVersion = rc.getInt("pack", "indexversion", DEFAULT_INDEXVERSION);
+		packIndexVersion = rc.getInt("pack", "indexversion", 2);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index fb97747..c6a13b6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -42,9 +42,7 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
-import java.io.IOException;
 
-import org.spearce.jgit.errors.ConfigInvalidException;
 import org.spearce.jgit.util.SystemReader;
 
 /**
@@ -57,10 +55,6 @@
 	/** Section name for a branch configuration. */
 	public static final String BRANCH_SECTION = "branch";
 
-	CoreConfig core;
-
-	TransferConfig transfer;
-
 	/**
 	 * Create a Git configuration file reader/writer/cache for a specific file.
 	 *
@@ -79,14 +73,14 @@ public RepositoryConfig(final Config base, final File cfgLocation) {
 	 * @return Core configuration values
 	 */
 	public CoreConfig getCore() {
-		return core;
+		return get(CoreConfig.KEY);
 	}
 
 	/**
 	 * @return transfer, fetch and receive configuration values
 	 */
 	public TransferConfig getTransfer() {
-		return transfer;
+		return get(TransferConfig.KEY);
 	}
 
 	/**
@@ -175,15 +169,5 @@ public void create() {
 		clear();
 		setInt("core", null, "repositoryformatversion", 0);
 		setBoolean("core", null, "filemode", true);
-
-		core = new CoreConfig(this);
-		transfer = new TransferConfig(this);
-	}
-
-	@Override
-	public void load() throws IOException, ConfigInvalidException {
-		super.load();
-		core = new CoreConfig(this);
-		transfer = new TransferConfig(this);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java
index ff3a5eb..8760103 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java
@@ -37,13 +37,22 @@
 
 package org.spearce.jgit.lib;
 
+import org.spearce.jgit.lib.Config.SectionParser;
+
 /**
  * The standard "transfer", "fetch" and "receive" configuration parameters.
  */
 public class TransferConfig {
+	/** Key for {@link Config#get(SectionParser)}. */
+	public static final Config.SectionParser<TransferConfig> KEY = new SectionParser<TransferConfig>() {
+		public TransferConfig parse(final Config cfg) {
+			return new TransferConfig(cfg);
+		}
+	};
+
 	private final boolean fsckObjects;
 
-	TransferConfig(final RepositoryConfig rc) {
+	private TransferConfig(final Config rc) {
 		fsckObjects = rc.getBoolean("receive", "fsckobjects", false);
 	}
 
-- 
1.6.4.rc2.216.g769fa
