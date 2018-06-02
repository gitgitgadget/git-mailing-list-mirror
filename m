Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1238F1F403
	for <e@80x24.org>; Sat,  2 Jun 2018 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeFBVgH (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 17:36:07 -0400
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net ([173.201.193.239]:59811
        "EHLO p3plsmtpa09-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750886AbeFBVgG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Jun 2018 17:36:06 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jun 2018 17:36:01 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PE4if9a6maUaoPE4sfBxW8; Sat, 02 Jun 2018 14:28:48 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for receive-pack
Date:   Sun,  3 Jun 2018 00:27:49 +0300
Message-Id: <20180602212749.21324-3-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-Reply-To: <20180602212749.21324-1-max@max630.net>
References: <20180602212749.21324-1-max@max630.net>
X-CMAE-Envelope: MS4wfKhSIrm6vpdW2HbxtdJSHHA/pH6Ag0EQkjcr07MEgkZAfEDP8u+eSb+yoyXB+jPHiP6DBw4UWmyoaRKPvRC60cEQY1WyBKJy2jrtDbk8XQaxVR0bNOJ+
 NJwvOEb7g2Fu+cRcFSFJH6xtKjrjrGuTwEBtjTJYT/fcELFqGqd8DXsV59eF5lXafGU+RGHAD4iXZ/zzeOhXA6MRITM5zzukwHE/7dPhwqy6PPXAZEQU+Sc0
 z4+GH35BhzwV9TPNd1t2ZTKKVAwEcGMcJe01sMJMqZp3T6BB9YBcicy3I2HzK1Oh4QeJYb/c5vFFmEITFqvciMn2UolKpNsmIZyygfj7LZzeECsbQMmxHMWI
 PrmBu3G+u8F5S/BEbmtR5WEwt4s9gAynoJ1lNrwP+DXGIb7x8VU=
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
 Makefile                                |   1 +
 http-backend.c                          |  49 ++++++--
 t/helper/test-print-larger-than-ssize.c |  11 ++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t5560-http-backend-noserver.sh        |  13 ++
 t/t5562-http-backend-content-length.sh  | 155 ++++++++++++++++++++++++
 t/t5562/invoke-with-content-length.pl   |  30 +++++
 8 files changed, 250 insertions(+), 11 deletions(-)
 create mode 100644 t/helper/test-print-larger-than-ssize.c
 create mode 100755 t/t5562-http-backend-content-length.sh
 create mode 100755 t/t5562/invoke-with-content-length.pl

diff --git a/Makefile b/Makefile
index f181687250..93dc4bc23b 100644
--- a/Makefile
+++ b/Makefile
@@ -678,6 +678,7 @@ TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-print-larger-than-ssize.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-ref-store.o
diff --git a/http-backend.c b/http-backend.c
index 3066697a24..78a588c551 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -351,23 +351,22 @@ static ssize_t get_content_length(void)
 	return val;
 }
 
-static ssize_t read_request(int fd, unsigned char **out)
+static ssize_t read_request(int fd, unsigned char **out, ssize_t req_len)
 {
-	ssize_t req_len = get_content_length();
-
 	if (req_len < 0)
 		return read_request_eof(fd, out);
 	else
 		return read_request_fixed_len(fd, req_len, out);
 }
 
-static void inflate_request(const char *prog_name, int out, int buffer_input)
+static void inflate_request(const char *prog_name, int out, int buffer_input, ssize_t req_len)
 {
 	git_zstream stream;
 	unsigned char *full_request = NULL;
 	unsigned char in_buf[8192];
 	unsigned char out_buf[8192];
 	unsigned long cnt = 0;
+	ssize_t req_remaining_len = req_len;
 
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init_gzip_only(&stream);
@@ -379,11 +378,18 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
 			if (full_request)
 				n = 0; /* nothing left to read */
 			else
-				n = read_request(0, &full_request);
+				n = read_request(0, &full_request, req_len);
 			stream.next_in = full_request;
 		} else {
-			n = xread(0, in_buf, sizeof(in_buf));
+			ssize_t buffer_len;
+			if (req_remaining_len < 0 || req_remaining_len > sizeof(in_buf))
+			    buffer_len = sizeof(in_buf);
+			else
+			    buffer_len = req_remaining_len;
+			n = xread(0, in_buf, buffer_len);
 			stream.next_in = in_buf;
+			if (req_remaining_len >= 0)
+				req_remaining_len -= n;
 		}
 
 		if (n <= 0)
@@ -416,10 +422,10 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
 	free(full_request);
 }
 
