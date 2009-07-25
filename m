From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 13/19] Make Config thread safe by using copy-on-write semantics
Date: Sat, 25 Jul 2009 11:52:56 -0700
Message-ID: <1248547982-4003-14-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO9-0002ZF-Bx
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbZGYSxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbZGYSxi
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:38 -0400
Received: from george.spearce.org ([209.20.77.23]:35578 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZGYSxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:12 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 82BF738221; Sat, 25 Jul 2009 18:53:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id ECB18381FE;
	Sat, 25 Jul 2009 18:53:06 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-13-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124046>

It is relatively rare that the Config instance is modified from
application code.  When it is, we usually are working on a small
set of values read from .git/config or ~/.gitconfig.  Making the
class thread-safe through basic copy-on-write semantics for its
inner collection of entries simplifies the locking and permits us
to optimize for the much more common read path.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   85 +++++++++++++++++---
 1 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index f4e78f3..4d4b315 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -46,6 +46,7 @@
 import java.util.HashSet;
 import java.util.List;
 import java.util.Set;
+import java.util.concurrent.atomic.AtomicReference;
 
 import org.spearce.jgit.errors.ConfigInvalidException;
 import org.spearce.jgit.util.StringUtils;
@@ -60,9 +61,15 @@
 	private static final long MiB = 1024 * KiB;
 	private static final long GiB = 1024 * MiB;
 
-	private List<Entry> entries;
+	/**
+	 * Immutable current state of the configuration data.
+	 * <p>
+	 * This state is copy-on-write. It should always contain an immutable list
+	 * of the configuration keys/values.
+	 */
+	private final AtomicReference<State> state;
 
-	final Config baseConfig;
+	private final Config baseConfig;
 
 	/**
 	 * Magic value indicating a missing entry.
@@ -87,7 +94,7 @@ public Config() {
 	 */
 	public Config(Config defaultConfig) {
 		baseConfig = defaultConfig;
-		clear();
+		state = new AtomicReference<State>(newState());
 	}
 
 	/**
@@ -358,7 +365,7 @@ public String getString(final String section, String subsection,
 	 */
 	public Set<String> getSubsections(final String section) {
 		final Set<String> result = new HashSet<String>();
-		for (final Entry e : entries) {
+		for (final Entry e : state.get().entryList) {
 			if (StringUtils.equalsIgnoreCase(section, e.section)
 					&& e.subsection != null)
 				result.add(e.subsection);
@@ -382,7 +389,7 @@ else if (baseConfig != null)
 	private List<String> getRawStringList(final String section,
 			final String subsection, final String name) {
 		List<String> r = null;
-		for (final Entry e : entries) {
+		for (final Entry e : state.get().entryList) {
 			if (e.match(section, subsection, name))
 				r = add(r, e.value);
 		}
@@ -541,6 +548,17 @@ public void unset(final String section, final String subsection,
 	 */
 	public void setStringList(final String section, final String subsection,
 			final String name, final List<String> values) {
+		State src, res;
+		do {
+			src = state.get();
+			res = replaceStringList(src, section, subsection, name, values);
+		} while (!state.compareAndSet(src, res));
+	}
+
+	private State replaceStringList(final State srcState,
+			final String section, final String subsection, final String name,
+			final List<String> values) {
+		final List<Entry> entries = copy(srcState, values);
 		int entryIndex = 0;
 		int valueIndex = 0;
 		int insertPosition = -1;
@@ -548,11 +566,12 @@ public void setStringList(final String section, final String subsection,
 		// Reset the first n Entry objects that match this input name.
 		//
 		while (entryIndex < entries.size() && valueIndex < values.size()) {
-			final Entry e = entries.get(entryIndex++);
+			final Entry e = entries.get(entryIndex);
 			if (e.match(section, subsection, name)) {
-				e.value = values.get(valueIndex++);
-				insertPosition = entryIndex;
+				entries.set(entryIndex, e.forValue(values.get(valueIndex++)));
+				insertPosition = entryIndex + 1;
 			}
+			entryIndex++;
 		}
 
 		// Remove any extra Entry objects that we no longer need.
@@ -573,7 +592,7 @@ public void setStringList(final String section, final String subsection,
 				// is already a section available that matches. Insert
 				// after the last key of that section.
 				//
-				insertPosition = findSectionEnd(section, subsection);
+				insertPosition = findSectionEnd(entries, section, subsection);
 			}
 			if (insertPosition < 0) {
 				// We didn't find any matching section header for this key,
@@ -594,9 +613,22 @@ public void setStringList(final String section, final String subsection,
 				entries.add(insertPosition++, e);
 			}
 		}
+
+		return newState(entries);
+	}
+
+	private static List<Entry> copy(final State src, final List<String> values) {
+		// At worst we need to insert 1 line for each value, plus 1 line
+		// for a new section header. Assume that and allocate the space.
+		//
+		final int max = src.entryList.size() + values.size() + 1;
+		final ArrayList<Entry> r = new ArrayList<Entry>(max);
+		r.addAll(src.entryList);
+		return r;
 	}
 
-	private int findSectionEnd(final String section, final String subsection) {
+	private static int findSectionEnd(final List<Entry> entries,
+			final String section, final String subsection) {
 		for (int i = 0; i < entries.size(); i++) {
 			Entry e = entries.get(i);
 			if (e.match(section, subsection, null)) {
@@ -619,7 +651,7 @@ private int findSectionEnd(final String section, final String subsection) {
 	 */
 	public String toText() {
 		final StringBuilder out = new StringBuilder();
-		for (final Entry e : entries) {
+		for (final Entry e : state.get().entryList) {
 			if (e.prefix != null)
 				out.append(e.prefix);			
 			if (e.section != null && e.name == null) {
@@ -721,14 +753,22 @@ public void fromText(final String text) throws ConfigInvalidException {
 				throw new ConfigInvalidException("Invalid line in config file");
 		}
 
-		entries = newEntries;
+		state.set(newState(newEntries));
+	}
+
+	private State newState() {
+		return new State(Collections.<Entry> emptyList());
+	}
+
+	private State newState(final List<Entry> entries) {
+		return new State(Collections.unmodifiableList(entries));
 	}
 
 	/**
 	 * Clear the configuration file
 	 */
 	protected void clear() {
-		entries = new ArrayList<Entry>();
+		state.set(newState());
 	}
 
 	private static String readSectionName(final StringReader in)
@@ -893,6 +933,14 @@ private static String readValue(final StringReader in, boolean quote,
 		return value.length() > 0 ? value.toString() : null;
 	}
 
+	private static class State {
+		final List<Entry> entryList;
+
+		State(List<Entry> entries) {
+			entryList = entries;
+		}
+	}
+
 	/**
 	 * The configuration file entry
 	 */
@@ -927,6 +975,17 @@ private static String readValue(final StringReader in, boolean quote,
 		 */
 		String suffix;
 
+		Entry forValue(final String newValue) {
+			final Entry e = new Entry();
+			e.prefix = prefix;
+			e.section = section;
+			e.subsection = subsection;
+			e.name = name;
+			e.value = newValue;
+			e.suffix = suffix;
+			return e;
+		}
+
 		boolean match(final String aSection, final String aSubsection,
 				final String aKey) {
 			return eqIgnoreCase(section, aSection)
-- 
1.6.4.rc2.216.g769fa
