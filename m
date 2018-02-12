Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4709F1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 00:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbeBLARX (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 19:17:23 -0500
Received: from avasout01.plus.net ([84.93.230.227]:45780 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeBLARW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 19:17:22 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id l1o8eIRoDykf2l1oAe74y2; Mon, 12 Feb 2018 00:17:22 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B8mXLtlM c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=kmC7ijDzF47jIYV_hCQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] t4151: consolidate multiple calls to test_i18ngrep
Message-ID: <24dd5405-2112-612f-fc0a-f746ace6b292@ramsayjones.plus.com>
Date:   Mon, 12 Feb 2018 00:17:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJBgsxx0ZV/NFY3pXc4D7FtXf+yDwWwvYvYCpGmbZdJDPS4vcEM8W3w3dCGxRlKG0zqQwZDgKKA3wDpd5hrclL2y3MOpzwf8jzRdyC+zfR3z7hfRChEb
 eWKExS59naI/zOITekunTCpLzX50ORVfXPsSvAHZAoyROF3reFIEMQQA/mol0AnkmGybVMIGwm+UdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Attempting to grep the output of test_i18ngrep will not work under a
poison build, since the output is (almost) guaranteed not to have the
string you are looking for. In this case, we have a test_i18ngrep call
which attempts to filter the contents of a file, which was itself the
result of a call to test_i18ngrep. In this case, we can achieve the
same effect with a single call to test_i18ngrep (without creating the
intermediate file), since the second regular expression can be used
without change to filter the original input.

Also, replace a call to test_i18ncmp with test_cmp, since the content
being compared is not subject to i18n anyway.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/t4151-am-abort.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 9473c2779..16432781d 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -46,9 +46,8 @@ do
 
 	test_expect_success "am$with3 --skip continue after failed am$with3" '
 		test_must_fail git am$with3 --skip >output &&
-		test_i18ngrep "^Applying" output >output.applying &&
-		test_i18ngrep "^Applying: 6$" output.applying &&
-		test_i18ncmp file-2-expect file-2 &&
+		test_i18ngrep "^Applying: 6$" output &&
+		test_cmp file-2-expect file-2 &&
 		test ! -f .git/MERGE_RR
 	'
 
-- 
2.16.0