-static void copy_request(const char *prog_name, int out)
+static void copy_request(const char *prog_name, int out, ssize_t req_len)
 {
 	unsigned char *buf;
-	ssize_t n = read_request(0, &buf);
+	ssize_t n = read_request(0, &buf, req_len);
 	if (n < 0)
 		die_errno("error reading request body");
 	if (write_in_full(out, buf, n) < 0)
@@ -428,6 +434,24 @@ static void copy_request(const char *prog_name, int out)
 	free(buf);
 }
 
+static void pipe_fixed_length(const char *prog_name, int out, size_t req_len)
+{
+	unsigned char buf[8192];
+	size_t remaining_len = req_len;
+
+	while (remaining_len > 0) {
+		size_t chunk_length = remaining_len > sizeof(buf) ? sizeof(buf) : remaining_len;
+		size_t n = xread(0, buf, chunk_length);
+		if (n < 0)
+			die_errno("Reading request failed");
+		if (write_in_full(out, buf, n) < 0)
+			die_errno("%s aborted reading request", prog_name);
+		remaining_len -= n;
+	}
+
+	close(out);
+}
+
 static void run_service(const char **argv, int buffer_input)
 {
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
@@ -435,6 +459,7 @@ static void run_service(const char **argv, int buffer_input)
 	const char *host = getenv("REMOTE_ADDR");
 	int gzipped_request = 0;
 	struct child_process cld = CHILD_PROCESS_INIT;
+	ssize_t req_len = get_content_length();
 
 	if (encoding && !strcmp(encoding, "gzip"))
 		gzipped_request = 1;
@@ -453,7 +478,7 @@ static void run_service(const char **argv, int buffer_input)
 				 "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
 	cld.argv = argv;
-	if (buffer_input || gzipped_request)
+	if (buffer_input || gzipped_request || req_len >= 0)
 		cld.in = -1;
 	cld.git_cmd = 1;
 	if (start_command(&cld))
@@ -461,9 +486,11 @@ static void run_service(const char **argv, int buffer_input)
 
 	close(1);
 	if (gzipped_request)
-		inflate_request(argv[0], cld.in, buffer_input);
+		inflate_request(argv[0], cld.in, buffer_input, req_len);
 	else if (buffer_input)
-		copy_request(argv[0], cld.in);
+		copy_request(argv[0], cld.in, req_len);
+	else if (req_len >= 0)
+		pipe_fixed_length(argv[0], cld.in, req_len);
 	else
 		close(0);
 
diff --git a/t/helper/test-print-larger-than-ssize.c b/t/helper/test-print-larger-than-ssize.c
new file mode 100644
index 0000000000..83472a32f1
--- /dev/null
+++ b/t/helper/test-print-larger-than-ssize.c
@@ -0,0 +1,11 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__print_larger_than_ssize(int argc, const char **argv)
+{
+	size_t large = ~0;
+
+	large = ~(large & ~(large >> 1)) + 1;
+	printf("%" PRIuMAX "\n", (uintmax_t) large);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 87066ced62..edcfe5df63 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -25,6 +25,7 @@ static struct test_cmd cmds[] = {
 	{ "mktemp", cmd__mktemp },
 	{ "online-cpus", cmd__online_cpus },
 	{ "path-utils", cmd__path_utils },
+        { "print-larger-than-ssize", cmd__print_larger_than_ssize },
 	{ "prio-queue", cmd__prio_queue },
 	{ "read-cache", cmd__read_cache },
 	{ "ref-store", cmd__ref_store },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7116ddfb94..c2aa0803d2 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -19,6 +19,7 @@ int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
+int cmd__print_larger_than_ssize(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 9fafcf1945..8c212393b4 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -71,4 +71,17 @@ test_expect_success 'http-backend blocks bad PATH_INFO' '
 	expect_aliased 1 //domain/data.txt
 '
 
+test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
+	NOT_FIT_IN_SSIZE=$("$GIT_BUILD_DIR/t/helper/test-tool" print-larger-than-ssize) &&
+	env \
+		CONTENT_TYPE=application/x-git-upload-pack-request \
+		QUERY_STRING=/repo.git/git-upload-pack \
+		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
+		GIT_HTTP_EXPORT_ALL=TRUE \
+		REQUEST_METHOD=POST \
+		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
+		git http-backend </dev/zero >/dev/null 2>err &&
+	grep -q "fatal:.*CONTENT_LENGTH" err
+'
+
 test_done
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
new file mode 100755
index 0000000000..6b0c005db0
--- /dev/null
+++ b/t/t5562-http-backend-content-length.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+
+test_description='test git-http-backend respects CONTENT_LENGTH'
+. ./test-lib.sh
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
+test_expect_success 'setup repository' '
+	test_commit c0 &&
+	test_commit c1
+'
+
+hash_head=$(git rev-parse HEAD)
+hash_prev=$(git rev-parse HEAD~1)
+
+cat >fetch_body <<EOF
+0032want $hash_head
+00000032have $hash_prev
+0009done
+EOF
+
+gzip -k fetch_body
+
+head -c -10 <fetch_body.gz >fetch_body.gz.trunc
+
+head -c -10 <fetch_body >fetch_body.trunc
+
+hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree})
+printf '00790000000000000000000000000000000000000000 %s refs/heads/newbranch\0report-status\n0000' "$hash_next" >push_body
+echo "$hash_next" | git pack-objects --stdout >>push_body
+
+gzip -k push_body
+
+head -c -10 <push_body.gz >push_body.gz.trunc
+
+head -c -10 <push_body >push_body.trunc
+
+touch empty_body
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
+	test_must_fail verify_http_result "200 OK"
+'
+
+test_expect_success 'fetch plain empty' '
+	test_http_env upload \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
+	test_must_fail verify_http_result "200 OK"
+'
+
+test_expect_success 'fetch gzipped' '
+	test_http_env upload \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.gz git http-backend >act.out 2>act.err &&
+	verify_http_result "200 OK"
+'
+
+test_expect_success 'fetch gzipped truncated' '
+	test_http_env upload \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.gz.trunc git http-backend >act.out 2>act.err &&
+	test_must_fail verify_http_result "200 OK"
+'
+
+test_expect_success 'fetch gzipped empty' '
+	test_http_env upload \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
+	test_must_fail verify_http_result "200 OK"
+'
+
+test_expect_success 'push plain' '
+	git config http.receivepack true &&
+	test_http_env receive \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body git http-backend >act.out 2>act.err &&
+	verify_http_result "200 OK" &&
+	git rev-parse newbranch >act.head &&
+	echo "$hash_next" >exp.head &&
+	test_cmp act.head exp.head &&
+	git branch -D newbranch
+'
+
+
+test_expect_success 'push plain truncated' '
+	git config http.receivepack true &&
+	test_http_env receive \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.trunc git http-backend >act.out 2>act.err &&
+	test_must_fail verify_http_result "200 OK"
+'
+
+test_expect_success 'push plain empty' '
+	git config http.receivepack true &&
+	test_http_env receive \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
+	test_must_fail verify_http_result "200 OK"
+'
+
+test_expect_success 'push gzipped' '
+	test_http_env receive \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.gz git http-backend >act.out 2>act.err &&
+	verify_http_result "200 OK" &&
+	git rev-parse newbranch >act.head &&
+	echo "$hash_next" >exp.head &&
+	test_cmp act.head exp.head &&
+	git branch -D newbranch
+'
+
+test_expect_success 'push gzipped truncated' '
+	test_http_env receive \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body.gz.trunc git http-backend >act.out 2>act.err &&
+	test_must_fail verify_http_result "200 OK"
+'
+
+test_expect_success 'push gzipped empty' '
+	test_http_env receive \
+		HTTP_CONTENT_ENCODING="gzip" \
+		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl empty_body git http-backend >act.out 2>act.err &&
+	test_must_fail verify_http_result "200 OK"
+'
+
+test_done
diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
new file mode 100755
index 0000000000..7f84242e77
--- /dev/null
+++ b/t/t5562/invoke-with-content-length.pl
@@ -0,0 +1,30 @@
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
+defined syswrite($out, $body_data) or die "Cannot write data: $!";
+
+sleep 1; # is interrupted by SIGCHLD
+if (!$exited) {
+        close($out);
+        die "Command did not exit after reading whole body";
+}
-- 
2.17.0.1185.g782057d875

