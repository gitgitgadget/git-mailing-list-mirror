From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 2/2] status: always show tracking branch even no change
Date: Mon, 26 Aug 2013 15:02:49 +0800
Message-ID: <2f3a942d7049e80dca689aa68d494b70c288f2c7.1377500206.git.worldhello.net@gmail.com>
References: <cover.1377500206.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 26 09:10:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDqwT-0000nZ-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 09:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab3HZHKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 03:10:20 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49674 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317Ab3HZHKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 03:10:16 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so3071090pab.36
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=koeU3MFWavyyY2aF7cHt3cLx6JdYNWMopkcMKOvJFtA=;
        b=y5ib3/pif4IukEG0u+CmTfQoaXerAn8CRXpfVKzg800M9vAvn+zNDqI85G0t0aUjQn
         zKLcZbH8PObGSrKCxFhShbe0WghrsKkgJGJvUflqf2x6jX+m7eoThV1Aw+1vwwbVKfjL
         iHcreI+wbSA7VJsqcZYCDTRtI/1pzOmI7t/cXqZv6OH51faAzGX+y0eKtiXQhsG+870U
         quVqTmwbOe6MukcmVT6C37B46Dp6Zd69UZj1m9Ko0V0w5M6bRliG8BFIZAaorJ2Zcwje
         +0iwnapTX+IUdvR5RCQqxeKq6EIKbDuipZJ5cS86Xe5EYPjsJVrBMS0ZwLlTN9Ft7L82
         SohQ==
X-Received: by 10.66.194.13 with SMTP id hs13mr1276156pac.163.1377501015921;
        Mon, 26 Aug 2013 00:10:15 -0700 (PDT)
Received: from localhost.localdomain ([114.248.144.150])
        by mx.google.com with ESMTPSA id kd1sm17994787pab.20.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 00:10:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.g434fd97
In-Reply-To: <cover.1377500206.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1377500206.git.worldhello.net@gmail.com>
References: <7v7gfiojz7.fsf@alter.siamese.dyndns.org> <cover.1377500206.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232979>

In order to see what the current branch is tracking, one way is using
"git branch -v -v", but branches other than the current are also
reported. Another way is using "git status", such as:

    $ git status
    # On branch master
    # Your branch is ahead of 'origin/master' by 1 commit.
    ...

But this will not work if there is no change between the current
branch and its upstream. Always report upstream tracking info
even if there is no difference, so that "git status" is consistent
for checking tracking info for current branch. E.g.

    $ git status
    # On branch feature1
    # Your branch is identical to 'github/feature1'.
    ...

    $ git status -bs
    ## feature1...github/feature1
    ...

    $ git checkout feature1
    Already on 'feature1'
    Your branch is identical to 'github/feature1'.
    ...

Also add some test cases in t6040.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c                 |  7 ++++---
 t/t6040-tracking-info.sh | 34 +++++++++++++++++++++++++++++++++-
 wt-status.c              | 10 +++++-----
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index 87c8dd3..7a8fe3f 100644
--- a/remote.c
+++ b/remote.c
@@ -1788,9 +1788,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		upstream_is_gone = 1;
 		break;
 	default:
-		/* Nothing to report if neither side has changes. */
-		if (!ours && !theirs)
-			return 0;
 		/* with base */
 		break;
 	}
@@ -1804,6 +1801,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		if (advice_status_hints)
 			strbuf_addf(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+	} else if (!ours && !theirs) {
+		strbuf_addf(sb,
+			_("Your branch is identical to '%s'.\n"),
+			base);
 	} else if (!theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 6f678a4..b24a18c 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -32,7 +32,8 @@ test_expect_success setup '
 		git checkout -b brokenbase origin &&
 		git checkout -b b5 --track brokenbase &&
 		advance g &&
-		git branch -d brokenbase
+		git branch -d brokenbase &&
+		git checkout -b b6 origin
 	) &&
 	git checkout -b follower --track master &&
 	advance h
@@ -61,6 +62,7 @@ b2 origin/master: ahead 1, behind 1
 b3 origin/master: behind 1
 b4 origin/master: ahead 2
 b5 brokenbase: gone
+b6 origin/master
 EOF
 
 test_expect_success 'branch -vv' '
@@ -93,6 +95,13 @@ test_expect_success 'checkout (upstream is gone)' '
 	test_i18ngrep "is based on .*, but the upstream is gone." actual
 '
 
+test_expect_success 'checkout (identical to upstream)' '
+	(
+		cd test && git checkout b6
+	) >actual &&
+	test_i18ngrep "Your branch is identical to .origin/master" actual
+'
+
 test_expect_success 'status (diverged from upstream)' '
 	(
 		cd test &&
@@ -113,6 +122,16 @@ test_expect_success 'status (upstream is gone)' '
 	test_i18ngrep "is based on .*, but the upstream is gone." actual
 '
 
+test_expect_success 'status (identical to upstream)' '
+	(
+		cd test &&
+		git checkout b6 >/dev/null &&
+		# reports nothing to commit
+		test_must_fail git commit --dry-run
+	) >actual &&
+	test_i18ngrep "Your branch is identical to .origin/master" actual
+'
+
 cat >expect <<\EOF
 ## b1...origin/master [ahead 1, behind 1]
 EOF
@@ -139,6 +158,19 @@ test_expect_success 'status -s -b (upstream is gone)' '
 	test_i18ncmp expect actual
 '
 
+cat >expect <<\EOF
+## b6...origin/master
+EOF
+
+test_expect_success 'status -s -b (identical to upstream)' '
+	(
+		cd test &&
+		git checkout b6 >/dev/null &&
+		git status -s -b | head -1
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'fail to track lightweight tags' '
 	git checkout master &&
 	git tag light &&
diff --git a/wt-status.c b/wt-status.c
index 4b1713e..c5e6817 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1396,11 +1396,6 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		upstream_is_gone = 1;
 		break;
 	default:
-		/* Stop reporting if neither side has changes. */
-		if (!num_ours && !num_theirs) {
-			fputc(s->null_termination ? '\0' : '\n', s->fp);
-			return;
-		}
 		/* with base */
 		break;
 	}
@@ -1410,6 +1405,11 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
 
+	if (!upstream_is_gone && !num_ours && !num_theirs) {
+		fputc(s->null_termination ? '\0' : '\n', s->fp);
+		return;
+	}
+
 	color_fprintf(s->fp, header_color, " [");
 	if (upstream_is_gone) {
 		color_fprintf(s->fp, header_color, _("gone"));
-- 
1.8.4.rc3.2.g434fd97
