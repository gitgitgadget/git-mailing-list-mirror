Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C3F203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933992AbcLMTJi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:09:38 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:29391 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932547AbcLMTJf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:09:35 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tdTlw3FBCz5tlG;
        Tue, 13 Dec 2016 20:09:32 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 61E811E45;
        Tue, 13 Dec 2016 20:09:31 +0100 (CET)
Subject: [PATCH 3/2] t5547-push-quarantine: run the path separator test on
 Windows, too
To:     Jeff King <peff@peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
Date:   Tue, 13 Dec 2016 20:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To perform the test case on Windows in a way that corresponds to the
POSIX version, inject the semicolon in a directory name.

Typically, an absolute POSIX style path, such as the one in $PWD, is
translated into a Windows style path by bash when it invokes git.exe.
However, the presence of the semicolon suppresses this translation;
but the untranslated POSIX style path is useless for git.exe.
Therefore, instead of $PWD pass the Windows style path that $(pwd)
produces.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 12.12.2016 um 20:53 schrieb Jeff King:
> Johannes, please let me know if I am wrong about skipping the test on
> !MINGW. The appropriate check there would be ";" anyway, but I am not
> sure _that_ is allowed in paths, either.

Here is a version for Windows. I'd prefer this patch on top instead
of squashing it into yours to keep the $PWD vs. $(pwd) explanation.

The result is the same as yours in all practical matters; but this
version I have already tested.

 t/t5547-push-quarantine.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 6275ec807b..af9fcd833a 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -33,8 +33,7 @@ test_expect_success 'rejected objects are removed' '
 	test_cmp expect actual
 '
 
-# MINGW does not allow colons in pathnames in the first place
-test_expect_success !MINGW 'push to repo path with colon' '
+test_expect_success 'push to repo path with path separator (colon)' '
 	# The interesting failure case here is when the
 	# receiving end cannot access its original object directory,
 	# so make it likely for us to generate a delta by having
@@ -43,13 +42,20 @@ test_expect_success !MINGW 'push to repo path with colon' '
 	test-genrandom foo 4096 >file.bin &&
 	git add file.bin &&
 	git commit -m bin &&
-	git clone --bare . xxx:yyy.git &&
+
+	if test_have_prereq MINGW
+	then
+		pathsep=";"
+	else
+		pathsep=":"
+	fi &&
+	git clone --bare . "xxx${pathsep}yyy.git" &&
 
 	echo change >>file.bin &&
 	git commit -am change &&
 	# Note that we have to use the full path here, or it gets confused
 	# with the ssh host:path syntax.
-	git push "$PWD/xxx:yyy.git" HEAD
+	git push "$(pwd)/xxx${pathsep}yyy.git" HEAD
 '
 
 test_done
-- 
2.11.0.55.g6a4dbb1

