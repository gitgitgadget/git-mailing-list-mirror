Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F391F404
	for <e@80x24.org>; Sat, 10 Feb 2018 12:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbeBJMii (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 07:38:38 -0500
Received: from mout.web.de ([212.227.15.14]:43185 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBJMih (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 07:38:37 -0500
Received: from [192.168.178.36] ([79.237.247.111]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6Df8-1eukug3V62-00yCHu; Sat, 10
 Feb 2018 13:38:32 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Adam Spiers <git@adamspiers.org>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] check-ignore: fix mix of directories and other file types
Message-ID: <a6cf7660-8c80-c588-0cb7-88d507e56b06@web.de>
Date:   Sat, 10 Feb 2018 13:38:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jRXUXGgkjxwhhs/zPoUmZ8qa7qiPv5Fass3hvcTzK4is5/QYkDP
 tU5Dtr42aRxFi60i3k6DFRWEAHfjIW4uM5oKFpTlwi4VsB5T/0xlIsLUr1Xkh3maN3mud2o
 D0l2N1VFs2GYYA6FHpnB/i0clCMmvavVWAdy1dJKy7ziAfjibHe8E2PHJagG0ZxQSiMUsYF
 167095UWYn4HI3nqT9TbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMKWXU9SHr8=:5spEjPTuYMHYbpEZgV/HEI
 aYT6U37BF6hbm0KW1SoQhMtzJRvlhOAaa3PVpXYmo2+qJNTiQF70IHqQrCzdb89ibkaPf/COu
 UZen7q8UOUzGBBFuQKmxm5aP/X6i9n5xqIj1DSJgGQQCbV1SsrADDgKkK5GFpaz6IVhicFp03
 kQzCS5n7E3q1EjOJt64I2bByIlgAEAGbr247g0ioBbSVTlWFaIxh3qyz36v3Tb8f7j82RZbwC
 k2XPkBVAuRVWDLt7UORDx9n/kT2zNGsBGCUtaP4wZL8FKVHbERD0h72p6mEviYUUlklIb2tff
 c4msd2hkv8ksfaFJiF/fpeIrxitDY9wbtjBbgihZMwbfuyTyNs4J9w2cObtBGLKoOneJQm4KL
 CqLGCJKJ6Bbzup8pfptz9mfugB4U+CXkfLHHnbJs/Nv8BegqmeKSq/r9d5EJLicZ/GKaLHHkj
 vwkhJUmELwvPHB3rUQfCYk4A3YSNi3Vtb16uYEuw+Sp2DJ4s9wEemUTnTEmh1eTghSpH3IenJ
 YAfVTqP5J5rMrWtb4KpXch2aGXXQyUbrd7LQXFoO/Uae5SMZN/bqyPwbY7FrCZMxcZoP//v0U
 aJK+aA9cgr45jkwxD8zJJeJP6NjlXvll7CepT6z5cysmo8mYkevOFQI81uflhFr9UtXtPJ5eq
 t7x/V5iY296g3uodcytxHwb2nR6TuzXT+3lvpHmGsfSPVo7Z3oc5ghIuRJV/IqFMqbPxgt/d7
 S7rTMDmeJ3WXxh2xs1d+ZmtIPlPbWZD+kAn0srH7/TYhxIoufGmpFP9iUhcpUSKHeHKrL4Uo9
 1JflZR6two0f2rCX57sk3+58n0lq1hUhkbbk4ZFyX6sDhbNfFY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In check_ignore(), the first pathspec item determines the dtype for any
subsequent ones.  That means that a pathspec matching a regular file can
prevent following pathspecs from matching directories, which makes no
sense.  Fix that by determining the dtype for each pathspec separately,
by passing the value DT_UNKNOWN to last_exclude_matching() each time.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/check-ignore.c |  3 ++-
 t/t0008-ignores.sh     | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 3e280b9c7a..ec9a959e08 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -72,7 +72,7 @@ static int check_ignore(struct dir_struct *dir,
 {
 	const char *full_path;
 	char *seen;
-	int num_ignored = 0, dtype = DT_UNKNOWN, i;
+	int num_ignored = 0, i;
 	struct exclude *exclude;
 	struct pathspec pathspec;
 
@@ -104,6 +104,7 @@ static int check_ignore(struct dir_struct *dir,
 		full_path = pathspec.items[i].match;
 		exclude = NULL;
 		if (!seen[i]) {
+			int dtype = DT_UNKNOWN;
 			exclude = last_exclude_matching(dir, &the_index,
 							full_path, &dtype);
 		}
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index d27f438bf4..54a4703ef1 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -775,6 +775,26 @@ test_expect_success PIPE 'streaming support for --stdin' '
 	echo "$response" | grep "^::	two"
 '
 
+test_expect_success 'existing file and directory' '
+	test_when_finished "rm one" &&
+	test_when_finished "rmdir top-level-dir" &&
+	>one &&
+	mkdir top-level-dir &&
+	git check-ignore one top-level-dir >actual &&
+	grep one actual &&
+	grep top-level-dir actual
+'
+
+test_expect_success 'existing directory and file' '
+	test_when_finished "rm one" &&
+	test_when_finished "rmdir top-level-dir" &&
+	>one &&
+	mkdir top-level-dir &&
+	git check-ignore top-level-dir one >actual &&
+	grep one actual &&
+	grep top-level-dir actual
+'
+
 ############################################################################
 #
 # test whitespace handling
-- 
2.16.1
