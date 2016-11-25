Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0A51FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 16:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932763AbcKYQgg (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 11:36:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:56276 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932680AbcKYQgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 11:36:33 -0500
Received: from virtualbox ([95.208.59.208]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPlMc-1c6U0M2ONm-004xMT; Fri, 25
 Nov 2016 17:36:28 +0100
Date:   Fri, 25 Nov 2016 17:36:26 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: [PATCH 2/2] Avoid a segmentation fault with renaming merges
In-Reply-To: <cover.1480091758.git.johannes.schindelin@gmx.de>
Message-ID: <5b1c217bc490289f1f14bee490533c9e307a2e06.1480091758.git.johannes.schindelin@gmx.de>
References: <cover.1480091758.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:a0b74cx1AQleWszhhBXtXS/ijPD1rWjF4e745+UgsXeRDbNedJP
 qjsxkEArJ51fHqL6x+C/ey9lkA3tat+m2vn/CNw78gmqg2iTANdhYyKuU6Z/LuO5XxSk9mi
 ALkkl8qnWA1f4qiFkIYi217949pll5A8KvAdqX1Kztj+uMjCwmPi/PdnYUmW8ot4hJ0Lpid
 aAwLUt7EnvC6f1MC3ET8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fxosYJw900I=:7W0hQZ0GJR7Zx0QwUDAVeL
 tGgJKvSkxb2Hj/Fg4Us5AngX/exmzQOb/jcfV6vJIfhfsdjpm+szFuQLLV76XfXwZa9b2y24S
 c8iPJ07KML+6mQ8qKDGHsr+yUpeWTt5rcriPvB4RtXFhgpAj9lF4G6wgDuLIjF+FSnSu6HGFr
 5a7nytOuH0QfGhtQxC0u3WCC1YramLzk+0NxbiuSx/MBec7zdXvskI7DzGDyYNtoJhI5Zq8jv
 /nKkTp1GuhvLFM7a0a3W/HWBLBF/oANIROBX8NgTCQeXi6bqmJRSopcVOCn49HZiCGds6N+vw
 gv3AeGd8TvVJkvMErNPn3B8FOr1RWRkLbedeq9dAgg18uqozmg7PBCAGNT1I8/izW4R/taYhd
 8C+ZkkZ0b/X13BQBAi3fKMiwRHgt9C+goNM24C9XM7p09Kj55PsUpZasvlHS0iAoZ++uFn16C
 jqSHDq4qbfJ4zlnGg4WYwF30ojqTApEuTRlzRiflN9oVFwkGeK5+cxYczmAaLvXq99pcQbsFB
 cc7C6xmEQAJvHdm8EcK257fHU7Ft4AffykKtBeT+8+tNi8jrwA0ew8XyTaBEHbLn47Ivwm/V7
 Cjvz7S/00H06tZLVl58NBv914dcpyFekO3HXzGmjaAH9DeOtdmv5R8ex1jtCbXFvLTrBTk70P
 /8rAjeTk5Wy+Gp2Y9zG0SxdZ9SGQAYZ7VvQNeVYdd6prMVVVzbxVxMPaqD6MipxjjkWDuj4bu
 P5bd7pC85nPQZa8Wu+nispwD13FYoyeJOsweGc63Maeo0xmQH3DleX2zJDt7950F5JMKne8nx
 P2+yPPa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Under very particular circumstances, merge-recursive's `add_cacheinfo()`
function gets a `NULL` returned from `refresh_cache_entry()` without
expecting it, and subsequently passes it to `add_cache_entry()` which
consequently crashes.

Let's not crash.

This fixes https://github.com/git-for-windows/git/issues/952

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c             | 2 ++
 t/t3501-revert-cherry-pick.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9041c2f149..609061f58a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -235,6 +235,8 @@ static int add_cacheinfo(struct merge_options *o,
 		struct cache_entry *nce;
 
 		nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
+		if (!nce)
+			return err(o, _("addinfo: '%s' is not up-to-date"), path);
 		if (nce != ce)
 			ret = add_cache_entry(nce, options);
 	}
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index d96d391af3..8e21840f11 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'cherry-pick fails gracefully with dirty renamed file' '
+test_expect_success 'cherry-pick fails gracefully with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
-- 
2.11.0.rc3.windows.1
