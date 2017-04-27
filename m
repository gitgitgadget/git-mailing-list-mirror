Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E935207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 09:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031202AbdD0JBK (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 05:01:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:41149 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031191AbdD0JBI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 05:01:08 -0400
Received: (qmail 5539 invoked by uid 109); 27 Apr 2017 09:01:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 09:01:07 +0000
Received: (qmail 2230 invoked by uid 111); 27 Apr 2017 09:01:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 05:01:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 05:01:05 -0400
Date:   Thu, 27 Apr 2017 05:01:05 -0400
From:   Jeff King <peff@peff.net>
To:     Stephen Kent <smkent@smkent.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] status: fix missing newline when comment chars are disabled
Message-ID: <20170427090105.vaodugbqdaxunoin@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git-status shows tracking data for the current branch
in the long format, we try to end the stanza with a blank
line. When status.displayCommentPrefix is true, we call
color_fprintf_ln() to do so. But when it's false, we call
the enigmatic:

  fputs("", s->fp);

which does nothing at all! This is a bug from 7d7d68022
(silence a bunch of format-zero-length warnings,
2014-05-04). Prior to that, we called fprintf_ln() with an
empty string. Switching to fputs() meant we needed to
include the "newline in the string, but we didn't.

So you see:

  On branch jk/status-tracking-newline
  Your branch is ahead of 'origin/master' by 1 commit.
  Changes not staged for commit:
          modified:  foo

  Untracked files:
     bar

whereas there should be a blank line before the "Changes not
staged" line.

The fix itself is a one-liner. But we never noticed this
bug because t7508 doesn't exercise the ahead/behind code at
all.  So let's configure an upstream during the initial
setup, which means that the code will be exercised as part
of all of the various invocations in that script. This makes
the diff rather noisy, but should give us good coverage.

Signed-off-by: Jeff King <peff@peff.net>
---
The no-comment view is the default, so this has been broken
for basically everyone for 2 years. And nobody complained.
So perhaps people really prefer it? Or perhaps they just
didn't notice. I certainly didn't, but now that I know about
it, the squished view is intolerable. :)

 t/t7508-status.sh | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 wt-status.c       |   2 +-
 2 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index fb00e6d9b..a000ed4e7 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -32,6 +32,17 @@ test_expect_success 'commit -h in broken repository' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
+test_expect_success 'create upstream branch' '
+	git checkout -b upstream &&
+	test_commit upstream1 &&
+	test_commit upstream2 &&
+	# leave the first commit on master as root because several
+	# tests depend on this case; for our upstream we only
+	# care about commit counts anyway, so a totally divergent
+	# history is OK
+	git checkout --orphan master
+'
+
 test_expect_success 'setup' '
 	: >tracked &&
 	: >modified &&
@@ -53,7 +64,9 @@ test_expect_success 'setup' '
 	echo 1 >dir1/modified &&
 	echo 2 >dir2/modified &&
 	echo 3 >dir2/added &&
-	git add dir2/added
+	git add dir2/added &&
+
+	git branch --set-upstream-to=upstream
 '
 
 test_expect_success 'status (1)' '
@@ -75,6 +88,10 @@ EOF
 test_expect_success 'status --column' '
 	cat >expect <<\EOF &&
 # On branch master
+# Your branch and '\''upstream'\'' have diverged,
+# and have 1 and 2 different commits each, respectively.
+#   (use "git pull" to merge the remote branch into yours)
+#
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
 #
@@ -105,6 +122,10 @@ test_expect_success 'status --column status.displayCommentPrefix=false' '
 
 cat >expect <<\EOF
 # On branch master
+# Your branch and 'upstream' have diverged,
+# and have 1 and 2 different commits each, respectively.
+#   (use "git pull" to merge the remote branch into yours)
+#
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
 #
@@ -178,6 +199,9 @@ test_expect_success 'commit ignores status.displayCommentPrefix=false in COMMIT_
 
 cat >expect <<\EOF
 On branch master
+Your branch and 'upstream' have diverged,
+and have 1 and 2 different commits each, respectively.
+
 Changes to be committed:
 	new file:   dir2/added
 
@@ -248,6 +272,10 @@ test_expect_success 'status with gitignore' '
 
 	cat >expect <<\EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -313,6 +341,10 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 
 	cat >expect <<\EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -348,7 +380,7 @@ output*
 EOF
 
 cat >expect <<\EOF
