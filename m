Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180C61F90A
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbeGMRME (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:31833 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbeGMRMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:03 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0A3EC3F4158;
        Fri, 13 Jul 2018 12:56:35 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 95F403F4155;
        Fri, 13 Jul 2018 12:56:34 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 07/25] structured-logging: t0420 basic tests
Date:   Fri, 13 Jul 2018 16:56:03 +0000
Message-Id: <20180713165621.52017-8-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add structured logging prereq definition "SLOG" to test-lib.sh.
Create t0420 test script with some basic tests.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t0420-structured-logging.sh | 143 ++++++++++++++++++++++++++++++++++++++++++
 t/t0420/parse_json.perl       |  52 +++++++++++++++
 t/test-lib.sh                 |   1 +
 3 files changed, 196 insertions(+)
 create mode 100755 t/t0420-structured-logging.sh
 create mode 100644 t/t0420/parse_json.perl

diff --git a/t/t0420-structured-logging.sh b/t/t0420-structured-logging.sh
new file mode 100755
index 0000000..a594af3
--- /dev/null
+++ b/t/t0420-structured-logging.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+
+test_description='structured logging tests'
+
+. ./test-lib.sh
+
+if ! test_have_prereq SLOG
+then
+	skip_all='skipping structured logging tests'
+	test_done
+fi
+
+LOGFILE=$TRASH_DIRECTORY/test.log
+
+test_expect_success 'setup' '
+	test_commit hello &&
+	cat >key_cmd_start <<-\EOF &&
+	"event":"cmd_start"
+	EOF
+	cat >key_cmd_exit <<-\EOF &&
+	"event":"cmd_exit"
+	EOF
+	cat >key_exit_code_0 <<-\EOF &&
+	"exit_code":0
+	EOF
+	cat >key_exit_code_129 <<-\EOF &&
+	"exit_code":129
+	EOF
+	git config --local slog.pretty false &&
+	git config --local slog.path "$LOGFILE"
+'
+
+test_expect_success 'basic events' '
+	test_when_finished "rm \"$LOGFILE\"" &&
+	git status >/dev/null &&
+	grep -f key_cmd_start "$LOGFILE" &&
+	grep -f key_cmd_exit "$LOGFILE" &&
+	grep -f key_exit_code_0 "$LOGFILE"
+'
+
+test_expect_success 'basic error code and message' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
+	test_expect_code 129 git status --xyzzy >/dev/null 2>/dev/null &&
+	grep -f key_cmd_exit "$LOGFILE" >event_exit &&
+	grep -f key_exit_code_129 event_exit &&
+	grep "\"errors\":" event_exit
+'
+
+test_lazy_prereq PERLJSON '
+	perl -MJSON -e "exit 0"
+'
+
+# Let perl parse the resulting JSON and dump it out.
+#
+# Since the output contains PIDs, SIDs, clock values, and the full path to
+# git[.exe] we cannot have a HEREDOC with the expected result, so we look
+# for a few key fields.
+#
+test_expect_success PERLJSON 'parse JSON for basic command' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
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
+	grep "row\[0\]\.command status" <parsed_exit
+'
+
+test_expect_success PERLJSON 'parse JSON for branch command/sub-command' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
+	git branch -v >/dev/null &&
+	git branch --all >/dev/null &&
+	git branch new_branch >/dev/null &&
+
+	grep -f key_cmd_exit "$LOGFILE" >event_exit &&
+
+	perl "$TEST_DIRECTORY"/t0420/parse_json.perl <event_exit >parsed_exit &&
+
+	grep "row\[0\]\.version\.slog 0" <parsed_exit &&
+	grep "row\[0\]\.argv\[1\] branch" <parsed_exit &&
+	grep "row\[0\]\.argv\[2\] -v" <parsed_exit &&
+	grep "row\[0\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[0\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[0\]\.command branch" <parsed_exit &&
+	grep "row\[0\]\.sub_command list" <parsed_exit &&
+
+	grep "row\[1\]\.argv\[1\] branch" <parsed_exit &&
+	grep "row\[1\]\.argv\[2\] --all" <parsed_exit &&
+	grep "row\[1\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[1\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[1\]\.command branch" <parsed_exit &&
+	grep "row\[1\]\.sub_command list" <parsed_exit &&
+
+	grep "row\[2\]\.argv\[1\] branch" <parsed_exit &&
+	grep "row\[2\]\.argv\[2\] new_branch" <parsed_exit &&
+	grep "row\[2\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[2\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[2\]\.command branch" <parsed_exit &&
+	grep "row\[2\]\.sub_command create" <parsed_exit
+'
+
+test_expect_success PERLJSON 'parse JSON for checkout command' '
+	test_when_finished "rm \"$LOGFILE\" event_exit" &&
+	git checkout new_branch >/dev/null &&
+	git checkout master >/dev/null &&
+	git checkout -- hello.t >/dev/null &&
+
+	grep -f key_cmd_exit "$LOGFILE" >event_exit &&
+
+	perl "$TEST_DIRECTORY"/t0420/parse_json.perl <event_exit >parsed_exit &&
+
+	grep "row\[0\]\.version\.slog 0" <parsed_exit &&
+	grep "row\[0\]\.argv\[1\] checkout" <parsed_exit &&
+	grep "row\[0\]\.argv\[2\] new_branch" <parsed_exit &&
+	grep "row\[0\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[0\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[0\]\.command checkout" <parsed_exit &&
+	grep "row\[0\]\.sub_command switch_branch" <parsed_exit &&
+
+	grep "row\[1\]\.version\.slog 0" <parsed_exit &&
+	grep "row\[1\]\.argv\[1\] checkout" <parsed_exit &&
+	grep "row\[1\]\.argv\[2\] master" <parsed_exit &&
+	grep "row\[1\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[1\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[1\]\.command checkout" <parsed_exit &&
+	grep "row\[1\]\.sub_command switch_branch" <parsed_exit &&
+
+	grep "row\[2\]\.version\.slog 0" <parsed_exit &&
+	grep "row\[2\]\.argv\[1\] checkout" <parsed_exit &&
+	grep "row\[2\]\.argv\[2\] --" <parsed_exit &&
+	grep "row\[2\]\.argv\[3\] hello.t" <parsed_exit &&
+	grep "row\[2\]\.event cmd_exit" <parsed_exit &&
+	grep "row\[2\]\.result\.exit_code 0" <parsed_exit &&
+	grep "row\[2\]\.command checkout" <parsed_exit &&
+	grep "row\[2\]\.sub_command path" <parsed_exit
+'
+
+test_done
diff --git a/t/t0420/parse_json.perl b/t/t0420/parse_json.perl
new file mode 100644
index 0000000..ca4e5bf
--- /dev/null
+++ b/t/t0420/parse_json.perl
@@ -0,0 +1,52 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+use JSON;
+
+sub dump_array {
+    my ($label_in, $ary_ref) = @_;
+    my @ary = @$ary_ref;
+
+    for ( my $i = 0; $i <= $#{ $ary_ref }; $i++ )
+    {
+	my $label = "$label_in\[$i\]";
+	dump_item($label, $ary[$i]);
+    }
+}
+
+sub dump_hash {
+    my ($label_in, $obj_ref) = @_;
+    my %obj = %$obj_ref;
+
+    foreach my $k (sort keys %obj) {
+	my $label = (length($label_in) > 0) ? "$label_in.$k" : "$k";
+	my $value = $obj{$k};
+
+	dump_item($label, $value);
+    }
+}
+
+sub dump_item {
+    my ($label_in, $value) = @_;
+    if (ref($value) eq 'ARRAY') {
+	print "$label_in array\n";
+	dump_array($label_in, $value);
+    } elsif (ref($value) eq 'HASH') {
+	print "$label_in hash\n";
+	dump_hash($label_in, $value);
+    } elsif (defined $value) {
+	print "$label_in $value\n";
+    } else {
+	print "$label_in null\n";
+    }
+}
+
+my $row = 0;
+while (<>) {
+    my $data = decode_json( $_ );
+    my $label = "row[$row]";
+
+    dump_hash($label, $data);
+    $row++;
+}
+
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2831570..3d38bc7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1071,6 +1071,7 @@ test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -z "$STRUCTURED_LOGGING" || test_set_prereq SLOG
 
 # Can we rely on git's output in the C locale?
 if test -n "$GETTEXT_POISON"
-- 
2.9.3

