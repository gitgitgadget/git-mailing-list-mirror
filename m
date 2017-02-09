Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6E81FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbdBIW2B (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:28:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:64396 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753882AbdBIW17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:27:59 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lev1D-1c4W2y3JV9-00qkKw; Thu, 09
 Feb 2017 23:27:51 +0100
Date:   Thu, 9 Feb 2017 23:27:49 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mingw: use OpenSSL's SHA-1 routines
Message-ID: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j7RC85fEpfxAY0xwaF327w5KHaiij7MzfnrdkNgxKYezycGvB6K
 LXxsqHlVPvHWHO5gPXUlkJL0uTc6e+ZE3Uqle4180rxDGQxqOEN/SEOCfqUo32Aws8W8TrV
 w8bnGOc3l4FGmxIipAu7UZIuLsAeXKTUfNhfxOfIwrSIt/xZd3eCe8zu0uHPViAXMk3uFS9
 oMF7hKel/e+R6W/9A/P5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CInvvp6vXM4=:vbBCsE2SvYliZ/z+mv6E1G
 d1nrrv6Zkac/j8ZeORave7ZgTI8hJxGPcHzcmIC/4jTLUYmqxnXb7licxJ1P+q31FZeExzk7x
 4h5bw8IHmkGtQqJk1t5auc6wL++iOZEoxwLuqb+dxZXDBtZxVojAbJQFsfLUaYW3xYr6/T2Ga
 4C+R5KR5oJWcUMLGH4FMj+yA1ox3s1A4UaOZzCw+eKZPtJPw04+4blq053/UkDkK+5+NukMgO
 hL2vbQM/6CamJmQQ2a2PG2fWLtSHp+7tkHD2wsFElc1YcFwO8W9I7o3dQF5RrgdcH79g+gcGs
 N4UGiJoVGaUjHxr70HvBfdjECUONKygGPqpde65MAazezgo2va8WZO1TUUYsvFSqcrOGVKWy8
 MKRt8eO2Bk4e1fKHQpfFjDIvrtL3t8/xn3fsMqczkqqbXzdziw9DFjdZXQZSFgZupTP8qIeyR
 z8U5Y75bHpfWX/s3RHEc7lRB54rOA3sIbF8LccvIOT9lBoNRRyc8+5qMrbXNy7VLN7snhSQgd
 2xt5o8+0qqS2HN58A3alQdzVKnqBawtTHOjTvNAwvW/m6oMv+JHKjCZMpQRi/bcJ57+tU6TLX
 qukHaz9QR2RQJjnlujVw7QdEIEiIzxqprChH7EbxGWMhPCApMb11H2nG1X+kvb9kxYogIvq7p
 qJW44fsUdHuUhtXOnEZBbjLZqg4TqNKJlN6afCfvok3kXOhNZRU1rrFF5odYy2P6V04MjxZqD
 558QYmn7BlnsQCwFHtugkfgwsK/eqgqeH6gLxeSKnoE7Er6692JG3JtCrsGgI1WhQ121S9Mon
 I6SNxlV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use OpenSSL's SHA-1 routines rather than builtin block-sha1 routines.
This improves performance on SHA1 operations on Intel processors.

OpenSSL 1.0.2 has made considerable performance improvements and
support the Intel hardware acceleration features.  See:
https://software.intel.com/en-us/articles/improving-openssl-performance
https://software.intel.com/en-us/articles/intel-sha-extensions

To test this I added/staged a single file in a gigantic
repository having a 450MB index file.  The code in read-cache.c
verifies the header SHA as it reads the index and computes a new
header SHA as it writes out the new index.  Therefore, in this test
the SHA code must process 900MB of data.  Testing was done on an
Intel I7-4770 CPU @ 3.40GHz (Intel64, Family 6, Model 60) CPU.

The block-sha1 version averaged 5.27 seconds.
The OpenSSL    version averaged 4.50 seconds.

================================================================

$ echo xxx >> project.mk
$ time /e/blk_sha/bin/git.exe add project.mk

real    0m5.207s
user    0m0.000s
sys     0m0.250s

$ echo xxx >> project.mk
$ time /e/blk_sha/bin/git.exe add project.mk

real    0m5.362s
user    0m0.015s
sys     0m0.234s

$ echo xxx >> project.mk
$ time /e/blk_sha/bin/git.exe add project.mk

real    0m5.300s
user    0m0.016s
sys     0m0.250s

$ echo xxx >> project.mk
$ time /e/blk_sha/bin/git.exe add project.mk

real    0m5.216s
user    0m0.000s
sys     0m0.250s

================================================================
$ echo xxx >> project.mk
$ time /e/openssl/bin/git.exe add project.mk

real    0m4.431s
user    0m0.000s
sys     0m0.250s

$ echo xxx >> project.mk
$ time /e/openssl/bin/git.exe add project.mk

real    0m4.478s
user    0m0.000s
sys     0m0.265s

$ echo xxx >> project.mk
$ time /e/openssl/bin/git.exe add project.mk

real    0m4.690s
user    0m0.000s
sys     0m0.250s

$ echo xxx >> project.mk
$ time /e/openssl/bin/git.exe add project.mk

real    0m4.420s
user    0m0.000s
sys     0m0.234s

================================================================

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/mingw-openssl-sha1-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-openssl-sha1-v1

 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 447f36ac2e..a07936da8b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -515,7 +515,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
-	BLK_SHA1 = YesPlease
 	ETAGS_TARGET = ETAGS
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease

base-commit: 6e3a7b3398559305c7a239a42e447c21a8f39ff8
-- 
2.11.1.windows.1
