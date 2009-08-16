From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 1/2] Add time and timezone to SystemReader properties
Date: Sun, 16 Aug 2009 23:36:51 +0200
Message-ID: <1250458612-21095-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 16 23:37:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McnPZ-0004jt-BJ
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 23:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146AbZHPVg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 17:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755960AbZHPVgz
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 17:36:55 -0400
Received: from mail.dewire.com ([83.140.172.130]:12997 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755896AbZHPVgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 17:36:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BA6951434E97;
	Sun, 16 Aug 2009 23:36:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUybJEFWwE7I; Sun, 16 Aug 2009 23:36:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D437680280F;
	Sun, 16 Aug 2009 23:36:53 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.115.gc0eb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126081>

Having an uncontrollable variable time and timezone is
inconvenient for unit testing.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/MockSystemReader.java |   11 ++++++++++
 .../src/org/spearce/jgit/lib/PersonIdent.java      |    6 +++-
 .../src/org/spearce/jgit/util/SystemReader.java    |   22 ++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
index 7a65f99..e51df7e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
@@ -39,6 +39,7 @@
 
 import java.util.HashMap;
 import java.util.Map;
+import java.util.TimeZone;
 
 import org.spearce.jgit.util.SystemReader;
 
@@ -75,4 +76,14 @@ public FileBasedConfig openUserConfig() {
 	public String getHostname() {
 		return "fake.host.example.com";
 	}
+
+	@Override
+	public long getCurrentTime() {
+		return 1250379778668L; // Sat Aug 15 20:12:58 GMT-03:30 2009 
+	}
+
+	@Override
+	public int getTimezone(long when) {
+		return TimeZone.getTimeZone("GMT-3:30").getOffset(when);
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
index 393e177..a0418ab 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
@@ -44,6 +44,8 @@
 import java.util.Locale;
 import java.util.TimeZone;
 
+import org.spearce.jgit.util.SystemReader;
+
 /**
  * A combination of a person identity and time in Git.
  * 
@@ -70,8 +72,8 @@ public PersonIdent(final Repository repo) {
 		final RepositoryConfig config = repo.getConfig();
 		name = config.getCommitterName();
 		emailAddress = config.getCommitterEmail();
-		when = System.currentTimeMillis();
-		tzOffset = TimeZone.getDefault().getOffset(when) / (60 * 1000);
+		when = SystemReader.getInstance().getCurrentTime();
+		tzOffset = SystemReader.getInstance().getTimezone(when);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
index 51a0d29..083d120 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
@@ -40,6 +40,7 @@
 import java.io.File;
 import java.net.InetAddress;
 import java.net.UnknownHostException;
+import java.util.TimeZone;
 
 import org.spearce.jgit.lib.FileBasedConfig;
 
@@ -81,6 +82,16 @@ public String getHostname() {
 			}
 			return hostname;
 		}
+
+		@Override
+		public long getCurrentTime() {
+			return System.currentTimeMillis();
+		}
+
+		@Override
+		public int getTimezone(long when) {
+			return TimeZone.getDefault().getOffset(when) / (60 * 1000);
+		}
 	};
 
 	/** @return the live instance to read system properties. */
@@ -120,4 +131,15 @@ public static void setInstance(SystemReader newReader) {
 	 * @return the git configuration found in the user home
 	 */
 	public abstract FileBasedConfig openUserConfig();
+
+	/**
+	 * @return the current system time
+	 */
+	public abstract long getCurrentTime();
+
+	/**
+	 * @param when TODO
+	 * @return the local time zone
+	 */
+	public abstract int getTimezone(long when);
 }
-- 
1.6.4.115.gc0eb0
