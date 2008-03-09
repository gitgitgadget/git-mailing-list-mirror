From: Iustin Pop <iusty@k1024.org>
Subject: [PATCH] Fix git pull handling of the quiet option
Date: Sun, 9 Mar 2008 23:31:11 +0100
Message-ID: <20080309223111.GA16360@teal.hq.k1024.org>
References: <7v8x0ssfud.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 23:32:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYU47-00050P-9v
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 23:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYCIWbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 18:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbYCIWbT
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 18:31:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:20506 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYCIWbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 18:31:18 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1687405fga.17
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 15:31:16 -0700 (PDT)
Received: by 10.82.184.2 with SMTP id h2mr11062884buf.1.1205101875661;
        Sun, 09 Mar 2008 15:31:15 -0700 (PDT)
Received: from teal.hq.k1024.org ( [84.75.117.152])
        by mx.google.com with ESMTPS id e10sm9878450muf.10.2008.03.09.15.31.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Mar 2008 15:31:13 -0700 (PDT)
Received: by teal.hq.k1024.org (Postfix, from userid 4004)
	id 9A35840A051; Sun,  9 Mar 2008 23:31:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8x0ssfud.fsf@gitster.siamese.dyndns.org>
X-Linux: This message was written on Linux
X-Header: /usr/include gives great headers
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76675>

Although git pull has a documented quiet option, currently it doesn't
handle this option at all, and this results in it terminating the
handling of command line options when this particular option is met.

More exactly, it will cause the following invocation:
  git pull --quiet --no-commit
to fail with:
  error: unknown option `no-commit'
  usage: git-fetch [options] [<repository> <refspec>...]
because it will not look at anything after quiet (and no-commit and
other options should not be passed to git fetch).

This patch adds the handling of this option, and passes it correctly to
both git fetch and git merge (and therefore needs to be applied on top
of patched git merge).

The patch also adds a small test for making sure that the quiet option
works.

Signed-off-by: Iustin Pop <iusty@k1024.org>
---
 This is an updated version which includes a small test for the quiet option.

 git-pull.sh     |    8 +++++---
 t/t5520-pull.sh |    8 ++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 3ce32b5..2201ca0 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,7 +16,7 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
-strategy_args= no_summary= no_commit= squash= no_ff=
+strategy_args= no_summary= no_commit= squash= no_ff= quiet=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
@@ -61,6 +61,8 @@ do
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
 		;;
+	-q|--q|--qui|--quie|--quiet)
+		quiet=--quiet ;;
 	-h|--h|--he|--hel|--help)
 		usage
 		;;
@@ -116,7 +118,7 @@ test true = "$rebase" && {
 		"refs/remotes/$origin/$reflist" 2>/dev/null)"
 }
 orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
-git-fetch --update-head-ok "$@" || exit 1
+git-fetch $quiet --update-head-ok "$@" || exit 1
 
 curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
 if test "$curr_head" != "$orig_head"
@@ -177,4 +179,4 @@ test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
 exec git-merge $no_summary $no_commit $squash $no_ff $strategy_args \
-	"$merge_name" HEAD $merge_head
+	$quiet "$merge_name" HEAD $merge_head
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9484129..6e36c00 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -21,6 +21,14 @@ test_expect_success 'pulling into void' '
 	git pull ..
 '
 
+test_expect_success 'quiet pull' '
+	git pull --quiet .. &&
+	if test -n "`git pull --quiet ..`"; then
+		echo "[OOPS] quiet pull is not quiet"
+		false
+	fi
+'
+
 cd "$D"
 
 test_expect_success 'checking the results' '
-- 
1.5.4.3
