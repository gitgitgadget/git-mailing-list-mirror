Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88270C43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiFLGGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiFLGGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:06:04 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23119C10
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655013937;
        bh=qsdawq715O/V/nmmBycYUKaJbChEBTxQP9xdGa7cxHw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=i/FQcIE/UCDioV2c8ecACF3m7Ts1NByGV8Q7pxDjy+jAYJdwfFCqjUAz6cMLW+Ewg
         NRzvl+MOM8G+eRQVgJWeBTWkX2Qm0edz4BIjchplaaf1K/Y4/Lpr5qMKq84XDNYbxl
         bZe245xRZq0igjJo1zBGZxVhbyZCIiaeMGlzf1KI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UgI-1nh0g64842-016l8K; Sun, 12
 Jun 2022 08:05:37 +0200
Message-ID: <0c7a4261-47e6-941f-bd0c-4ecc646bb124@web.de>
Date:   Sun, 12 Jun 2022 08:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v3 2/5] archive-tar: factor out write_block()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
In-Reply-To: <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HFRQ8GIFNgO/2VjM39nuU+bGm+qBME5kYKjpuvs+XWifhBLfbfP
 ri6a3NDrCjL8DpHtpNpKaXiioQSY31e91zLSF5CWn9c1qvEXRrPrRV/CqiADqsLpbSIeH6H
 Xw6mvHid0r355gxwWlGJsJBSnEN2l3VF9yH7i4+kcuTTZH5p73Oj+CMla2jRNuclXI13SN0
 LswfIOlOJkinDbBOGDbQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:le9+ddnGe44=:EoUj6Q8g9Wvqf0CXNbDGsT
 i5Cf4YfRa5OJc00hp9D9fyQzVyxndoF3jYiiWXNkzQ3h839D79oRI/UCpI7GxsZ9yZ6gOkiX7
 yQ3Un4hP995iDjK2donklpdhuo1z+BSp9N/nL9YFpbKuxnX8CO3/WN5rozQwhipByXnIf1cZP
 BkkdJNztuzIhA+cdGjul31DkTTQ1FaCmCubJU8whJO7MR7sF8DTNqthHkIUj9BprtwsjT9XCU
 3quTISBzCviou0+dImW2sxdVouOIGU9XVHqgBkAk5ogErJrP9oWaSZm0gJNXu9+AuA9KUulPn
 g7ZqOm2oU36yRmkwh8k3gkiLHfq+/HfOqn2GeklqvnlXW09Ghwg3GLT2M3Usrb5iy5y2RqivE
 mI0SBlMmpT2hq8yiOlJXBaC1+7JN7ON3gCZJgkADauf0TysWOAJaK/RNpPbxHhvRWbC4AS9+O
 /P//9mxfIZpejaC0xxvItyPCpnyCPwAncS670YL8EmLMY4apUvYFPbCalLbp4NYpMVS9nwL0M
 QDjozseeVWWB6aL1OYk93VMCQ5RDbwlLzKYiIkbRaDQ1e9tNQula2TJGGWrkIvaI2aAvLvvMl
 cEVu7sSYP/ePt9tOzeLsL8GeHYXALbj1OLq9wKWg3E6C/VS0olvukeriurw1OppE5SQy7pVef
 swom1seuO4Xo7OKp/fb1+LFNN4gFIJ2jJMGQo67fEToPE9VZdaswuQBJ3D+ry1epGNQHwoANb
 dr+njL2dMpwBL/eGpFOSnnSmeG8UOLWUzztQ0tk6UWcjQaOk/6MBcEJMv1YnIQlVpZitUqoSo
 /rTwJE1kzZjfQJMWRNtV3PHkP5s0YtEfP5O3zA11SP6Xfm20cHHNoVwhhvDqz1pnohpt/rDjl
 cmc02ydS32Yss6c0Mt+EI+Lw05u2busV2oC03YU2EqgzxGgicnRR9mD6rNB8EqeJMTphbdLem
 2UFlWgzRFAu9Ni2ItkP+ux4AWJ0BZhJO0e8Sh+jq5CGfIkbUoT8YtFfi1pSVbvsE2vt+7QjCV
 QUW1zZxKD8/A0TymvztgOYbKuUL48IqxXQQLoKlqAiUV5gMKBSX4fqMK3X7eEVviPLeMxx+0T
 64bQKbNabCjwAmV6Vw/887o1Yg8aIhBA+nG
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All tar archive writes have the same size and are done to the same file
descriptor.  Move them to a common function, write_block(), to reduce
code duplication and make it easy to change the destination.

Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 2717e34a1d..4e6a3deb80 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -38,11 +38,16 @@ static int write_tar_filter_archive(const struct archi=
ver *ar,
 #define USTAR_MAX_MTIME 077777777777ULL
 #endif

+static void write_block(const void *buf)
+{
+	write_or_die(1, buf, BLOCKSIZE);
+}
+
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
 {
 	if (offset =3D=3D BLOCKSIZE) {
-		write_or_die(1, block, BLOCKSIZE);
+		write_block(block);
 		offset =3D 0;
 	}
 }
@@ -66,7 +71,7 @@ static void do_write_blocked(const void *data, unsigned =
long size)
 		write_if_needed();
 	}
 	while (size >=3D BLOCKSIZE) {
-		write_or_die(1, buf, BLOCKSIZE);
+		write_block(buf);
 		size -=3D BLOCKSIZE;
 		buf +=3D BLOCKSIZE;
 	}
@@ -101,10 +106,10 @@ static void write_trailer(void)
 {
 	int tail =3D BLOCKSIZE - offset;
 	memset(block + offset, 0, tail);
-	write_or_die(1, block, BLOCKSIZE);
+	write_block(block);
 	if (tail < 2 * RECORDSIZE) {
 		memset(block, 0, offset);
-		write_or_die(1, block, BLOCKSIZE);
+		write_block(block);
 	}
 }

=2D-
2.36.1
