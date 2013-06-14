From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] t/rebase: add failing tests for a peculiar revision
Date: Fri, 14 Jun 2013 18:47:50 +0530
Message-ID: <1371215872-9796-2-git-send-email-artagnon@gmail.com>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:20:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTv6-0004tR-Bz
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab3FNNTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:19:50 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63985 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab3FNNTt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:19:49 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so564903pdj.26
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zAyZivb8bUV4AnzJO6a1XwIyJjFV2XW1uJT66ILYaIo=;
        b=mRiSatrFedytR8O5T/s8nGKD9MrPlZ3ol/lq63F0ozZ20y1VXxxDjUrMmHIhX4VM4v
         G+PNhMPPTjAUMhTfS2ZnaBXW92X3SoR23UJ3t7AuQSbanCFE8ST4WfdHOqDZmGTpgHNY
         KixNcgxp1h7rOUVQFwoYPsQ2UyH3cMF0oefMYxJLkwpywizmIDLjW5zXRJPt8b3RuSRT
         4/uw11Hh0YK/3dY8qzlycLmhhqx4jXPZm0PruRZsAbUuDFQyUfFD7czJ4mb2xKwFq4b1
         SLlHqtUzHhVFgf7mR0Rs1+jE+4izmif9rL/NxlajK9z+zJ6hQTPqJ845/sDC11wTzrB5
         oEDg==
X-Received: by 10.66.245.110 with SMTP id xn14mr2518774pac.130.1371215988623;
        Fri, 14 Jun 2013 06:19:48 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id i16sm2422081pag.18.2013.06.14.06.19.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 06:19:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.g12ca056.dirty
In-Reply-To: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227827>

The following commands fail, even if :/quuxery and :/foomery resolve to
perfectly valid commits:

  $ git rebase [-i] --onto :/quuxery :/foomery

This is because rebase [-i] attempts to rev-parse ${REV}^0 to verify
that the given revision resolves to a commit.  Add tests to document
these failures.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3400-rebase.sh             | 11 +++++++++++
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b58fa1a..81ec517 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -88,6 +88,17 @@ test_expect_success 'rebase fast-forward to master' '
 	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
 '
 
+test_expect_failure 'rebase, with <onto> and <upstream> specified as :/quuxery' '
+	test_when_finished "git branch -D torebase" &&
+	git checkout -b torebase my-topic-branch^ &&
+	upstream=$(git rev-parse ":/Add B") &&
+	onto=$(git rev-parse ":/Add A") &&
+	git rebase --onto $onto $upstream &&
+	git reset --hard my-topic-branch^ &&
+	git rebase --onto ":/Add A" ":/Add B" &&
+	git checkout my-topic-branch
+'
+
 test_expect_success 'the rebase operation should not have destroyed author information' '
 	! (git log | grep "Author:" | grep "<>")
 '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 79e8d3c..eb241f5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -947,4 +947,15 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_failure 'rebase -i, with <onto> and <upstream> specified as :/quuxery' '
+	test_when_finished "git branch -D torebase" &&
+	git checkout -b torebase branch1 &&
+	upstream=$(git rev-parse ":/J") &&
+	onto=$(git rev-parse ":/A") &&
+	git rebase --onto $onto $upstream &&
+	git reset --hard branch1 &&
+	git rebase --onto ":/A" ":/J" &&
+	git checkout branch1
+'
+
 test_done
-- 
1.8.3.1.381.g12ca056.dirty
