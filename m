From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Move 'stupid' merge strategy to contrib.
Date: Sat,  5 Jul 2008 16:43:51 +0200
Message-ID: <1215269031-19559-1-git-send-email-vmiklos@frugalware.org>
References: <20080704000701.GX4729@genesis.frugalware.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 16:44:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF90D-0004rf-V4
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 16:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbYGEOnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 10:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYGEOnj
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 10:43:39 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:39428 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYGEOni (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 10:43:38 -0400
Received: from vmobile.example.net (dsl5401C7D7.pool.t-online.hu [84.1.199.215])
	by yugo.frugalware.org (Postfix) with ESMTP id 971381DDC5B;
	Sat,  5 Jul 2008 16:43:36 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 97CBA1A9CEF; Sat,  5 Jul 2008 16:43:51 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
In-Reply-To: <20080704000701.GX4729@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87448>

As pointed out by Linus, this strategy tries to take the best merge
base, but 'recursive' just does it better. If one needs something more
than 'resolve' then he/she should really use 'recursive' and not
'stupid'.

Given that it may still serve as a good example, don't remove it, just
move it to contrib/examples.
---

On Fri, Jul 04, 2008 at 02:07:01AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Thu, Jul 03, 2008 at 04:54:31PM -0700, Junio C Hamano
> <gitster@pobox.com> wrote:
> > It is called stupid for a reason ;-).
> >
> > It has been sitting there as an example for a long time, and I do
> > not think anybody minds removing it.
>
> OK, then should I resend a patch that moves it to contrib/examples?

Here is one.

 .gitignore                           |    1 -
 Makefile                             |    3 +-
 contrib/examples/git-merge-stupid.sh |   80 ++++++++++++++++++++++++++++++++++
 git-merge-stupid.sh                  |   80 ----------------------------------
 4 files changed, 81 insertions(+), 83 deletions(-)
 create mode 100755 contrib/examples/git-merge-stupid.sh
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
diff --git a/contrib/examples/git-merge-stupid.sh b/contrib/examples/git-merge-stupid.sh
new file mode 100755
index 0000000..f612d47
--- /dev/null
+++ b/contrib/examples/git-merge-stupid.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+#
+# Resolve two trees, 'stupid merge'.
+
+# The first parameters up to -- are merge bases; the rest are heads.
+bases= head= remotes= sep_seen=
+for arg
+do
+	case ",$sep_seen,$head,$arg," in
+	*,--,)
+		sep_seen=yes
+		;;
+	,yes,,*)
+		head=$arg
+		;;
+	,yes,*)
+		remotes="$remotes$arg "
+		;;
+	*)
+		bases="$bases$arg "
+		;;
+	esac
+done
+
+# Give up if we are given two or more remotes -- not handling octopus.
+case "$remotes" in
+?*' '?*)
+	exit 2 ;;
+esac
+
+# Find an optimum merge base if there are more than one candidates.
+case "$bases" in
+?*' '?*)
+	echo "Trying to find the optimum merge base."
+	G=.tmp-index$$
+	best=
+	best_cnt=-1
+	for c in $bases
+	do
+		rm -f $G
+		GIT_INDEX_FILE=$G git read-tree -m $c $head $remotes \
+			 2>/dev/null ||	continue
+		# Count the paths that are unmerged.
+		cnt=`GIT_INDEX_FILE=$G git ls-files --unmerged | wc -l`
+		if test $best_cnt -le 0 -o $cnt -le $best_cnt
+		then
+			best=$c
+			best_cnt=$cnt
+			if test "$best_cnt" -eq 0
+			then
+				# Cannot do any better than all trivial merge.
+				break
+			fi
+		fi
+	done
+	rm -f $G
+	common="$best"
+	;;
+*)
+	common="$bases"
+	;;
+esac
+
+git update-index --refresh 2>/dev/null
+git read-tree -u -m $common $head $remotes || exit 2
+echo "Trying simple merge."
+if result_tree=$(git write-tree  2>/dev/null)
+then
+	exit 0
+else
+	echo "Simple merge failed, trying Automatic merge."
+	if git-merge-index -o git-merge-one-file -a
+	then
+		exit 0
+	else
+		exit 1
+	fi
+fi
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
1.5.6.1.322.ge904b.dirty
