Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4791F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbeGMRMJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:31847 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387810AbeGMRMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D09743F4821;
        Fri, 13 Jul 2018 12:56:41 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 68EC13F481F;
        Fri, 13 Jul 2018 12:56:41 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 19/25] structured-logging: t0420 tests for aux-data
Date:   Fri, 13 Jul 2018 16:56:15 +0000
Message-Id: <20180713165621.52017-20-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t0420-structured-logging.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t0420-structured-logging.sh b/t/t0420-structured-logging.sh
index 37c7e83..2e06cd7 100755
--- a/t/t0420-structured-logging.sh
+++ b/t/t0420-structured-logging.sh
@@ -188,4 +188,37 @@ test_expect_success PERLJSON 'turn on index timers only' '
 	test_expect_code 1 grep "row\[0\]\.timers\.status\.untracked\.total_us" <parsed_exit
 '
 
+test_expect_success PERLJSON 'turn on aux-data, verify a few fields' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
+	echo "hello.t" >.git/info/sparse-checkout &&
+	git config --local core.sparsecheckout true &&
+	git config --local slog.aux foo,index,bar &&
+	rm -f "$LOGFILE" &&
+
+	git checkout HEAD &&
+
+	grep -f key_cmd_exit "$LOGFILE" >event_exit &&
+
+	perl "$TEST_DIRECTORY"/t0420/parse_json.perl <event_exit >parsed_exit &&
+
+	grep "row\[0\]\.version\.slog 0" <parsed_exit &&
+	grep "row\[0\]\.argv\[1\] checkout" <parsed_exit &&
+	grep "row\[0\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[0\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[0\]\.command checkout" <parsed_exit &&
+	grep "row\[0\]\.sub_command switch_branch" <parsed_exit &&
+
+	# Expect:
+	#   row[0].aux.index[<k>][0] cache_nr
+	#   row[0].aux.index[<k>][1] 1
+	#   row[0].aux.index[<j>][0] sparse_checkout_count
+	#   row[0].aux.index[<j>][1] 1
+	#
+	# But do not assume values for <j> and <k> (in case the sorting changes
+	# or other "aux" fields are added later).
+
+	grep "row\[0\]\.aux\.index\[.*\]\[0\] cache_nr" <parsed_exit &&
+	grep "row\[0\]\.aux\.index\[.*\]\[0\] sparse_checkout_count" <parsed_exit
+'
+
 test_done
-- 
2.9.3

