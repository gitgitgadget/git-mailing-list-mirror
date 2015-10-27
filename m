From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH] t4034: Test parsing words following newline
Date: Mon, 26 Oct 2015 18:40:13 -0700
Message-ID: <1445910013-13382-2-git-send-email-lucian.poston@gmail.com>
References: <1445910013-13382-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 02:40:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqtFu-0002Dy-QO
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 02:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbbJ0Bks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 21:40:48 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35997 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbbJ0Bkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 21:40:47 -0400
Received: by pacfv9 with SMTP id fv9so214113714pac.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=urba9epWXz7HPFlf6O5QJPtn710VgiAgLjHUwfH/XcA=;
        b=xZFNm8p5O+tIY+2EVAvQaPkTgHRWdOearfHSMkmSR8jP4+dOk9IoNqAWLK1jm8LJN+
         xaK1HyIMUFdSo0yChhRrs+QvEHRNxgVWpd+TqInrcmQiVfsPdX2y6y+nnb0klSssDqF0
         u+WEbnHCwITEgoQhSXunz+0picfgbip5MIpA/fqMcbdfLvOlHU6GEZzd1pjVuaKOumOj
         MIYLW/nYgIswiJG+SRDwILpiUBbG/XRUK4KcFPTH39n6F6FSAPnCbOpprgTw3xH0MtlC
         yyvD/qiYW8PsV8dWShGSmovID8KscnU3eBRuroUROWUNmsj0UjAGyUP/0gxRL8p2Zwhq
         iSKw==
X-Received: by 10.68.211.132 with SMTP id nc4mr25984745pbc.16.1445910047223;
        Mon, 26 Oct 2015 18:40:47 -0700 (PDT)
Received: from bliss.localdomain (c-24-143-94-84.customer.broadstripe.net. [24.143.94.84])
        by smtp.gmail.com with ESMTPSA id t9sm36229967pbs.17.2015.10.26.18.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 18:40:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1445910013-13382-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280241>

Add test that shows diff --word-diff's inconsistent placement of removed
words. This occurs when both the removed word is first on its line and the
previous line has a removed word.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4034-diff-words.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index f2f55fc..8d9f1b7 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -265,6 +265,36 @@ test_expect_success 'test parsing words for newline' '
 	word_diff --color-words="a+"
 '
 
+test_expect_success 'test parsing words following newline' '
+	cat >pre <<-\EOF &&
+		11aa
+		11aa
+		
+		11aa
+		11aa
+	EOF
+	cat >post <<-\EOF &&
+		11aa
+		aa
+		
+		aa
+		aa
+	EOF
+	cat >expect <<-\EOF &&
+		<BOLD>diff --git a/pre b/post<RESET>
+		<BOLD>index 2e0acd4..f6e6721 100644<RESET>
+		<BOLD>--- a/pre<RESET>
+		<BOLD>+++ b/post<RESET>
+		<CYAN>@@ -1,5 +1,5 @@<RESET>
+		11aa<RESET>
+		<RED>11<RESET>aa
+		
+		<RED>11<RESET>aa
+		<RED>11<RESET>aa
+	EOF
+	word_diff --color-words="a+|1+"
+'
+
 test_expect_success 'test when words are only removed at the end' '
 	echo "(:" >pre &&
 	echo "(" >post &&
-- 
2.4.10
