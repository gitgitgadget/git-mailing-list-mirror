From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-repack-script: Add option to repack all objects.
Date: Mon, 29 Aug 2005 10:34:43 -0700
Message-ID: <7vll2kbqa4.fsf_-_@assigned-by-dhcp.cox.net>
References: <43102727.2050206@tuxrocks.com>
	<7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>
	<4312BC27.9010604@tuxrocks.com>
	<7vvf1obsfc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 19:36:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9nWy-0007pz-IH
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 19:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVH2Req (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVH2Req
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 13:34:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14783 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751157AbVH2Rep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 13:34:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050829173445.VJRN8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 Aug 2005 13:34:45 -0400
To: Frank Sorenson <frank@tuxrocks.com>
In-Reply-To: <7vvf1obsfc.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 29 Aug 2005 09:48:23 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7908>

This originally came from Frank Sorenson but with a bit of
rework to allow future enhancement to the command without
changing the external interface for removal part.

With the '-a' option, all objects in the current repository are
packed into a single pack.  When the '-d' option is given at the
same time, existing packs that were made redundant by this round
of repacking are deleted.

Since we currently have only two repacking strategies, one '-a'
(everything into one) and the other not '-a' (incrementally pack
only the unpacked ones), '-d' is meaningful only used with '-a'
and removes all the existing packs before repacking for now.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Junio C Hamano <junkio@cox.net> writes:
    > I am not saying we should not remove old pack.  I am saying that
    > repacking, choosing which pack to remove and doing the actual
    > removing should be kept as separate steps and in separate
    > commands, perhaps the latter two as part of "git prune".

    Frank, this is what I meant by the above.  When we have pack
    redundancy detection and removal in "git prune", probably we
    would call it when '-d' is given instead of rolling our own
    here.  That is, "git repack [-a] -d" would be just a
    shorthand to say "repack" without '-d' immediately followed
    by "git prune --redundant-packs".

    Pack optimization idea itself might turn out to be not worth
    it, in which case this version would suffice.  I don't know..

 git-repack-script |   51 +++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 43 insertions(+), 8 deletions(-)

0c3d34bce4c44640a606e47c6346c400bc353604
diff --git a/git-repack-script b/git-repack-script
--- a/git-repack-script
+++ b/git-repack-script
@@ -5,28 +5,63 @@
 
 . git-sh-setup-script || die "Not a git archive"
 	
-no_update_info=
+no_update_info= all_into_one= remove_redundant=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
+	-a)	all_into_one=t ;;
+	-d)	remove_redandant=t ;;
 	*)	break ;;
 	esac
 	shift
 done
 
 rm -f .tmp-pack-*
-packname=$(git-rev-list --unpacked --objects $(git-rev-parse --all) |
-	git-pack-objects --non-empty --incremental .tmp-pack) ||
+PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
+
+# There will be more repacking strategies to come...
+case ",$all_into_one," in
+,,)
+	rev_list='--unpacked'
+	rev_parse='--all'
+	pack_objects='--incremental'
+	;;
+,t,)
+	rev_list=
+	rev_parse='--all'
+	pack_objects=
+	# This part is a stop-gap until we have proper pack redundancy
+	# checker.
+	existing=`cd "$PACKDIR" && \
+	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
+	;;
+esac
+name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) |
+	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
 	exit 1
-if [ -z "$packname" ]; then
-	echo Nothing new to pack
+if [ -z "$name" ]; then
+	echo Nothing new to pack.
 	exit 0
 fi
+echo "Pack pack-$name created."
+
+mkdir -p "$PACKDIR" || exit
+
+mv .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
+mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
+exit
+
+if test "$remove_redandant" = t
+then
+	# We know $existing are all redandant only when
+	# all-into-one is used.
+	if test "$all_into_one" != '' && test "$existing" != ''
+	then
+		( cd "$PACKDIR" && rm -f $existing )
+	fi
+fi
 
-mkdir -p "$GIT_OBJECT_DIRECTORY/pack" &&
-mv .tmp-pack-$packname.pack "$GIT_OBJECT_DIRECTORY/pack/pack-$packname.pack" &&
-mv .tmp-pack-$packname.idx  "$GIT_OBJECT_DIRECTORY/pack/pack-$packname.idx" &&
 case "$no_update_info" in
 t) : ;;
 *) git-update-server-info ;;
