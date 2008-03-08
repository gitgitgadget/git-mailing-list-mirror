From: Iustin Pop <iusty@k1024.org>
Subject: [PATCH 2/2] Fix git pull handling of the quiet option
Date: Sun,  9 Mar 2008 00:52:36 +0100
Message-ID: <1205020356-6682-3-git-send-email-iusty@k1024.org>
References: <1205020356-6682-1-git-send-email-iusty@k1024.org>
Cc: Iustin Pop <iusty@k1024.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 00:53:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8qw-0005gC-HE
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbYCHXwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYCHXwq
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:52:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:15204 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYCHXwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:52:42 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1247753fga.17
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 15:52:41 -0800 (PST)
Received: by 10.82.177.3 with SMTP id z3mr7860978bue.23.1205020360417;
        Sat, 08 Mar 2008 15:52:40 -0800 (PST)
Received: from teal.hq.k1024.org ( [84.75.117.152])
        by mx.google.com with ESMTPS id u9sm21264173muf.4.2008.03.08.15.52.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 15:52:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by teal.hq.k1024.org (Postfix) with ESMTP id DFC5640DE74;
	Sun,  9 Mar 2008 00:52:36 +0100 (CET)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1205020356-6682-1-git-send-email-iusty@k1024.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76626>

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
---
 git-pull.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

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
-- 
1.5.4.3

