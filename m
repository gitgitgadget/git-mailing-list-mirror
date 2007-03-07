From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/9] Fix mmap leak caused by reading bad indexes.
Date: Tue, 6 Mar 2007 20:44:11 -0500
Message-ID: <20070307014411.GC26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlEH-00070d-8W
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbXCGBo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbXCGBoz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49199 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161171AbXCGBoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlCD-0003oy-UB; Tue, 06 Mar 2007 20:44:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 35CD320FBAE; Tue,  6 Mar 2007 20:44:11 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41637>

If an index is corrupt, or is simply too new for us to understand,
we were leaking the mmap that held the entire content of the index.
This could be a considerable size on large projects, given that
the index is at least 24 bytes * nr_objects.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c13ef66..cfce7ac 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -430,8 +430,9 @@ void pack_report()
 		pack_mapped, peak_pack_mapped);
 }
 
-static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
-				void **idx_map_)
+static int check_packed_git_idx(const char *path,
+	unsigned long *idx_size_,
+	void **idx_map_)
 {
 	void *idx_map;
 	uint32_t *index;
@@ -446,6 +447,10 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 		return -1;
 	}
 	idx_size = st.st_size;
+	if (idx_size < 4 * 256 + 20 + 20) {
+		close(fd);
+		return error("index file %s is too small", path);
+	}
 	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
@@ -453,25 +458,25 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 	*idx_map_ = idx_map;
 	*idx_size_ = idx_size;
 
-	/* check index map */
-	if (idx_size < 4*256 + 20 + 20)
-		return error("index file %s is too small", path);
-
 	/* a future index format would start with this, as older git
 	 * binaries would fail the non-monotonic index check below.
 	 * give a nicer warning to the user if we can.
 	 */
-	if (index[0] == htonl(PACK_IDX_SIGNATURE))
+	if (index[0] == htonl(PACK_IDX_SIGNATURE)) {
+		munmap(idx_map, idx_size);
 		return error("index file %s is a newer version"
 			" and is not supported by this binary"
 			" (try upgrading GIT to a newer version)",
 			path);
+	}
 
 	nr = 0;
 	for (i = 0; i < 256; i++) {
 		unsigned int n = ntohl(index[i]);
-		if (n < nr)
+		if (n < nr) {
+			munmap(idx_map, idx_size);
 			return error("non-monotonic index %s", path);
+		}
 		nr = n;
 	}
 
@@ -482,8 +487,10 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 	 *  - 20-byte SHA1 of the packfile
 	 *  - 20-byte SHA1 file checksum
 	 */
-	if (idx_size != 4*256 + nr * 24 + 20 + 20)
+	if (idx_size != 4*256 + nr * 24 + 20 + 20) {
+		munmap(idx_map, idx_size);
 		return error("wrong index file size in %s", path);
+	}
 
 	return 0;
 }
-- 
1.5.0.3.863.gf0989
