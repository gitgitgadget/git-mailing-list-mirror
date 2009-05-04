From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/7] FindBugs: Fix use of byte[].toString() in error messages
Date: Mon,  4 May 2009 16:30:46 -0700
Message-ID: <1241479848-20687-5-git-send-email-spearce@spearce.org>
References: <1241479848-20687-1-git-send-email-spearce@spearce.org>
 <1241479848-20687-2-git-send-email-spearce@spearce.org>
 <1241479848-20687-3-git-send-email-spearce@spearce.org>
 <1241479848-20687-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Matthias Sohn <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue May 05 01:31:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M17dL-00068Y-HK
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 01:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbZEDXbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 19:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbZEDXa7
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 19:30:59 -0400
Received: from george.spearce.org ([209.20.77.23]:52555 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbZEDXau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 19:30:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D8555381D0; Mon,  4 May 2009 23:30:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1CCCA38196;
	Mon,  4 May 2009 23:30:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc4.206.g03e16
In-Reply-To: <1241479848-20687-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118274>

We meant to use typeString here, not encodedTypeString, as we want
a human-readable string form of the object type for display into
an exception message.  FindBugs caught us using a byte[] here and
not a string, resulting in a useless portion of the message text.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |    2 +-
 .../jgit/transport/WalkFetchConnection.java        |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 7881124..b2bcbb7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -744,7 +744,7 @@ private void verifySafeObject(final AnyObjectId id, final int type,
 				objCheck.check(type, data);
 			} catch (CorruptObjectException e) {
 				throw new IOException("Invalid "
-						+ Constants.encodedTypeString(type) + " " + id.name()
+						+ Constants.typeString(type) + " " + id.name()
 						+ ":" + e.getMessage());
 			}
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 06b2c87..4d14305 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -602,7 +602,7 @@ private void verifyLooseObject(final AnyObjectId id, final byte[] compressed)
 		if (!AnyObjectId.equals(id, idBuffer)) {
 			throw new TransportException("Incorrect hash for " + id.name()
 					+ "; computed " + idBuffer.name() + " as a "
-					+ Constants.encodedTypeString(uol.getType()) + " from "
+					+ Constants.typeString(uol.getType()) + " from "
 					+ compressed.length + " bytes.");
 		}
 		if (objCheck != null) {
@@ -610,7 +610,7 @@ private void verifyLooseObject(final AnyObjectId id, final byte[] compressed)
 				objCheck.check(uol.getType(), uol.getCachedBytes());
 			} catch (CorruptObjectException e) {
 				throw new TransportException("Invalid "
-						+ Constants.encodedTypeString(uol.getType()) + " "
+						+ Constants.typeString(uol.getType()) + " "
 						+ id.name() + ":" + e.getMessage());
 			}
 		}
-- 
1.6.3.rc4.206.g03e16
