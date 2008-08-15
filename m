From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 2/2] Honor ~/.ssh/config whenever possible during SSH based transport
Date: Fri, 15 Aug 2008 10:35:05 -0700
Message-ID: <1218821705-2631-2-git-send-email-spearce@spearce.org>
References: <1218821705-2631-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3Dx-0001JA-8G
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 19:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbYHORfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 13:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755685AbYHORfM
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 13:35:12 -0400
Received: from george.spearce.org ([209.20.77.23]:44212 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbYHORfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 13:35:08 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3BCCD38378; Fri, 15 Aug 2008 17:35:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A60C838375;
	Fri, 15 Aug 2008 17:35:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc3.250.g8dd0
In-Reply-To: <1218821705-2631-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92496>

I rely on ~/.ssh/config to setup host aliases, especially for very
common destinations.  For example I have the following on most of
my systems:

	Host orcz
		HostName repo.or.cz
		User spearce
		IdentityFile .ssh/id_orcz

as not every system I use has my local user name as "spearce".  The
C Git transport honors these settings just fine for short URLs like
"orcz:/srv/git/egit.git" but jgit failed horribly on these as there
is no local system named "orcz" on any of my networks.

By reading (and caching) the ~/.ssh/config file jgit can now honor
the important aspects of the host configuration blocks, allowing it
to use the same URLs as C Git.

The JSch API does not seem to allow forcing a specific key identity
for a Session so we are forced to load the identity file listed in
the configuration into the core JSch object we are running with.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/ui/EclipseSshSessionFactory.java  |   44 ++-
 .../spearce/jgit/transport/OpenSshConfigTest.java  |  131 ++++++++
 .../jgit/transport/DefaultSshSessionFactory.java   |   22 ++-
 .../org/spearce/jgit/transport/OpenSshConfig.java  |  318 ++++++++++++++++++++
 4 files changed, 499 insertions(+), 16 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
index 8f80373..640a165 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
@@ -8,13 +8,15 @@
  *******************************************************************************/
 package org.spearce.egit.ui;
 
+import java.io.File;
 import java.io.IOException;
 import java.io.OutputStream;
-import java.security.AccessController;
-import java.security.PrivilegedAction;
+import java.util.HashSet;
+import java.util.Set;
 
 import org.eclipse.jsch.core.IJSchService;
 import org.eclipse.jsch.ui.UserInfoPrompter;
+import org.spearce.jgit.transport.OpenSshConfig;
 import org.spearce.jgit.transport.SshSessionFactory;
 
 import com.jcraft.jsch.JSchException;
@@ -23,15 +25,27 @@
 class EclipseSshSessionFactory extends SshSessionFactory {
 	private final IJSchService provider;
 
+	private final Set<String> loadedIdentities = new HashSet<String>();
+
+	private OpenSshConfig config;
+
 	EclipseSshSessionFactory(final IJSchService p) {
 		provider = p;
 	}
 
 	@Override
-	public Session getSession(final String user, final String pass,
-			final String host, final int port) throws JSchException {
-		final Session session = provider.createSession(host, port > 0 ? port
-				: -1, user != null ? user : userName());
+	public Session getSession(String user, String pass, String host, int port)
+			throws JSchException {
+		final OpenSshConfig.Host hc = getConfig().lookup(host);
+		host = hc.getHostName();
+		if (port <= 0)
+			port = hc.getPort();
+		if (user == null)
+			user = hc.getUser();
+
+		final Session session = provider.createSession(host, port, user);
+		if (hc.getIdentityFile() != null)
+			addIdentity(hc.getIdentityFile());
 		if (pass != null)
 			session.setPassword(pass);
 		else
@@ -39,12 +53,17 @@ public Session getSession(final String user, final String pass,
 		return session;
 	}
 
-	private static String userName() {
-		return AccessController.doPrivileged(new PrivilegedAction<String>() {
-			public String run() {
-				return System.getProperty("user.name");
-			}
-		});
+	private synchronized OpenSshConfig getConfig() {
+		if (config == null)
+			config = OpenSshConfig.get();
+		return config;
+	}
+
+	private void addIdentity(final File identityFile)
+			throws JSchException {
+		final String path = identityFile.getAbsolutePath();
+		if (loadedIdentities.add(path))
+			provider.getJSch().addIdentity(path);
 	}
 
 	@Override
@@ -52,6 +71,7 @@ public OutputStream getErrorStream() {
 		return new OutputStream() {
 
 			StringBuilder all = new StringBuilder();
+
 			StringBuilder sb = new StringBuilder();
 
 			public String toString() {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
new file mode 100644
index 0000000..a250f9d
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
@@ -0,0 +1,131 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport;
+
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.io.OutputStreamWriter;
+
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.transport.OpenSshConfig.Host;
+
+public class OpenSshConfigTest extends RepositoryTestCase {
+	private File home;
+
+	private File configFile;
+
+	private OpenSshConfig osc;
+
+	public void setUp() throws Exception {
+		super.setUp();
+
+		home = new File(trash, "home");
+		home.mkdir();
+
+		configFile = new File(new File(home, ".ssh"), "config");
+		configFile.getParentFile().mkdir();
+
+		System.setProperty("user.name", "jex_junit");
+		osc = new OpenSshConfig(home, configFile);
+	}
+
+	private void config(final String data) throws IOException {
+		final OutputStreamWriter fw = new OutputStreamWriter(
+				new FileOutputStream(configFile), "UTF-8");
+		fw.write(data);
+		fw.close();
+	}
+
+	public void testNoConfig() {
+		final Host h = osc.lookup("repo.or.cz");
+		assertNotNull(h);
+		assertEquals("repo.or.cz", h.getHostName());
+		assertEquals("jex_junit", h.getUser());
+		assertEquals(22, h.getPort());
+		assertNull(h.getIdentityFile());
+	}
+
+	public void testAlias_DoesNotMatch() throws Exception {
+		config("Host orcz\n" + "\tHostName repo.or.cz\n");
+		final Host h = osc.lookup("repo.or.cz");
+		assertNotNull(h);
+		assertEquals("repo.or.cz", h.getHostName());
+		assertEquals("jex_junit", h.getUser());
+		assertEquals(22, h.getPort());
+		assertNull(h.getIdentityFile());
+	}
+
+	public void testAlias_OptionsSet() throws Exception {
+		config("Host orcz\n" + "\tHostName repo.or.cz\n" + "\tPort 2222\n"
+				+ "\tUser jex\n" + "\tIdentityFile .ssh/id_jex\n"
+				+ "\tForwardX11 no\n");
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertEquals("repo.or.cz", h.getHostName());
+		assertEquals("jex", h.getUser());
+		assertEquals(2222, h.getPort());
+		assertEquals(new File(home, ".ssh/id_jex"), h.getIdentityFile());
+	}
+
+
+	public void testAlias_OptionsKeywordCaseInsensitive() throws Exception {
+		config("hOsT orcz\n" + "\thOsTnAmE repo.or.cz\n" + "\tPORT 2222\n"
+				+ "\tuser jex\n" + "\tidentityfile .ssh/id_jex\n"
+				+ "\tForwardX11 no\n");
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertEquals("repo.or.cz", h.getHostName());
+		assertEquals("jex", h.getUser());
+		assertEquals(2222, h.getPort());
+		assertEquals(new File(home, ".ssh/id_jex"), h.getIdentityFile());
+	}
+
+	public void testAlias_OptionsInherit() throws Exception {
+		config("Host orcz\n" + "\tHostName repo.or.cz\n" + "\n" + "Host *\n"
+				+ "\tHostName not.a.host.example.com\n" + "\tPort 2222\n"
+				+ "\tUser jex\n" + "\tIdentityFile .ssh/id_jex\n"
+				+ "\tForwardX11 no\n");
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertEquals("repo.or.cz", h.getHostName());
+		assertEquals("jex", h.getUser());
+		assertEquals(2222, h.getPort());
+		assertEquals(new File(home, ".ssh/id_jex"), h.getIdentityFile());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 0484fc0..a2437c2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -49,6 +49,8 @@
 import java.io.OutputStream;
 import java.security.AccessController;
 import java.security.PrivilegedAction;
+import java.util.HashSet;
+import java.util.Set;
 
 import javax.swing.JLabel;
 import javax.swing.JOptionPane;
@@ -76,21 +78,27 @@
  */
 class DefaultSshSessionFactory extends SshSessionFactory {
 	/** IANA assigned port number for SSH. */
-	private static final int SSH_PORT = 22;
+	static final int SSH_PORT = 22;
 
 	private Set<String> loadedIdentities;
 
 	private JSch userJSch;
 
+	private OpenSshConfig config;
+
 	@Override
 	public synchronized Session getSession(String user, String pass,
 			String host, int port) throws JSchException {
+		final OpenSshConfig.Host hc = getConfig().lookup(host);
+		host = hc.getHostName();
 		if (port <= 0)
-			port = SSH_PORT;
+			port = hc.getPort();
 		if (user == null)
-			user = userName();
+			user = hc.getUser();
 
 		final Session session = getUserJSch().getSession(user, host, port);
+		if (hc.getIdentityFile() != null)
+			addIdentity(hc.getIdentityFile());
 		if (pass != null)
 			session.setPassword(pass);
 		else
@@ -98,7 +106,7 @@ public synchronized Session getSession(String user, String pass,
 		return session;
 	}
 
-	private static String userName() {
+	static String userName() {
 		return AccessController.doPrivileged(new PrivilegedAction<String>() {
 			public String run() {
 				return System.getProperty("user.name");
@@ -116,6 +124,12 @@ private JSch getUserJSch() throws JSchException {
 		return userJSch;
 	}
 
+	private OpenSshConfig getConfig() {
+		if (config == null)
+			config = OpenSshConfig.get();
+		return config;
+	}
+
 	private void knownHosts(final JSch sch) throws JSchException {
 		final File home = FS.userHome();
 		if (home == null)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
new file mode 100644
index 0000000..f927b1a
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -0,0 +1,318 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport;
+
+import java.io.BufferedReader;
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.InputStreamReader;
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.LinkedHashMap;
+import java.util.List;
+import java.util.Map;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.fnmatch.FileNameMatcher;
+import org.spearce.jgit.util.FS;
+
+/**
+ * Simple configuration parser for the OpenSSH ~/.ssh/config file.
+ * <p>
+ * Since JSch does not (currently) have the ability to parse an OpenSSH
+ * configuration file this is a simple parser to read that file and make the
+ * critical options available to {@link SshSessionFactory}.
+ */
+public class OpenSshConfig {
+	/**
+	 * Obtain the user's configuration data.
+	 * <p>
+	 * The configuration file is always returned to the caller, even if no file
+	 * exists in the user's home directory at the time the call was made. Lookup
+	 * requests are cached and are automatically updated if the user modifies
+	 * the configuration file since the last time it was cached.
+	 * 
+	 * @return a caching reader of the user's configuration file.
+	 */
+	public static OpenSshConfig get() {
+		File home = FS.userHome();
+		if (home == null)
+			home = new File(".").getAbsoluteFile();
+
+		final File config = new File(new File(home, ".ssh"), "config");
+		final OpenSshConfig osc = new OpenSshConfig(home, config);
+		osc.refresh();
+		return osc;
+	}
+
+	/** The user's home directory, as key files may be relative to here. */
+	private final File home;
+
+	/** The .ssh/config file we read and monitor for updates. */
+	private final File configFile;
+
+	/** Modification time of {@link #configFile} when {@link #hosts} loaded. */
+	private long lastModified;
+
+	/** Cached entries read out of the configuration file. */
+	private Map<String, Host> hosts;
+
+	protected OpenSshConfig(final File h, final File cfg) {
+		home = h;
+		configFile = cfg;
+		hosts = Collections.emptyMap();
+	}
+
+	/**
+	 * Locate the configuration for a specific host request.
+	 * 
+	 * @param hostName
+	 *            the name the user has supplied to the SSH tool. This may be a
+	 *            real host name, or it may just be a "Host" block in the
+	 *            configuration file.
+	 * @return r configuration for the requested name. Never null.
+	 */
+	public Host lookup(final String hostName) {
+		final Map<String, Host> cache = refresh();
+		Host h = cache.get(hostName);
+		if (h == null)
+			h = new Host();
+		if (h.patternsApplied)
+			return h;
+
+		for (final Map.Entry<String, Host> e : cache.entrySet()) {
+			if (!isHostPattern(e.getKey()))
+				continue;
+			if (!isHostMatch(e.getKey(), hostName))
+				continue;
+			h.copyFrom(e.getValue());
+		}
+
+		if (h.hostName == null)
+			h.hostName = hostName;
+		if (h.user == null)
+			h.user = DefaultSshSessionFactory.userName();
+		if (h.port == 0)
+			h.port = DefaultSshSessionFactory.SSH_PORT;
+		h.patternsApplied = true;
+		return h;
+	}
+
+	private synchronized Map<String, Host> refresh() {
+		final long mtime = configFile.lastModified();
+		if (mtime != lastModified) {
+			try {
+				final FileInputStream in = new FileInputStream(configFile);
+				try {
+					hosts = parse(in);
+				} finally {
+					in.close();
+				}
+			} catch (FileNotFoundException none) {
+				hosts = Collections.emptyMap();
+			} catch (IOException err) {
+				hosts = Collections.emptyMap();
+			}
+			lastModified = mtime;
+		}
+		return hosts;
+	}
+
+	private Map<String, Host> parse(final InputStream in) throws IOException {
+		final Map<String, Host> m = new LinkedHashMap<String, Host>();
+		final BufferedReader br = new BufferedReader(new InputStreamReader(in));
+		final List<Host> current = new ArrayList<Host>(4);
+		String line;
+
+		while ((line = br.readLine()) != null) {
+			line = line.trim();
+			if (line.length() == 0 || line.startsWith("#"))
+				continue;
+
+			final int sp = line.indexOf(' ');
+			final int eq = line.indexOf('=');
+			final int splitAt;
+			if (sp >= 0 && eq >= 0)
+				splitAt = Math.min(sp, eq);
+			else if (sp < 0)
+				splitAt = eq;
+			else
+				splitAt = sp;
+			final String keyword = line.substring(0, splitAt).trim();
+			final String argValue = line.substring(splitAt + 1).trim();
+
+			if ("Host".equalsIgnoreCase(keyword)) {
+				current.clear();
+				for (final String name : argValue.split("[ \t]")) {
+					Host c = m.get(name);
+					if (c == null) {
+						c = new Host();
+						m.put(name, c);
+					}
+					current.add(c);
+				}
+				continue;
+			}
+
+			if (current.isEmpty()) {
+				// We received an option outside of a Host block. We
+				// don't know who this should match against, so skip.
+				//
+				continue;
+			}
+
+			if ("HostName".equalsIgnoreCase(keyword)) {
+				for (final Host c : current)
+					if (c.hostName == null)
+						c.hostName = dequote(argValue);
+			} else if ("User".equalsIgnoreCase(keyword)) {
+				for (final Host c : current)
+					if (c.user == null)
+						c.user = dequote(argValue);
+			} else if ("Port".equalsIgnoreCase(keyword)) {
+				try {
+					final int port = Integer.parseInt(dequote(argValue));
+					for (final Host c : current)
+						if (c.port == 0)
+							c.port = port;
+				} catch (NumberFormatException nfe) {
+					// Bad port number. Don't set it.
+				}
+			} else if ("IdentityFile".equalsIgnoreCase(keyword)) {
+				for (final Host c : current)
+					if (c.identityFile == null)
+						c.identityFile = toFile(dequote(argValue));
+			}
+		}
+
+		return m;
+	}
+
+	private static boolean isHostPattern(final String s) {
+		return s.indexOf('*') >= 0 || s.indexOf('?') >= 0;
+	}
+
+	private static boolean isHostMatch(final String pattern, final String name) {
+		final FileNameMatcher fn;
+		try {
+			fn = new FileNameMatcher(pattern, null);
+		} catch (InvalidPatternException e) {
+			return false;
+		}
+		fn.append(name);
+		return fn.isMatch();
+	}
+
+	private static String dequote(final String value) {
+		if (value.startsWith("\"") && value.endsWith("\""))
+			return value.substring(1, value.length() - 2);
+		return value;
+	}
+
+	private File toFile(final String path) {
+		if (path.startsWith("~/"))
+			return new File(home, path.substring(2));
+		return new File(home, path);
+	}
+
+	/**
+	 * Configuration of one "Host" block in the configuration file.
+	 * <p>
+	 * If returned from {@link OpenSshConfig#lookup(String)} some or all of the
+	 * properties may not be populated. The properties which are not populated
+	 * should be defaulted by the caller.
+	 * <p>
+	 * When returned from {@link OpenSshConfig#lookup(String)} any wildcard
+	 * entries which appear later in the configuration file will have been
+	 * already merged into this block.
+	 */
+	public static class Host {
+		boolean patternsApplied;
+
+		String hostName;
+
+		int port;
+
+		File identityFile;
+
+		String user;
+
+		void copyFrom(final Host src) {
+			if (hostName == null)
+				hostName = src.hostName;
+			if (port == 0)
+				port = src.port;
+			if (identityFile == null)
+				identityFile = src.identityFile;
+			if (user == null)
+				user = src.user;
+		}
+
+		/**
+		 * @return the real IP address or host name to connect to; never null.
+		 */
+		public String getHostName() {
+			return hostName;
+		}
+
+		/**
+		 * @return the real port number to connect to; never 0.
+		 */
+		public int getPort() {
+			return port;
+		}
+
+		/**
+		 * @return path of the private key file to use for authentication; null
+		 *         if the caller should use default authentication strategies.
+		 */
+		public File getIdentityFile() {
+			return identityFile;
+		}
+
+		/**
+		 * @return the real user name to connect as; never null.
+		 */
+		public String getUser() {
+			return user;
+		}
+	}
+}
-- 
1.6.0.rc3.250.g8dd0
