From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT RFC PATCH] Improve handling of parsing errors in
	OpenSshConfig
Date: Thu, 25 Sep 2008 15:29:37 +0200
Message-ID: <20080925132937.GA16151@diku.dk>
References: <20080925083934.GB10273@diku.dk> <tQAHDMR4.1222342394.9002900.roro@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"sverre@rabbelier.nl" <sverre@rabbelier.nl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 15:31:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiqw7-0007h5-9z
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 15:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbYIYN3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbYIYN3q
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 09:29:46 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:39268 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbYIYN3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 09:29:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 116AE52C407;
	Thu, 25 Sep 2008 15:29:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ioLtm8MPLNtR; Thu, 25 Sep 2008 15:29:39 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id B8C8E52C408;
	Thu, 25 Sep 2008 15:29:37 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id EFDB26DFD6D; Thu, 25 Sep 2008 15:29:03 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 9DBCA1A4001; Thu, 25 Sep 2008 15:29:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <tQAHDMR4.1222342394.9002900.roro@localhost>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96762>

Badly quoted entries are now ignored similar to how bad port number are
currently ignored. A check for negative port numbers is now performed
so that they also will be ignored.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
 .../spearce/jgit/transport/OpenSshConfigTest.java  |   46 +++++++++++++++---
 .../jgit/transport/DefaultSshSessionFactory.java   |   10 +++-
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   51 ++++++++++++-------
 3 files changed, 79 insertions(+), 28 deletions(-)

 Robin Rosenberg <robin.rosenberg@dewire.com> wrote Thu, Sep 25, 2008:
 > Den 9/25/2008, skrev "Jonas Fonseca" <fonseca@diku.dk>:
 > 
 > >Badly quoted entries are now ignored similar to how bad port number are
 > >currently ignored. A check for negative port numbers is now performed
 > >so that they also will be ignored.
 > 
 > Nooo. We should really give some feedback on bad entries. OpenSSH
 > (version 5.1) complains and refuses to connect if I give it a bad port
 > number or hostname. It complains about "missing parameter" and bad
 > port number for these cases. OpenSSH doesn't simply ignore them.
 > 
 > HostName=bad"
 > Port=hubba
 > 
 > Even if openssh would ignore them I'd think it would be bad if we did,
 > unless there was some serious compatibility issue here.

 Maybe something like this? It adds OpenSshConfigException which will
 "contain" either a NumberFormatException or a ParseException.

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
index ad6e79c..6b7bb4b 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
@@ -42,6 +42,7 @@
 import java.io.IOException;
 import java.io.OutputStreamWriter;
 
+import org.spearce.jgit.errors.OpenSshConfigException;
 import org.spearce.jgit.lib.RepositoryTestCase;
 import org.spearce.jgit.transport.OpenSshConfig.Host;
 
@@ -72,7 +73,18 @@ private void config(final String data) throws IOException {
 		fw.close();
 	}
 
