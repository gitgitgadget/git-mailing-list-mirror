From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Remove read_or_die in favor of better error messages.
Date: Sun, 14 Jan 2007 01:01:49 -0500
Message-ID: <20070114060149.GA19249@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 07:02:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5yRO-0004KN-5s
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 07:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbXANGBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 01:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbXANGBy
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 01:01:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47511 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbXANGBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 01:01:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5yRD-00070m-Aa; Sun, 14 Jan 2007 01:01:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F3C0D20FBAE; Sun, 14 Jan 2007 01:01:49 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36795>

Originally I introduced read_or_die for the purpose of reading
the pack header and trailer, and I was too lazy to print proper
error messages.

Linus Torvalds <torvalds@osdl.org>:
> For a read error, at the very least you have to say WHICH FILE
> couldn't be read, because it's usually a matter of some file just
> being too short, not some system-wide problem.

and of course Linus is right. Make it so.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h        |    1 -
 sha1_file.c    |    6 ++++--
 write_or_die.c |   12 ------------
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index c482c32..620b6a4 100644
--- a/cache.h
+++ b/cache.h
@@ -434,7 +434,6 @@ extern char *git_log_output_encoding;
 
 extern int copy_fd(int ifd, int ofd);
 extern int read_in_full(int fd, void *buf, size_t count);
-extern void read_or_die(int fd, void *buf, size_t count);
 extern int write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
diff --git a/sha1_file.c b/sha1_file.c
index 2a5be53..1b1c0f7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -572,7 +572,8 @@ static void open_packed_git(struct packed_git *p)
 		die("cannot set FD_CLOEXEC");
 
 	/* Verify we recognize this pack file format. */
-	read_or_die(p->pack_fd, &hdr, sizeof(hdr));
+	if (read_in_full(p->pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+		die("file %s is far too short to be a packfile", p->pack_name);
 	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
 		die("file %s is not a GIT packfile", p->pack_name);
 	if (!pack_version_ok(hdr.hdr_version))
@@ -588,7 +589,8 @@ static void open_packed_git(struct packed_git *p)
 			num_packed_objects(p));
 	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
 		die("end of packfile %s is unavailable", p->pack_name);
-	read_or_die(p->pack_fd, sha1, sizeof(sha1));
+	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) != sizeof(sha1))
+		die("packfile %s signature is unavailable", p->pack_name);
 	idx_sha1 = ((unsigned char *)p->index_base) + p->index_size - 40;
 	if (hashcmp(sha1, idx_sha1))
 		die("packfile %s does not match index", p->pack_name);
diff --git a/write_or_die.c b/write_or_die.c
index 4e8183e..046e79d 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -17,18 +17,6 @@ int read_in_full(int fd, void *buf, size_t count)
 	return total;
 }
 
-void read_or_die(int fd, void *buf, size_t count)
-{
-	ssize_t loaded;
-
-	loaded = read_in_full(fd, buf, count);
-	if (loaded != count) {
-		if (loaded < 0)
-			die("read error (%s)", strerror(errno));
-		die("read error: end of file");
-	}
-}
-
 int write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
-- 
1.5.0.rc1.g4494
