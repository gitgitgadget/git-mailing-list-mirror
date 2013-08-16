From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 3/3] status: always show tracking branch even no change
Date: Fri, 16 Aug 2013 10:29:34 +0800
Message-ID: <83686ec4894d881b3dd6272fd235762146ae5111.1376620130.git.worldhello.net@gmail.com>
References: <cover.1376618877.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 16 04:31:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA9pD-0007Xa-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 04:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab3HPCbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 22:31:36 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:47983 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab3HPCbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 22:31:34 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so1344249pad.18
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 19:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=h25LjwyjjKMC0T8d9d94xoe7kxFfRDGFTcjM/qG3S3o=;
        b=qLuuKovqZMBGy3GLQe6yhdpt6E0KlAFTerd8W1KdW2FRCSSq7YdidaBLs2KNwlmNrE
         agIAPl7dHFfPFudFQkpA9sbKte7AzYyJ6Udu6Gid3MPR20KXwRhoCCCWFZEjnZge3Y59
         VE8/zWySyAE59Gl4aJqar4gyNAICde4LpM/3U+yOcO6GFd2u7jLxVEiEGgZ3QAbFNZFg
         X7MCvP+QQjSfQGPFF+D1dPAKMzFpcLj65K7CI4cRFfe8mWnJIZR59tSVK2/2cMSEIzOM
         uUsvvv7rrMHJo9hKUYdPUp32U/XX8CJZdwSvAWfdUl9zveFxfxcliRAL1hMbkPe3AmM0
         CGkA==
X-Received: by 10.68.130.71 with SMTP id oc7mr18762794pbb.10.1376620294228;
        Thu, 15 Aug 2013 19:31:34 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.124])
        by mx.google.com with ESMTPSA id pw9sm2698975pbb.20.2013.08.15.19.31.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 19:31:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.479.g44abce8
In-Reply-To: <cover.1376618877.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1376620130.git.worldhello.net@gmail.com>
References: <7vzjsio99d.fsf@alter.siamese.dyndns.org> <cover.1376620130.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232395>

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
---
 remote.c                 |  7 ++++---
 t/t6040-tracking-info.sh | 34 +++++++++++++++++++++++++++++++++-
 wt-status.c              |  9 +++++----
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 4caccb5..79effe6 100644
--- a/remote.c
+++ b/remote.c
@@ -1822,9 +1822,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		upstream_is_gone = 1;
 		break;
 	default:
-		/* Nothing to report if neither side has changes. */
-		if (!ours && !theirs)
-			return 0;
 		/* with base */
 		break;
 	}
@@ -1838,6 +1835,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
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
index 46d181a..c8c2d77 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1395,10 +1395,6 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		break;
 	default:
 		/* with base */
-		if (!num_ours && !num_theirs) {
-			fputc(s->null_termination ? '\0' : '\n', s->fp);
-			return;
-		}
 		break;
 	}
 
@@ -1407,6 +1403,11 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
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
1.8.4.rc2.479.g44abce8
