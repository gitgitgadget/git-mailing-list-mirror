From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 11/12] t3418: non-interactive rebase --continue with rerere enabled
Date: Sun, 19 Jul 2015 23:49:17 +0800
Message-ID: <1437320958-11192-12-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:50:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqs-0005oa-Qg
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbbGSPuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:50:02 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36379 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbbGSPuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:50:00 -0400
Received: by pachj5 with SMTP id hj5so89074738pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtnVKLAJEEd3/1LLvyru2fq2npmx08dy0hKO4HLwiHk=;
        b=OthL7neINz62qui9kO7DNX7W1ddy/4KIZhijyaDQyDp//sr7xV1E1jxBUDW6S+dQSv
         jok92llSvAiQjYa+sd6u7DOq59+hh0+0Y9txbb/U66CCUCcoZO8fgR+vWY8DIup+uXGY
         m85VvYp1yZrduQ+mRacH/71CneaTR0bhbRRnetGz3rDIJltDqROGh+WrpxfdmIBIYI0z
         MvLAp75yHL+mp+D7yEUojVdbcH/LLNqGcNAbNpVX+JZUe5PpVWDyVzixuLVxlFJ0zyvn
         cswlBUoTYgKCh7Qb8/xyE9i7NPRjwHYQ79S3eW3pPYxrTM43z+hvuhMCuKulIU/azJdo
         9S+Q==
X-Received: by 10.66.249.1 with SMTP id yq1mr48604654pac.3.1437321000093;
        Sun, 19 Jul 2015 08:50:00 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274223>

Since 8389b52 (git-rerere: reuse recorded resolve., 2006-01-28), git-am
will call git-rerere to re-use recorded merge conflict resolutions if
any occur in a threeway merge.

Add a test to ensure that git-rerere is called by git-am (which handles
the non-interactive rebase).

Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t3418-rebase-continue.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 2680375..4428b90 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -40,6 +40,25 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
 	git rebase --continue
 '
 
+test_expect_success 'non-interactive rebase --continue with rerere enabled' '
+	test_config rerere.enabled true &&
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	git checkout master &&
+	rm -fr .git/rebase-* &&
+
+	test_must_fail git rebase --onto master master topic &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	cp F2 F2.expected &&
+	git rebase --continue &&
+
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	git checkout master &&
+	test_must_fail git rebase --onto master master topic &&
+	test_cmp F2.expected F2
+'
+
 test_expect_success 'rebase --continue can not be used with other options' '
 	test_must_fail git rebase -v --continue &&
 	test_must_fail git rebase --continue -v
-- 
2.5.0.rc2.110.gf2a5fc6
