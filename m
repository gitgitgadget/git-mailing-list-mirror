From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 16/16] line-range: reject -L line numbers less than 1
Date: Tue,  6 Aug 2013 09:59:49 -0400
Message-ID: <1375797589-65308-17-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hov-0003fH-0j
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab3HFOBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:01:01 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:62983 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab3HFOBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:01:00 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so771018oah.9
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBRNZySOBe1WKZ6Q0097OLILpkWy/CzZlRHzuixS6Yg=;
        b=JjkL5xWYHEonwgWaVv6pyWlgWwCeNYBVVpzQV1mQaZVJcoup3GQhKQBLCTop2RCqBG
         Sa2afjnOXvbSCcMS8PuIjPhO5Bu+jbSbzISNRj61R0YcyE9QZMiQ+xf0n2SQZchx1wEU
         6Zadn0bhllXuDJpfgSobqMxlyVFcs9Bt32nwMKvtuPP82t8O1pqGYnjrL3hDpQ0DsayV
         JbkKBHpLyiO5ipms9T4LVZ22n7ErsuiCv9p/QqRZvY7gDbsxGuUfg9jjWU4o9xAkyOdf
         lkt0XOmo+QJju/DGNarmO9vs/tFiXPoanOV2ZqdLRvVvnMUaVTufVdXaUh40jP+GKpdv
         lv/g==
X-Received: by 10.60.38.164 with SMTP id h4mr1163001oek.22.1375797659705;
        Tue, 06 Aug 2013 07:00:59 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231751>

Since inception, git-blame -L has been documented as accepting 1-based
line numbers. When handed a line number less than 1, -L's behavior is
undocumented and undefined; it's also nonsensical and should be
diagnosed as an error. Do so.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-range.c        |  5 ++++-
 t/annotate-tests.sh | 18 +++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/line-range.c b/line-range.c
index ede0c6c..de4e32f 100644
--- a/line-range.c
+++ b/line-range.c
@@ -54,8 +54,11 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 	}
 	num = strtol(spec, &term, 10);
 	if (term != spec) {
-		if (ret)
+		if (ret) {
+			if (num <= 0)
+				die("-L invalid line number: %ld", num);
 			*ret = num;
+		}
 		return term;
 	}
 
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 376b042..99caa42 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -185,15 +185,15 @@ test_expect_success 'blame -L Y,X (undocumented)' '
 	check_count -L6,3 B 1 B1 1 B2 1 D 1
 '
 
-test_expect_failure 'blame -L -X' '
+test_expect_success 'blame -L -X' '
 	test_must_fail $PROG -L-1 file
 '
 
-test_expect_failure 'blame -L 0' '
+test_expect_success 'blame -L 0' '
 	test_must_fail $PROG -L0 file
 '
 
-test_expect_failure 'blame -L ,0' '
+test_expect_success 'blame -L ,0' '
 	test_must_fail $PROG -L,0 file
 '
 
@@ -447,8 +447,8 @@ test_expect_success 'blame empty' '
 	check_count -h HEAD^^ -f incremental
 '
 
-test_expect_success 'blame -L 0 empty (undocumented)' '
-	check_count -h HEAD^^ -f incremental -L0
+test_expect_success 'blame -L 0 empty' '
+	test_must_fail $PROG -L0 incremental HEAD^^
 '
 
 test_expect_success 'blame -L 1 empty' '
@@ -463,8 +463,8 @@ test_expect_success 'blame half' '
 	check_count -h HEAD^ -f incremental I 1
 '
 
-test_expect_success 'blame -L 0 half (undocumented)' '
-	check_count -h HEAD^ -f incremental -L0 I 1
+test_expect_success 'blame -L 0 half' '
+	test_must_fail $PROG -L0 incremental HEAD^
 '
 
 test_expect_success 'blame -L 1 half' '
@@ -483,8 +483,8 @@ test_expect_success 'blame full' '
 	check_count -f incremental I 1
 '
 
-test_expect_success 'blame -L 0 full (undocumented)' '
-	check_count -f incremental -L0 I 1
+test_expect_success 'blame -L 0 full' '
+	test_must_fail $PROG -L0 incremental
 '
 
 test_expect_success 'blame -L 1 full' '
-- 
1.8.4.rc1.409.gbd48715
