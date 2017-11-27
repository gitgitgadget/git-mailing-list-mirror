Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A834C20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdK0ECN (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:02:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64752 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751168AbdK0ECN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:02:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 344BCB1488;
        Sun, 26 Nov 2017 23:02:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0VEsFoD0dAO+pYlbJp4hc1mTIqc=; b=G4GDbS
        GpvbxhkY02SWzrCzrRmqSFpreKVFJUT4pm5HLKwxqWmXSkImHQSlxdNI1XRQNisf
        ZCeMrjpt4Y+xtvSvSXp6LtSuD1Mj5nktE5zt6YoukRM71b4ug3POKGjCMCr8rEHR
        L4nsv+nW52c6Qvj/XyvZz7T++NgeiIc5GBaiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X6gXnbrXY+jCOOqqzTHTCsLV9qWkrBWR
        OjbuUqlcsTAI65RSJAckSAiLTOndWzEXgYRRk+8YrLWO4Y5i/IQl7tAiz0aUewp7
        y3g4M+QTbr/zt79ipvHJ+kO8lmvWhw5PAQ6DE8/e+Od5AEL4zRmzMYiGjNx/E++2
        Fj0sxg+C7Do=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2950CB1487;
        Sun, 26 Nov 2017 23:02:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E49FB1486;
        Sun, 26 Nov 2017 23:02:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20171126193813.12531-1-max@max630.net>
Date:   Mon, 27 Nov 2017 13:02:10 +0900
In-Reply-To: <20171126193813.12531-1-max@max630.net> (Max Kirillov's message
        of "Sun, 26 Nov 2017 21:38:11 +0200")
Message-ID: <xmqqzi78e5dp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BED0A8B6-D327-11E7-A388-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To recap (other than the typofix in the proposed log message), here
is what I would have as SQUASH??? on top of (or interspersed with)
v6.

Thanks.

diff --git a/http-backend.c b/http-backend.c
index 69570d16e7..2268d65731 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -324,10 +324,9 @@ static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **o
 	ssize_t cnt = 0;
 
 	if (max_request_buffer < req_len) {
-		die("request was larger than our maximum size (%lu): %lu;"
-			    " try setting GIT_HTTP_MAX_REQUEST_BUFFER",
-			    max_request_buffer,
-			    req_len);
+		die("request was larger than our maximum size (%lu): "
+		    "%" PRIuMAX "; try setting GIT_HTTP_MAX_REQUEST_BUFFER",
+		    max_request_buffer, (uintmax_t)req_len);
 	}
 
 	if (req_len <= 0) {

diff --git a/Makefile b/Makefile
index e61f8319b3..3380f68040 100644
--- a/Makefile
+++ b/Makefile
@@ -661,7 +661,7 @@ TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
-TEST_PROGRAMS_NEED_X += test-print-values
+TEST_PROGRAMS_NEED_X += test-print-larger-than-ssize
 TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
 TEST_PROGRAMS_NEED_X += test-write-cache

diff --git a/t/helper/test-print-values.c b/t/helper/test-print-larger-than-ssize.c
similarity index 31%
rename from t/helper/test-print-values.c
rename to t/helper/test-print-larger-than-ssize.c
index 8f7e5af319..b9852c493d 100644
--- a/t/helper/test-print-values.c
+++ b/t/helper/test-print-larger-than-ssize.c
@@ -1,10 +1,10 @@
-#include <stdio.h>
-#include <string.h>
+#include "cache.h"
 
 int cmd_main(int argc, const char **argv)
 {
-	if (argc == 2 && strcmp(argv[1], "(size_t)(-20)") == 0)
-		printf("%zu", (ssize_t)(-20));
+	size_t large = ~0;
 
+	large = ~(large & ~(large >> 1)) + 1;
+	printf("%" PRIuMAX "\n", (uintmax_t) large);
 	return 0;
 }

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index f452090216..112b5d6eb2 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -72,7 +72,7 @@ test_expect_success 'http-backend blocks bad PATH_INFO' '
 '
 
 # overrides existing definition for further cases
-run_backend() {
+run_backend () {
 	CONTENT_LENGTH="${#2}" && export CONTENT_LENGTH &&
 	( echo "$2" && cat /dev/zero ) |
 	QUERY_STRING="${1#*[?]}" \
@@ -89,7 +89,7 @@ test_expect_success 'CONTENT_LENGTH set and infinite input' '
 '
 
 test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
-	NOT_FIT_IN_SSIZE=`"$GIT_BUILD_DIR/t/helper/test-print-values" "(size_t)(-20)"` &&
+	NOT_FIT_IN_SSIZE=$("$GIT_BUILD_DIR/t/helper/test-print-larger-than-ssize") &&
 	env \
 		CONTENT_TYPE=application/x-git-upload-pack-request \
 		QUERY_STRING=/repo.git/git-upload-pack \
