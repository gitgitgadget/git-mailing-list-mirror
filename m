Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0781F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdB0W1B (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:27:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:53405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdB0W0n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:26:43 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3zT0-1cRLSo1574-00rcVo; Mon, 27
 Feb 2017 22:30:28 +0100
Date:   Mon, 27 Feb 2017 22:30:26 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] t0006 & t5000: prepare for 64-bit time_t
In-Reply-To: <cover.1488231002.git.johannes.schindelin@gmx.de>
Message-ID: <3871d1d9de0315a1a98bce5d8f544a5e18917f25.1488231002.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PKxU+GsY2yQLidl2XDHpqRrB1LSlQ+ncV0pv5nX/5LeTKlmzMQv
 KPjy7LhLWGSUWfeTeX55KKBfsghJ2NlzS7m+a03F4vpHo403W0YjHb07R77skmbAQto7zk5
 FENkT5QKrQDWYbOBTMVEkP+U1tW7aiy2l0N/ldCWRj6hZdFcyWBVoOjmOv3xpWMXLuNh95a
 UxcMzqw8uXgQLCXQbbSqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:doJhb0huH+A=:OUia/KTXotpuyxyay0wVjd
 T07MEbrszINw6/fvh13J25mEvZpJosG2ofBbIueImv3Eq85ZkrRBkTeg0509mYnohZa/x+HdD
 bpan92kRui3It6TFnljZIVDQBEBrtluFWVaxWMa9u2/WWctgdeTGjCzqP24lf8BiLbIg6vRmC
 WT0QakjpIjm+Ffll0mvZFgY9i1w7vFVeX23PZb3XnDgs5cbGDPikW8PeMkXBC7objjz11Y7bQ
 iAhzDXofEe15c+w+P9WZ/0heMtTekmSxZcBKs1VhYdQzJhTjhl+T7yckM8UuJ90Pc//Dokwun
 i9hl9R3VjU/OidJj0WuWEfaDXw8ZkOyquRC7CerNzk5tTwnMvGuMc6Ven43elWtI2wVZoQAik
 lQOCd2f4diBu2/iLqWtA4aYhG6EGr5ztqNc9FhLjKuQpMEHAcx7g/uVC+oJsBIDD5oplbTNhG
 80fH//P/0FNQR+Kwhhz+Cw3zkrCvj3XIwdZhjbQQE6irSqjAVZ7jhXoiqSmAQVjgqSYKzK8mR
 JgFYihNV/DXA5xeSHy9nwK7gYVkWcVJV6nS/49qjxb6pBrlqmtsFSLWPCMyKXig5XzhSfj9LP
 NlmDZsdM8bD7wE6623QxUciAnc0vZBmndEO3XDQMRF8x883LOrrDjtM5M76pidEYgXgJGn4ni
 EEzUwXPvmF7+fe1U1mAKimn03a2fEBngRv/X2Q6jk2BA2EaaATq3mdZNE1kz8ZYJQVJSZ09i2
 5gGTQjex7vGOqa+EvetZvrJPnUtMDb0a3TeAiJ81LJVeeMjAl0k6a7eZS0jsw8IHJGlqLZ7GG
 ihlAILj6pw4+pDSSym+WSmo1/HcJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's source code refers to timestamps as unsigned longs. On 32-bit
platforms, as well as on Windows, unsigned long is not large enough to
capture dates that are "absurdly far in the future".

It is perfectly valid by the C standard, of course, for the `long` data
type to refer to 32-bit integers. That is why the `time_t` data type
exists: so that it can be 64-bit even if `long` is 32-bit. Git's source
code simply does not use `time_t`, is all.

The earlier quick fix 6b9c38e14cd (t0006: skip "far in the future" test
when unsigned long is not long enough, 2016-07-11) forced the test cases
to be skipped that require a 64-bit (or larger) data type to be used to
represent the time.

This quick fix, however, tests for *long* to be 64-bit or not. What we
need, though, is a test that says whether *whatever data type we use for
timestamps* is 64-bit or not.

The same quick fix was used to handle the similar problem where Git's
source code uses `unsigned long` to represent size, instead of `size_t`.

So let's just add another prerequisite to test specifically whether
timestamps are represented by a 64-bit data type or not. Later, when we
will have switched to using `time_t` where appropriate, we can flip that
prerequisite to test `time_t` instead of `long`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-date.c | 5 ++++-
 t/t0006-date.sh      | 4 ++--
 t/t5000-tar-tree.sh  | 6 +++---
 t/test-lib.sh        | 2 ++
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 506054bcd5d..4727bea255c 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -4,7 +4,8 @@ static const char *usage_msg = "\n"
 "  test-date relative [time_t]...\n"
 "  test-date show:<format> [time_t]...\n"
 "  test-date parse [date]...\n"
-"  test-date approxidate [date]...\n";
+"  test-date approxidate [date]...\n"
+"  test-date is64bit\n";
 
 static void show_relative_dates(const char **argv, struct timeval *now)
 {
@@ -93,6 +94,8 @@ int cmd_main(int argc, const char **argv)
 		parse_dates(argv+1, &now);
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
+	else if (!strcmp(*argv, "is64bit"))
+		return sizeof(unsigned long) == 8 ? 0 : 1;
 	else
 		usage(usage_msg);
 	return 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index c0c910867d7..9539b425ffb 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -53,8 +53,8 @@ check_show unix-local "$TIME" '1466000000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" LONG_IS_64BIT
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" LONG_IS_64BIT
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT
 
 check_parse() {
 	echo "$1 -> $2" >expect
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 886b6953e40..997aa9dea28 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -390,7 +390,7 @@ test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our huge size' '
 	test_cmp expect actual
 '
 
-test_expect_success LONG_IS_64BIT 'set up repository with far-future commit' '
+test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
 	rm -f .git/index &&
 	echo content >file &&
 	git add file &&
@@ -398,11 +398,11 @@ test_expect_success LONG_IS_64BIT 'set up repository with far-future commit' '
 		git commit -m "tempori parendum"
 '
 
-test_expect_success LONG_IS_64BIT 'generate tar with future mtime' '
+test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
 	git archive HEAD >future.tar
 '
 
-test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our future mtime' '
+test_expect_success TAR_HUGE,TIME_IS_64BIT 'system tar can read our future mtime' '
 	echo 4147 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 86d77c16dd3..6151a3d70f8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1163,3 +1163,5 @@ build_option () {
 test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
+
+test_lazy_prereq TIME_IS_64BIT 'test-date is64bit'
-- 
2.11.1.windows.1.379.g44ae0bc


