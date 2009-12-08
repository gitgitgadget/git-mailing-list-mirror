From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 16:47:42 +0200
Message-ID: <20091208144740.GA30830@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 15:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1Of-0002j6-RB
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536AbZLHOuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbZLHOuV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:50:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364AbZLHOuU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:50:20 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB8EoPnQ028550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 8 Dec 2009 09:50:25 -0500
Received: from redhat.com (dhcp-0-94.tlv.redhat.com [10.35.0.94])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id nB8EoNhf027980;
	Tue, 8 Dec 2009 09:50:24 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134883>

Add --revisions flag to rebase, so that it can be used
to apply an arbitrary range of commits on top
of a current branch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I've been wishing for this functionality for a while now,
so here goes. This isn't yet properly documented and I didn't
write a test, but the patch seems to work fine for me.
Any early flames/feedback?


 git-rebase.sh |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b121f45..d99d04b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,12 +3,13 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
+USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newbase>] [--revisions <revision range>] [<upstream>|--root] [<branch>] [--quiet | -q]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
 It then attempts to create a new commit for each commit from the original
-<branch> that does not exist in the <upstream> branch.
+<branch> that does not exist in the <upstream> branch, or for
+each commit matching <revision range> when the --revisions options is provided.
 
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
@@ -41,6 +42,7 @@ If you would prefer to skip this patch, instead run \"git rebase --skip\".
 To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset newbase
+unset revisions
 strategy=recursive
 do_merge=
 dotest="$GIT_DIR"/rebase-merge
@@ -291,6 +293,11 @@ do
 		newbase="$2"
 		shift
 		;;
+	--revisions)
+		test 2 -le "$#" || usage
+		revisions="$2"
+		shift
+		;;
 	-M|-m|--m|--me|--mer|--merg|--merge)
 		do_merge=t
 		;;
@@ -459,12 +466,24 @@ case "$#" in
 esac
 orig_head=$branch
 
+if test -z "$revisions"
+then
+	if test -n "$rebase_root"
+	then
+		revisions="$onto..$orig_head"
+	else
+		revisions="$upstream..$orig_head"
+	fi
+	mb=$(git merge-base "$onto" "$branch")
+else
+	mb=""
+fi
+
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
 # Check if we are already based on $onto with linear history,
 # but this should be done only when upstream and onto are the same.
-mb=$(git merge-base "$onto" "$branch")
 if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$branch" | sane_grep " .* ") > /dev/null
@@ -489,10 +508,10 @@ if test -n "$diffstat"
 then
 	if test -n "$verbose"
 	then
-		echo "Changes from $mb to $onto:"
+		echo "Changes $revisions:"
 	fi
 	# We want color (if set), but no pager
-	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
+	GIT_PAGER='' git diff --stat --summary "$revisions"
 fi
 
 # If the $onto is a proper descendant of the tip of the branch, then
@@ -504,13 +523,6 @@ then
 	exit 0
 fi
 
-if test -n "$rebase_root"
-then
-	revisions="$onto..$orig_head"
-else
-	revisions="$upstream..$orig_head"
-fi
-
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-- 
1.6.6.rc1.43.gf55cc