-	public void testNoConfig() {
+	private boolean parseError(String config) throws Exception {
+		config(config);
+		OpenSshConfigException osce = null;
+		try {
+			osc.lookup("something");
+		} catch (OpenSshConfigException cause) {
+			return true;
+		}
+		return false;
+	}
+
+	public void testNoConfig() throws Exception {
 		final Host h = osc.lookup("repo.or.cz");
 		assertNotNull(h);
 		assertEquals("repo.or.cz", h.getHostName());
@@ -114,11 +126,7 @@ config("Host \"good\"\n" +
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
@@ -128,7 +136,31 @@ config("Host \"good\"\n" +
 		assertEquals(2222, osc.lookup("unquoted").getPort());
 		assertEquals(2222, osc.lookup("hosts").getPort());
 		assertEquals(" spaced\ttld ", osc.lookup("spaced").getHostName());
-		assertEquals("bad.tld\"", osc.lookup("bad").getHostName());
+	}
+
+	public void testNegativePortNumber() throws Exception {
+		assertTrue(parseError("Host negativeportnumber\n" +
+			   "Port -200\n"));
+	}
+
+	public void testBadPortNumber() throws Exception {
+		assertTrue(parseError("Host badportnumber\n" +
+		       "Port twentytwo\n"));
+	}
+
+	public void testBadlyQuotedPortNumber() throws Exception {
+		assertTrue(parseError("Host badportquote\n" +
+		       "Port \"2222\n"));
+	}
+
+	public void testBadlyQuotedPortNumber2() throws Exception {
+		assertTrue(parseError("Host badportquote2\n" +
+		       "Port 2222\"\n"));
+	}
+
+	public void testBadlyQuotedHost() throws Exception {
+		assertTrue(parseError("Host badly \"quoted\n" +
+		       "HostName=unknown\n"));
 	}
 
 	public void testAlias_DoesNotMatch() throws Exception {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 89beab7..123a9b5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -65,6 +65,7 @@
 import com.jcraft.jsch.Session;
 import com.jcraft.jsch.UIKeyboardInteractive;
 import com.jcraft.jsch.UserInfo;
+import org.spearce.jgit.errors.OpenSshConfigException;
 
 /**
  * Loads known hosts and private keys from <code>$HOME/.ssh</code>.
@@ -89,7 +90,12 @@
 	@Override
 	public synchronized Session getSession(String user, String pass,
 			String host, int port) throws JSchException {
-		final OpenSshConfig.Host hc = getConfig().lookup(host);
+		final OpenSshConfig.Host hc;
+		try {
+			hc = getConfig().lookup(host);
+		} catch (OpenSshConfigException osce) {
+			throw new JSchException(osce.getMessage());
+		}
 		host = hc.getHostName();
 		if (port <= 0)
 			port = hc.getPort();
@@ -128,7 +134,7 @@ private JSch getUserJSch() throws JSchException {
 		return userJSch;
 	}
 
-	private OpenSshConfig getConfig() {
+	private OpenSshConfig getConfig() throws OpenSshConfigException {
 		if (config == null)
 			config = OpenSshConfig.get();
 		return config;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index b08d5c6..95a37f5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -44,13 +44,16 @@
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.InputStreamReader;
+import java.text.ParseException;
 import java.util.ArrayList;
 import java.util.Collections;
+import java.util.Iterator;
 import java.util.LinkedHashMap;
 import java.util.List;
 import java.util.Map;
 
 import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.OpenSshConfigException;
 import org.spearce.jgit.fnmatch.FileNameMatcher;
 import org.spearce.jgit.util.FS;
 
@@ -72,7 +75,7 @@
 	 *
 	 * @return a caching reader of the user's configuration file.
 	 */
-	public static OpenSshConfig get() {
+	public static OpenSshConfig get() throws OpenSshConfigException {
 		File home = FS.userHome();
 		if (home == null)
 			home = new File(".").getAbsoluteFile();
@@ -110,7 +113,7 @@ protected OpenSshConfig(final File h, final File cfg) {
 	 *            configuration file.
 	 * @return r configuration for the requested name. Never null.
 	 */
-	public Host lookup(final String hostName) {
+	public Host lookup(final String hostName) throws OpenSshConfigException {
 		final Map<String, Host> cache = refresh();
 		Host h = cache.get(hostName);
 		if (h == null)
@@ -136,7 +139,7 @@ public Host lookup(final String hostName) {
 		return h;
 	}
 
-	private synchronized Map<String, Host> refresh() {
+	private synchronized Map<String, Host> refresh() throws OpenSshConfigException {
 		final long mtime = configFile.lastModified();
 		if (mtime != lastModified) {
 			try {
@@ -146,6 +149,10 @@ public Host lookup(final String hostName) {
 				} finally {
 					in.close();
 				}
+			} catch (NumberFormatException nfe) {
+				throw new OpenSshConfigException("Parse error", nfe);
+			} catch (ParseException pe) {
+				throw new OpenSshConfigException("Parse error", pe);
 			} catch (FileNotFoundException none) {
 				hosts = Collections.emptyMap();
 			} catch (IOException err) {
@@ -156,7 +163,7 @@ public Host lookup(final String hostName) {
 		return hosts;
 	}
 
-	private Map<String, Host> parse(final InputStream in) throws IOException {
+	private Map<String, Host> parse(final InputStream in) throws IOException, ParseException {
 		final Map<String, Host> m = new LinkedHashMap<String, Host>();
 		final BufferedReader br = new BufferedReader(new InputStreamReader(in));
 		final List<Host> current = new ArrayList<Host>(4);
@@ -192,35 +199,37 @@ public Host lookup(final String hostName) {
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
-				try {
-					final int port = Integer.parseInt(dequote(argValue));
-					for (final Host c : current)
-						if (c.port == 0)
-							c.port = port;
-				} catch (NumberFormatException nfe) {
-					// Bad port number. Don't set it.
-				}
+				final int port = Integer.parseInt(value);
+				if (port < 0)
+					throw new NumberFormatException("Negative port number");
+				for (final Host c : current)
+					if (c.port == 0)
+						c.port = port;
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
 
@@ -242,9 +251,13 @@ private static boolean isHostMatch(final String pattern, final String name) {
 		return fn.isMatch();
 	}
 
-	private static String dequote(final String value) {
-		if (value.startsWith("\"") && value.endsWith("\""))
+	private static String dequote(final String value) throws ParseException {
+		final boolean hasStart = value.startsWith("\"");
+		final boolean hasEnd = value.endsWith("\"");
+		if (hasStart && hasEnd)
 			return value.substring(1, value.length() - 1);
+		if (hasStart || hasEnd)
+			throw new ParseException("Quote mismatch", value.indexOf("\""));
 		return value;
 	}
 
-- 
tg: (cf67dfc..) jf/opensshconfigquote (depends on: master)

-- 
Jonas Fonseca
