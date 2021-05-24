Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2016BC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 19:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84246140B
	for <git@archiver.kernel.org>; Mon, 24 May 2021 19:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhEXTjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 15:39:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:6767 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233593AbhEXTjj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 15:39:39 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4FpnYs6prgz5tlB;
        Mon, 24 May 2021 21:38:09 +0200 (CEST)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t9001-send-email.sh: fix expected absolute paths on Windows
Message-ID: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
Date:   Mon, 24 May 2021 21:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git for Windows is a native Windows program that works with native
absolute paths in the drive letter style C:\dir. The auxiliary
infrastructure is based on MSYS2, which uses POSIX style /C/dir.

When we test for output of absolute paths produced by git.exe, we
usally have to expect C:\dir style paths. To produce such expected
paths, we have to use $(pwd) in the test scripts; the alternative,
$PWD, produces a POSIX style path. ($PWD is a shell variable, and the
shell is bash, an MSYS2 program, and operates in the POSIX realm.)

There are two recently added tests that were written to expect C:\dir
paths. The output that is tested is produced by `git send-email`, but
behind the scenes, this is a Perl script, which also works in the
POSIX realm and produces /C/dir style output.

In the first test case that is changed here, replace $(pwd) by $PWD
so that the expected path is constructed using /C/dir style.

The second test case sets core.hooksPath to an absolute path. Since
the test script talks to native git.exe, it is supposed to place a
C:/dir style path into the configuration; therefore, keep $(pwd).
When this configuration value is consumed by the Perl script, it is
transformed to /C/dir style by the MSYS2 layer and echoed back in
this form in the error message. Hence, do use $PWD for the expected
value.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 When I say "the configuration is transformed to /C/dir style", I am
 actually hand-waving: I can observe that a transformation must
 happen somewhere, but I actually do not know where the conversion
 really happens. "The MSYS2 layer" is my best qualified guess.

 t/t9001-send-email.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b3035371..68bebc505b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -539,15 +539,14 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
-	hooks_path="$(pwd)/my-hooks" &&
-	test_config core.hooksPath "$hooks_path" &&
+	test_config core.hooksPath "$(pwd)/my-hooks" &&
 	test_when_finished "rm my-hooks.ran" &&
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
@@ -558,7 +557,7 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
-- 
2.31.0.152.g120726e270

