From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] filter-branch: use --simplify-merges
Date: Sun, 10 Aug 2008 16:02:40 +0200
Message-ID: <1218376960-6406-1-git-send-email-trast@student.ethz.ch>
References: <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 16:03:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSBWE-0000jh-ON
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 16:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYHJOCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 10:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbYHJOCf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 10:02:35 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:4124 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbYHJOCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 10:02:34 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 16:02:31 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 16:02:33 +0200
X-Mailer: git-send-email 1.6.0.rc2.29.g7ec81
In-Reply-To: <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 10 Aug 2008 14:02:33.0120 (UTC) FILETIME=[BC2D3200:01C8FAF1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91840>

Use rev-list --simplify-merges everywhere.  This changes the behaviour
of --subdirectory-filter in cases such as

  O -- A -\
   \       \
    \- B -- M

where A and B bring the same changes to the subdirectory: It now keeps
both sides of the merge.  Previously, the history would have been
simplified to 'O -- A'.  Merges of unrelated side histories that never
touch the subdirectory are still removed.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This obviously depends on --simplify-merges which is only in 'next'.

Junio C Hamano wrote:
>
> Perhaps --full-history is needed to the rev-list call (and the recent
> invention --simplify-merges that will hopefully appear sometime after
> 1.6.0)?  See recent discussion of --full-history and the default merge
> simplification between Linus and Roman Zippel.

Following history pointers, it turns out the discussion surrounding
a17171b4 (Revert "filter-branch: subdirectory filter needs
--full-history") actually mentions that a simplification step on top
of --full-history is needed:

Junio C Hamano wrote:
[http://kerneltrap.org/mailarchive/git/2007/6/13/249107]
> In short,
> you will end up with something like this:
> 
>              .---. (side branch)
>             /     \
>         ---A---B---C (merge)
> 
> The "merge clean-up" would conceptually be a simple operation.
> Whenever you see a merge C, you look at its parents A and B, and
> cull the ones that are reachable from other parents.  You notice
> that A is an ancestor of B, drop A from the parents of C, and
> simplify the above down to:
> 
>         ---A---B---C (not-a-merge)

Well, turns out that's what you did with --simplify-merges, so let's
use it.

 git-filter-branch.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 539b2e6..60f64ac 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -239,11 +239,11 @@ mkdir ../map || die "Could not create map/ directory"
 case "$filter_subdir" in
 "")
 	git rev-list --reverse --topo-order --default HEAD \
-		--parents "$@"
+		--parents --simplify-merges "$@"
 	;;
 *)
 	git rev-list --reverse --topo-order --default HEAD \
-		--parents "$@" -- "$filter_subdir"
+		--parents --simplify-merges "$@" -- "$filter_subdir"
 esac > ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
@@ -333,7 +333,8 @@ then
 	do
 		sha1=$(git rev-parse "$ref"^0)
 		test -f "$workdir"/../map/$sha1 && continue
-		ancestor=$(git rev-list -1 $ref -- "$filter_subdir")
+		ancestor=$(git rev-list --simplify-merges -1 \
+				$ref -- "$filter_subdir")
 		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
 	done < "$tempdir"/heads
 fi
-- 
1.6.0.rc2.29.g7ec81
