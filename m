From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/7] Include URIish in bundle transport within any TransportExceptions
Date: Thu,  4 Sep 2008 16:42:17 -0700
Message-ID: <1220571739-4219-6-git-send-email-spearce@spearce.org>
References: <1220571739-4219-1-git-send-email-spearce@spearce.org>
 <1220571739-4219-2-git-send-email-spearce@spearce.org>
 <1220571739-4219-3-git-send-email-spearce@spearce.org>
 <1220571739-4219-4-git-send-email-spearce@spearce.org>
 <1220571739-4219-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOUu-0000st-4t
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbYIDXmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbYIDXmb
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:42:31 -0400
Received: from george.spearce.org ([209.20.77.23]:33775 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbYIDXmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:42:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A00EC383A6; Thu,  4 Sep 2008 23:42:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 884EA3835F;
	Thu,  4 Sep 2008 23:42:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
In-Reply-To: <1220571739-4219-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94980>

This way the bundle path (as entered by the user) is reported as
part of the error.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/TransportBundle.java    |   21 ++++++++-----------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index e502619..de62fb8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -128,7 +128,7 @@ BundleFetchConnection() throws TransportException {
 				in = new FileInputStream(bundle);
 				bin = new RewindBufferedInputStream(in);
 			} catch (FileNotFoundException err) {
-				throw new TransportException(bundle.getPath() + ": not found");
+				throw new TransportException(uri, "not found");
 			}
 
 			try {
@@ -137,8 +137,7 @@ BundleFetchConnection() throws TransportException {
 					readBundleV2();
 					break;
 				default:
-					throw new TransportException(bundle.getPath()
-							+ ": not a bundle");
+					throw new TransportException(uri, "not a bundle");
 				}
 
 				in.getChannel().position(
@@ -149,12 +148,10 @@ BundleFetchConnection() throws TransportException {
 				throw err;
 			} catch (IOException err) {
 				close();
-				throw new TransportException(bundle.getPath() + ": "
-						+ err.getMessage(), err);
+				throw new TransportException(uri, err.getMessage(), err);
 			} catch (RuntimeException err) {
 				close();
-				throw new TransportException(bundle.getPath() + ": "
-						+ err.getMessage(), err);
+				throw new TransportException(uri, err.getMessage(), err);
 			}
 		}
 
@@ -162,7 +159,7 @@ private int readSignature() throws IOException {
 			final String rev = readLine(new byte[1024]);
 			if (V2_BUNDLE_SIGNATURE.equals(rev))
 				return 2;
-			throw new TransportException(bundle.getPath() + ": not a bundle");
+			throw new TransportException(uri, "not a bundle");
 		}
 
 		private void readBundleV2() throws IOException {
@@ -189,8 +186,8 @@ private void readBundleV2() throws IOException {
 		}
 
 		private PackProtocolException duplicateAdvertisement(final String name) {
-			return new PackProtocolException("duplicate advertisements of "
-					+ name);
+			return new PackProtocolException(uri,
+					"duplicate advertisements of " + name);
 		}
 
 		private String readLine(final byte[] hdrbuf) throws IOException {
@@ -217,10 +214,10 @@ protected void doFetch(final ProgressMonitor monitor,
 				ip.renameAndOpenPack();
 			} catch (IOException err) {
 				close();
-				throw new TransportException(err.getMessage(), err);
+				throw new TransportException(uri, err.getMessage(), err);
 			} catch (RuntimeException err) {
 				close();
-				throw new TransportException(err.getMessage(), err);
+				throw new TransportException(uri, err.getMessage(), err);
 			}
 		}
 
-- 
1.6.0.1.319.g9f32b
