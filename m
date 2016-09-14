Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9951FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 16:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763373AbcINQFr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 12:05:47 -0400
Received: from mout.web.de ([212.227.17.12]:52242 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762269AbcINQFq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 12:05:46 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MPHGG-1bfmq40GBc-004UCq; Wed, 14 Sep 2016 18:05:40
 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] xdiff: fix merging of hunks with -W context and -u context
Message-ID: <a6f5a3cb-74d3-6072-a611-8dd63b902057@web.de>
Date:   Wed, 14 Sep 2016 18:05:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:20vYS/Ym24URcuxTIWDfgpfL/WjJkfXificPQkbwyeF1+3aFQWb
 e36qkHAim2O9DLI8Df26AtENWaZ8GDOENO+7pD+KVyxhyISUPOtWjJViBRg/JsH0+fRKFh3
 JtkQzomxCUbstzrDgKoAfW8vHTCz3sZh9Jle36K1lSWwaBCCYqF4nEGUMARDGFzFoev21Jy
 qBVAYsXdglA3QwJG9mnTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CZmVRcjEMAE=:6e0n0ngTztndfy47izgvx8
 5uIUaPaHnD93Lsag3jxKYdth+HyWRft2paF32KgiTDHpnoTdzb7hVgIhAlkGaPOXZ1/EgYAc6
 P4a3j88p30nQXLpoim/YvdC6wo9aB/L2QpQNTu2g8okuhNqb/9c0KlL9aXwiL/Y3VDRFQ5MW1
 o1EVaYhyjYTvea7gr85RNgV9nK7uHFlb7LVErag2duyP2jbKsz6lTfscg0G4IgF8zPBbwW7L/
 SGEIAP/VQi93JNkgda6P3TMAopRB4fzVv3Bku5Ba9g1K6dgXdrJ8GedM+wtrpdtQCERDqLY3A
 /YjZ4LT0v2ytD011IhDln5sDZiQBRB/Ew3FRHIQBCuuWzTeAfx+UZX1WV8v39stNaCkpwGCRs
 ncHMq8Sxp1nf7pOXoUOo4n2xOIywSe7L0Bp14IdKwUXCjhxjG1ohHCHfR2tSvtRchLTjvYJDK
 CBPj4Xwi8G4lKuuG79TOIL3S4XMH52BcX2HUk4f8JTL9Mv3glYGzQwO49DxjfuQlFRle6eXWV
 MLf33cNM6ZVZJ42y87rR3xsTukfs9P0BvjaexYrr7KguebZ0ZYjp1N33wyqz6kvmlFZP5enCK
 A38xiT4x2nGYr6sqsXXt8uEvRiN7zqv+3ZsPYxszPQvMXM9/b524XPB2pNHDWw/mwlZ19aHWm
 HV/PccTXCuGWXX0ZQaTuG1NchqdNFUozsi+zeMNAD8b32cRRK/GZ21XJFDBaTLKLTz0SXpsV4
 ufM9WpLhWK7eSmnfeTBj4ZhvbbolxkMTDMkW/9wewWZAiSuCYrEEpGN6qKr8ysaMVKlPowBn2
 8/TaWLh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the function context for a hunk (with -W) reaches the beginning of
the next hunk then we need to merge these two -- otherwise we'd show
some lines twice, which looks strange and even confuses git apply.  We
already do this checking and merging in xdl_emit_diff(), but forget to
consider regular context (with -u or -U).

Fix that by merging hunks already if function context of the first one
touches or overlaps regular context of the second one.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4051-diff-function-context.sh | 25 +++++++++++++++++++++++++
 xdiff/xemit.c                    |  2 +-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index b79b877..6154acb 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -67,6 +67,15 @@ test_expect_success 'setup' '
 	commit_and_tag long_common_tail file.c &&
 
 	git checkout initial &&
+	cat "$dir/hello.c" "$dir/dummy.c" >file.c &&
+	commit_and_tag hello_dummy file.c &&
+
+	# overlap function context of 1st change and -u context of 2nd change
+	grep -v "delete me from hello" <"$dir/hello.c" >file.c &&
+	sed 2p <"$dir/dummy.c" >>file.c &&
+	commit_and_tag changed_hello_dummy file.c &&
+
+	git checkout initial &&
 	grep -v "delete me from hello" <file.c >file.c.new &&
 	mv file.c.new file.c &&
 	cat "$dir/appended1.c" >>file.c &&
@@ -179,4 +188,20 @@ test_expect_success ' context does not include other functions' '
 	test $(grep -c "^[ +-].*Begin" changed_hello_appended.diff) -le 2
 '
 
+check_diff changed_hello_dummy 'changed two consecutive functions'
+
+test_expect_success ' context includes begin' '
+	grep "^ .*Begin of hello" changed_hello_dummy.diff &&
+	grep "^ .*Begin of dummy" changed_hello_dummy.diff
+'
+
+test_expect_success ' context includes end' '
+	grep "^ .*End of hello" changed_hello_dummy.diff &&
+	grep "^ .*End of dummy" changed_hello_dummy.diff
+'
+
+test_expect_success ' overlapping hunks are merged' '
+	test $(grep -c "^@@" changed_hello_dummy.diff) -eq 1
+'
+
 test_done
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index b52b4b9..7389ce4 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -239,7 +239,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			if (xche->next) {
 				long l = XDL_MIN(xche->next->i1,
 						 xe->xdf1.nrec - 1);
-				if (l <= e1 ||
+				if (l - xecfg->ctxlen <= e1 ||
 				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
 					xche = xche->next;
 					goto post_context_calculation;
-- 
2.10.0

