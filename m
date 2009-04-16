From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH 2/3] Moved common SSH related functionality to the base 
	class SshTransport
Date: Thu, 16 Apr 2009 18:04:42 +0400
Message-ID: <85647ef50904160704w1ef283bcn2f0e0a146ca63d69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 16:07:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuSEN-0000uG-2G
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 16:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZDPOEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 10:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbZDPOEq
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 10:04:46 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:43986 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZDPOEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 10:04:45 -0400
Received: by bwz17 with SMTP id 17so432126bwz.37
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=zUVObkCsXfd/s3g4Grl9RNDonhzcaqJXwOhiuX26kYM=;
        b=TuaMe0hSp4s5BrgB3QKHgVj/OdFuQcBZxHnuocPBpPXlZ2+87h5k/ad/xT9/fnOAqV
         he0RUPMG5ebSWZcDZp3RH+7pH+rjv4ARJ+NOEiJ3WQe23TlnJ0vUP/gZFIiT7VxMF4h7
         jHXELdWZcFDjjqQUpFnv4HDC6H+jALSISHHu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=wagrX37TelwKNLPK/RDH60O1uOJcoQyxhydaPWz041pXKeB8CgsE8SjvglxEk48y7A
         ZF4e7m2Xrwleyp6Lfzf/UOk/cMNm5GEBW6NZmQPL0Cn/ypcWw6uK9fGVqKa1Q1fFAKHU
         9o1ASQwQ8gtizdGnfZFXAus8pdAVB5PoJh09A=
Received: by 10.204.72.15 with SMTP id k15mr1324940bkj.14.1239890682938; Thu, 
	16 Apr 2009 07:04:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116703>

The common SSH-related functionality moved from subclasses
to base class (creating and closing sessions). The ability
to configure SSH session factory was added as well.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../org/spearce/jgit/transport/SshTransport.java   |   84 +++++++++++++++++++-
 .../spearce/jgit/transport/TransportGitSsh.java    |   40 ---------
 .../org/spearce/jgit/transport/TransportSftp.java  |   41 ----------
 3 files changed, 82 insertions(+), 83 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
index 4532590..f053f28 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
@@ -37,14 +37,28 @@
  */
 package org.spearce.jgit.transport;

+import java.net.ConnectException;
+import java.net.UnknownHostException;
+
+import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;

