From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Correctly honor IdentityFile from ~/.ssh/config
Date: Fri, 17 Apr 2009 09:36:42 -0700
Message-ID: <1239986202-28629-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 18:40:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lur5T-00089Q-J9
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 18:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758892AbZDQQgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 12:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757406AbZDQQgp
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 12:36:45 -0400
Received: from george.spearce.org ([209.20.77.23]:59888 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbZDQQgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 12:36:44 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 557E938215; Fri, 17 Apr 2009 16:36:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 702E1381CE;
	Fri, 17 Apr 2009 16:36:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc0.200.g4086
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116757>

JSch offers all identities available within the JSch object used to
create a Session.  In order to offer only a specific IdentityFile
to the remote server we must create a unique JSch with only that
one identity loaded.  However, we also want to cache the key once
it has been decrypted, so that repeated uses of a single file from
the same JVM do not cause repeated passphrase prompts.

The SshConfigSessionFactory now loads only the default SSH keys
(~/.ssh/identity for SSH1, ~/.ssh/{id_rsa,id_dsa} for SSH2) into
the default JSch.  If a Host block in ~/.ssh/config selects some
other IdentityFile then we create a unique JSch instance for the
key, and copy over the same known hosts table.

Fix issue 35 (Correctly honor IdentityFile in ~/.ssh/config)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/ui/EclipseSshSessionFactory.java  |   36 +++++--
 .../jgit/transport/SshConfigSessionFactory.java    |  100 ++++++++++++--------
 2 files changed, 89 insertions(+), 47 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
index 2cafdfe..04600ea 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
@@ -1,6 +1,7 @@
 /*******************************************************************************
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, Google, Inc.
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -10,8 +11,8 @@
 
 import org.eclipse.jsch.core.IJSchService;
 import org.eclipse.jsch.ui.UserInfoPrompter;
+import org.spearce.jgit.transport.OpenSshConfig;
 import org.spearce.jgit.transport.SshConfigSessionFactory;
-import org.spearce.jgit.transport.OpenSshConfig.Host;
 
 import com.jcraft.jsch.JSch;
 import com.jcraft.jsch.JSchException;
@@ -25,19 +26,36 @@ EclipseSshSessionFactory(final IJSchService p) {
 	}
 
 	@Override
-	protected Session createSession(final String user, final String host,
-			final int port) throws JSchException {
-		return provider.createSession(host, port, user);
+	protected JSch createDefaultJSch() throws JSchException {
+		// Forcing a dummy session to be created will cause the known hosts
+		// and configured private keys to be initialized. This is needed by
+		// our parent class in case non-default JSch instances need to be made.
+		//
+		provider.createSession("127.0.0.1", 0, "eclipse");
+		return provider.getJSch();
 	}
 
 	@Override
-	protected void configure(final Host hc, final Session session) {
-		if (!hc.isBatchMode())
-			new UserInfoPrompter(session);
+	protected Session createSession(final OpenSshConfig.Host hc,
+			final String user, final String host, final int port)
+			throws JSchException {
+		final JSch jsch = getJSch(hc);
+		if (jsch == provider.getJSch()) {
+			// If its the default JSch desired, let the provider
+			// manage the session creation for us.
+			//
+			return provider.createSession(host, port, user);
+		} else {
+			// This host configuration is using a different IdentityFile,
+			// one that is not available through the default JSch.
+			//
+			return jsch.getSession(user, host, port);
+		}
 	}
 
 	@Override
-	protected JSch getUserJSch() throws JSchException {
-		return provider.getJSch();
+	protected void configure(final OpenSshConfig.Host hc, final Session session) {
+		if (!hc.isBatchMode())
+			new UserInfoPrompter(session);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
index f929e6b..4d29829 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
@@ -2,6 +2,7 @@
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
  * Copyright (C) 2009, JetBrains s.r.o.
+ * Copyright (C) 2009, Google, Inc.
  *
  * All rights reserved.
  *
@@ -43,8 +44,8 @@
 import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.OutputStream;
-import java.util.HashSet;
-import java.util.Set;
+import java.util.HashMap;
+import java.util.Map;
 
 import org.spearce.jgit.util.FS;
 
@@ -66,9 +67,9 @@
  * to supply appropriate {@link UserInfo} to the session.
  */
 public abstract class SshConfigSessionFactory extends SshSessionFactory {
-	private final Set<String> loadedIdentities = new HashSet<String>();
+	private final Map<String, JSch> byIdentityFile = new HashMap<String, JSch>();
 
-	private JSch userJSch;
+	private JSch defaultJSch;
 
 	private OpenSshConfig config;
 
@@ -82,9 +83,7 @@ public synchronized Session getSession(String user, String pass,
 		if (user == null)
 			user = hc.getUser();
 
-		final Session session = createSession(user, host, port);
-		if (hc.getIdentityFile() != null)
-			addIdentity(hc.getIdentityFile());
+		final Session session = createSession(hc, user, host, port);
 		if (pass != null)
 			session.setPassword(pass);
 		final String strictHostKeyCheckingPolicy = hc
@@ -102,6 +101,8 @@ public synchronized Session getSession(String user, String pass,
 	/**
 	 * Create a new JSch session for the requested address.
 	 *
+	 * @param hc
+	 *            host configuration
 	 * @param user
 	 *            login to authenticate as.
 	 * @param host
@@ -112,9 +113,10 @@ public synchronized Session getSession(String user, String pass,
 	 * @throws JSchException
 	 *             the session could not be created.
 	 */
-	protected Session createSession(String user, String host, int port)
+	protected Session createSession(final OpenSshConfig.Host hc,
+			final String user, final String host, final int port)
 			throws JSchException {
-		return getUserJSch().getSession(user, host, port);
+		return getJSch(hc).getSession(user, host, port);
 	}
 
 	/**
@@ -131,17 +133,50 @@ protected Session createSession(String user, String host, int port)
 	/**
 	 * Obtain the JSch used to create new sessions.
 	 *
+	 * @param hc
+	 *            host configuration
 	 * @return the JSch instance to use.
 	 * @throws JSchException
 	 *             the user configuration could not be created.
 	 */
-	protected JSch getUserJSch() throws JSchException {
-		if (userJSch == null) {
-			userJSch = new JSch();
-			knownHosts(userJSch);
-			identities();
+	protected JSch getJSch(final OpenSshConfig.Host hc) throws JSchException {
+		final JSch def = getDefaultJSch();
+		final File identityFile = hc.getIdentityFile();
+		if (identityFile == null) {
+			return def;
+		}
+
+		final String identityKey = identityFile.getAbsolutePath();
+		JSch jsch = byIdentityFile.get(identityKey);
+		if (jsch == null) {
+			jsch = new JSch();
+			jsch.setHostKeyRepository(def.getHostKeyRepository());
+			jsch.addIdentity(identityKey);
+			byIdentityFile.put(identityKey, jsch);
 		}
-		return userJSch;
+		return jsch;
+	}
+
+	private JSch getDefaultJSch() throws JSchException {
+		if (defaultJSch == null) {
+			defaultJSch = createDefaultJSch();
+			for (Object name : defaultJSch.getIdentityNames()) {
+				byIdentityFile.put((String) name, defaultJSch);
+			}
+		}
+		return defaultJSch;
+	}
+
+	/**
+	 * @return the new default JSch implementation.
+	 * @throws JSchException
+	 *             known host keys cannot be loaded.
+	 */
+	protected JSch createDefaultJSch() throws JSchException {
+		final JSch jsch = new JSch();
+		knownHosts(jsch);
+		identities(jsch);
+		return jsch;
 	}
 
 	private OpenSshConfig getConfig() {
@@ -150,7 +185,7 @@ private OpenSshConfig getConfig() {
 		return config;
 	}
 
-	private void knownHosts(final JSch sch) throws JSchException {
+	private static void knownHosts(final JSch sch) throws JSchException {
 		final File home = FS.userHome();
 		if (home == null)
 			return;
@@ -169,39 +204,28 @@ private void knownHosts(final JSch sch) throws JSchException {
 		}
 	}
 
-	private void identities() {
+	private static void identities(final JSch sch) {
 		final File home = FS.userHome();
 		if (home == null)
 			return;
 		final File sshdir = new File(home, ".ssh");
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
+		if (sshdir.isDirectory()) {
+			loadIdentity(sch, new File(sshdir, "identity"));
+			loadIdentity(sch, new File(sshdir, "id_rsa"));
+			loadIdentity(sch, new File(sshdir, "id_dsa"));
+		}
+	}
 
+	private static void loadIdentity(final JSch sch, final File priv) {
+		if (priv.isFile()) {
 			try {
-				addIdentity(k);
+				sch.addIdentity(priv.getAbsolutePath());
 			} catch (JSchException e) {
-				continue;
+				// Instead, pretend the key doesn't exist.
 			}
 		}
 	}
 
-	private void addIdentity(final File identityFile) throws JSchException {
-		final String path = identityFile.getAbsolutePath();
-		if (!loadedIdentities.contains(path)) {
-			getUserJSch().addIdentity(path);
-			loadedIdentities.add(path);
-		}
-	}
-
 	@Override
 	public OutputStream getErrorStream() {
 		return new OutputStream() {
-- 
1.6.3.rc0.200.g4086
