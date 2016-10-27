Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FF4820193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034220AbcJ0WO3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:14:29 -0400
Received: from mout.web.de ([212.227.15.14]:57953 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936313AbcJ0WO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:14:26 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MPJya-1bvT5e3Qqe-004VLf; Fri, 28 Oct 2016 00:14:02
 +0200
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] valgrind: support test helpers
Message-ID: <71c3d13a-fa29-75d3-50ac-81978c08f552@web.de>
Date:   Fri, 28 Oct 2016 00:14:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:1Jz5+mq9Uk8RgUyhqKTW2COwVy8c7UFHhR9jTgnYmBEiaBe7GKg
 9TZqf+1JoAxVn4/CLZBNM8a00QxSprR9u1BNC9weaBLC+j0x9PNLOh3Epi3J/4gkHLljbLg
 3vhfX8lrjGjNdjOezvJOU/fGOujLsRnp6sGqkcVNAXNhRLRzcTl7Sb2SB+SfyLR4U0snEs/
 K3HrEHV/wNn87kzgHWnXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:edBkL+aqrMQ=:7zP7cj8xQieBPCv8EuYeBK
 pPNgtpuutuP1Z0QbXDGe51BDhSy+yl6gGzkJ0HTKM9iiqkGNJi4hpoKPv7lBohIMxImBI5SQl
 Y/0LI/RGJHxO6v0L64yxi+jCVBiQZX4qWBR28ZEUc7V6DoAElc7ZTyOdhravyFT7T2i8k/ttW
 0xStxc1Kty2x6Mxpkg2MqUT23zUhqKoZ2fugq2PS6DZvPGlEY3iRSv8RnhUno64+xzQg8Yq1j
 A5Dj5erNiX8GjEQk4W+pGb0ZA+3uy7hZDR+FtOculZZRyi0Yj+4/mJF4FjkSdNNZaSfxNZxKs
 WXBGRher2H0AtqfbtNgzlUOM5gLpSwCPNir0yG8qJVa5T9QQiTd3tfpY20X8JmncduWFO05cB
 ptUkRENsNPOB0WkFzdf/y0yy9AyC4FXxQWwL8g96KsrfnwcSdZyQ5KmKrYuUgGSFROidJXkkT
 CgwLqtP6uHb5sEQ7y7gcU3GNA+T/6UofFpdRaq5BDX98zft8O6S4bAimBKJEUPXwxY8Pwmo8Q
 6BC4QIaHwGoe7Xd8zmoqrFnBSh4IM/u9w+qjOLi3LpklVn0DB2sC0Au/zfDmQCIX2vaR/CC8W
 4Oc9w9VoTdQ/rQ+RoWPZ7AxOtYKA1vt9n89umnKvvg38e+0uEbrextZQI6gLV6C/PyzybxDAd
 TQvUgCjQae98LiqxNzU23GD9dDDwBaiNytJYouk74aq2et55qP4OddS16KgAlxZZeKGM9edOa
 BMLRyYrZDUUy7n3N+7BFPfLj174b6aLmv5x5a77u8jj0OFNdDDSr5MZ9258s9VBw6xVTuhAFF
 RvsvFHT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests run with --valgrind call git commands through a wrapper script
that invokes valgrind on them.  This script (valgrind.sh) is in turn
invoked through symlinks created for each command in t/valgrind/bin/.

Since e6e7530d (test helpers: move test-* to t/helper/ subdirectory)
these symlinks have been broken for test helpers -- they point to the
old locations in the root of the build directory.  Fix that by teaching
the code for creating the links about the new location of the binaries,
and do the same in the wrapper script to allow it to find its payload.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/test-lib.sh          |  9 ++++++++-
 t/valgrind/valgrind.sh | 12 ++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b859db6..a724181 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -809,7 +809,14 @@ then
 		return;
 
 		base=$(basename "$1")
-		symlink_target=$GIT_BUILD_DIR/$base
+		case "$base" in
+		test-*)
+			symlink_target="$GIT_BUILD_DIR/t/helper/$base"
+			;;
+		*)
+			symlink_target="$GIT_BUILD_DIR/$base"
+			;;
+		esac
 		# do not override scripts
 		if test -x "$symlink_target" &&
 		    test ! -d "$symlink_target" &&
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index 4215303..669ebaf 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -1,11 +1,19 @@
 #!/bin/sh
 
 base=$(basename "$0")
+case "$base" in
+test-*)
+	program="$GIT_VALGRIND/../../t/helper/$base"
+	;;
+*)
+	program="$GIT_VALGRIND/../../$base"
+	;;
+esac
 
 TOOL_OPTIONS='--leak-check=no'
 
 test -z "$GIT_VALGRIND_ENABLED" &&
-exec "$GIT_VALGRIND"/../../"$base" "$@"
+exec "$program" "$@"
 
 case "$GIT_VALGRIND_MODE" in
 memcheck-fast)
@@ -29,4 +37,4 @@ exec valgrind -q --error-exitcode=126 \
 	--log-fd=4 \
 	--input-fd=4 \
 	$GIT_VALGRIND_OPTIONS \
-	"$GIT_VALGRIND"/../../"$base" "$@"
+	"$program" "$@"
-- 
2.10.1
