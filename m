From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH] Add tests for handling of parsing errors in
	OpenSshConfig
Date: Thu, 25 Sep 2008 10:39:34 +0200
Message-ID: <20080925083934.GB10273@diku.dk>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl> <bd6139dc0809201819o5d6eb5b1r7bf0e46702c711d7@mail.gmail.com> <20080921112519.GA24200@diku.dk> <200809222242.29165.robin.rosenberg.lists@dewire.com> <20080922210734.GE3669@spearce.org> <20080924232519.GA15318@diku.dk> <20080924233104.GG3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	sverre@rabbelier.nl, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 10:41:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KimPI-0005vX-U5
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 10:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYIYIjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 04:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYIYIjl
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 04:39:41 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:55515 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbYIYIjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 04:39:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id D66E019BC59;
	Thu, 25 Sep 2008 10:39:37 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13207-12; Thu, 25 Sep 2008 10:39:35 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 07FD719BB97;
	Thu, 25 Sep 2008 10:39:35 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 898716DFD0B; Thu, 25 Sep 2008 10:39:01 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id E04221A4001; Thu, 25 Sep 2008 10:39:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080924233104.GG3669@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96735>

Badly quoted entries are now ignored similar to how bad port number are
currently ignored. A check for negative port numbers is now performed
so that they also will be ignored.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../spearce/jgit/transport/OpenSshConfigTest.java  |   32 +++++++++++++++---
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   34 +++++++++++++++----
 2 files changed, 53 insertions(+), 13 deletions(-)

 Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 24, 2008:
 > Jonas Fonseca <fonseca@diku.dk> wrote:
 > > I propose to simply remove these hosts from the host map and clear
 > > the current host list so that no values will be saved, effectively
 > > causing invalid hosts to result in the same as unknown hosts.
 > 
 > Yea, that seems quite reasonable.
 > 
 > If you want more debugging than that on your ~/.ssh/config file then
 > run OpenSSH tools on it.  Hell, I can't count the number of times
 > I've made typos in there and couldn't figure out why it was still
 > asking for a password, etc.  And that's just the OpenSSH command
 > line tools.

 Heh, so below makes JGit compatible with OpenSSH's silent treatment. I
 also fixed the .ssh/config parser to ignore negative port numbers.

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
index ad6e79c..ccd7400 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
@@ -114,11 +114,7 @@ config("Host \"good\"\n" +
 			" Port=\"2222\"\n" +
 			"Host \"spaced\"\n" +
 			"# Bad host name, but testing preservation of spaces\n" +
-			" HostName=\" spaced\ttld \"\n" +
-			"# Misbalanced quotes\n" +
-			"Host \"bad\"\n" +
-			"# OpenSSH doesn't allow this but ...\n" +
-			" HostName=bad.tld\"\n");
+			" HostName=\" spaced\ttld \"\n");
 		assertEquals("good.tld", osc.lookup("good").getHostName());
 		assertEquals("gooduser", osc.lookup("good").getUser());
 		assertEquals(6007, osc.lookup("good").getPort());
