From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Switch local fetch connection to use our own UploadPack
Date: Tue, 23 Dec 2008 14:56:47 -0800
Message-ID: <1230073007-17337-6-git-send-email-spearce@spearce.org>
References: <1230073007-17337-1-git-send-email-spearce@spearce.org>
 <1230073007-17337-2-git-send-email-spearce@spearce.org>
 <1230073007-17337-3-git-send-email-spearce@spearce.org>
 <1230073007-17337-4-git-send-email-spearce@spearce.org>
 <1230073007-17337-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 23:58:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFGD2-0004pX-1a
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 23:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYLWW5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 17:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbYLWW5B
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 17:57:01 -0500
Received: from george.spearce.org ([209.20.77.23]:51458 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbYLWW4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 17:56:52 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id A621E38210; Tue, 23 Dec 2008 22:56:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 48BDA3821F;
	Tue, 23 Dec 2008 22:56:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230073007-17337-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103853>

Just like with push, we now use our own version of upload pack to
perform a fetch from a local repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/BasePackFetchConnection.java    |    2 +
 .../org/spearce/jgit/transport/TransportLocal.java |   96 +++++++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 1fe504b..19ac161 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -86,6 +86,8 @@
 	 */
 	private static final int MAX_HAVES = 256;
 
+	protected static final int MAX_CLIENT_BUFFER = MAX_HAVES * 46 + 1024;
+
 	static final String OPTION_INCLUDE_TAG = "include-tag";
 
 	static final String OPTION_MULTI_ACK = "multi_ack";
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index b5dd5fc..17d95c2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -86,7 +86,10 @@ TransportLocal(final Repository local, final URIish uri) {
 
 	@Override
 	public FetchConnection openFetch() throws TransportException {
-		return new LocalFetchConnection();
+		final String up = getOptionUploadPack();
+		if ("git-upload-pack".equals(up) || "git upload-pack".equals(up))
+			return new InternalLocalFetchConnection();
+		return new ForkLocalFetchConnection();
 	}
 
 	@Override
@@ -130,10 +133,97 @@ protected Process startProcessWithErrStream(final String cmd)
 		}
 	}
 
-	class LocalFetchConnection extends BasePackFetchConnection {
+	class InternalLocalFetchConnection extends BasePackFetchConnection {
+		private Thread worker;
+
+		InternalLocalFetchConnection() throws TransportException {
+			super(TransportLocal.this);
+
+			final Repository dst;
+			try {
+				dst = new Repository(remoteGitDir);
+			} catch (IOException err) {
+				throw new TransportException(uri, "not a git directory");
+			}
+
+			final PipedInputStream in_r;
+			final PipedOutputStream in_w;
+
+			final PipedInputStream out_r;
+			final PipedOutputStream out_w;
+			try {
+				in_r = new PipedInputStream();
+				in_w = new PipedOutputStream(in_r);
+
+				out_r = new PipedInputStream() {
+					// The client (BasePackFetchConnection) can write
+					// a huge burst before it reads again. We need to
+					// force the buffer to be big enough, otherwise it
+					// will deadlock both threads.
+					{
+						buffer = new byte[MAX_CLIENT_BUFFER];
+					}
+				};
+				out_w = new PipedOutputStream(out_r);
+			} catch (IOException err) {
+				dst.close();
+				throw new TransportException(uri, "cannot connect pipes", err);
+			}
+
+			worker = new Thread("JGit-Upload-Pack") {
+				public void run() {
+					try {
+						final UploadPack rp = new UploadPack(dst);
+						rp.upload(out_r, in_w, null);
+					} catch (IOException err) {
+						// Client side of the pipes should report the problem.
+						err.printStackTrace();
+					} catch (RuntimeException err) {
+						// Clients side will notice we went away, and report.
+						err.printStackTrace();
+					} finally {
+						try {
+							out_r.close();
+						} catch (IOException e2) {
+							// Ignore close failure, we probably crashed above.
+						}
+
+						try {
+							in_w.close();
+						} catch (IOException e2) {
+							// Ignore close failure, we probably crashed above.
+						}
+
+						dst.close();
+					}
+				}
+			};
+			worker.start();
+
+			init(in_r, out_w);
+			readAdvertisedRefs();
+		}
+
+		@Override
+		public void close() {
+			super.close();
+
+			if (worker != null) {
+				try {
+					worker.join();
+				} catch (InterruptedException ie) {
+					// Stop waiting and return anyway.
+				} finally {
+					worker = null;
+				}
+			}
+		}
+	}
+
+	class ForkLocalFetchConnection extends BasePackFetchConnection {
 		private Process uploadPack;
 
-		LocalFetchConnection() throws TransportException {
+		ForkLocalFetchConnection() throws TransportException {
 			super(TransportLocal.this);
 			uploadPack = startProcessWithErrStream(getOptionUploadPack());
 			init(uploadPack.getInputStream(), uploadPack.getOutputStream());
-- 
1.6.1.rc4.301.g5497a
