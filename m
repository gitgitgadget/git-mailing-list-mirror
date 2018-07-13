Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272021F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbeGMRMM (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:31920 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387869AbeGMRML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A9D263F4161;
        Fri, 13 Jul 2018 12:56:44 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 422B63F413F;
        Fri, 13 Jul 2018 12:56:44 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 24/25] structured-logging: t0420 tests for interacitve child_summary
Date:   Fri, 13 Jul 2018 16:56:20 +0000
Message-Id: <20180713165621.52017-25-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Test running a command with a fake pager and verify that a child_summary
is generated.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t0420-structured-logging.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t0420-structured-logging.sh b/t/t0420-structured-logging.sh
index 4ac404d..69f811a 100755
--- a/t/t0420-structured-logging.sh
+++ b/t/t0420-structured-logging.sh
@@ -260,4 +260,34 @@ test_expect_success PERLJSON 'verify child start/end events during clone' '
 	grep "row\[1\]\.detail\.data\.child_exit_code 0" <parsed_detail
 '
 
+. "$TEST_DIRECTORY"/lib-pager.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+test_expect_success 'setup fake pager to test interactive' '
+	test_when_finished "rm \"$LOGFILE\" " &&
+	sane_unset GIT_PAGER GIT_PAGER_IN_USE &&
+	test_unconfig core.pager &&
+
+	PAGER="cat >paginated.out" &&
+	export PAGER &&
+
+	test_commit initial
+'
+
+test_expect_success TTY 'verify fake pager detected and process marked interactive' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
+	rm -f paginated.out &&
+	rm -f "$LOGFILE" &&
+
+	test_terminal git log &&
+	test -e paginated.out &&
+
+	grep -f key_cmd_exit "$LOGFILE" >event_exit &&
+
+	perl "$TEST_DIRECTORY"/t0420/parse_json.perl <event_exit >parsed_exit &&
+
+	grep "row\[0\]\.child_summary\.pager\.count 1" <parsed_exit
+'
+
+
 test_done
-- 
2.9.3