-## master
+## master...upstream [ahead 1, behind 2]
  M dir1/modified
 A  dir2/added
 ?? dir1/untracked
@@ -382,6 +414,10 @@ test_expect_success 'setup dir3' '
 test_expect_success 'status -uno' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -408,6 +444,9 @@ test_expect_success 'status (status.showUntrackedFiles no)' '
 test_expect_success 'status -uno (advice.statusHints false)' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+
 Changes to be committed:
 	new file:   dir2/added
 
@@ -439,6 +478,10 @@ test_expect_success 'status -s (status.showUntrackedFiles no)' '
 test_expect_success 'status -unormal' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -493,6 +536,10 @@ test_expect_success 'status -s (status.showUntrackedFiles normal)' '
 test_expect_success 'status -uall' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -552,6 +599,10 @@ test_expect_success 'status -s (status.showUntrackedFiles all)' '
 test_expect_success 'status with relative paths' '
 	cat >expect <<\EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -617,6 +668,10 @@ test_expect_success 'setup unique colors' '
 test_expect_success 'status with color.ui' '
 	cat >expect <<\EOF &&
 On branch <GREEN>master<RESET>
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -675,7 +730,7 @@ test_expect_success 'status -s with color.status' '
 '
 
 cat >expect <<\EOF
-## <GREEN>master<RESET>
+## <GREEN>master<RESET>...<RED>upstream<RESET> [ahead <GREEN>1<RESET>, behind <RED>2<RESET>]
  <RED>M<RESET> dir1/modified
 <GREEN>A<RESET>  dir2/added
 <BLUE>??<RESET> dir1/untracked
@@ -726,7 +781,7 @@ test_expect_success 'status --porcelain respects -b' '
 
 	git status --porcelain -b >output &&
 	{
-		echo "## master" &&
+		echo "## master...upstream [ahead 1, behind 2]" &&
 		cat expect
 	} >tmp &&
 	mv tmp expect &&
@@ -739,6 +794,10 @@ test_expect_success 'status --porcelain respects -b' '
 test_expect_success 'status without relative paths' '
 	cat >expect <<\EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -785,6 +844,10 @@ test_expect_success 'status -s without relative paths' '
 test_expect_success 'dry-run of partial commit excluding new file in index' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -825,6 +888,10 @@ test_expect_success 'setup status submodule summary' '
 test_expect_success 'status submodule summary is disabled by default' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -881,6 +948,10 @@ head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 test_expect_success 'status submodule summary' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 1 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -939,6 +1010,10 @@ test_expect_success 'status -s submodule summary' '
 test_expect_success 'status submodule summary (clean submodule): commit' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
@@ -985,6 +1060,10 @@ test_expect_success 'status -z implies porcelain' '
 test_expect_success 'commit --dry-run submodule summary (--amend)' '
 	cat >expect <<EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD^1 <file>..." to unstage)
 
@@ -1038,6 +1117,10 @@ touch .gitmodules
 test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
 	cat > expect << EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -1146,6 +1229,10 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with modifie
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
 	cat > expect << EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -1202,6 +1289,10 @@ head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
 	cat > expect << EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -1282,6 +1373,10 @@ test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary
 
 cat > expect << EOF
 ; On branch master
+; Your branch and 'upstream' have diverged,
+; and have 2 and 2 different commits each, respectively.
+;   (use "git pull" to merge the remote branch into yours)
+;
 ; Changes to be committed:
 ;   (use "git reset HEAD <file>..." to unstage)
 ;
@@ -1329,6 +1424,10 @@ test_expect_success "status (core.commentchar with two chars with submodule summ
 test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	cat > expect << EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
@@ -1353,6 +1452,10 @@ EOF
 test_expect_success '.gitmodules ignore=all suppresses unstaged submodule summary' '
 	cat > expect << EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
@@ -1472,6 +1575,10 @@ test_expect_success 'git commit --dry-run will show a staged but ignored submodu
 	git add sm &&
 	cat >expect << EOF &&
 On branch master
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
 
diff --git a/wt-status.c b/wt-status.c
index 037548496..b7ade902f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1002,7 +1002,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
 				 comment_line_char);
 	else
-		fputs("", s->fp);
+		fputs("\n", s->fp);
 }
 
 static int has_unmerged(struct wt_status *s)
-- 
2.13.0.rc1.388.gcf562aed8
