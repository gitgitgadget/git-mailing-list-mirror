From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH 3/3] Extracted AWT-independent superclass from 
	DefaultSshSessionFactory
Date: Thu, 16 Apr 2009 18:11:11 +0400
Message-ID: <85647ef50904160711w6fbcfcedk2b9a9e1740a4ddd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 16:15:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuSKg-0004gK-7c
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 16:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbZDPOLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 10:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbZDPOLP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 10:11:15 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:58746 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbZDPOLO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 10:11:14 -0400
Received: by bwz17 with SMTP id 17so436266bwz.37
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=HC4U/fj/Iny6A2TFBHWN3oHjlkMQmEwYXT3mSBUaG9U=;
        b=MZ+DpQslGVtIryhLurUmzSdbAf1FaVWki5C1TbmaswO8qm99UqBZR4mCuP2KTsuvWJ
         BdJtyZDHsTC9KGO9kmju3VCZWjUwHupSKCoNdJwoSPDa1STzw/345Ik4gPz5xbk+aH4J
         7D2oMSu1dxyfaoBLBMVySwxi6/fxZhHfe6UGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ZCiBYv34J4DKY/BKmuJNb/WcVNeN3JI2RVHJzJcfJ9Qp6pb7j/05o0DbwGJSx+lfph
         EL9OpAZBJeti6n1eLLw+YywVSG2KRym15lVraiuLY6vEzhh0WEp+hy/oBEKEcy++6bAs
         s3j5zWriGR0XHawPC514tA/e2mItF7UTH+H9g=
Received: by 10.204.55.140 with SMTP id u12mr1311494bkg.98.1239891071478; Thu, 
	16 Apr 2009 07:11:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116704>

The part of DefaultSshSessionFactory that does not depend on
AWT was refactored to the super class SshConfigSessionFactory.
The parts of DefaultSshSessionFactory that were used only by
the OpenSshConfig class were moved to that class.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
Note that I did not update EclipseSshSessionFactory since it handles
JSch object a bit differently, and I do not quite understand the
reason for these differences. But EclipseSshSessionFactory might also
benefit from SshConfigSessionFactory.

 .../jgit/transport/DefaultSshSessionFactory.java   |  157 +--------------
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   17 ++-
 .../jgit/transport/SshConfigSessionFactory.java    |  215 ++++++++++++++++++++
 3 files changed, 233 insertions(+), 156 deletions(-)
 create mode 100644
org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index c9050fa..8e7e529 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -42,15 +42,6 @@
 import java.awt.GridBagConstraints;
 import java.awt.GridBagLayout;
 import java.awt.Insets;
-import java.io.File;
-import java.io.FileInputStream;
-import java.io.FileNotFoundException;
-import java.io.IOException;
-import java.io.OutputStream;
-import java.security.AccessController;
-import java.security.PrivilegedAction;
-import java.util.HashSet;
-import java.util.Set;

 import javax.swing.JLabel;
 import javax.swing.JOptionPane;
@@ -58,10 +49,6 @@
 import javax.swing.JPasswordField;
 import javax.swing.JTextField;

-import org.spearce.jgit.util.FS;
-
-import com.jcraft.jsch.JSch;
-import com.jcraft.jsch.JSchException;
 import com.jcraft.jsch.Session;
 import com.jcraft.jsch.UIKeyboardInteractive;
 import com.jcraft.jsch.UserInfo;
@@ -76,116 +63,11 @@
  * If user interactivity is required by SSH (e.g. to obtain a password) AWT is
  * used to display a password input field to the end-user.
  */
