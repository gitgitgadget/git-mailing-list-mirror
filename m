From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-apply: do not lose cwd when run from a subdirectory.
Date: Mon, 19 Feb 2007 17:58:58 -0800
Message-ID: <7vk5yd37z1.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
	<7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
	<7vps854qf8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 02:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJKHY-00037J-7n
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 02:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbXBTB7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 20:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbXBTB7A
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 20:59:00 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51995 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768AbXBTB67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 20:58:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220015859.PJUX1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 20:58:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rdyy1W00H1kojtg0000000; Mon, 19 Feb 2007 20:58:59 -0500
In-Reply-To: <7vps854qf8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 19 Feb 2007 16:35:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40197>

When a patch modifies (not deletes) the last file in a
directory, because we treat a modification just as deletion
followed by creation, and deleting the last file in a directory
automatically rmdir(2)'s that directory, we ended up removing
the directory, which can potentially be the cwd, and then
recreating the same directory to create the patch result.

Avoid the rmdir step when remove_file() is called only because
we are replacing it with the result by later calling
create_file().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is not related to the previous patch, but the updated
   test trigeers it ;-).

 builtin-apply.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 20fb5bd..6153791 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2243,7 +2243,7 @@ static void patch_stats(struct patch *patch)
 	}
 }
 
-static void remove_file(struct patch *patch)
+static void remove_file(struct patch *patch, int rmdir_empty)
 {
 	if (write_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
@@ -2251,7 +2251,7 @@ static void remove_file(struct patch *patch)
 		cache_tree_invalidate_path(active_cache_tree, patch->old_name);
 	}
 	if (!cached) {
-		if (!unlink(patch->old_name)) {
+		if (!unlink(patch->old_name) && rmdir_empty) {
 			char *name = xstrdup(patch->old_name);
 			char *end = strrchr(name, '/');
 			while (end) {
-- 
1.5.0.1.555.g13b30
