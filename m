Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D99EC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E242360FE7
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 17:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhJ3RKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 13:10:18 -0400
Received: from mout.web.de ([212.227.17.12]:46215 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhJ3RKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 13:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635613660;
        bh=Np2Wrcg5Z+XzxDqWLSBj+AYsG5N1kNcgQkU8HZmbBZM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=JXmlwF5AjQ9eZyQQIjOBddtPlqJe0lkQ1OgwrWkmJy5N1rIymPSTrkSwLAcs2Qux9
         ladkEJfcGO99OmG0NxEXRL46rSINseRokoG/yGWAJWVzPB3vJDLqnefacvAw+LV1i1
         vR2ozTxoFe7Vy01hxK+tLmhIpZvf6417JGyLXa7A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LiCsx-1n3DtA3sax-00nO3h; Sat, 30 Oct 2021 19:07:39 +0200
Subject: [PATCH 2/2] gpg-interface: avoid buffer overrun in parse_ssh_output()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Junio C Hamano <gitster@pobox.com>
References: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
Message-ID: <a72ebd19-9871-f811-cd5c-72b89dad6c6f@web.de>
Date:   Sat, 30 Oct 2021 19:07:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xfeEqzIov5pk//2+uhAxvAz+CbrnbbAFuLEjYbWwURqVCdA1hq9
 ld+R0SB601C7XZ9/NaPVWexCnpT+ofJ//4Xqq04rwG2kE/QYqCLy40DUqcxsopBa88Xvn2o
 ql2GMxpysCfoaG/pLZh1G8MH+puZYxxU7vcj0bC5AqFmskznkg6UJG7bZWSgmZp7Hf/u8L3
 5R68xrng6mVZSNQFOv6Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:52t7ViZjIcI=:58nSOkshwfqHXvcQk/ma7F
 RvfmSzvJKvN1sntSUmg7JT9ECiee3WRgE7oVUxmMXw9jLtx3awky4owU2HD+y4F3FHrDNRJbm
 dIp36XExBkEqPy5ta20x0jzcVpVfvs2GS7dCCKG1AgBMNLTUyTE9fM/y2EZUwrHayPATR6Gd3
 fpoANdQLc6qsvRv5hmD/lJnMYLwMuPgwC2voG7hRhxvyVUAHD94EIaSX4j0HGDcxt6DuqdDTh
 lRC3lY2iyrlTPXd367/E4Ioc8YTc+ywf5mXJmGivUFIIjFFMce7uQQ/D6unuzCV2G6swzQiGg
 1nnZ73XRjL0uONuQz6RNKVZhad0zAcB0tQRjZ18g/he1dTmLH2RGxTxgK3WlZ301mDN/zyqq2
 IpBKCZLlrs1InPsySPdUDhMCoisbrZXHNsIY1bpDL6bN4t2KAYWi0V7hmh17q/9wP1dEepsxE
 SvBBkspn+v66StBlG9nPfNvD0Ox2LuCmaqbSJpjv6jtoWB2uLWqW1YjdmWS15e+YM1PAY2eiv
 feCGYjVYg0T464YBxb3MVh8taVv3Fbzo+qHr6YvfjXbnfk7hSo+f5jAk6ItwTyA9Ecskf8Yt3
 r96KZLNYwXIv+Nebq9b6MuIB9xT+RWNmiUaMGnNR4ydDALDY0A84rGGL/FcYoTqzj9+Sw2T9O
 dXZf+RDuGKbBgqgN2KcPQ5NgBRZRfA4o0L0XHPr1azZEbONj0nJtkRillbPQVaYnq6UH2gjcU
 IXQv93yeUY4KvBQkBzYKM74uMSRVh/ugH6mOKin3wNoVE9tE0wV129jL/0HHYzpuXohFXhbll
 cjOibxu+bf0c9SVfd/wngEYGHrppKNSsU9kQu1ZBCCdd3W3hb9zq9bsJ5K8mxGJ40R4bLlF12
 K+Mu/VOasGNkQaJDPp/WJoGybig0o4ez2MMqExkWH8GeD23s1fHvvM5HvHehvvRegsPHb14JC
 ND0Q+PgbQWqGZVVyxrXztFKAxeKZTM3MvlwiMoabZh/KgQSUjc9KxKmht8gZor7t08pVFUg9E
 u7i6+Tql+Em3xqRM7z03qP4Cv8YPt/KssNwHdN0wMCi8DDBFE358aJRez7jOLw2yrg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the string "key" we found in the output of ssh-keygen happens to be
located at the very end of the line, then going four characters further
leaves us beyond the end of the string.  Explicitly search for the
space after "key" to handle a missing one gracefully.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
This code was added after v2.33.0.

 gpg-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 62d340e78a..3838536f0a 100644
=2D-- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -409,9 +409,9 @@ static void parse_ssh_output(struct signature_check *s=
igc)
 		goto cleanup;
 	}

-	key =3D strstr(line, "key");
+	key =3D strstr(line, "key ");
 	if (key) {
-		sigc->fingerprint =3D xstrdup(strstr(line, "key") + 4);
+		sigc->fingerprint =3D xstrdup(strstr(line, "key ") + 4);
 		sigc->key =3D xstrdup(sigc->fingerprint);
 	} else {
 		/*
=2D-
2.33.1

