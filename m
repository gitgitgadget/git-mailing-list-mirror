From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 18/19] Use Config SectionParser cache to store daemon enable states
Date: Sat, 25 Jul 2009 11:53:01 -0700
Message-ID: <1248547982-4003-19-git-send-email-spearce@spearce.org>
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
 <1248547982-4003-15-git-send-email-spearce@spearce.org>
 <1248547982-4003-16-git-send-email-spearce@spearce.org>
 <1248547982-4003-17-git-send-email-spearce@spearce.org>
 <1248547982-4003-18-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmOE-0002ZF-0u
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZGYSxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbZGYSxo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:44 -0400
Received: from george.spearce.org ([209.20.77.23]:35575 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZGYSxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9DBAE381FF; Sat, 25 Jul 2009 18:53:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 99AF538239;
	Sat, 25 Jul 2009 18:53:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-18-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124053>

Rather than looking up the boolean each time we start a new connection
in a repository we now cache it in the configuration cache under a key
that is unique to the daemon service.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/DaemonService.java  |   30 ++++++++++++++++----
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
index 817aeee..b7198c7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
@@ -39,13 +39,15 @@
 
 import java.io.IOException;
 
+import org.spearce.jgit.lib.Config;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Config.SectionParser;
 
 /** A service exposed by {@link Daemon} over anonymous <code>git://</code>. */
 public abstract class DaemonService {
 	private final String command;
 
-	private final String config;
+	private final SectionParser<ServiceConfig> configKey;
 
 	private boolean enabled;
 
@@ -53,10 +55,23 @@
 
 	DaemonService(final String cmdName, final String cfgName) {
 		command = cmdName.startsWith("git-") ? cmdName : "git-" + cmdName;
-		config = cfgName;
+		configKey = new SectionParser<ServiceConfig>() {
+			public ServiceConfig parse(final Config cfg) {
+				return new ServiceConfig(DaemonService.this, cfg, cfgName);
+			}
+		};
 		overridable = true;
 	}
 
+	private static class ServiceConfig {
+		final boolean enabled;
+
+		ServiceConfig(final DaemonService service, final Config cfg,
+				final String name) {
+			enabled = cfg.getBoolean("daemon", name, service.isEnabled());
+		}
+	}
+
 	/** @return is this service enabled for invocation? */
 	public boolean isEnabled() {
 		return enabled;
@@ -109,16 +124,19 @@ void execute(final DaemonClient client, final String commandLine)
 		if (db == null)
 			return;
 		try {
-			boolean on = isEnabled();
-			if (isOverridable())
-				on = db.getConfig().getBoolean("daemon", config, on);
-			if (on)
+			if (isEnabledFor(db))
 				execute(client, db);
 		} finally {
 			db.close();
 		}
 	}
 
+	private boolean isEnabledFor(final Repository db) {
+		if (isOverridable())
+			return db.getConfig().get(configKey).enabled;
+		return isEnabled();
+	}
+
 	abstract void execute(DaemonClient client, Repository db)
 			throws IOException;
 }
-- 
1.6.4.rc2.216.g769fa
