From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH/RFC] Removed possibility to change stderr for ssh 
	sessions
Date: Tue, 21 Apr 2009 22:49:56 +0400
Message-ID: <85647ef50904211149lc4a4902h554c973017d87adb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 20:52:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwL4U-0005ga-8U
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 20:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbZDUSuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 14:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757864AbZDUSuA
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 14:50:00 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:61456 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758759AbZDUSt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 14:49:58 -0400
Received: by fxm2 with SMTP id 2so2686981fxm.37
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=P9XJdT2WZNiExemSLV4p/yODKlPkZhwt1UNP64I5E/4=;
        b=TtCnH3nELHGogAsvgcu59H2hk2Dc3Hr8rJ9yc9lUgM0d8G/47mFMVpLEOVcZz1upOP
         1Z+0nJvcknLSUhBEB3ugVN0wE7iZHTxEfTQaa6qdPDTawTAyxnY8o3dlCvub7se1faKb
         Bh+7UQB216RXUvaYuuqXRmDY4Hn1a/8DRrFa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=a9kwiv8RVjMfSTiOAE6hTOWmNRwOZ5gm0QfbuM3gtX3hCRY6+XGma3F84iVzbvD5iF
         2GkJKm/NF7VU3v6Vg8jbphbD9BdSrFhHoVZmIbivnKyczmb/gZnTTqIJ83p7iTHfcsqC
         nZAsjiwvZxYswQy3OqBofbkW/g4yuZYbPy3zo=
Received: by 10.204.59.18 with SMTP id j18mr6752841bkh.206.1240339796581; Tue, 
	21 Apr 2009 11:49:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117149>

The current implementation allowed to change stderr for the
ssh sessions. However this functionality is broken. It is used
only by GitSshTransport and that class expects a very specific
behavior from this class. For example toString() method should
return the entire content of the stream. So only implementation
from SshConfigSessionFactory would have worked anyway. Returning
System.err (as was suggested by javadoc) comment would have broken
existing functionality. This patch makes this functionality
explicitly private.

If this functionality is to be reopened, this additional behavior
should be documented and there should be additional lifecycle
control, since the user streams will be interested to know when
stream will be no more used in order to release resoources.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../jgit/transport/SshConfigSessionFactory.java    |   34 -----------------
 .../spearce/jgit/transport/SshSessionFactory.java  |    8 +++--
 .../spearce/jgit/transport/TransportGitSsh.java    |   38 +++++++++++++++++++-
 3 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
index 4d29829..a87e149 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshConfigSessionFactory.java
@@ -43,7 +43,6 @@
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
-import java.io.OutputStream;
 import java.util.HashMap;
 import java.util.Map;

@@ -225,37 +224,4 @@ private static void loadIdentity(final JSch sch,
final File priv) {
 			}
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
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshSessionFactory.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/SshSessionFactory.java
index f03e80c..bd24d2f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshSessionFactory.java
@@ -125,10 +125,12 @@ public void releaseSession(final Session session) {
 	}

 	/**
-	 * Find or create an OutputStream for Ssh to use. For a command line client
-	 * this is probably System.err.
+	 * The method does not have to be implemented and will be removed in
future versions.
 	 *
 	 * @return an OutputStream to receive the SSH error stream.
 	 */
-	public abstract OutputStream getErrorStream();
+	@Deprecated
+	public OutputStream getErrorStream() {
+		throw new UnsupportedOperationException("This method should not be called.");
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index a24878a..bfe0259 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -137,7 +137,7 @@ ChannelExec exec(final String exe) throws
TransportException {
 			cmd.append(' ');
 			sqAlways(cmd, path);
 			channel.setCommand(cmd.toString());
-			errStream = SshSessionFactory.getInstance().getErrorStream();
+			errStream = createErrorStream();
 			channel.setErrStream(errStream, true);
 			channel.connect();
 			return channel;
@@ -146,6 +146,42 @@ ChannelExec exec(final String exe) throws
TransportException {
 		}
 	}

+	/**
+	 * @return the error stream for the channel, the stream is used to
detect specific
+	 *   error reasons for exceptions.
+	 */
+	private static OutputStream createErrorStream() {
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
+
 	NoRemoteRepositoryException cleanNotFound(NoRemoteRepositoryException nf) {
 		String why = errStream.toString();
 		if (why == null || why.length() == 0)
-- 
1.6.0.2.1172.ga5ed0
