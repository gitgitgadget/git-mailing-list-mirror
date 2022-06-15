Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F315C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357457AbiFORBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356915AbiFORBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 13:01:31 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA13E0C1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655312475;
        bh=qsdawq715O/V/nmmBycYUKaJbChEBTxQP9xdGa7cxHw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=Ah5vpoSRdViGyVkK57rtyyto6LulQkKfHwYQoGSO3RdltpgvMJaj6NUo+TEmmG+yc
         6jcY+BHhX5BQ08rL0s8XDocP/FYeydF/he2dJBZAXqGxzoWTHf0zIsByLJ9zRSl8fc
         4gKwoTCdpWXnZPG/kz444j/ZQIYtyDA7c8Y11xOk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1nKnj52B6K-00jV7e; Wed, 15
 Jun 2022 19:01:15 +0200
Message-ID: <2415cea0-47c4-b63f-7ef8-1d8f3e08d523@web.de>
Date:   Wed, 15 Jun 2022 19:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v4 3/6] archive-tar: factor out write_block()
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
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
In-Reply-To: <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lEUf/Pcvhh1U4rCfHA4RtfuJL8doxSNUguagOYNInY6gRLvNulM
 eM5l+IPeFwctnWgB4ntJ00uJ/arsD1Kwn5pU6yyKaSPh0r3jIIXCHcdA5U/yoVZchNgwwgX
 scJNQQ4lov+sRNXhc6Jz4QsttkBI+xLUDggMZkuNHtUCj0yNQOD2gRPjPlUgDR3KrsuvA4V
 weSgNJjudOs2AeEm5uG1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K0b2rW2P5J4=:0M6QdM1SjuaKxwBNESYhYQ
 uyNEcJNhcXq6YWocZzuBfB2cYvZOKiYdrR6AvUxvvpWpgOfmN/RB+bEOSK4dcK7cvh7p8+nfb
 mrxrvvGNbcH8ZtB7YN78xdwJxBpjcaTJ6a2lwF8cPREf6GJF+6dYXYIBv7aIVvzlDoZuFpAHI
 YNuxRDMuuwVlXKZ5lHMbNy+OcBukK0GeGfnR6/i9l8730pzFd3uRDz/NRf5eMoSYYoeolo2pH
 hAqunZjxnm4johPeK2KQrKupgHC9DOR53cU60D0IyyfU5ByiuuuSHmOqv0YPIIAGudfQI5Utj
 KKs3L8wvPHk67jkRewhLGfucZVHeSnmKD3qBq2IFWOiKywOd7e+CgfAfUSS6WpHYnIkNlpvRl
 KGuqHkqCFpolT+bqmFA0vGH5XpSMVYrMCT6msv9VJ/pGddhu4W2yIuvQF7L9WwFVDNXAT9Gp3
 L0PGI9TdCH8vLyH0E95uwvnmfeqgulXH3WpayPa/Yp4aUld5+6XoEaOiCQYxACen7NFNxSiWf
 BA28Qx/5qg1BA0dZJcAzy2pIL112cI2K8At+WiLEVCF2xU6LQqODLjeb69srIqnnI2CUGGbrj
 G3/ZXHl23OJc9Rlfs2DGQ78icWEw73Dx7rSM8s9LWV2FdqaYnd0QHyZ5gRhS/2gUfGRh3FYBr
 /hK6l/nNkIfvvT8a5to+XMXcyJDwNwpCVmjalFVeugXCNmBidEagp0Bb4vb51pgt7YA09jsA2
 ksvycLShO81aGe3o34Y9FaHVT9Wk41kr/wGxSV4cYBxLjOKa2m19FMyPbSeYEcyylvcTL62uS
 ehmx7FZk+c+V/boW3kJgmY2aOeNR3fs1vPfbB0tErKnENXYKz8DVA/Jz7ybvSc/4S6vRqpBE7
 muRPVWA5Lwws/JwF7zoOkmDwV19hN8WfwzdGF9EazxFFCz/4HkYLhu88kg9DDyHgo42KI1bfc
 0wepIBUgLNwTckd04556cid8R+u6fURvedqdvia1Cz8CKvIJdO4xFnVQFrF+Zz7Rv+hvGv4z6
 1VLPfwMr8MbptakigSFb6hJG/jfSAHDu4yXiaCRO0QiIUWr+xnF7O3bnEKepRvTvKhfV08wkN
 CHS4UCrzUShqjQ1nIvclbcilf10JdkpUWaL
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
