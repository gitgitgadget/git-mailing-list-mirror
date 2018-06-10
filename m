Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6681F403
	for <e@80x24.org>; Sun, 10 Jun 2018 15:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeFJPNW (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 11:13:22 -0400
Received: from p3plsmtpa06-02.prod.phx3.secureserver.net ([173.201.192.103]:35040
        "EHLO p3plsmtpa06-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753375AbeFJPNT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 11:13:19 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2018 11:13:11 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id S1uNfeU0REJZQS1uofyRGz; Sun, 10 Jun 2018 08:06:00 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v8 3/3] http-backend: respect CONTENT_LENGTH for receive-pack
Date:   Sun, 10 Jun 2018 18:05:21 +0300
Message-Id: <20180610150521.9714-4-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-Reply-To: <20180610150521.9714-1-max@max630.net>
References: <20180610150521.9714-1-max@max630.net>
X-CMAE-Envelope: MS4wfHFtRHiJNzUCDhPYurl7mmCSTYmuUHPL3HJ14jTUJC9IvVN1ibBdEf0Ov5LGn1qdXefyEcgi3UwPwKYIKeWE2SD77KWKvEkoq4EbqMfk9OeD/RWWTa6i
 GL+OdkOToQWIXUswxD6/TjkWXUdCgc2qv8z66qFcVr6Xk4+9AcSPTAUPznsSVuG//yxmJ7pCre6VnpOTHI2VZrn0u4nANy6yNU4/Zd3iMe0XB5co47lSiKCw
 yJ4J/mAm2Uo4cr93joZzpLHz35i6E+NeMrsbIzkRC2xFjskp/6GG08JfI3ZlXpGdg0RSD79W0/SOQHlIN6KiHyMvEckGJTGJlDrtrnyQxUWcGMy5IrIG3Vpz
 q0aYPsnIyBMe8xhFRt6eKbchri4jbE0SlYrwEzrPRs6mL+D2byo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Push passes to another commands, as described in
https://public-inbox.org/git/20171129032214.GB32345@sigill.intra.peff.net/

As it gets complicated to correctly track the data length, instead transfer
the data through parent process and cut the pipe as the specified length is
reached. Do it only when CONTENT_LENGTH is set, otherwise pass the input
directly to the forked commands.

Add tests for cases:

* CONTENT_LENGTH is set, script's stdin has more data, with all combinations
  of variations: fetch or push, plain or compressed body, correct or truncated
  input.

* CONTENT_LENGTH is specified to a value which does not fit into ssize_t.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
 help.c                                 |   1 +
 http-backend.c                         |  32 ++++-
 t/t5562-http-backend-content-length.sh | 169 +++++++++++++++++++++++++
 t/t5562/invoke-with-content-length.pl  |  37 ++++++
 4 files changed, 237 insertions(+), 2 deletions(-)
 create mode 100755 t/t5562-http-backend-content-length.sh
 create mode 100755 t/t5562/invoke-with-content-length.pl

diff --git a/help.c b/help.c
index 60071a9bea..42600ca026 100644
--- a/help.c
+++ b/help.c
@@ -419,6 +419,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 		else
 			printf("no commit associated with this build\n");
 		printf("sizeof-long: %d\n", (int)sizeof(long));
+		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 	return 0;
diff --git a/http-backend.c b/http-backend.c
index 0c9e9be2b7..28c07e7c2a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -372,6 +372,8 @@ static void inflate_request(const char *prog_name, int out, int buffer_input, ss
 	unsigned char in_buf[8192];
 	unsigned char out_buf[8192];
 	unsigned long cnt = 0;
+	int req_len_defined = req_len >= 0;
+	size_t req_remaining_len = req_len;
 
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init_gzip_only(&stream);
@@ -386,8 +388,15 @@ static void inflate_request(const char *prog_name, int out, int buffer_input, ss
 				n = read_request(0, &full_request, req_len);
 			stream.next_in = full_request;
 		} else {
-			n = xread(0, in_buf, sizeof(in_buf));
+			ssize_t buffer_len;
+			if (req_len_defined && req_remaining_len <= sizeof(in_buf))
+				buffer_len = req_remaining_len;
+			else
+				buffer_len = sizeof(in_buf);
+			n = xread(0, in_buf, buffer_len);
 			stream.next_in = in_buf;
+			if (req_len_defined && n > 0)
+				req_remaining_len -= n;
 		}
 
 		if (n <= 0)
@@ -430,6 +439,23 @@ static void copy_request(const char *prog_name, int out, ssize_t req_len)
 	free(buf);
 }
 
+static void pipe_fixed_length(const char *prog_name, int out, size_t req_len)
+{
+	unsigned char buf[8192];
+	size_t remaining_len = req_len;
+
+	while (remaining_len > 0) {
+		size_t chunk_length = remaining_len > sizeof(buf) ? sizeof(buf) : remaining_len;
+		ssize_t n = xread(0, buf, chunk_length);
+		if (n < 0)
+			die_errno("Reading request failed");
+		write_to_child(out, buf, n, prog_name);
+		remaining_len -= n;
+	}
+
+	close(out);
+}
+
 static void run_service(const char **argv, int buffer_input)
 {
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
@@ -456,7 +482,7 @@ static void run_service(const char **argv, int buffer_input)
 				 "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
 	cld.argv = argv;
-	if (buffer_input || gzipped_request)
+	if (buffer_input || gzipped_request || req_len >= 0)
 		cld.in = -1;
 	cld.git_cmd = 1;
 	if (start_command(&cld))
@@ -467,6 +493,8 @@ static void run_service(const char **argv, int buffer_input)
 		inflate_request(argv[0], cld.in, buffer_input, req_len);
 	else if (buffer_input)
 		copy_request(argv[0], cld.in, req_len);
+	else if (req_len >= 0)
+		pipe_fixed_length(argv[0], cld.in, req_len);
 	else
 		close(0);
 
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
new file mode 100755
index 0000000000..8040d80e04
--- /dev/null
+++ b/t/t5562-http-backend-content-length.sh
@@ -0,0 +1,169 @@
+#!/bin/sh
+
+test_description='test git-http-backend respects CONTENT_LENGTH'
+. ./test-lib.sh
+
+test_lazy_prereq GZIP 'gzip --version'
+
+verify_http_result() {
+	# sometimes there is fatal error buit the result is still 200
+	if grep 'fatal:' act.err
+	then
+		return 1
+	fi
+
+	if ! grep "Status" act.out >act
+	then
+		printf "Status: 200 OK\r\n" >act
+	fi
+	printf "Status: $1\r\n" >exp &&
+	test_cmp exp act
+}
+
+test_http_env() {
+	handler_type="$1"
+	shift
+	env \
+		CONTENT_TYPE="application/x-git-$handler_type-pack-request" \
+		QUERY_STRING="/repo.git/git-$handler_type-pack" \
+		PATH_TRANSLATED="$PWD/.git/git-$handler_type-pack" \
+		GIT_HTTP_EXPORT_ALL=TRUE \
+		REQUEST_METHOD=POST \
+		"$@"
+}
+
+ssize_b100dots() {
+	# hardcoded ((size_t) SSIZE_MAX) + 1
+	case "$(build_option sizeof-size_t)" in
+	8) echo 9223372036854775808;;
+	4) echo 2147483648;;
+	*) die "Unexpected ssize_t size: $(build_option sizeof-size_t)";;
+	esac
+}
+
+test_expect_success 'setup' '
+	git config http.receivepack true &&
+	test_commit c0 &&
+	test_commit c1 &&
+	hash_head=$(git rev-parse HEAD) &&
+	hash_prev=$(git rev-parse HEAD~1) &&
+	printf "want %s" "$hash_head" | packetize >fetch_body &&
+	printf 0000 >>fetch_body &&
+	printf "have %s" "$hash_prev" | packetize >>fetch_body &&
+	printf done | packetize >>fetch_body &&
+	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
+	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
+	printf "%s %s refs/heads/newbranch\\0report-status\\n" "$_z40" "$hash_next" | packetize >push_body &&
+	printf 0000 >>push_body &&
+	echo "$hash_next" | git pack-objects --stdout >>push_body &&
+	test_copy_bytes 10 <push_body >push_body.trunc &&
+	: >empty_body
+'
+
+test_expect_success GZIP 'setup, compression related' '
+	gzip -k fetch_body &&
+	test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
+	gzip -k push_body &&
+	test_copy_bytes 10 <push_body.gz >push_body.gz.trunc
+'
+
+test_expect_success 'fetch plain' '
+	test_http_env upload \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body git http-backend >act.out 2>act.err &&
+	verify_http_result "200 OK"
+'
+
+test_expect_success 'fetch plain truncated' '
+	test_http_env upload \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.trunc git http-backend >act.out 2>act.err &&
+	! verify_http_result "200 OK"
+'
+
+test_expect_success 'fetch plain empty' '
+	test_http_env upload \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
+	! verify_http_result "200 OK"
+'
+
+test_expect_success GZIP 'fetch gzipped' '
+	test_http_env upload \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.gz git http-backend >act.out 2>act.err &&
+	verify_http_result "200 OK"
+'
+
+test_expect_success GZIP 'fetch gzipped truncated' '
+	test_http_env upload \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.gz.trunc git http-backend >act.out 2>act.err &&
+	! verify_http_result "200 OK"
+'
+
+test_expect_success GZIP 'fetch gzipped empty' '
+	test_http_env upload \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
+	! verify_http_result "200 OK"
+'
+
+test_expect_success GZIP 'push plain' '
+	test_when_finished "git branch -D newbranch" &&
+	test_http_env receive \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body git http-backend >act.out 2>act.err &&
+	verify_http_result "200 OK" &&
+	git rev-parse newbranch >act.head &&
+	echo "$hash_next" >exp.head &&
+	test_cmp act.head exp.head
+'
+
+test_expect_success 'push plain truncated' '
+	test_http_env receive \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.trunc git http-backend >act.out 2>act.err &&
+	! verify_http_result "200 OK"
+'
+
+test_expect_success 'push plain empty' '
+	test_http_env receive \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
+	! verify_http_result "200 OK"
+'
+
+test_expect_success GZIP 'push gzipped' '
+	test_when_finished "git branch -D newbranch" &&
+	test_http_env receive \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.gz git http-backend >act.out 2>act.err &&
+	verify_http_result "200 OK" &&
+	git rev-parse newbranch >act.head &&
+	echo "$hash_next" >exp.head &&
+	test_cmp act.head exp.head
+'
+
+test_expect_success GZIP 'push gzipped truncated' '
+	test_http_env receive \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.gz.trunc git http-backend >act.out 2>act.err &&
+	! verify_http_result "200 OK"
+'
+
+test_expect_success GZIP 'push gzipped empty' '
+	test_http_env receive \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
+	! verify_http_result "200 OK"
+'
+
+test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
+	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
+	env \
+		CONTENT_TYPE=application/x-git-upload-pack-request \
+		QUERY_STRING=/repo.git/git-upload-pack \
+		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
+		GIT_HTTP_EXPORT_ALL=TRUE \
+		REQUEST_METHOD=POST \
+		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
+		git http-backend </dev/zero >/dev/null 2>err &&
+	grep "fatal:.*CONTENT_LENGTH" err
+'
+
+test_done
diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
new file mode 100755
index 0000000000..6c2aae7692
--- /dev/null
+++ b/t/t5562/invoke-with-content-length.pl
@@ -0,0 +1,37 @@
+#!/usr/bin/perl
+use 5.008;
+use strict;
+use warnings;
+
+my $body_filename = $ARGV[0];
+my @command = @ARGV[1 .. $#ARGV];
+
+# read data
+my $body_size = -s $body_filename;
+$ENV{"CONTENT_LENGTH"} = $body_size;
+open(my $body_fh, "<", $body_filename) or die "Cannot open $body_filename: $!";
+my $body_data;
+defined read($body_fh, $body_data, $body_size) or die "Cannot read $body_filename: $!";
+close($body_fh);
+
+my $exited = 0;
+$SIG{"CHLD"} = sub {
+        $exited = 1;
+};
+
+# write data
+my $pid = open(my $out, "|-", @command);
+{
+        # disable buffering at $out
+        my $old_selected = select;
+        select $out;
+        $| = 1;
+        select $old_selected;
+}
+print $out $body_data or die "Cannot write data: $!";
+
+sleep 60; # is interrupted by SIGCHLD
+if (!$exited) {
+        close($out);
+        die "Command did not exit after reading whole body";
+}
-- 
2.17.0.1185.g782057d875

