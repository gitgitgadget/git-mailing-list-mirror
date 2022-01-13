Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC6FC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 20:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiAMU2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 15:28:51 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:63350 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232027AbiAMU2t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 15:28:49 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4JZbcF6TKlz5tlD;
        Thu, 13 Jan 2022 21:28:45 +0100 (CET)
Message-ID: <529d99f3-13c8-ffc1-dd4c-3fc70330262a@kdbg.org>
Date:   Thu, 13 Jan 2022 21:28:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
X-Mozilla-News-Host: news://nntp.gmane.org:119
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH ab/fsck-unexpected-type] t1450-fsck: exec-bit is not needed to
 make loose object writable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A test case wants to append stuff to a loose object file to ensure
that this kind of corruption is detected. To make a read-only loose
object file writable with chmod, it is not necessary to also make
it executable. Replace the bitmask 755 with the instruction +w to
request only the write bit and to also heed the umask. And get rid
of a POSIXPERM prerequisite, which is unnecessary for the test.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I happened to notice this by chance when I built on Windows today.

 t/t1450-fsck.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 6337236fd8..de50c0ea01 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -94,13 +94,13 @@ test_expect_success 'object with hash and type mismatch' '
 	)
 '
 
-test_expect_success POSIXPERM 'zlib corrupt loose object output ' '
+test_expect_success 'zlib corrupt loose object output ' '
 	git init --bare corrupt-loose-output &&
 	(
 		cd corrupt-loose-output &&
 		oid=$(git hash-object -w --stdin --literally </dev/null) &&
 		oidf=objects/$(test_oid_to_path "$oid") &&
-		chmod 755 $oidf &&
+		chmod +w $oidf &&
 		echo extra garbage >>$oidf &&
 
 		cat >expect.error <<-EOF &&
-- 
2.34.1.141.g867d0e9267

