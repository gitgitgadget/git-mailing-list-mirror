Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47081F453
	for <e@80x24.org>; Fri, 18 Jan 2019 06:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfARGSK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 01:18:10 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:41462 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfARGSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 01:18:08 -0500
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190118061807.XGXW4136.fed1rmfepo103.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:18:07 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id A91BBB82419;
        Thu, 17 Jan 2019 23:18:06 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090204.5C416F9F.0031,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=St8kF8G0 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=kviXuzpPAAAA:8 a=ylxF0vzRz3BzzoOddn8A:9
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
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 5/5] Add `human` date format tests.
Date:   Thu, 17 Jan 2019 23:18:05 -0700
Message-Id: <20190118061805.19086-6-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20190118061805.19086-1-ischis2@cox.net>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20190118061805.19086-1-ischis2@cox.net>
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
 t/t0006-date.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index ffb2975e48..c7c0786b24 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -128,4 +128,24 @@ check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
 check_approxidate '2008-12-01' '2008-12-01 19:20:00'
 check_approxidate '2009-12-01' '2009-12-01 19:20:00'
 
+check_date_format() {
+	format=$1
+	t=$(($TEST_DATE_NOW - $2))
+	expect=$3
+	test_expect_success "human date $t" "
+	echo $TEST_DATE_NOW >now &&
+	test-tool date human $t >actual &&
+	grep '$expect' actual
+"
+}
+
+check_date_format human 18000 "5 hours ago" # 5 hours ago
+check_date_format human 432000 "Tue Aug 25 19:20" # 5 days ago
+check_date_format human 1728000 "Mon Aug 10 19:20" # 3 weeks ago
+check_date_format human 13000000 "Thu Apr 2 08:13" # 5 months ago
+check_date_format human 31449600 "Aug 31 2008" # 12 months ago
+check_date_format human 37500000 "Jun 22 2008" # 1 year, 2 months ago
+check_date_format human 55188000 "Dec 1 2007" # 1 year, 9 months ago
+check_date_format human 630000000 "Sep 13 1989" # 20 years ago
+
 test_done
-- 
2.20.1.2.gb21ebb671b

