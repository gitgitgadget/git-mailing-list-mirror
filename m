From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] Revert "check_packed_git_idx(): check integrity of the idx file itself."
Date: Wed, 18 Jan 2006 20:34:22 -0800
Message-ID: <7vpsmokf8x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: romieu@fr.zoreil.com
X-From: git-owner@vger.kernel.org Thu Jan 19 05:34:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzRVE-00065g-P1
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 05:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWASEe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 23:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbWASEe0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 23:34:26 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:180 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161075AbWASEeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 23:34:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119043212.VULZ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 23:32:12 -0500
To: git@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14882>

Andrew noticed that this format-patch in the linux-2.6
repository runs very very very slowly.  I tried it myself and
found it to be 4x slowdown in a repository where I have both
commits still not packed:

   $ git format-patch 7c5c220e 7c4d3367

0.99.9m ran this with 20 seconds wallclock on a Duron 850, while
1.1.3 (and the master) took 47 seconds wallclock.  Comparing
user time is worse: 10 seconds vs 37 seconds.

It turns out that this is due to the pack idx file integrity
check I added about a month ago (bisect is cool -- thanks
Linus):

    commit c5ced64578a82b9d172aceb2f67c6fb9e639f6d9
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Thu Dec 22 22:57:20 2005 -0800

        check_packed_git_idx(): check integrity of the idx file itself.

        Although pack-check.c had routine to verify the checksum for the
        pack index file itself, the core did not check it before using
        it.

The potential problem I saw with the core before this fix was
that after mapping the pack idx file and did some sanity
checks, we did not check the checksum we had in the idx file
that made sure the idx file itself is not corrupt.  Doing it
everytime turned out to be quite expensive as illustrated by
this problem.  With the revert, the same test runs as fast as
0.99.9m used to.

git-fsck-objects should catch it if idx file is corrupt, so this
is removing suspender while we still have belt.

So I am going to propose reverting this "safety measure";
objections?

-- >8 --
Date: Wed Jan 18 20:26:14 2006 -0800

This reverts c5ced64578a82b9d172aceb2f67c6fb9e639f6d9 commit.
It turns out that doing this check every time we map the idx file
is quite expensive.  A corrupt idx file is caught by git-fsck-objects,
so this check is not strictly necessary.

In one unscientific test, 0.99.9m spent 10 seconds usertime for
the same task 1.1.3 takes 37 seconds usertime.  Reverting this gives
us the performance of 0.99.9 back.

---

 sha1_file.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

a53f669407a76d01c7271124d06366a2dbd5a12d
diff --git a/sha1_file.c b/sha1_file.c
index 8bebbb2..20f6419 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -349,16 +349,12 @@ struct packed_git *packed_git;
 static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 				void **idx_map_)
 {
-	SHA_CTX ctx;
-	unsigned char sha1[20];
 	void *idx_map;
 	unsigned int *index;
 	unsigned long idx_size;
 	int nr, i;
-	int fd;
+	int fd = open(path, O_RDONLY);
 	struct stat st;
-
-	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
 	if (fstat(fd, &st)) {
@@ -396,16 +392,6 @@ static int check_packed_git_idx(const ch
 	if (idx_size != 4*256 + nr * 24 + 20 + 20)
 		return error("wrong index file size");
 
-	/*
-	 * File checksum.
-	 */
-	SHA1_Init(&ctx);
-	SHA1_Update(&ctx, idx_map, idx_size-20);
-	SHA1_Final(sha1, &ctx);
-
-	if (memcmp(sha1, idx_map + idx_size - 20, 20))
-		return error("index checksum mismatch");
-
 	return 0;
 }
 
-- 
1.1.3.gce7b
