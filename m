Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC561F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbeGMRMM (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:31839 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387868AbeGMRML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1F9A23F4139;
        Fri, 13 Jul 2018 12:56:44 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id ABF833F4025;
        Fri, 13 Jul 2018 12:56:43 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 23/25] structured-logging: t0420 tests for child process detail events
Date:   Fri, 13 Jul 2018 16:56:19 +0000
Message-Id: <20180713165621.52017-24-git@jeffhostetler.com>
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
 t/t0420-structured-logging.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t0420-structured-logging.sh b/t/t0420-structured-logging.sh
index 2e06cd7..4ac404d 100755
--- a/t/t0420-structured-logging.sh
+++ b/t/t0420-structured-logging.sh
@@ -26,6 +26,9 @@ test_expect_success 'setup' '
 	cat >key_exit_code_129 <<-\EOF &&
 	"exit_code":129
 	EOF
+	cat >key_detail <<-\EOF &&
+	"event":"detail"
+	EOF
 	git config --local slog.pretty false &&
 	git config --local slog.path "$LOGFILE"
 '
@@ -221,4 +224,40 @@ test_expect_success PERLJSON 'turn on aux-data, verify a few fields' '
 	grep "row\[0\]\.aux\.index\[.*\]\[0\] sparse_checkout_count" <parsed_exit
 '
 
+test_expect_success PERLJSON 'verify child start/end events during clone' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
+	git config --local slog.aux false &&
+	git config --local slog.detail false &&
+	git config --local slog.timers false &&
+	rm -f "$LOGFILE" &&
+
+	# Clone seems to read the config after it switches to the target repo
+	# rather than the source repo, so we have to explicitly set the config
+	# settings on the command line.
+	git -c slog.path="$LOGFILE" -c slog.detail=true clone . ./clone1 &&
+
+	grep -f key_cmd_exit "$LOGFILE" >event_exit &&
+	grep -f key_detail "$LOGFILE" >event_detail &&
+
+	perl "$TEST_DIRECTORY"/t0420/parse_json.perl <event_exit >parsed_exit &&
+	perl "$TEST_DIRECTORY"/t0420/parse_json.perl <event_detail >parsed_detail &&
+
+	grep "row\[0\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[0\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[0\]\.command upload-pack" <parsed_exit &&
+
+	grep "row\[1\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[1\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[1\]\.command clone" <parsed_exit &&
+
+	grep "row\[0\]\.detail\.label child_starting" <parsed_detail &&
+	grep "row\[0\]\.detail\.data\.child_id 0" <parsed_detail &&
+	grep "row\[0\]\.detail\.data\.child_argv\[0\] git-upload-pack" <parsed_detail &&
+
+	grep "row\[1\]\.detail\.label child_ended" <parsed_detail &&
+	grep "row\[1\]\.detail\.data\.child_id 0" <parsed_detail &&
+	grep "row\[1\]\.detail\.data\.child_argv\[0\] git-upload-pack" <parsed_detail &&
+	grep "row\[1\]\.detail\.data\.child_exit_code 0" <parsed_detail
+'
+
 test_done
-- 
2.9.3

