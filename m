Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B211F453
	for <e@80x24.org>; Tue, 29 Jan 2019 03:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfA2Du0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 22:50:26 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:46104 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfA2DuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 22:50:19 -0500
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190129035018.GXIN4136.fed1rmfepo103.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Mon, 28 Jan 2019 22:50:18 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 3E957B81A5E;
        Mon, 28 Jan 2019 20:50:17 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090211.5C4FCD7A.0012,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=Tv9Sewfh c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=kviXuzpPAAAA:8 a=qrhz1JM_Fw-vKaZgdOYA:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v4 5/5] Add `human` date format tests.
Date:   Mon, 28 Jan 2019 20:50:16 -0700
Message-Id: <20190129035016.25981-6-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20190129035016.25981-1-ischis2@cox.net>
References: <20190121053112.4736-1-ischis2@cox.net>
 <20190129035016.25981-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using `human` several fields are suppressed depending on the time
difference between the reference date and the local computer date. In
cases where the difference is less than a year, the year field is
supppressed. If the time is less than a day; the month and year is
suppressed.

Use TEST_DATE_NOW environment variable when using the test-tool to
hold the expected output strings constant.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/t0006-date.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 90930c2aa7..d9fcc829a9 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -128,4 +128,22 @@ check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
 check_approxidate '2008-12-01' '2008-12-01 19:20:00'
 check_approxidate '2009-12-01' '2009-12-01 19:20:00'
 
+check_date_format_human() {
+	t=$(($GIT_TEST_DATE_NOW - $1))
+	echo "$t -> $2" >expect
+	test_expect_success "human date $t" '
+		test-tool date human $t >actual &&
+		test_i18ncmp expect actual
+'
+}
+
+check_date_format_human 18000 "5 hours ago" # 5 hours ago
+check_date_format_human 432000 "Tue Aug 25 19:20" # 5 days ago
+check_date_format_human 1728000 "Mon Aug 10 19:20" # 3 weeks ago
+check_date_format_human 13000000 "Thu Apr 2 08:13" # 5 months ago
+check_date_format_human 31449600 "Aug 31 2008" # 12 months ago
+check_date_format_human 37500000 "Jun 22 2008" # 1 year, 2 months ago
+check_date_format_human 55188000 "Dec 1 2007" # 1 year, 9 months ago
+check_date_format_human 630000000 "Sep 13 1989" # 20 years ago
+
 test_done
-- 
2.20.1.2.gb21ebb671b

