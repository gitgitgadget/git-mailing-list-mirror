Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81118207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 13:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171934AbdDXN6s (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:58:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:62324 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171928AbdDXN6i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:58:38 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBZ9u-1csEeq3mUw-00AVPO; Mon, 24
 Apr 2017 15:58:35 +0200
Date:   Mon, 24 Apr 2017 15:58:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 8/8] Use uintmax_t for timestamps
In-Reply-To: <cover.1493042239.git.johannes.schindelin@gmx.de>
Message-ID: <50b62ed69c3239c076c28c5048bbd07396a25c5c.1493042239.git.johannes.schindelin@gmx.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de> <cover.1493042239.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/osytREWsk0IjS1u1CxWl25ljmvKnRjdCybvzvtPwrb1o2KMynK
 jVv4A7MblsudAgBJZNhCmuJpEO8hyFKObOOe1S7Y/RRjnqlbR02nQ4Z+Ti8phtfjsIG4/pZ
 9DziuzGFhW8Y00R8vhT66tAQoLwGmIqXob4lcRJfmlGYS5sxGpNbljmolW9HiEY/jmVd4Wi
 JNvMbp7ol3kk8C1ENYDuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+YB1ow2ZVmE=:Sa7rpmUG1yvJhxd+CLCGBm
 y5vASe9QYtlipMsAloDbfA4O8jZ7cTvuE5SfyMxVx9gGeXF/KqP292yRnS5ASYedAftK73T8q
 da1ZpBz23J1fZjbQ2+ibh64LIrfZoh+bCBcaMDkJE0VTz++Hn7MnXAbb3vrjAS0B9y8Zjlxyz
 gDz5x3ofbQsSAmB0vICRtNySMwJSU8gahblQuLh5AU6x5S5j0paGokeuF9779ousjN1aEQoDP
 NyvXG9Qyjib0l87uLcgGKjIpqkkPSlf25x/pFzXXEZFMbn5Fc8ClBEpitgrr4ah0TVi9OsM0s
 SPnRBNfgM16xeX48WFsxrIyGYoWGUXqe2QgbD2N98iSIj297JCAjo9588BbdbH/+eyiJgXXH9
 RKu364IgZOD7f525TmdUZ51ANe4vGHnqkeLSCQp9RWPR6vDKfDKeZXsqRFmCuKnQBQ0mvmZhj
 YR12zkp6EdD3E/E9ggdM5taDY9TJNhsC5ngaDPchK5d1KaqfGjmn31A58PIt0SftVQrm2cLj+
 AxGA7Rb23Uwx9Bmo9sJBG1bXGYkfxqujUhNBx65iIlYrzwDfRCNJYHpEwvop31knc/FjHOfZP
 +fTerp3dt89McKPjVXOXV7/3e4l3QUAb+5J1lvsuY1SMkBj+khNqAiVwBDykufY5DDskwNxmH
 psKdvuzkgDtbpwf7/SlFwfq4ArnXMfFMzENU/UsJLArErj45t/OGSK7X2HQBl9shTDPo/ivZF
 4rNEJJ64wDwMjHOv4cH3XbZHi8NOQl1hXWkPvrpVwinJ6O+D1GWOA1rcVHVRCyWMALrPX6O3O
 nInKtKf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we used `unsigned long` for timestamps. This was only a good
choice on Linux, where we know implicitly that `unsigned long` is what is
used for `time_t`.

However, we want to use a different data type for timestamps for two
reasons:

- there is nothing that says that `unsigned long` should be the same data
  type as `time_t`, and indeed, on 64-bit Windows for example, it is not:
  `unsigned long` is 32-bit but `time_t` is 64-bit.

- even on 32-bit Linux, where `unsigned long` (and thereby `time_t`) is
  32-bit, we *want* to be able to encode timestamps in Git that are
  currently absurdly far in the future, *even if* the system library is
  not able to format those timestamps into date strings.

So let's just switch to the maximal integer type available, which should
be at least 64-bit for all practical purposes these days. It certainly
cannot be worse than `unsigned long`, so...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 594100e7652..b66995685af 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,10 +319,14 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
-typedef unsigned long timestamp_t;
-#define PRItime "lu"
-#define parse_timestamp strtoul
+typedef uintmax_t timestamp_t;
+#define PRItime PRIuMAX
+#define parse_timestamp strtoumax
+#ifdef ULLONG_MAX
+#define TIME_MAX ULLONG_MAX
+#else
 #define TIME_MAX ULONG_MAX
+#endif
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
-- 
2.12.2.windows.2.406.gd14a8f8640f
