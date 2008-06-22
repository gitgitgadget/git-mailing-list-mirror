From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Take care of errors reported from the server when upload command is started
Date: Sun, 22 Jun 2008 19:46:35 +0200
Message-ID: <1214156797-29186-1-git-send-email-robin.rosenberg@dewire.com>
References: <20080622013640.GA18629@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 21:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAUoV-0004am-TC
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 21:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYFVTAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbYFVTAb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 15:00:31 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:63567 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753353AbYFVTA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 15:00:26 -0400
Received: from localhost.localdomain (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB003C2067; Sun, 22 Jun 2008 19:50:28 +0200
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <20080622013640.GA18629@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85793>

When JSch cannot launch the command our SSH Channel will close immediately
in connect, resulting in a NullPointerException and a closed System.err
silencing an errors.

Using System.err for errors also means we get no feedback when using from
Eclipse.
---
 .../spearce/egit/ui/EclipseSshSessionFactory.java  |   29 ++++++++++++++++++++
 .../jgit/transport/DefaultSshSessionFactory.java   |    6 ++++
 .../spearce/jgit/transport/SshSessionFactory.java  |   10 +++++++
 .../spearce/jgit/transport/TransportGitSsh.java    |   12 +++++++-
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
index 5005494..144d47d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
@@ -8,6 +8,8 @@
  *******************************************************************************/
 package org.spearce.egit.ui;
 
+import java.io.IOException;
+import java.io.OutputStream;
 import java.security.AccessController;
 import java.security.PrivilegedAction;
 
@@ -44,4 +46,31 @@ class EclipseSshSessionFactory extends SshSessionFactory {
 			}
 		});
 	}
+
+	@Override
+	public OutputStream getErrorStream() {
+		return new OutputStream() {
+
+			StringBuilder all = new StringBuilder();
+			StringBuilder sb = new StringBuilder();
+
+			public String toString() {
+				return all.toString();
+			}
+
+			@Override
+			public void write(int b) throws IOException {
+				if (b == '\r')
+					return;
+				sb.append((char) b);
+				if (b == '\n') {
+					String s = sb.toString();
+					all.append(s);
+					sb = new StringBuilder();
+					Activator.logError(s, new Throwable());
+				}
+			}
+		};
+	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 8a59904..5924a04 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -46,6 +46,7 @@ import java.io.File;
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
+import java.io.OutputStream;
 import java.security.AccessController;
 import java.security.PrivilegedAction;
 
@@ -249,4 +250,9 @@ class DefaultSshSessionFactory extends SshSessionFactory {
 			return null; // cancel
 		}
 	}
+
+	@Override
+	public OutputStream getErrorStream() {
+		return System.err;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SshSessionFactory.java
index 7f8136d..4c9eae0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshSessionFactory.java
@@ -38,6 +38,8 @@
 
 package org.spearce.jgit.transport;
 
+import java.io.OutputStream;
+
 import com.jcraft.jsch.JSchException;
 import com.jcraft.jsch.Session;
 
@@ -121,4 +123,12 @@ public abstract class SshSessionFactory {
 		if (session.isConnected())
 			session.disconnect();
 	}
+
+	/**
+	 * Find or create an OutputStream for Ssh to use. For a command line client
+	 * this is probably System.err.
+	 * 
+	 * @return an OutputStream to receive the SSH error stream.
+	 */
+	public abstract OutputStream getErrorStream();
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index 8944df7..82723a3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -39,6 +39,7 @@
 package org.spearce.jgit.transport;
 
 import java.io.IOException;
+import java.io.OutputStream;
 import java.net.ConnectException;
 import java.net.UnknownHostException;
 
@@ -77,6 +78,7 @@ class TransportGitSsh extends PackTransport {
 	}
 
 	final SshSessionFactory sch;
+	OutputStream errStream;
 
 	TransportGitSsh(final Repository local, final URIish uri) {
 		super(local, uri);
@@ -179,7 +181,8 @@ class TransportGitSsh extends PackTransport {
 			cmd.append(' ');
 			sqAlways(cmd, path);
 			channel.setCommand(cmd.toString());
-			channel.setErrStream(System.err);
+			errStream = SshSessionFactory.getInstance().getErrorStream();
+			channel.setErrStream(errStream, true); 
 			channel.connect();
 			return channel;
 		} catch (JSchException je) {
@@ -198,7 +201,12 @@ class TransportGitSsh extends PackTransport {
 			try {
 				session = openSession();
 				channel = exec(session, getOptionUploadPack());
-				init(channel.getInputStream(), channel.getOutputStream());
+
+				if (channel.isConnected())
+					init(channel.getInputStream(), channel.getOutputStream());
+				else
+					throw new TransportException(errStream.toString());
+					
 			} catch (TransportException err) {
 				close();
 				throw err;
-- 
1.5.5.1.178.g1f811
