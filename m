Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1201920D09
	for <e@80x24.org>; Sun, 16 Apr 2017 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756516AbdDPQ4O (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 12:56:14 -0400
Received: from mout.web.de ([212.227.17.11]:49495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756149AbdDPQ4N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 12:56:13 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHowb-1d2psC1O2v-003fq6; Sun, 16
 Apr 2017 18:56:01 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] server-info: avoid calling fclose(3) twice in
 update_info_file()
Message-ID: <137d732f-7a23-8a8a-9f2b-7f16bb361c5a@web.de>
Date:   Sun, 16 Apr 2017 18:55:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:B71G61vc63w0+8ooAWuLdkEELWwqB/JibVk8fi4F8G7Bzpq1sbA
 eAx0YHyqJFuO8z+KrVJ3B01sThO6reU86kotgcYLf6zUL2GqsJMbUSMBSvBz4Ixat6FeiLF
 2pdhtYWAC482yj1KtrdM+4Mxh4IXJ5ShrzGY4SykbjbJjSf21IZSPrTv9xG1VWuPIcj+Xl/
 Hx/wm+60XJ/qrv/SrHCAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qO7TpeckSig=:NTIpPaX2vINgMYcOl8hn1b
 zcab9Iqx3hGrteIFoJwVPK8mUMwV69eAI7PRvif+TbszzgbU9MFLBwBymZiUpZtiAw0gBnOw3
 P9DTE0+s1ceYbfVpbgVA0xAgBfaiyhv37wkrYegs7kGT4BPdgRJJxNKwkD6MmfOlzFEEbouKS
 dTHILYzyjVpq409VnhGm4U4Vj0fE5YK8ulfZVZQItWoN9NNpepFM32YZydXzeODWG4PdLAvfc
 JZqTdQKpJCtXUkxNOQBv9Zpv7j6WTUdOUD7zs4ydV5+2Tax+YBEutzH6X2zhu5oX+WC7JZ0pq
 EZI0RM2f4cIU5lpEHbbLzAHjVc9oiz9GOxoQLfMQowztgJ/u9iYOxrQspJ1feXoRvlYGUnRrg
 T+Oj8dBS09T4ZGGKc8tAsKJ+LsjT/XgIHI6Kysy/bAvGG+bCUQ6xZ3r9d4mAWYSBOUu4FsU7j
 4Sawm+K4bZZ4ns6fShaaJQ984h0gg4Vxi1OjOEGS0o/nOXGyjt2H39oA5STK/4FUKdKh3h56J
 Vyi9j84zSu4dKdnbDE9r/hVuEWlNEWbwlbUyytvlrrzWT1OZcW51EsfPjG4B4f7L3TIBgCYpn
 u5csppv6SNUM8V1fTtDfGAs8oirch4Qo2kBVapBGp1x/lCfM8cfbAjifGW+Qsh1d+5Dx3TVRr
 W0yE4kJcYVI25+/V0oZSo9rnzsTXescBQA7qwOQtC3TmsuLwyapLq3s+sIcrMED1ft+BRizeo
 HJRSnkLqrraQ61AGouHLHlfA6BIzxaV4bKJOXrLkX1sGJnUpOx4FKUa4/jvykfIVjGiqXmwhn
 iDBvWDl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If an error occurs when or after closing the stream we call fclose(3)
again in the error handler.  The second call can exhibit undefined
behavior, so make sure to call fclose(3) at most once.  Also avoid
calling close(2) after fd has been successfully associated with the
stream, as fclose(3) has become responsible for doing that beyond
this point.

Found with Cppcheck.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 server-info.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/server-info.c b/server-info.c
index 7bc4e75d22..f6c1a3dfb0 100644
--- a/server-info.c
+++ b/server-info.c
@@ -14,19 +14,21 @@ static int update_info_file(char *path, int (*generate)(FILE *))
 	char *tmp = mkpathdup("%s_XXXXXX", path);
 	int ret = -1;
 	int fd = -1;
-	FILE *fp = NULL;
+	FILE *fp = NULL, *to_close;
 
 	safe_create_leading_directories(path);
 	fd = git_mkstemp_mode(tmp, 0666);
 	if (fd < 0)
 		goto out;
-	fp = fdopen(fd, "w");
+	to_close = fp = fdopen(fd, "w");
 	if (!fp)
 		goto out;
+	fd = -1;
 	ret = generate(fp);
 	if (ret)
 		goto out;
-	if (fclose(fp))
+	fp = NULL;
+	if (fclose(to_close))
 		goto out;
 	if (adjust_shared_perm(tmp) < 0)
 		goto out;
-- 
2.12.2

