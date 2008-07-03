From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC/PATCH] Remove 'stupid' merge strategy.
Date: Fri,  4 Jul 2008 01:18:21 +0200
Message-ID: <1215127101-14932-1-git-send-email-vmiklos@frugalware.org>
References: <alpine.LFD.1.10.0807030947360.18105@woody.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 01:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEY4y-00040G-Tn
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 01:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbYGCXSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 19:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756380AbYGCXSK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 19:18:10 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48425 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198AbYGCXSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 19:18:09 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 125D61DDC5B;
	Fri,  4 Jul 2008 01:18:07 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8A6741A9833; Fri,  4 Jul 2008 01:18:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <alpine.LFD.1.10.0807030947360.18105@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87334>

As pointed out by Linus, this strategy tries to take the best merge
base, but 'recursive' just does it better. If one needs something more
than 'resolve' then he/she should really use 'recursive' and not
'stupid'.
---

On Thu, Jul 03, 2008 at 10:08:54AM -0700, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> I think -stupid should probably be removed.

Here is an attempt to do so.

> The history of -stupid is from doing the simple single-tree resolve
> that
> git-read-tree can do, but then doing the obvious hack of just trying
> to
> pick the base that gives the least number of conflicts.
>
> HOWEVER.
>
>  (...)

Thanks for the detailed answer.

 .gitignore          |    1 -
 Makefile            |    3 +-
 git-merge-stupid.sh |   80 ---------------------------------------------------
 3 files changed, 1 insertions(+), 83 deletions(-)
 delete mode 100755 git-merge-stupid.sh

diff --git a/.gitignore b/.gitignore
index 4ff2fec..8054d9d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,7 +75,6 @@ git-merge-one-file
 git-merge-ours
 git-merge-recursive
 git-merge-resolve
-git-merge-stupid
 git-merge-subtree
 git-mergetool
 git-mktag
diff --git a/Makefile b/Makefile
index 78e08d3..bddd1a7 100644
--- a/Makefile
+++ b/Makefile
@@ -241,7 +241,6 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-merge.sh
-SCRIPT_SH += git-merge-stupid.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
@@ -1429,7 +1428,7 @@ check-docs::
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-resolve | git-merge-stupid | git-merge-subtree | \
+		git-merge-resolve | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
 		esac ; \
diff --git a/git-merge-stupid.sh b/git-merge-stupid.sh
deleted file mode 100755
index f612d47..0000000
--- a/git-merge-stupid.sh
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Linus Torvalds
-#
-# Resolve two trees, 'stupid merge'.
-
-# The first parameters up to -- are merge bases; the rest are heads.
-bases= head= remotes= sep_seen=
-for arg
-do
-	case ",$sep_seen,$head,$arg," in
-	*,--,)
-		sep_seen=yes
-		;;
-	,yes,,*)
-		head=$arg
-		;;
-	,yes,*)
-		remotes="$remotes$arg "
-		;;
-	*)
-		bases="$bases$arg "
-		;;
-	esac
-done
-
-# Give up if we are given two or more remotes -- not handling octopus.
-case "$remotes" in
-?*' '?*)
-	exit 2 ;;
-esac
-
-# Find an optimum merge base if there are more than one candidates.
-case "$bases" in
-?*' '?*)
-	echo "Trying to find the optimum merge base."
-	G=.tmp-index$$
-	best=
-	best_cnt=-1
-	for c in $bases
-	do
-		rm -f $G
-		GIT_INDEX_FILE=$G git read-tree -m $c $head $remotes \
-			 2>/dev/null ||	continue
-		# Count the paths that are unmerged.
-		cnt=`GIT_INDEX_FILE=$G git ls-files --unmerged | wc -l`
-		if test $best_cnt -le 0 -o $cnt -le $best_cnt
-		then
-			best=$c
-			best_cnt=$cnt
-			if test "$best_cnt" -eq 0
-			then
-				# Cannot do any better than all trivial merge.
-				break
-			fi
-		fi
-	done
-	rm -f $G
-	common="$best"
-	;;
-*)
-	common="$bases"
-	;;
-esac
-
-git update-index --refresh 2>/dev/null
-git read-tree -u -m $common $head $remotes || exit 2
-echo "Trying simple merge."
-if result_tree=$(git write-tree  2>/dev/null)
-then
-	exit 0
-else
-	echo "Simple merge failed, trying Automatic merge."
-	if git-merge-index -o git-merge-one-file -a
-	then
-		exit 0
-	else
-		exit 1
-	fi
-fi
-- 
1.5.6.1