+import com.jcraft.jsch.JSchException;
+import com.jcraft.jsch.Session;
+
 /**
- * The base class for transports that use SSH protocol. This class
- * allows customizing SSH connection settings.
+ * The base class for transports that use SSH protocol. This class allows
+ * customizing SSH connection settings.
  */
 public abstract class SshTransport extends TcpTransport {

+	private SshSessionFactory sch;
+
+	/**
+	 * The open SSH session
+	 */
+	protected Session sock;
+
 	/**
 	 * Create a new transport instance.
 	 *
@@ -58,5 +72,71 @@
 	 */
 	public SshTransport(Repository local, URIish uri) {
 		super(local, uri);
+		sch = SshSessionFactory.getInstance();
+	}
+
+	/**
+	 * Set SSH session factory instead of the default one for this instance of
+	 * the transport.
+	 *
+	 * @param factory
+	 *            a factory to set, must not be null
+	 * @throws IllegalStateException
+	 *             if session has been already created.
+	 */
+	public void setSshSessionFactory(SshSessionFactory factory) {
+		if (factory == null)
+			throw new NullPointerException("The factory must not be null");
+		if (sock != null)
+			throw new IllegalStateException(
+					"An SSH session has been already created");
+		sch = factory;
+	}
+
+	/**
+	 * @return the SSH session factory that will be used for creating SSH sessions
+	 */
+	public SshSessionFactory getSshSessionFactory() {
+		return sch;
+	}
+
+
+	/**
+	 * Initialize SSH session
+	 *
+	 * @throws TransportException
+	 *             in case of error with opening SSH session
+	 */
+	protected void initSession() throws TransportException {
+		if (sock != null)
+			return;
+
+		final String user = uri.getUser();
+		final String pass = uri.getPass();
+		final String host = uri.getHost();
+		final int port = uri.getPort();
+		try {
+			sock = sch.getSession(user, pass, host, port);
+			if (!sock.isConnected())
+				sock.connect();
+		} catch (JSchException je) {
+			final Throwable c = je.getCause();
+			if (c instanceof UnknownHostException)
+				throw new TransportException(uri, "unknown host");
+			if (c instanceof ConnectException)
+				throw new TransportException(uri, c.getMessage());
+			throw new TransportException(uri, je.getMessage(), je);
+		}
+	}
+
+	@Override
+	public void close() {
+		if (sock != null) {
+			try {
+				sch.releaseSession(sock);
+			} finally {
+				sock = null;
+			}
+		}
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index 1f69ed7..a24878a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -41,8 +41,6 @@

 import java.io.IOException;
 import java.io.OutputStream;
-import java.net.ConnectException;
-import java.net.UnknownHostException;

 import org.spearce.jgit.errors.NoRemoteRepositoryException;
 import org.spearce.jgit.errors.TransportException;
@@ -51,7 +49,6 @@

 import com.jcraft.jsch.ChannelExec;
 import com.jcraft.jsch.JSchException;
-import com.jcraft.jsch.Session;

 /**
  * Transport through an SSH tunnel.
@@ -80,15 +77,10 @@ static boolean canHandle(final URIish uri) {
 		return false;
 	}

-	private final SshSessionFactory sch;
-
-	private Session sock;
-
 	OutputStream errStream;

 	TransportGitSsh(final Repository local, final URIish uri) {
 		super(local, uri);
-		sch = SshSessionFactory.getInstance();
 	}

 	@Override
@@ -101,17 +93,6 @@ public PushConnection openPush() throws TransportException {
 		return new SshPushConnection();
 	}

-	@Override
-	public void close() {
-		if (sock != null) {
-			try {
-				sch.releaseSession(sock);
-			} finally {
-				sock = null;
-			}
-		}
-	}
-
 	private static void sqMinimal(final StringBuilder cmd, final String val) {
 		if (val.matches("^[a-zA-Z0-9._/-]*$")) {
 			// If the string matches only generally safe characters
@@ -135,27 +116,6 @@ private static void sq(final StringBuilder cmd,
final String val) {
 			cmd.append(QuotedString.BOURNE.quote(val));
 	}

-	private void initSession() throws TransportException {
-		if (sock != null)
-			return;
-
-		final String user = uri.getUser();
-		final String pass = uri.getPass();
-		final String host = uri.getHost();
-		final int port = uri.getPort();
-		try {
-			sock = sch.getSession(user, pass, host, port);
-			if (!sock.isConnected())
-				sock.connect();
-		} catch (JSchException je) {
-			final Throwable c = je.getCause();
-			if (c instanceof UnknownHostException)
-				throw new TransportException(uri, "unknown host");
-			if (c instanceof ConnectException)
-				throw new TransportException(uri, c.getMessage());
-			throw new TransportException(uri, je.getMessage(), je);
-		}
-	}

 	ChannelExec exec(final String exe) throws TransportException {
 		initSession();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index 50bd564..e18d128 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -41,8 +41,6 @@
 import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.OutputStream;
-import java.net.ConnectException;
-import java.net.UnknownHostException;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.Collections;
@@ -63,7 +61,6 @@
 import com.jcraft.jsch.Channel;
 import com.jcraft.jsch.ChannelSftp;
 import com.jcraft.jsch.JSchException;
-import com.jcraft.jsch.Session;
 import com.jcraft.jsch.SftpATTRS;
 import com.jcraft.jsch.SftpException;

@@ -92,13 +89,8 @@ static boolean canHandle(final URIish uri) {
 		return uri.isRemote() && "sftp".equals(uri.getScheme());
 	}

-	private final SshSessionFactory sch;
-
-	private Session sock;
-
 	TransportSftp(final Repository local, final URIish uri) {
 		super(local, uri);
-		sch = SshSessionFactory.getInstance();
 	}

 	@Override
@@ -117,39 +109,6 @@ public PushConnection openPush() throws
TransportException {
 		return r;
 	}

-	@Override
-	public void close() {
-		if (sock != null) {
-			try {
-				sch.releaseSession(sock);
-			} finally {
-				sock = null;
-			}
-		}
-	}
-
-	private void initSession() throws TransportException {
-		if (sock != null)
-			return;
-
-		final String user = uri.getUser();
-		final String pass = uri.getPass();
-		final String host = uri.getHost();
-		final int port = uri.getPort();
-		try {
-			sock = sch.getSession(user, pass, host, port);
-			if (!sock.isConnected())
-				sock.connect();
-		} catch (JSchException je) {
-			final Throwable c = je.getCause();
-			if (c instanceof UnknownHostException)
-				throw new TransportException(uri, "unknown host");
-			if (c instanceof ConnectException)
-				throw new TransportException(uri, c.getMessage());
-			throw new TransportException(uri, je.getMessage(), je);
-		}
-	}
-
 	ChannelSftp newSftp() throws TransportException {
 		initSession();

-- 
1.6.0.2.1172.ga5ed0
