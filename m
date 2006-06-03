From: Junio C Hamano <junkio@cox.net>
Subject: Re: git reset --hard not removing some files
Date: Sat, 03 Jun 2006 01:48:10 -0700
Message-ID: <7vy7we8w1h.fsf@assigned-by-dhcp.cox.net>
References: <20060601160052.GK14325@admingilde.org>
	<Pine.LNX.4.64.0606010918060.5498@g5.osdl.org>
	<7vhd33d2q2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sat Jun 03 10:48:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmRns-0004w9-Iz
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 10:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWFCIsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 04:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWFCIsN
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 04:48:13 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43907 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751137AbWFCIsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 04:48:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060603084811.SRQU19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Jun 2006 04:48:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vhd33d2q2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Jun 2006 07:57:57 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21188>

Junio C Hamano <junkio@cox.net> writes:

> I would agree in the reproduction recipe Martin gave there is no
> problem but feature, but at the same time I suspect the recent
> "reset --hard simplification" has introduced a true regression.
> ...
>         $ git ls-files -u
>         100644 b1b716105590454bfc4c0247f193a04088f39c7f 1	file1
>         100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 3	file1
>         $ ls
>         file0  file1  file2
>         $ git reset --hard
>         $ ls
>         file0  file1  file2
>
> We used to remove file1 from the working tree in this case.  One
> of the most important reason to use "git reset --hard" is to
> recover from a conflicted, failed merge.  

I think this patch fixes the regression.  Comments?

-- >8 --
read-tree --reset: update working tree file for conflicted paths.

The earlier "git reset --hard" simplification stopped removing
leftover working tree files from a failed automerge, when
switching back to the HEAD version that does not have the
paths.

This patch, instead of removing the unmerged paths from the
index, drops them down to stage#0 but marks them with mode=0
(the same "to be deleted" marker we internally use for paths
deleted by the merge).  one_way_merge() function and the
functions it calls already know what to do with them -- if the
tree we are reading has the path the working tree file is
overwritten, and if it doesn't the working tree file is
removed.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 builtin-read-tree.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 716f792..71edaf6 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -753,6 +753,8 @@ static int read_cache_unmerged(void)
 {
 	int i, deleted;
 	struct cache_entry **dst;
+	int unmerged = 0;
+	struct cache_entry *last = NULL;
 
 	read_cache();
 	dst = active_cache;
@@ -760,16 +762,22 @@ static int read_cache_unmerged(void)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce)) {
-			deleted++;
+			unmerged++;
+			if (last && !strcmp(ce->name, last->name)) {
+				deleted++;
+				continue;
+			}
 			invalidate_ce_path(ce);
-			continue;
+			last = ce;
+			ce->ce_mode = 0;
+			ce->ce_flags &= ~htons(CE_STAGEMASK);
 		}
 		if (deleted)
 			*dst = ce;
 		dst++;
 	}
 	active_nr -= deleted;
-	return deleted;
+	return unmerged;
 }
 
 static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
@@ -850,7 +858,10 @@ int cmd_read_tree(int argc, const char *
 			continue;
 		}
 
-		/* This differs from "-m" in that we'll silently ignore unmerged entries */
+		/* This differs from "-m" in that we'll silently ignore
+		 * unmerged entries and overwrite working tree files that
+		 * correspond to them.
+		 */
 		if (!strcmp(arg, "--reset")) {
 			if (stage || merge)
 				usage(read_tree_usage);
