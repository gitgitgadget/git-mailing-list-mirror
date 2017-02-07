Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89D21FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 22:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbdBGWEb (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 17:04:31 -0500
Received: from mout.web.de ([212.227.15.3]:64216 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932101AbdBGWEa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 17:04:30 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhQWG-1c6c940n7w-00mb1P; Tue, 07
 Feb 2017 23:04:26 +0100
To:     Brandon Williams <bmwill@google.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] dir: avoid allocation in fill_directory()
Message-ID: <73ec9cc7-8a86-8ba9-90fd-a954fa031820@web.de>
Date:   Tue, 7 Feb 2017 23:04:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Y8oJxQQUXczSF8JfYzYUc3CVmnaBI56cwo5Ig/eldlXeQ+y6f0V
 Yk/NhKDApdkQLiuFqa+joQll5/8Pxlq5gr7borzDEtr/PqYNhZoOMfFQHQG2XrQ4snUlted
 c8gfhreNmPSsGuHQp1mgk7Gg9PBObXLhymGmJcVIEcZ8CfPV/qCm/t5sZB+sVPQ+pJukFqP
 gfUBArkohYnENfgSjrUSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AWRSUdVWA10=:ZUv4UdIY8CXj2V/Us2YGpS
 YBCTNXBe5oGjk3Yskr58AjjmbXavOl0ClA+o/iIqEZqLq3MvuT1THzk0rGLgDJNp2bgEogpYc
 Xo29WIYswn/1klg3WhBfBBAkG7hfIgVpoqevR/QDmvJkxsipmR0qrlLsXBsjWsHw6Lt82annt
 nTSIH0e5hyrj/ieiCKpZln7xa28aHOCwuuK+oC2YMXAmwILsQ6dhdgQCv2W7wCLfjR7am8Trn
 HxXwIYVgblMr/qaA9WLLFXURSK0zI9ASI8FXceMGC1uXfXoD+NlfWMGVtq7mDKaBL6nS5PpJn
 fg+utf4daGTjcbWD3+2bRy/jDMTKveDYAUTKz36tLSFi2XHYv0yCxGixiMRnmk/g0pVX2Onua
 A4E8vNWvD13s2j9paVteF5OfjVdKpsqLlUcLqysrT3DsXi2y4mv5iJed/+bkL4/NSvPVqoQKe
 vhVYGRTv/4DKTLAYfeeBUw8TZ+TM7JOcvI5WOswH6OXKzZyimYk8n2Kobu1Xa/uI3c+xWXucI
 eDCc2TKyXoAnPlWR4PHe62e/D4fe+3p+O1DxTtJDmQg4LyThpguysV/l1vqi8FFX3OtEM9rdI
 EHbUypkiIYq1yGzDnBu29iOlcqG6VlSB1QYuHNJHlsPXlSBrMoB5ZG9LkcOTRbhp/WvU2Z6pc
 qXftaTronL6kvzHhMls5U5dYueJXD8xVapxK1cwA8mP0lf7pFwbAU9Nttlgx/AbiyN3aCEH8d
 rirNdibsNyL+U0To2uhOoydjLFfAzuiu9CpKuVigTwdxTFU77Dkm3CtU3uf0nQs0xsnCwmXjB
 BPQcT8n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the match member of the first pathspec item directly to
read_directory() instead of using common_prefix() to duplicate it first,
thus avoiding memory duplication, strlen(3) and free(3).

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This updates 966de3028 (dir: convert fill_directory to use the pathspec
struct interface).  The result is closer to the original, yet still
using the modern interface.

This patch eerily resembles 2b189435 (dir: simplify fill_directory()).

 dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 65c3e681b8..4541f9e146 100644
--- a/dir.c
+++ b/dir.c
@@ -174,20 +174,19 @@ char *common_prefix(const struct pathspec *pathspec)
 
 int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 {
-	char *prefix;
+	const char *prefix;
 	size_t prefix_len;
 
 	/*
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	prefix = common_prefix(pathspec);
-	prefix_len = prefix ? strlen(prefix) : 0;
+	prefix_len = common_prefix_len(pathspec);
+	prefix = prefix_len ? pathspec->items[0].match : "";
 
 	/* Read the directory and prune it */
 	read_directory(dir, prefix, prefix_len, pathspec);
 
-	free(prefix);
 	return prefix_len;
 }
 
-- 
2.11.1

