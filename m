From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 3/3] status: always show tracking branch even no change
Date: Fri, 16 Aug 2013 02:11:23 +0800
Message-ID: <224af6e4fce9004aa50ea0c11c703107857c46f0.1376590264.git.worldhello.net@gmail.com>
References: <6bc0643a5fa0fae03be6fdb59f63075be1e4d983.1376590264.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 15 20:13:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA22j-0003q0-7h
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 20:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759471Ab3HOSNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 14:13:00 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:40977 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759308Ab3HOSM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 14:12:59 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so1112272pdj.11
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=snP6inv44uvOJe2wNmDlVQykANuTa3YlWMxdIUQ3jtY=;
        b=IxWveQcggOWLHlmXFEIGIG6WenLshynYxvTeWKkSeNxjx73m5cplHhsfBas8bTIfRm
         jJhY5RkmO4ouTfHrF38PsT1/X3I7fvGXrll/7Z6FVM9rH1p/W5ibp2xHSlfP55h+t7vF
         24+NyiTneFcj5BdqKxWFU8T7E9MlsIKWpRBoRrVtXuWU4zcvoN41oHpwryJQ3Dt5m49V
         mzqEKS/KsSXPcWJwxr8oFHrtMh+wYP8SnWdHZk7BgqAGTkZiErW6tSMOU4JvSz88mVMh
         hd4E1u3IbG45lahKuSg5fBpXtBkNR54txY07KS+DENnc9AhKSdZ72PTWrJcCflIrnsH/
         SGYg==
X-Received: by 10.66.27.101 with SMTP id s5mr2875488pag.176.1376590378543;
        Thu, 15 Aug 2013 11:12:58 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.124])
        by mx.google.com with ESMTPSA id bt1sm1346733pbb.2.2013.08.15.11.12.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 11:12:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.478.g12f0bfd.dirty
In-Reply-To: <6bc0643a5fa0fae03be6fdb59f63075be1e4d983.1376590264.git.worldhello.net@gmail.com>
In-Reply-To: <7vbo50uvty.fsf@alter.siamese.dyndns.org>
References: <7vbo50uvty.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232360>

In order to see what the current branch is tracking, one way is using
"git branch -v -v", but branches other than the current are also
reported. Another way is using "git status", such as:

    $ git status
    # On branch master
    # Your branch is ahead of 'origin/master' by 1 commit.
    ...

But this will not work if there is no change between the current
branch and its upstream. What if report upstream tracking info
always even if there is no difference. E.g.

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
index aa87381..1137394 100644
--- a/remote.c
+++ b/remote.c
@@ -1822,9 +1822,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		broken_upstream = 1;
 		break;
 	default:
-		/* Nothing to report if neither side has changes. */
-		if (!ours && !theirs)
-			return 0;
 		break;
 	}
 
@@ -1837,6 +1834,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
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
index e362a01..404b629 100755
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
 b5 brokenbase: broken
+b6 origin/master
 EOF
 
 test_expect_success 'branch -vv' '
@@ -93,6 +95,13 @@ test_expect_success 'checkout (broken upstream)' '
 	test_i18ngrep "is based on a broken ref" actual
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
@@ -113,6 +122,16 @@ test_expect_success 'status (broken upstream)' '
 	test_i18ngrep "is based on a broken ref" actual
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
@@ -139,6 +158,19 @@ test_expect_success 'status -s -b (broken upstream)' '
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
index 60164d4..c66963c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1394,10 +1394,6 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		broken_upstream = 1;
 		break;
 	default:
-		if (!num_ours && !num_theirs) {
-			fputc(s->null_termination ? '\0' : '\n', s->fp);
-			return;
-		}
 		break;
 	}
 
@@ -1406,6 +1402,11 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
 
+	if (!broken_upstream && !num_ours && !num_theirs) {
+		fputc(s->null_termination ? '\0' : '\n', s->fp);
+		return;
+	}
+
 	color_fprintf(s->fp, header_color, " [");
 	if (broken_upstream) {
 		color_fprintf(s->fp, header_color, _("broken"));
-- 
1.8.4.rc2.478.g12f0bfd.dirty
