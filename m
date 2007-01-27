From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] create_symref(): do not assume pathname from git_path() persists long enough
Date: Fri, 26 Jan 2007 17:49:00 -0800
Message-ID: <7vr6thqlwz.fsf@assigned-by-dhcp.cox.net>
References: <1169850371517-git-send-email-nico@cam.org>
	<11698503712588-git-send-email-nico@cam.org>
	<11698503712998-git-send-email-nico@cam.org>
	<1169850372648-git-send-email-nico@cam.org>
	<11698503722922-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 02:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAcgq-0001dq-Oq
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 02:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbXA0BtE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 20:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbXA0BtE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 20:49:04 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:50016 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbXA0BtD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 20:49:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127014901.EKWW3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 20:49:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G1o31W00C1kojtg0000000; Fri, 26 Jan 2007 20:48:03 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37911>

Being lazy to rely on the cycling N buffers mkpath() and friends
return is nice in general, but it makes it too easy to introduce
new bugs that are "mysterious".

Introduction of read_ref() in create_symref() after calling
git_path() to get the git_HEAD value (i.e. the path to create a
new symref at) consumed more than the available buffers and
broke a later call to mkpath() that derives lockpath from it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * t7201-co.sh caught three failures.  The problem this patch is
   fixing overwrote and gave ".lock" in lockpath, then open() on
   that path failed and gave fd = -1 (because I scratched my
   head and re-run the test without cleaning, and O_EXCL
   triggered), which threw write_in_full() into infinite loop,
   which will be fixed with the next patch.

 refs.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 5913185..4a52308 100644
--- a/refs.c
+++ b/refs.c
@@ -992,7 +992,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	const char *lockpath;
 	char ref[1000];
 	int fd, len, written;
-	const char *git_HEAD = git_path("%s", ref_target);
+	char *git_HEAD = xstrdup(git_path("%s", ref_target));
 	unsigned char old_sha1[20], new_sha1[20];
 
 	if (logmsg && read_ref(ref_target, old_sha1))
@@ -1010,36 +1010,38 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	len = snprintf(ref, sizeof(ref), "ref: %s\n", refs_heads_master);
 	if (sizeof(ref) <= len) {
 		error("refname too long: %s", refs_heads_master);
-		return -1;
+		goto error_free_return;
 	}
 	lockpath = mkpath("%s.lock", git_HEAD);
 	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0) {
 		error("Unable to open %s for writing", lockpath);
-		return -5;
+		goto error_free_return;
 	}
 	written = write_in_full(fd, ref, len);
 	close(fd);
 	if (written != len) {
-		unlink(lockpath);
 		error("Unable to write to %s", lockpath);
-		return -2;
+		goto error_unlink_return;
 	}
 	if (rename(lockpath, git_HEAD) < 0) {
-		unlink(lockpath);
 		error("Unable to create %s", git_HEAD);
-		return -3;
+		goto error_unlink_return;
 	}
 	if (adjust_shared_perm(git_HEAD)) {
-		unlink(lockpath);
 		error("Unable to fix permissions on %s", lockpath);
-		return -4;
+	error_unlink_return:
+		unlink(lockpath);
+	error_free_return:
+		free(git_HEAD);
+		return -1;
 	}
 
 	done:
 	if (logmsg && !read_ref(refs_heads_master, new_sha1))
 		log_ref_write(ref_target, old_sha1, new_sha1, logmsg);
 
+	free(git_HEAD);
 	return 0;
 }
 
-- 
1.5.0.rc2.g8ac6-dirty
