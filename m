From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH] pretty: user format ignores i18n.logOutputEncoding setting
Date: Mon, 25 Jul 2011 14:31:15 +0400
Message-ID: <1311589875-12569-2-git-send-email-zapped@mail.ru>
References: <1311589875-12569-1-git-send-email-zapped@mail.ru>
Cc: Alexey Shumkin <zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 12:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlIRb-0006rz-MO
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 12:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab1GYKbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 06:31:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45948 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab1GYKbW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 06:31:22 -0400
Received: by wyg8 with SMTP id 8so2639369wyg.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bbfrjteU9Gfbf2F4YgRFiXvsnnK6I2DAkFePHFwHruM=;
        b=mgOjv+il5c59YKAr/rCaT68AWDT1MRv0BiYREqLfdfzXkP3wsZ0zRAeUt7mRjH4iYL
         1Li69S6Rj7eWoTrdv1x4SGB4MW6E5/3kk1zYzhEf/VjCGpFu2Oc+CY25GjuHwy7f8Al2
         NoDwrSvwcI8BRVNdAx7m6h4yJ/oVc2cD+6oVk=
Received: by 10.216.60.207 with SMTP id u57mr3521138wec.89.1311589881348;
        Mon, 25 Jul 2011 03:31:21 -0700 (PDT)
Received: from zappedws (ppp91-77-22-223.pppoe.mtu-net.ru [91.77.22.223])
        by mx.google.com with ESMTPS id u46sm1444069wec.25.2011.07.25.03.31.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 03:31:21 -0700 (PDT)
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <Alex@zappedws>)
	id 1QlIRS-0003Hl-SD; Mon, 25 Jul 2011 14:31:18 +0400
X-Mailer: git-send-email 1.7.6.dirty
In-Reply-To: <1311589875-12569-1-git-send-email-zapped@mail.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177790>

git log --graph --oneline
and
git log --graph --pretty=format:'%C(yellow)%h %Creset%s'
give different outputs on Linux UTF-8 console
when commit messages contain non-UTF-8 characters
(e.g. commits made on Windows)

Fix it.

Signed-off-by: Alexey Shumkin <zapped@mail.ru>
---
 log-tree.c                    |    1 +
 t/t4205-log-pretty-formats.sh |   20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index e945701..39913d7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -488,6 +488,7 @@ void show_log(struct rev_info *opt)
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
+	ctx.output_encoding = get_log_output_encoding();
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 2ae9faa..24e787a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -11,10 +11,12 @@ test_expect_success 'set up basic repos' '
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git commit -m initial &&
+	git config i18n.commitEncoding cp1251 &&
+	printf "initial \320\272\320\276\320\274\320\274\320\270\321\202" | iconv -t cp1251 -f utf-8 | xargs -I{} git commit -m "{}" &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar"
+	git commit -m "add bar" &&
+	git config --unset i18n.commitEncoding
 '
 
 test_expect_success 'alias builtin format' '
@@ -38,6 +40,20 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'alias user-defined tformat with %s (native encoding)' '
+	git config i18n.logOutputEncoding cp1251 &&
+	git log --oneline >expected-s &&
+	git log --pretty="tformat:%h %s" >actual-s &&
+	git config --unset i18n.logOutputEncoding &&
+	test_cmp expected-s actual-s
+'
+
+test_expect_success 'alias user-defined tformat with %s (utf-8 encoding)' '
+	git log --oneline >expected-s &&
+	git log --pretty="tformat:%h %s" >actual-s &&
+	test_cmp expected-s actual-s
+'
+
 test_expect_success 'alias user-defined tformat' '
 	git log --pretty="tformat:%h" >expected &&
 	git config pretty.test-alias "tformat:%h" &&
-- 
1.7.6.dirty
