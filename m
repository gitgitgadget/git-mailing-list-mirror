Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65481F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbeGMRMH (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:07 -0400
Received: from siwi.pair.com ([209.68.5.199]:31847 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbeGMRMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:07 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8FFAF3F47F1;
        Fri, 13 Jul 2018 12:56:39 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 27F1F3F47FA;
        Fri, 13 Jul 2018 12:56:39 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 15/25] structured-logging: t0420 tests for timers
Date:   Fri, 13 Jul 2018 16:56:11 +0000
Message-Id: <20180713165621.52017-16-git@jeffhostetler.com>
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
 t/t0420-structured-logging.sh | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t0420-structured-logging.sh b/t/t0420-structured-logging.sh
index a594af3..37c7e83 100755
--- a/t/t0420-structured-logging.sh
+++ b/t/t0420-structured-logging.sh
@@ -140,4 +140,52 @@ test_expect_success PERLJSON 'parse JSON for checkout command' '
 	grep "row\[2\]\.sub_command path" <parsed_exit
 '
 
+test_expect_success PERLJSON 'turn on all timers, verify some are present' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
+	git config --local slog.timers 1 &&
+	rm -f "$LOGFILE" &&
+
+	git status >/dev/null &&
+
+	grep -f key_cmd_exit "$LOGFILE" >event_exit &&
+
+	perl "$TEST_DIRECTORY"/t0420/parse_json.perl <event_exit >parsed_exit &&
+
+	grep "row\[0\]\.version\.slog 0" <parsed_exit &&
+	grep "row\[0\]\.argv\[1\] status" <parsed_exit &&
+	grep "row\[0\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[0\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[0\]\.command status" <parsed_exit &&
+
+	grep "row\[0\]\.timers\.index\.do_read_index\.count" <parsed_exit &&
+	grep "row\[0\]\.timers\.index\.do_read_index\.total_us" <parsed_exit &&
+
+	grep "row\[0\]\.timers\.status\.untracked\.count" <parsed_exit &&
+	grep "row\[0\]\.timers\.status\.untracked\.total_us" <parsed_exit
+'
+
+test_expect_success PERLJSON 'turn on index timers only' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
+	git config --local slog.timers foo,index,bar &&
+	rm -f "$LOGFILE" &&
+
+	git status >/dev/null &&
+
+	grep -f key_cmd_exit "$LOGFILE" >event_exit &&
+
+	perl "$TEST_DIRECTORY"/t0420/parse_json.perl <event_exit >parsed_exit &&
+
+	grep "row\[0\]\.version\.slog 0" <parsed_exit &&
+	grep "row\[0\]\.argv\[1\] status" <parsed_exit &&
+	grep "row\[0\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[0\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[0\]\.command status" <parsed_exit &&
+
+	grep "row\[0\]\.timers\.index\.do_read_index\.count" <parsed_exit &&
+	grep "row\[0\]\.timers\.index\.do_read_index\.total_us" <parsed_exit &&
+
+	test_expect_code 1 grep "row\[0\]\.timers\.status\.untracked\.count" <parsed_exit &&
+	test_expect_code 1 grep "row\[0\]\.timers\.status\.untracked\.total_us" <parsed_exit
+'
+
 test_done
-- 
2.9.3

