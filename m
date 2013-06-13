From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] t/rebase: add failing tests for a peculiar revision
Date: Thu, 13 Jun 2013 23:46:00 +0530
Message-ID: <1371147362-26962-2-git-send-email-artagnon@gmail.com>
References: <1371147362-26962-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:18:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC64-000878-3D
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869Ab3FMSSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:18:01 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:61795 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3FMSR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:17:59 -0400
Received: by mail-pd0-f170.google.com with SMTP id x11so5820537pdj.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=a4d59DOaXPxY4qH2SkO6L+XFw4hkJbL1YAJ40nJ61n0=;
        b=Uqp7W+J8Ug3K80eGWqdiOHJcsyMX3c47qXq0VWSN+sZ6z01TV/uG8wUwsifkRJaaib
         BIstlxq/dVa64wtgAXr45xpWfaDMljKorTJSRErgP3wVtAMwrHZjCxfl+j21Raksa4E0
         yIvtVZBYs2ZPX8nZXzro8gFq9XjjLD8QgoEcIYSZNhsGXjqxrTybdoyrU1Yqy29/bcyg
         ZemMKaEq8GZbDF6EjsN5cVz7dPlm9IDWmEQjteWGTyNYNU2CuM1UYMjesMR8G7lxVKyw
         cP1QulrSMQQ2bFAtpVBL4ojZjksQ2XoTBoRCZuhmjbYdb+l7/iXYJZLOcZ9adNzYcfk9
         +w7w==
X-Received: by 10.68.202.41 with SMTP id kf9mr2006955pbc.80.1371147478996;
        Thu, 13 Jun 2013 11:17:58 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pm7sm24250605pbb.31.2013.06.13.11.17.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 11:17:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.g31c8856.dirty
In-Reply-To: <1371147362-26962-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227765>

The following commands fail, even if :/quuxery resolves to a perfectly
valid commit:

  $ git rebase :/quuxery
  $ git rebase -i :/quuxery

This is because rebase [-i] attempts to rev-parse ${REV}^0 to verify
that the given revision resolves to a commit.  Add tests to document
these failures.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3400-rebase.sh             | 8 ++++++++
 t/t3404-rebase-interactive.sh | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b58fa1a..890f159 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -88,6 +88,14 @@ test_expect_success 'rebase fast-forward to master' '
 	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
 '
 
+test_expect_failure 'rebase against revision specified as :/quuxery' '
+	git checkout my-topic-branch^ &&
+	sha1=$(git rev-parse ":/Add B") &&
+	git rebase $sha1 &&
+	git checkout my-topic-branch^ &&
+	git rebase ":/Add B"
+'
+
 test_expect_success 'the rebase operation should not have destroyed author information' '
 	! (git log | grep "Author:" | grep "<>")
 '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 79e8d3c..ca4ee92 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -947,4 +947,12 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_failure 'rebase -i against revision specified as :/quuxery' '
+	git checkout branch1 &&
+	sha1=$(git rev-parse ":/J") &&
+	git rebase $sha1 &&
+	git checkout branch1 &&
+	git rebase ":/J"
+'
+
 test_done
-- 
1.8.3.1.381.g31c8856.dirty
