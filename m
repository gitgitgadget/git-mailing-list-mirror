From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] pack-refs --all
Date: Sun, 08 Oct 2006 01:08:54 -0700
Message-ID: <7v4pufkz55.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 08 10:09:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWTiW-00010O-E6
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 10:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWJHII5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 04:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWJHII5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 04:08:57 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:56219 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750901AbWJHIIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 04:08:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061008080855.SSDI22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Oct 2006 04:08:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xk8m1V00V1kojtg0000000
	Sun, 08 Oct 2006 04:08:47 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28524>

This changes 'git-pack-refs' to pack only tags by default.
Branches are meant to be updated, either by committing onto it
yourself or tracking remote branches, and packed entries can
become stale easily, but tags are usually "create once and live
forever" and benefit more from packing.

---

 * Likes?  Dislikes?

 builtin-pack-refs.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 23d0d07..1087657 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -2,7 +2,7 @@ #include "cache.h"
 #include "refs.h"
 
 static const char builtin_pack_refs_usage[] =
-"git-pack-refs [--prune]";
+"git-pack-refs [--all] [--prune]";
 
 struct ref_to_prune {
 	struct ref_to_prune *next;
@@ -68,6 +68,7 @@ int cmd_pack_refs(int argc, const char *
 {
 	int fd, i;
 	struct pack_refs_cb_data cbdata;
+	int (*iterate_ref)(each_ref_fn, void *) = for_each_tag_ref;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 
@@ -77,6 +78,10 @@ int cmd_pack_refs(int argc, const char *
 			cbdata.prune = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--all")) {
+			iterate_ref = for_each_ref;
+			continue;
+		}
 		/* perhaps other parameters later... */
 		break;
 	}
@@ -88,7 +93,7 @@ int cmd_pack_refs(int argc, const char *
 	if (!cbdata.refs_file)
 		die("unable to create ref-pack file structure (%s)",
 		    strerror(errno));
-	for_each_ref(handle_one_ref, &cbdata);
+	iterate_ref(handle_one_ref, &cbdata);
 	fflush(cbdata.refs_file);
 	fsync(fd);
 	fclose(cbdata.refs_file);
