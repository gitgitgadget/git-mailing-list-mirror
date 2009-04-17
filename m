From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Refactor EclipseSshSessionFactory to extend SshConfigSessionFactory
Date: Fri, 17 Apr 2009 08:35:10 -0700
Message-ID: <1239982510-20431-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 17:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luq7V-0006Wq-GM
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 17:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbZDQPfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 11:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbZDQPfN
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 11:35:13 -0400
Received: from george.spearce.org ([209.20.77.23]:42891 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431AbZDQPfM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 11:35:12 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C7ADE38215; Fri, 17 Apr 2009 15:35:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F25D3381CE;
	Fri, 17 Apr 2009 15:35:10 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc0.200.g4086
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116749>

Keeping the EclipseSshSessionFactory in sync with our OpenSSH compliant
DefaultSshSessionFactory was a problem; e.g. a few commits ago we had
support for StrictHostKeyChecking added, but it was missed in the fork
we use under Eclipse.

Constantine Plotnikov's recent patch pointed out we should clean up
the code and make EclipseSshSessionFactory use the same code as the
other JGit clients use.  This makes it possible by refactoring the
way we create the Session and obtain a handle on the JSch.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/ui/EclipseSshSessionFactory.java  |   86 +++-----------------
 .../jgit/transport/SshConfigSessionFactory.java    |   34 +++++++-
 2 files changed, 42 insertions(+), 78 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
index 098d234..2cafdfe 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
@@ -8,96 +8,36 @@
  *******************************************************************************/
 package org.spearce.egit.ui;
 
-import java.io.File;
-import java.io.IOException;
-import java.io.OutputStream;
-import java.util.HashSet;
-import java.util.Set;
-
 import org.eclipse.jsch.core.IJSchService;
 import org.eclipse.jsch.ui.UserInfoPrompter;
-import org.spearce.jgit.transport.OpenSshConfig;
-import org.spearce.jgit.transport.SshSessionFactory;
+import org.spearce.jgit.transport.SshConfigSessionFactory;
+import org.spearce.jgit.transport.OpenSshConfig.Host;
 
+import com.jcraft.jsch.JSch;
 import com.jcraft.jsch.JSchException;
 import com.jcraft.jsch.Session;
 
-class EclipseSshSessionFactory extends SshSessionFactory {
+class EclipseSshSessionFactory extends SshConfigSessionFactory {
 	private final IJSchService provider;
 
-	private final Set<String> loadedIdentities = new HashSet<String>();
-
-	private OpenSshConfig config;
-
 	EclipseSshSessionFactory(final IJSchService p) {
 		provider = p;
 	}
 
 	@Override
-	public Session getSession(String user, String pass, String host, int port)
-			throws JSchException {
-		final OpenSshConfig.Host hc = getConfig().lookup(host);
-		host = hc.getHostName();
-		if (port <= 0)
-			port = hc.getPort();
-		if (user == null)
-			user = hc.getUser();
-
-		final Session session = provider.createSession(host, port, user);
-		if (hc.getIdentityFile() != null)
-			addIdentity(hc.getIdentityFile());
-		if (pass != null)
-			session.setPassword(pass);
-		else if (!hc.isBatchMode())
-			new UserInfoPrompter(session);
-
-		final String pauth = hc.getPreferredAuthentications();
-		if (pauth != null)
-			session.setConfig("PreferredAuthentications", pauth);
-		return session;
-	}
-
-	private synchronized OpenSshConfig getConfig() {
-		if (config == null)
-			config = OpenSshConfig.get();
-		return config;
+	protected Session createSession(final String user, final String host,
+			final int port) throws JSchException {
+		return provider.createSession(host, port, user);
 	}
 
-	private void addIdentity(final File identityFile)
-			throws JSchException {
-		final String path = identityFile.getAbsolutePath();
-		if (loadedIdentities.add(path))
-			provider.getJSch().addIdentity(path);
+	@Override
+	protected void configure(final Host hc, final Session session) {
+		if (!hc.isBatchMode())
+			new UserInfoPrompter(session);
 	}
 
 	@Override
-	public OutputStream getErrorStream() {
-		return new OutputStream() {
-
-			StringBuilder all = new StringBuilder();
-
-			StringBuilder sb = new StringBuilder();
-
-			public String toString() {
-				String r = all.toString();
-				while (r.endsWith("\n"))
-					r = r.substring(0, r.length() - 1);
-				return r;
-			}
-
-			@Override
-			public void write(int b) throws IOException {
-				if (b == '\r')
-					return;
-				sb.append((char) b);
-				if (b == '\n') {
-					String s = sb.toString();
-					all.append(s);
-					sb = new StringBuilder();
-					Activator.logError(s, new Throwable());
-				}
-			}
-		};
+	protected JSch getUserJSch() throws JSchException {
+		return provider.getJSch();
 	}
-
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
index ec91494..f929e6b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
@@ -66,7 +66,7 @@
  * to supply appropriate {@link UserInfo} to the session.
  */
 public abstract class SshConfigSessionFactory extends SshSessionFactory {
-	private Set<String> loadedIdentities;
+	private final Set<String> loadedIdentities = new HashSet<String>();
 
 	private JSch userJSch;
 
@@ -82,7 +82,7 @@ public synchronized Session getSession(String user, String pass,
 		if (user == null)
 			user = hc.getUser();
 
-		final Session session = getUserJSch().getSession(user, host, port);
+		final Session session = createSession(user, host, port);
 		if (hc.getIdentityFile() != null)
 			addIdentity(hc.getIdentityFile());
 		if (pass != null)
@@ -100,6 +100,24 @@ public synchronized Session getSession(String user, String pass,
 	}
 
 	/**
+	 * Create a new JSch session for the requested address.
+	 *
+	 * @param user
+	 *            login to authenticate as.
+	 * @param host
+	 *            server name to connect to.
+	 * @param port
+	 *            port number of the SSH daemon (typically 22).
+	 * @return new session instance, but otherwise unconfigured.
+	 * @throws JSchException
+	 *             the session could not be created.
+	 */
+	protected Session createSession(String user, String host, int port)
+			throws JSchException {
+		return getUserJSch().getSession(user, host, port);
+	}
+
+	/**
 	 * Provide additional configuration for the session based on the host
 	 * information. This method could be used to supply {@link UserInfo}.
 	 *
@@ -110,9 +128,15 @@ public synchronized Session getSession(String user, String pass,
 	 */
 	protected abstract void configure(OpenSshConfig.Host hc, Session session);
 
-	private JSch getUserJSch() throws JSchException {
+	/**
+	 * Obtain the JSch used to create new sessions.
+	 *
+	 * @return the JSch instance to use.
+	 * @throws JSchException
+	 *             the user configuration could not be created.
+	 */
+	protected JSch getUserJSch() throws JSchException {
 		if (userJSch == null) {
-			loadedIdentities = new HashSet<String>();
 			userJSch = new JSch();
 			knownHosts(userJSch);
 			identities();
@@ -173,7 +197,7 @@ private void identities() {
 	private void addIdentity(final File identityFile) throws JSchException {
 		final String path = identityFile.getAbsolutePath();
 		if (!loadedIdentities.contains(path)) {
-			userJSch.addIdentity(path);
+			getUserJSch().addIdentity(path);
 			loadedIdentities.add(path);
 		}
 	}
-- 
1.6.3.rc0.200.g4086
