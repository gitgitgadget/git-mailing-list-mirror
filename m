From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/4] Refactor open_packed_git to return an error code.
Date: Thu, 1 Feb 2007 15:52:33 -0500
Message-ID: <20070201205233.GC19009@spearce.org>
References: <a0b03fc086bb66e2aa2e386dcb4ff97fc837f07f.1170363130.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:52:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCivA-0000UD-Un
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422994AbXBAUwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbXBAUwh
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:52:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43569 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422994AbXBAUwh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:52:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCiux-0005Ki-Ij; Thu, 01 Feb 2007 15:52:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DEEFD20FBAE; Thu,  1 Feb 2007 15:52:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <a0b03fc086bb66e2aa2e386dcb4ff97fc837f07f.1170363130.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38398>

Because I want to reuse open_packed_git in a context where I don't
want the process to die if the packfile in question is bogus, I'm
changing its behavior to return error("...") rather than die("...")
when it detects something is wrong with the packfile it was given.

Right now we still must die out of use_pack should open_packed_git
fail, as none of use_pack's callers are prepared to handle a failure
from that function.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4aef244..277319b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -552,7 +552,7 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-static void open_packed_git(struct packed_git *p)
+static int open_packed_git(struct packed_git *p)
 {
 	struct stat st;
 	struct pack_header hdr;
@@ -562,49 +562,50 @@ static void open_packed_git(struct packed_git *p)
 
 	p->pack_fd = open(p->pack_name, O_RDONLY);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
-		die("packfile %s cannot be opened", p->pack_name);
+		return -1;
 
 	/* If we created the struct before we had the pack we lack size. */
 	if (!p->pack_size) {
 		if (!S_ISREG(st.st_mode))
-			die("packfile %s not a regular file", p->pack_name);
+			return error("packfile %s not a regular file", p->pack_name);
 		p->pack_size = st.st_size;
 	} else if (p->pack_size != st.st_size)
-		die("packfile %s size changed", p->pack_name);
+		return error("packfile %s size changed", p->pack_name);
 
 	/* We leave these file descriptors open with sliding mmap;
 	 * there is no point keeping them open across exec(), though.
 	 */
 	fd_flag = fcntl(p->pack_fd, F_GETFD, 0);
 	if (fd_flag < 0)
-		die("cannot determine file descriptor flags");
+		return error("cannot determine file descriptor flags");
 	fd_flag |= FD_CLOEXEC;
 	if (fcntl(p->pack_fd, F_SETFD, fd_flag) == -1)
-		die("cannot set FD_CLOEXEC");
+		return error("cannot set FD_CLOEXEC");
 
 	/* Verify we recognize this pack file format. */
 	if (read_in_full(p->pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		die("file %s is far too short to be a packfile", p->pack_name);
+		return error("file %s is far too short to be a packfile", p->pack_name);
 	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
-		die("file %s is not a GIT packfile", p->pack_name);
+		return error("file %s is not a GIT packfile", p->pack_name);
 	if (!pack_version_ok(hdr.hdr_version))
-		die("packfile %s is version %u and not supported"
+		return error("packfile %s is version %u and not supported"
 			" (try upgrading GIT to a newer version)",
 			p->pack_name, ntohl(hdr.hdr_version));
 
 	/* Verify the pack matches its index. */
 	if (num_packed_objects(p) != ntohl(hdr.hdr_entries))
-		die("packfile %s claims to have %u objects"
+		return error("packfile %s claims to have %u objects"
 			" while index size indicates %u objects",
 			p->pack_name, ntohl(hdr.hdr_entries),
 			num_packed_objects(p));
 	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
-		die("end of packfile %s is unavailable", p->pack_name);
+		return error("end of packfile %s is unavailable", p->pack_name);
 	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) != sizeof(sha1))
-		die("packfile %s signature is unavailable", p->pack_name);
+		return error("packfile %s signature is unavailable", p->pack_name);
 	idx_sha1 = ((unsigned char *)p->index_base) + p->index_size - 40;
 	if (hashcmp(sha1, idx_sha1))
-		die("packfile %s does not match index", p->pack_name);
+		return error("packfile %s does not match index", p->pack_name);
+	return 0;
 }
 
 static int in_window(struct pack_window *win, unsigned long offset)
@@ -627,8 +628,8 @@ unsigned char* use_pack(struct packed_git *p,
 {
 	struct pack_window *win = *w_cursor;
 
-	if (p->pack_fd == -1)
-		open_packed_git(p);
+	if (p->pack_fd == -1 && open_packed_git(p))
+		die("packfile %s cannot be accessed", p->pack_name);
 
 	/* Since packfiles end in a hash of their content and its
 	 * pointless to ask for an offset into the middle of that
-- 
1.5.0.rc3.1.ge4b0e
