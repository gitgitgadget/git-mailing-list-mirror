From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Explicitly capture the stderr from a failed SSH fetch or push
Date: Thu, 10 Jul 2008 02:13:23 -0400
Message-ID: <1215670403-19191-6-git-send-email-spearce@spearce.org>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org>
 <1215670403-19191-2-git-send-email-spearce@spearce.org>
 <1215670403-19191-3-git-send-email-spearce@spearce.org>
 <1215670403-19191-4-git-send-email-spearce@spearce.org>
 <1215670403-19191-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 08:14:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGpQK-0004ug-7s
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 08:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbYGJGNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 02:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbYGJGNe
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 02:13:34 -0400
Received: from george.spearce.org ([209.20.77.23]:55201 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYGJGN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 02:13:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A7F94381FC; Thu, 10 Jul 2008 06:13:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0CF3C381FF;
	Thu, 10 Jul 2008 06:13:26 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1215670403-19191-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87943>

If the remote command name is not found on the remote system we are
likely to get a shell error sent to the channel's stderr stream,
and yet the channel is connected.  So we don't see the problem
until we try to read the advertised refs, which is somewhat late.

If we get EOF before the first advertised ref it is a very good
indication that the remote side did not start the process we wanted
it to.  Tossing a specialized exception allows the SSH transport
to offer up the contents of the stderr channel (if any) as possible
indication of why the repository does not exist.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/ui/EclipseSshSessionFactory.java  |    5 +-
 .../jgit/errors/NoRemoteRepositoryException.java   |   59 ++++++++++++++++++++
 .../spearce/jgit/transport/BasePackConnection.java |    3 +-
 .../jgit/transport/DefaultSshSessionFactory.java   |   30 ++++++++++-
 .../spearce/jgit/transport/TransportGitSsh.java    |   34 +++++++++++-
 5 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/NoRemoteRepositoryException.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
index 144d47d..8f80373 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
@@ -55,7 +55,10 @@ class EclipseSshSessionFactory extends SshSessionFactory {
 			StringBuilder sb = new StringBuilder();
 
 			public String toString() {
-				return all.toString();
+				String r = all.toString();
+				while (r.endsWith("\n"))
+					r = r.substring(0, r.length() - 1);
+				return r;
 			}
 
 			@Override
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/NoRemoteRepositoryException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/NoRemoteRepositoryException.java
new file mode 100644
index 0000000..604ec4d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/NoRemoteRepositoryException.java
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.errors;
+
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Indicates a remote repository does not exist.
+ */
+public class NoRemoteRepositoryException extends TransportException {
+	private static final long serialVersionUID = 1L;
+
+	/**
+	 * Constructs an exception indicating a repository does not exist.
+	 *
+	 * @param uri
+	 *            URI used for transport
+	 * @param s
+	 *            message
+	 */
+	public NoRemoteRepositoryException(final URIish uri, final String s) {
+		super(uri, s);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 7dc4620..52f3f48 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -49,6 +49,7 @@ import java.util.HashSet;
 import java.util.LinkedHashMap;
 import java.util.Set;
 
+import org.spearce.jgit.errors.NoRemoteRepositoryException;
 import org.spearce.jgit.errors.PackProtocolException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ObjectId;
@@ -129,7 +130,7 @@ abstract class BasePackConnection extends BaseConnection {
 				line = pckIn.readString();
 			} catch (EOFException eof) {
 				if (avail.isEmpty())
-					throw new TransportException(uri, "not found.");
+					throw new NoRemoteRepositoryException(uri, "not found.");
 				throw eof;
 			}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 5924a04..b4578d4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -253,6 +253,34 @@ class DefaultSshSessionFactory extends SshSessionFactory {
 
 	@Override
 	public OutputStream getErrorStream() {
-		return System.err;
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
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index 9a6c719..3f2cd37 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -44,6 +44,7 @@ import java.io.OutputStream;
 import java.net.ConnectException;
 import java.net.UnknownHostException;
 
+import org.spearce.jgit.errors.NoRemoteRepositoryException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;
 
@@ -217,6 +218,25 @@ class TransportGitSsh extends PackTransport {
 		}
 	}
 
+	NoRemoteRepositoryException cleanNotFound(NoRemoteRepositoryException nf) {
+		String why = errStream.toString();
+		if (why == null || why.length() == 0)
+			return nf;
+
+		String path = uri.getPath();
+		if (uri.getScheme() != null && uri.getPath().startsWith("/~"))
+			path = uri.getPath().substring(1);
+
+		final StringBuilder pfx = new StringBuilder();
+		pfx.append("fatal: ");
+		sqAlways(pfx, path);
+		pfx.append(": ");
+		if (why.startsWith(pfx.toString()))
+			why = why.substring(pfx.length());
+
+		return new NoRemoteRepositoryException(uri, why);
+	}
+
 	class SshFetchConnection extends BasePackFetchConnection {
 		private ChannelExec channel;
 
@@ -238,7 +258,12 @@ class TransportGitSsh extends PackTransport {
 				throw new TransportException(uri,
 						"remote hung up unexpectedly", err);
 			}
-			readAdvertisedRefs();
+
+			try {
+				readAdvertisedRefs();
+			} catch (NoRemoteRepositoryException notFound) {
+				throw cleanNotFound(notFound);
+			}
 		}
 
 		@Override
@@ -277,7 +302,12 @@ class TransportGitSsh extends PackTransport {
 				throw new TransportException(uri,
 						"remote hung up unexpectedly", err);
 			}
-			readAdvertisedRefs();
+
+			try {
+				readAdvertisedRefs();
+			} catch (NoRemoteRepositoryException notFound) {
+				throw cleanNotFound(notFound);
+			}
 		}
 
 		@Override
-- 
1.5.6.2.393.g45096
