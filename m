From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 1/3] Fix retrieval of test resources for paths
	containing spaces
Date: Wed, 22 Oct 2008 10:32:18 +0200
Message-ID: <20081022083217.GA17940@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 10:33:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZA1-0005kM-QA
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbYJVIcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYJVIcV
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:32:21 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:57288 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbYJVIcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:32:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 7FBB619BC0F;
	Wed, 22 Oct 2008 10:32:19 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24296-04; Wed, 22 Oct 2008 10:32:18 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 36B5A19BC0E;
	Wed, 22 Oct 2008 10:32:18 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1D9086DFB62; Wed, 22 Oct 2008 10:31:03 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 1764B4F9FA3; Wed, 22 Oct 2008 10:32:18 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98844>

The use of URL.getPath() can be problematic when the repository path
contains spaces since they get encoded as %20, which will lead to a "No
such file" error when resolving to a local file. The fix first tries to
convert the resource URL to a URI (added in Java 1.5), which is then
used to construct the File instance. As a fallback use the old behavior
if a URISyntaxException is thrown.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index bf2471d..eee0c14 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.util;
 
 import java.io.File;
+import java.net.URISyntaxException;
 import java.net.URL;
 
 public abstract class JGitTestUtil {
@@ -57,7 +58,11 @@ public static File getTestResourceFile(final String fileName) {
 			// loaded previously
 			return new File("tst", fileName);
 		}
-		return new File(url.getPath());
+		try {
+			return new File(url.toURI());
+		} catch(URISyntaxException e) {
+			return new File(url.getPath());
+		}
 	}
 
 	private static ClassLoader cl() {
-- 
1.6.0.2.1166.g8d97a.dirty

-- 
Jonas Fonseca
