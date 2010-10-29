From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] git-am: create a config setting for reject control.
Date: Thu, 28 Oct 2010 21:27:30 -0400
Message-ID: <1288315650-2488-1-git-send-email-paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 03:32:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBdpu-0004Dw-KF
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 03:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0J2B1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 21:27:33 -0400
Received: from mail.windriver.com ([147.11.1.11]:34958 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab0J2B1c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 21:27:32 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o9T1RV57028304
	for <git@vger.kernel.org>; Thu, 28 Oct 2010 18:27:31 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Oct 2010 18:27:31 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Oct 2010 18:27:31 -0700
X-Mailer: git-send-email 1.7.3.2.146.g2d444
X-OriginalArrivalTime: 29 Oct 2010 01:27:31.0755 (UTC) FILETIME=[750EF7B0:01CB7708]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160259>

git am already accepts a "--reject" switch, which basically means
apply the bits you can, but you can't set it as enabled by default
currently.  This adds a config option for it, and a --no-reject
so that you can manually override it.  The implementation copies
from the one and only existing git-am config option -- "keepcr".

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/git-am.txt |   12 +++++++++---
 git-am.sh                |   19 +++++++++++++++++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 51297d0..5158e20 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,8 +13,8 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
-	 [(<mbox> | <Maildir>)...]
+	 [--reject | --no-reject] [-q | --quiet]
+	 [--scissors | --no-scissors] [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
 DESCRIPTION
@@ -87,11 +87,17 @@ default.   You can use `--no-utf8` to override this.
 -C<n>::
 -p<n>::
 --directory=<dir>::
---reject::
 	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
 	program that applies
 	the patch.
 
+--reject::
+--no-reject::
+	With `--reject`, call 'git apply' (see linkgit:git-apply[1]) with
+	the same option, to have it apply whatever parts of the commit it
+	can. `am.reject` configuration variable can be used to specify the
+	default behaviour.  `--no-reject` is useful to override `am.reject`.
+
 -i::
 --interactive::
 	Run interactively.
diff --git a/git-am.sh b/git-am.sh
index df09b42..43a510f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -26,6 +26,7 @@ C=              pass it through git-apply
 p=              pass it through git-apply
 patch-format=   format the patch(es) are in
 reject          pass it through git-apply
+no-reject       do not pass it through git-apply, independent of am.reject
 resolvemsg=     override error message when patch failure occurs
 continue        continue applying patches after resolving a conflict
 r,resolved      synonyms for --continue
@@ -295,7 +296,7 @@ split_patches () {
 prec=4
 dotest="$GIT_DIR/rebase-apply"
 sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
-resolvemsg= resume= scissors= no_inbody_headers=
+resolvemsg= resume= scissors= no_inbody_headers= reject=
 git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
@@ -306,6 +307,11 @@ then
     keepcr=t
 fi
 
+if test "$(git config --bool --get am.reject)" = true
+then
+    reject=t
+fi
+
 while test $# != 0
 do
 	case "$1" in
@@ -346,8 +352,12 @@ do
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
 	--patch-format)
 		shift ; patch_format="$1" ;;
-	--reject|--ignore-whitespace|--ignore-space-change)
+	--ignore-whitespace|--ignore-space-change)
 		git_apply_opt="$git_apply_opt $1" ;;
+	--reject)
+		reject=t ;;
+	--no-reject)
+		reject=f ;;
 	--committer-date-is-author-date)
 		committer_date_is_author_date=t ;;
 	--ignore-date)
@@ -368,6 +378,11 @@ do
 	shift
 done
 
+if test "$reject" = t
+then
+	git_apply_opt="$git_apply_opt --reject"
+fi
+
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
-- 
1.7.3.2.146.g2d444