@@ -128,7 +124,31 @@ config("Host \"good\"\n" +
 		assertEquals(2222, osc.lookup("unquoted").getPort());
 		assertEquals(2222, osc.lookup("hosts").getPort());
 		assertEquals(" spaced\ttld ", osc.lookup("spaced").getHostName());
-		assertEquals("bad.tld\"", osc.lookup("bad").getHostName());
+	}
+
+	public void testParsingErrors() throws Exception {
+		config("Host negativeportnumber\n" +
+		       "Port -200\n" +
+		       "Host badportnumber\n" +
+		       "Port twentytwo\n" +
+		       "Host badportquote\n" +
+		       "Port \"2222\n" +
+		       "Host badportquote2\n" +
+		       "Port 2222\"\n" +
+		       "# Misbalanced quotes\n" +
+		       "Host badly \"quoted\n" +
+		       "HostName=unknown\n");
+
+		assertEquals(DefaultSshSessionFactory.SSH_PORT,
+			     osc.lookup("negativeportnumber").getPort());
+		assertEquals(DefaultSshSessionFactory.SSH_PORT,
+			     osc.lookup("badportnumber").getPort());
+		assertEquals(DefaultSshSessionFactory.SSH_PORT,
+			     osc.lookup("badportquote").getPort());
+		assertEquals(DefaultSshSessionFactory.SSH_PORT,
+			     osc.lookup("badportquote2").getPort());
+		assertNotSame("unknown", osc.lookup("badly").getHostName());
+		assertNotSame("unknown", osc.lookup("\"quoted"));
 	}
 
 	public void testAlias_DoesNotMatch() throws Exception {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index b08d5c6..6a3f2c1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -46,6 +46,7 @@
 import java.io.InputStreamReader;
 import java.util.ArrayList;
 import java.util.Collections;
+import java.util.Iterator;
 import java.util.LinkedHashMap;
 import java.util.List;
 import java.util.Map;
@@ -175,6 +176,15 @@ public Host lookup(final String hostName) {
 				current.clear();
 				for (final String pattern : argValue.split("[ \t]")) {
 					final String name = dequote(pattern);
+					if (name == null) {
+						/* Prune all the current hosts. */
+						Iterator<Host> it = m.values().iterator();
+						while (it.hasNext())
+							if (current.contains(it.next()))
+								it.remove();
+						current.clear();
+						break;
+					}
 					Host c = m.get(name);
 					if (c == null) {
 						c = new Host();
@@ -192,17 +202,23 @@ public Host lookup(final String hostName) {
 				continue;
 			}
 
+			final String value = dequote(argValue);
+			if (value == null)
+				continue;
+
 			if ("HostName".equalsIgnoreCase(keyword)) {
 				for (final Host c : current)
 					if (c.hostName == null)
-						c.hostName = dequote(argValue);
+						c.hostName = value;
 			} else if ("User".equalsIgnoreCase(keyword)) {
 				for (final Host c : current)
 					if (c.user == null)
-						c.user = dequote(argValue);
+						c.user = value;
 			} else if ("Port".equalsIgnoreCase(keyword)) {
 				try {
-					final int port = Integer.parseInt(dequote(argValue));
+					final int port = Integer.parseInt(value);
+					if (port < 0)
+						continue;
 					for (final Host c : current)
 						if (c.port == 0)
 							c.port = port;
@@ -212,15 +228,15 @@ public Host lookup(final String hostName) {
 			} else if ("IdentityFile".equalsIgnoreCase(keyword)) {
 				for (final Host c : current)
 					if (c.identityFile == null)
-						c.identityFile = toFile(dequote(argValue));
+						c.identityFile = toFile(value);
 			} else if ("PreferredAuthentications".equalsIgnoreCase(keyword)) {
 				for (final Host c : current)
 					if (c.preferredAuthentications == null)
-						c.preferredAuthentications = nows(dequote(argValue));
+						c.preferredAuthentications = nows(value);
 			} else if ("BatchMode".equalsIgnoreCase(keyword)) {
 				for (final Host c : current)
 					if (c.batchMode == null)
-						c.batchMode = yesno(dequote(argValue));
+						c.batchMode = yesno(value);
 			}
 		}
 
@@ -243,8 +259,12 @@ private static boolean isHostMatch(final String pattern, final String name) {
 	}
 
 	private static String dequote(final String value) {
-		if (value.startsWith("\"") && value.endsWith("\""))
+		final boolean hasStart = value.startsWith("\"");
+		final boolean hasEnd = value.endsWith("\"");
+		if (hasStart && hasEnd)
 			return value.substring(1, value.length() - 1);
+		if (hasStart || hasEnd)
+			return null;
 		return value;
 	}
 
-- 
tg: (cf67dfc..) jf/opensshconfigquote (depends on: master)

-- 
Jonas Fonseca
