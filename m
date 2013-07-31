From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/11] blame: fix -L bounds checking bug
Date: Wed, 31 Jul 2013 04:15:38 -0400
Message-ID: <1375258545-42240-5-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:16:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4RaR-0005zM-AE
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759101Ab3GaIQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:39 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:46724 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988Ab3GaIQh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:37 -0400
Received: by mail-ye0-f174.google.com with SMTP id q9so173719yen.5
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=gdL8O7LDKE+6Uyyl0FPNKTMoU7YktyybuByaD1wQ/l4=;
        b=zaRLtw81VZZmpT9BRI7P2aYKBa+txXISZObGdOymeLTwtfdK3elbEi1IxK92rBgcld
         6Y3k2MqDlY1NN9mOUmx96EfWYuPkw/1XJvuiPJs4YxKHTcSIC/zWYSyG6vklWHRXdZwL
         l9n4sTkQ3N5rmbN9FVvTua0UvXMJebBbXAg6Xy8kqBp809CUpUHh0eDARrHqJo9VoPPq
         swd3a+a8QCjVZVjIdsvSoiN76XVSdeymcaIVKAjst4ZIQdXkriB8cQjIH7A46dz0/jCo
         Zce8YRjKX81c5NNYCQjldVvJNevLL/aIDPYF4aFspDXlEvhSJU33eespeoDd5wJJ7M58
         bqXg==
X-Received: by 10.236.84.20 with SMTP id r20mr31860156yhe.60.1375258596532;
        Wed, 31 Jul 2013 01:16:36 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231403>

Since inception, -LX,Y has correctly reported an out-of-range error when
Y is beyond end of file, however, X was not checked, and an out-of-range
X would cause a crash.  92f9e273 (blame: prevent a segv when -L given
start > EOF; 2010-02-08) attempted to rectify this shortcoming but has
its own off-by-one error which allows X to extend one line past end of
file.  For example, given a file with 5 lines:

  git blame -L5 foo  # OK, blames line 5
  git blame -L6 foo  # accepted, no error, no output, huh?
  git blame -L7 foo  # error "fatal: file foo has only 5 lines"

Fix this bug.

In order to avoid regressing "blame foo" when foo is an empty file, the
fix is slightly more complicated than changing '<' to '<='.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/blame.c     | 4 ++--
 t/annotate-tests.sh | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 079dcd3..e70b089 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2495,13 +2495,13 @@ parse_done:
 	bottom = top = 0;
 	if (bottomtop)
 		prepare_blame_range(&sb, bottomtop, lno, &bottom, &top);
+	if (lno < top || ((lno || bottom) && lno < bottom))
+		die("file %s has only %lu lines", path, lno);
 	if (bottom < 1)
 		bottom = 1;
 	if (top < 1)
 		top = lno;
 	bottom--;
-	if (lno < top || lno < bottom)
-		die("file %s has only %lu lines", path, lno);
 
 	ent = xcalloc(1, sizeof(*ent));
 	ent->lno = bottom;
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index f67332c..f117ef0 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -232,7 +232,7 @@ test_expect_success 'blame -L X (X == nlines)' '
 	check_count -L$n C 1
 '
 
-test_expect_failure 'blame -L X (X == nlines + 1)' '
+test_expect_success 'blame -L X (X == nlines + 1)' '
 	n=$(expr $(wc -l <file) + 2) &&
 	test_must_fail $PROG -L$n file
 '
@@ -321,7 +321,7 @@ test_expect_success 'blame -L 0 empty (undocumented)' '
 	check_count -h HEAD^^ -f incremental -L0
 '
 
-test_expect_failure 'blame -L 1 empty' '
+test_expect_success 'blame -L 1 empty' '
 	test_must_fail $PROG -L1 incremental HEAD^^
 '
 
@@ -341,7 +341,7 @@ test_expect_success 'blame -L 1 half' '
 	check_count -h HEAD^ -f incremental -L1 I 1
 '
 
-test_expect_failure 'blame -L 2 half' '
+test_expect_success 'blame -L 2 half' '
 	test_must_fail $PROG -L2 incremental HEAD^
 '
 
@@ -361,7 +361,7 @@ test_expect_success 'blame -L 1 full' '
 	check_count -f incremental -L1 I 1
 '
 
-test_expect_failure 'blame -L 2 full' '
+test_expect_success 'blame -L 2 full' '
 	test_must_fail $PROG -L2 incremental
 '
 
-- 
1.8.3.4.1120.gc240c48
