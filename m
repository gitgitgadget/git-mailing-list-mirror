From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Reuse the same SSH connection when automatically fetching tags
Date: Thu, 10 Jul 2008 02:13:21 -0400
Message-ID: <1215670403-19191-4-git-send-email-spearce@spearce.org>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org>
 <1215670403-19191-2-git-send-email-spearce@spearce.org>
 <1215670403-19191-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 08:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGpQJ-0004ug-CQ
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 08:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbYGJGNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 02:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbYGJGNd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 02:13:33 -0400
Received: from george.spearce.org ([209.20.77.23]:55194 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbYGJGN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 02:13:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9105E382A6; Thu, 10 Jul 2008 06:13:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3C80D3821F;
	Thu, 10 Jul 2008 06:13:25 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1215670403-19191-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87942>

If we have to open a second connection to git-upload-pack in order
to automatically follow and fetch annotated tags we may be able to
reuse the same JSch Session object and simply run the second stream
over the already established, encrypted TCP stream.

Reusing the Session avoids the overheads associated with performing
public/private key authentication and reduces the overall latency
of the fetch process.

To make reuse work we cache the Session at the Transport instance
level and ask Transport API users to close the Transport once they
are completely done talking to this remote repository.  While the
Transport instance is unclosed however multiple FetchConnection
and/or PushConnections can be established, with each subsequent
connection being cheaper to setup.

In the future we may also support reusing the same Session onto
different Transport instances, permitting access to multiple
repositories hosted on the same remote SSH server.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/egit/core/op/CloneOperation.java   |   10 +++-
 .../egit/ui/internal/clone/SourceBranchPage.java   |    1 +
 .../spearce/jgit/transport/PushProcessTest.java    |    5 ++
 .../org/spearce/jgit/transport/TransportTest.java  |   10 +++
 .../src/org/spearce/jgit/pgm/Fetch.java            |   17 ++++--
 .../src/org/spearce/jgit/pgm/LsRemote.java         |    1 +
 .../src/org/spearce/jgit/transport/Transport.java  |   10 +++
 .../spearce/jgit/transport/TransportAmazonS3.java  |    5 ++
 .../spearce/jgit/transport/TransportBundle.java    |    5 ++
 .../spearce/jgit/transport/TransportGitAnon.java   |    5 ++
 .../spearce/jgit/transport/TransportGitSsh.java    |   60 +++++++++-----------
 .../org/spearce/jgit/transport/TransportHttp.java  |    5 ++
 .../org/spearce/jgit/transport/TransportLocal.java |    5 ++
 .../org/spearce/jgit/transport/TransportSftp.java  |   52 +++++++++---------
 14 files changed, 124 insertions(+), 67 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
index 7600e3b..656f3cb 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
@@ -85,8 +85,14 @@ public class CloneOperation implements IRunnableWithProgress {
 
 	private void doFetch(final IProgressMonitor monitor)
 			throws NotSupportedException, TransportException {
-		fetchResult = Transport.open(local, remote).fetch(
-				new EclipseGitProgressTransformer(monitor), null);
+		final Transport tn = Transport.open(local, remote);
+		try {
+			final EclipseGitProgressTransformer pm;
+			pm = new EclipseGitProgressTransformer(monitor);
+			fetchResult = tn.fetch(pm, null);
+		} finally {
+			tn.close();
+		}
 	}
 
 	private void doCheckout(final IProgressMonitor monitor) throws IOException {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
index b704aaa..b0aba1e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
@@ -241,6 +241,7 @@ class SourceBranchPage extends WizardPage {
 							adv = fn.getRefs();
 						} finally {
 							fn.close();
+							tn.close();
 						}
 
 						final Ref idHEAD = fn.getRef(Constants.HEAD);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
index fae1cbb..357e6b7 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
@@ -379,6 +379,11 @@ public class PushProcessTest extends RepositoryTestCase {
 				TransportException {
 			return new MockPushConnection();
 		}
+
+		@Override
+		public void close() {
+			// nothing here
+		}
 	}
 
 	private class MockPushConnection extends BaseConnection implements
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
index 10f6651..dc1cb21 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
@@ -56,6 +56,16 @@ public class TransportTest extends RepositoryTestCase {
 		final RepositoryConfig config = db.getConfig();
 		remoteConfig = new RemoteConfig(config, "test");
 		remoteConfig.addURI(new URIish("http://everyones.loves.git/u/2"));
+		transport = null;
+	}
+
+	@Override
+	protected void tearDown() throws Exception {
+		if (transport != null) {
+			transport.close();
+			transport = null;
+		}
+		super.tearDown();
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
index 36a0592..c361c26 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
@@ -63,12 +63,17 @@ class Fetch extends TextBuiltin {
 			args = new String[] { "origin" };
 
 		final Transport tn = Transport.open(db, args[argi++]);
-		final List<RefSpec> toget = new ArrayList<RefSpec>();
-		for (; argi < args.length; argi++)
-			toget.add(new RefSpec(args[argi]));
-		final FetchResult r = tn.fetch(new TextProgressMonitor(), toget);
-		if (r.getTrackingRefUpdates().isEmpty())
-			return;
+		final FetchResult r;
+		try {
+			final List<RefSpec> toget = new ArrayList<RefSpec>();
+			for (; argi < args.length; argi++)
+				toget.add(new RefSpec(args[argi]));
+			r = tn.fetch(new TextProgressMonitor(), toget);
+			if (r.getTrackingRefUpdates().isEmpty())
+				return;
+		} finally {
+			tn.close();
+		}
 
 		out.print("From ");
 		out.print(tn.getURI().setPass(null));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsRemote.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/LsRemote.java
index dbdfeb3..21e02ec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsRemote.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/LsRemote.java
@@ -70,6 +70,7 @@ class LsRemote extends TextBuiltin {
 			}
 		} finally {
 			c.close();
+			tn.close();
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index b962162..5bec4d2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -527,6 +527,16 @@ public abstract class Transport {
 	public abstract PushConnection openPush() throws NotSupportedException,
 			TransportException;
 
+	/**
+	 * Close any resources used by this transport.
+	 * <p>
+	 * If the remote repository is contacted by a network socket this method
+	 * must close that network socket, disconnecting the two peers. If the
+	 * remote repository is actually local (same system) this method must close
+	 * any open file handles used to read the "remote" repository.
+	 */
+	public abstract void close();
+
 	private Collection<RefSpec> expandPushWildcardsFor(
 			final Collection<RefSpec> specs) {
 		final Map<String, Ref> localRefs = local.getAllRefs();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
index cd62c5b..9aa2567 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
@@ -159,6 +159,11 @@ class TransportAmazonS3 extends WalkTransport {
 		return r;
 	}
 
+	@Override
+	public void close() {
+		// No explicit connections are maintained.
+	}
+
 	class DatabaseS3 extends WalkRemoteObjectDatabase {
 		private final String bucketName;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 6169179..24d49eb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -101,6 +101,11 @@ class TransportBundle extends PackTransport {
 				"Push is not supported for bundle transport");
 	}
 
+	@Override
+	public void close() {
+		// Resources must be established per-connection.
+	}
+
 	class BundleFetchConnection extends BaseFetchConnection {
 		FileInputStream in;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index 8a78099..a80c335 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -77,6 +77,11 @@ class TransportGitAnon extends PackTransport {
 		return new TcpPushConnection();
 	}
 
+	@Override
+	public void close() {
+		// Resources must be established per-connection.
+	}
+
 	Socket openConnection() throws TransportException {
 		final int port = uri.getPort() > 0 ? uri.getPort() : GIT_PORT;
 		try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index 1bbdf04..b169f4c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -78,7 +78,10 @@ class TransportGitSsh extends PackTransport {
 		return false;
 	}
 
-	final SshSessionFactory sch;
+	private final SshSessionFactory sch;
+
+	private Session sock;
+
 	OutputStream errStream;
 
 	TransportGitSsh(final Repository local, final URIish uri) {
@@ -96,6 +99,17 @@ class TransportGitSsh extends PackTransport {
 		return new SshPushConnection();
 	}
 
+	@Override
+	public void close() {
+		if (sock != null) {
+			try {
+				sch.releaseSession(sock);
+			} finally {
+				sock = null;
+			}
+		}
+	}
+
 	private static void sqMinimal(final StringBuilder cmd, final String val) {
 		if (val.matches("^[a-zA-Z0-9._/-]*$")) {
 			// If the string matches only generally safe characters
@@ -152,17 +166,18 @@ class TransportGitSsh extends PackTransport {
 		cmd.append('\'');
 	}
 
-	Session openSession() throws TransportException {
+	private void initSession() throws TransportException {
+		if (sock != null)
+			return;
+
 		final String user = uri.getUser();
 		final String pass = uri.getPass();
 		final String host = uri.getHost();
 		final int port = uri.getPort();
 		try {
-			final Session session;
-			session = sch.getSession(user, pass, host, port);
-			if (!session.isConnected())
-				session.connect();
-			return session;
+			sock = sch.getSession(user, pass, host, port);
+			if (!sock.isConnected())
+				sock.connect();
 		} catch (JSchException je) {
 			final Throwable c = je.getCause();
 			if (c instanceof UnknownHostException)
@@ -173,8 +188,9 @@ class TransportGitSsh extends PackTransport {
 		}
 	}
 
-	ChannelExec exec(final Session sock, final String exe)
-			throws TransportException {
+	ChannelExec exec(final String exe) throws TransportException {
+		initSession();
+
 		try {
 			final ChannelExec channel = (ChannelExec) sock.openChannel("exec");
 			String path = uri.getPath();
@@ -202,15 +218,12 @@ class TransportGitSsh extends PackTransport {
 	}
 
 	class SshFetchConnection extends BasePackFetchConnection {
-		private Session session;
-
 		private ChannelExec channel;
 
 		SshFetchConnection() throws TransportException {
 			super(TransportGitSsh.this);
 			try {
-				session = openSession();
-				channel = exec(session, getOptionUploadPack());
+				channel = exec(getOptionUploadPack());
 
 				if (channel.isConnected())
 					init(channel.getInputStream(), channel.getOutputStream());
@@ -240,27 +253,16 @@ class TransportGitSsh extends PackTransport {
 					channel = null;
 				}
 			}
-
-			if (session != null) {
-				try {
-					sch.releaseSession(session);
-				} finally {
-					session = null;
-				}
-			}
 		}
 	}
 
 	class SshPushConnection extends BasePackPushConnection {
-		private Session session;
-
 		private ChannelExec channel;
 
 		SshPushConnection() throws TransportException {
 			super(TransportGitSsh.this);
 			try {
-				session = openSession();
-				channel = exec(session, getOptionReceivePack());
+				channel = exec(getOptionReceivePack());
 				init(channel.getInputStream(), channel.getOutputStream());
 			} catch (TransportException err) {
 				close();
@@ -285,14 +287,6 @@ class TransportGitSsh extends PackTransport {
 					channel = null;
 				}
 			}
-
-			if (session != null) {
-				try {
-					sch.releaseSession(session);
-				} finally {
-					session = null;
-				}
-			}
 		}
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
index 9351a12..1357e58 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
@@ -106,6 +106,11 @@ class TransportHttp extends WalkTransport {
 		return r;
 	}
 
+	@Override
+	public void close() {
+		// No explicit connections are maintained.
+	}
+
 	class HttpObjectDB extends WalkRemoteObjectDatabase {
 		private final URL objectsUrl;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index 155d59f..d74f1b3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -93,6 +93,11 @@ class TransportLocal extends PackTransport {
 		return new LocalPushConnection();
 	}
 
+	@Override
+	public void close() {
+		// Resources must be established per-connection.
+	}
+
 	protected Process startProcessWithErrStream(final String cmd)
 			throws TransportException {
 		try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index c2cbe6a..6a5df07 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -91,7 +91,9 @@ class TransportSftp extends WalkTransport {
 		return uri.isRemote() && "sftp".equals(uri.getScheme());
 	}
 
-	final SshSessionFactory sch;
+	private final SshSessionFactory sch;
+
+	private Session sock;
 
 	TransportSftp(final Repository local, final URIish uri) {
 		super(local, uri);
@@ -114,17 +116,29 @@ class TransportSftp extends WalkTransport {
 		return r;
 	}
 
-	Session openSession() throws TransportException {
+	@Override
+	public void close() {
+		if (sock != null) {
+			try {
+				sch.releaseSession(sock);
+			} finally {
+				sock = null;
+			}
+		}
+	}
+
+	private void initSession() throws TransportException {
+		if (sock != null)
+			return;
+
 		final String user = uri.getUser();
 		final String pass = uri.getPass();
 		final String host = uri.getHost();
 		final int port = uri.getPort();
 		try {
-			final Session session;
-			session = sch.getSession(user, pass, host, port);
-			if (!session.isConnected())
-				session.connect();
-			return session;
+			sock = sch.getSession(user, pass, host, port);
+			if (!sock.isConnected())
+				sock.connect();
 		} catch (JSchException je) {
 			final Throwable c = je.getCause();
 			if (c instanceof UnknownHostException)
@@ -135,7 +149,9 @@ class TransportSftp extends WalkTransport {
 		}
 	}
 
-	ChannelSftp open(final Session sock) throws TransportException {
+	ChannelSftp newSftp() throws TransportException {
+		initSession();
+
 		try {
 			final Channel channel = sock.openChannel("sftp");
 			channel.connect();
@@ -148,10 +164,6 @@ class TransportSftp extends WalkTransport {
 	class SftpObjectDB extends WalkRemoteObjectDatabase {
 		private final String objectsPath;
 
-		private final boolean sessionOwner;
-
-		private Session session;
-
 		private ChannelSftp ftp;
 
 		SftpObjectDB(String path) throws TransportException {
@@ -160,9 +172,7 @@ class TransportSftp extends WalkTransport {
 			if (path.startsWith("~/"))
 				path = path.substring(2);
 			try {
-				session = openSession();
-				sessionOwner = true;
-				ftp = TransportSftp.this.open(session);
+				ftp = newSftp();
 				ftp.cd(path);
 				ftp.cd("objects");
 				objectsPath = ftp.pwd();
@@ -177,10 +187,8 @@ class TransportSftp extends WalkTransport {
 
 		SftpObjectDB(final SftpObjectDB parent, final String p)
 				throws TransportException {
-			sessionOwner = false;
-			session = parent.session;
 			try {
-				ftp = TransportSftp.this.open(session);
+				ftp = newSftp();
 				ftp.cd(parent.objectsPath);
 				ftp.cd(p);
 				objectsPath = ftp.pwd();
@@ -452,14 +460,6 @@ class TransportSftp extends WalkTransport {
 					ftp = null;
 				}
 			}
-
-			if (sessionOwner && session != null) {
-				try {
-					sch.releaseSession(session);
-				} finally {
-					session = null;
-				}
-			}
 		}
 	}
 }
-- 
1.5.6.2.393.g45096