-class DefaultSshSessionFactory extends SshSessionFactory {
-	/** IANA assigned port number for SSH. */
-	static final int SSH_PORT = 22;
-
-	private Set<String> loadedIdentities;
-
-	private JSch userJSch;
-
-	private OpenSshConfig config;
-
-	@Override
-	public synchronized Session getSession(String user, String pass,
-			String host, int port) throws JSchException {
-		final OpenSshConfig.Host hc = getConfig().lookup(host);
-		host = hc.getHostName();
-		if (port <= 0)
-			port = hc.getPort();
-		if (user == null)
-			user = hc.getUser();
+class DefaultSshSessionFactory extends SshConfigSessionFactory {

-		final Session session = getUserJSch().getSession(user, host, port);
-		if (hc.getIdentityFile() != null)
-			addIdentity(hc.getIdentityFile());
-		if (pass != null)
-			session.setPassword(pass);
-		else if (!hc.isBatchMode())
+	protected void configure(final OpenSshConfig.Host hc, final Session session) {
+		if (!hc.isBatchMode())
 			session.setUserInfo(new AWT_UserInfo());
-		final String strictHostKeyCheckingPolicy = hc.getStrictHostKeyChecking();
-		if (strictHostKeyCheckingPolicy != null)
-			session.setConfig("StrictHostKeyChecking", strictHostKeyCheckingPolicy);
-		final String pauth = hc.getPreferredAuthentications();
-		if (pauth != null)
-			session.setConfig("PreferredAuthentications", pauth);
-		return session;
-	}
-
-	static String userName() {
-		return AccessController.doPrivileged(new PrivilegedAction<String>() {
-			public String run() {
-				return System.getProperty("user.name");
-			}
-		});
-	}
-
-	private JSch getUserJSch() throws JSchException {
-		if (userJSch == null) {
-			loadedIdentities = new HashSet<String>();
-			userJSch = new JSch();
-			knownHosts(userJSch);
-			identities();
-		}
-		return userJSch;
-	}
-
-	private OpenSshConfig getConfig() {
-		if (config == null)
-			config = OpenSshConfig.get();
-		return config;
-	}
-
-	private void knownHosts(final JSch sch) throws JSchException {
-		final File home = FS.userHome();
-		if (home == null)
-			return;
-		final File known_hosts = new File(new File(home, ".ssh"), "known_hosts");
-		try {
-			final FileInputStream in = new FileInputStream(known_hosts);
-			try {
-				sch.setKnownHosts(in);
-			} finally {
-				in.close();
-			}
-		} catch (FileNotFoundException none) {
-			// Oh well. They don't have a known hosts in home.
-		} catch (IOException err) {
-			// Oh well. They don't have a known hosts in home.
-		}
-	}
-
-	private void identities() {
-		final File home = FS.userHome();
-		if (home == null)
-			return;
-		final File sshdir = new File(home, ".ssh");
-		final File[] keys = sshdir.listFiles();
-		if (keys == null)
-			return;
-		for (int i = 0; i < keys.length; i++) {
-			final File pk = keys[i];
-			final String n = pk.getName();
-			if (!n.endsWith(".pub"))
-				continue;
-			final File k = new File(sshdir, n.substring(0, n.length() - 4));
-			if (!k.isFile())
-				continue;
-
-			try {
-				addIdentity(k);
-			} catch (JSchException e) {
-				continue;
-			}
-		}
-	}
-
-	private void addIdentity(final File identityFile) throws JSchException {
-		final String path = identityFile.getAbsolutePath();
-		if (!loadedIdentities.contains(path)) {
-			userJSch.addIdentity(path);
-			loadedIdentities.add(path);
-		}
 	}

 	private static class AWT_UserInfo implements UserInfo,
@@ -285,37 +167,4 @@ public String getPassphrase() {
 			return null; // cancel
 		}
 	}
-
-	@Override
-	public OutputStream getErrorStream() {
-		return new OutputStream() {
-			private StringBuilder all = new StringBuilder();
-
-			private StringBuilder sb = new StringBuilder();
-
-			public String toString() {
-				String r = all.toString();
-				while (r.endsWith("\n"))
-					r = r.substring(0, r.length() - 1);
-				return r;
-			}
-
-			@Override
-			public void write(final int b) throws IOException {
-				if (b == '\r') {
-					System.err.print('\r');
-					return;
-				}
-
-				sb.append((char) b);
-
-				if (b == '\n') {
-					final String line = sb.toString();
-					System.err.print(line);
-					all.append(line);
-					sb = new StringBuilder();
-				}
-			}
-		};
-	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index 1c264d4..c50c228 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -44,6 +44,8 @@
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.InputStreamReader;
+import java.security.AccessController;
+import java.security.PrivilegedAction;
 import java.util.ArrayList;
 import java.util.Collections;
 import java.util.LinkedHashMap;
@@ -95,6 +97,9 @@ public static OpenSshConfig get() {
 	/** Cached entries read out of the configuration file. */
 	private Map<String, Host> hosts;

+	/** IANA assigned port number for SSH. */
+	static final int SSH_PORT = 22;
+
 	OpenSshConfig(final File h, final File cfg) {
 		home = h;
 		configFile = cfg;
@@ -129,9 +134,9 @@ public Host lookup(final String hostName) {
 		if (h.hostName == null)
 			h.hostName = hostName;
 		if (h.user == null)
-			h.user = DefaultSshSessionFactory.userName();
+			h.user = OpenSshConfig.userName();
 		if (h.port == 0)
-			h.port = DefaultSshSessionFactory.SSH_PORT;
+			h.port = OpenSshConfig.SSH_PORT;
 		h.patternsApplied = true;
 		return h;
 	}
@@ -277,6 +282,14 @@ private File toFile(final String path) {
 		return new File(home, path);
 	}

+	static String userName() {
+		return AccessController.doPrivileged(new PrivilegedAction<String>() {
+			public String run() {
+				return System.getProperty("user.name");
+			}
+		});
+	}
+
 	/**
 	 * Configuration of one "Host" block in the configuration file.
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
new file mode 100644
index 0000000..05e2346
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
@@ -0,0 +1,215 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, JetBrains s.r.o.
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
+package org.spearce.jgit.transport;
+
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.OutputStream;
+import java.util.HashSet;
+import java.util.Set;
+
+import org.spearce.jgit.util.FS;
+
+import com.jcraft.jsch.JSch;
+import com.jcraft.jsch.JSchException;
+import com.jcraft.jsch.Session;
+import com.jcraft.jsch.UserInfo;
+
+/**
+ * The base session factory that loads known hosts and private keys from
+ * <code>$HOME/.ssh</code>.
+ * <p>
+ * This is the default implementation used by JGit and provides most of the
+ * compatibility necessary to match OpenSSH, a popular implementation of SSH
+ * used by C Git.
+ * <p>
+ * The factory does not provides UI behavior. Override the method
+ * {@link #configure(org.spearce.jgit.transport.OpenSshConfig.Host, Session)}
+ * to supply appropriate {@link UserInfo} to the session.
+ */
+public abstract class SshConfigSessionFactory extends SshSessionFactory {
+
+	private Set<String> loadedIdentities;
+
+	private JSch userJSch;
+
+	private OpenSshConfig config;
+
+	@Override
+	public synchronized Session getSession(String user, String pass,
+			String host, int port) throws JSchException {
+		final OpenSshConfig.Host hc = getConfig().lookup(host);
+		host = hc.getHostName();
+		if (port <= 0)
+			port = hc.getPort();
+		if (user == null)
+			user = hc.getUser();
+
+		final Session session = getUserJSch().getSession(user, host, port);
+		if (hc.getIdentityFile() != null)
+			addIdentity(hc.getIdentityFile());
+		if (pass != null)
+			session.setPassword(pass);
+		final String strictHostKeyCheckingPolicy = hc
+				.getStrictHostKeyChecking();
+		if (strictHostKeyCheckingPolicy != null)
+			session.setConfig("StrictHostKeyChecking",
+					strictHostKeyCheckingPolicy);
+		final String pauth = hc.getPreferredAuthentications();
+		if (pauth != null)
+			session.setConfig("PreferredAuthentications", pauth);
+		configure(hc, session);
+		return session;
+	}
+
+
+	/**
+	 * Provide additional configuration for the session basing on the host
+	 * information. This method could be used to supply {@link UserInfo}.
+	 *
+	 * @param hc
+	 *            host configuration
+	 * @param session
+	 *            session to configure
+	 */
+	protected abstract void configure(final OpenSshConfig.Host hc, final
Session session);
+
+	private JSch getUserJSch() throws JSchException {
+		if (userJSch == null) {
+			loadedIdentities = new HashSet<String>();
+			userJSch = new JSch();
+			knownHosts(userJSch);
+			identities();
+		}
+		return userJSch;
+	}
+
+	private OpenSshConfig getConfig() {
+		if (config == null)
+			config = OpenSshConfig.get();
+		return config;
+	}
+
+	private void knownHosts(final JSch sch) throws JSchException {
+		final File home = FS.userHome();
+		if (home == null)
+			return;
+		final File known_hosts = new File(new File(home, ".ssh"), "known_hosts");
+		try {
+			final FileInputStream in = new FileInputStream(known_hosts);
+			try {
+				sch.setKnownHosts(in);
+			} finally {
+				in.close();
+			}
+		} catch (FileNotFoundException none) {
+			// Oh well. They don't have a known hosts in home.
+		} catch (IOException err) {
+			// Oh well. They don't have a known hosts in home.
+		}
+	}
+
+	private void identities() {
+		final File home = FS.userHome();
+		if (home == null)
+			return;
+		final File sshdir = new File(home, ".ssh");
+		final File[] keys = sshdir.listFiles();
+		if (keys == null)
+			return;
+		for (int i = 0; i < keys.length; i++) {
+			final File pk = keys[i];
+			final String n = pk.getName();
+			if (!n.endsWith(".pub"))
+				continue;
+			final File k = new File(sshdir, n.substring(0, n.length() - 4));
+			if (!k.isFile())
+				continue;
+
+			try {
+				addIdentity(k);
+			} catch (JSchException e) {
+				continue;
+			}
+		}
+	}
+
+	private void addIdentity(final File identityFile) throws JSchException {
+		final String path = identityFile.getAbsolutePath();
+		if (!loadedIdentities.contains(path)) {
+			userJSch.addIdentity(path);
+			loadedIdentities.add(path);
+		}
+	}
+
+	@Override
+	public OutputStream getErrorStream() {
+		return new OutputStream() {
+			private StringBuilder all = new StringBuilder();
+
+			private StringBuilder sb = new StringBuilder();
+
+			public String toString() {
+				String r = all.toString();
+				while (r.endsWith("\n"))
+					r = r.substring(0, r.length() - 1);
+				return r;
+			}
+
+			@Override
+			public void write(final int b) throws IOException {
+				if (b == '\r') {
+					System.err.print('\r');
+					return;
+				}
+
+				sb.append((char) b);
+
+				if (b == '\n') {
+					final String line = sb.toString();
+					System.err.print(line);
+					all.append(line);
+					sb = new StringBuilder();
+				}
+			}
+		};
+	}
+}
-- 
1.6.0.2.1172.ga5ed0
