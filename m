Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8616220C3E
	for <e@80x24.org>; Thu,  7 Dec 2017 20:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdLGUve (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:51:34 -0500
Received: from mout.web.de ([212.227.15.4]:49517 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbdLGUvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:51:33 -0500
Received: from [192.168.178.36] ([91.20.50.52]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx73h-1f6sL84841-016ihm; Thu, 07
 Dec 2017 21:51:28 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] strbuf: release memory on read error in strbuf_read_once()
Message-ID: <6a39662f-8ff2-c314-5348-4189737a6853@web.de>
Date:   Thu, 7 Dec 2017 21:51:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:BfooLri5vGBmkt8JtLoCA2paWvuvKg4TkpHmx/Wq+aUI2ziiaK0
 IGE8x77G2NUOa+70q0Zdqldc2XOZzcbIwwSRQMBBl7DtBrgZ6EKYWbHg2sxBYWa0W4sODsK
 aaqdOovS7uCBvriExWpKR7AYyBFuiuNWgnG1k8dHlGUJ7dmjohgUJJ28FEvo0brxYWSycWY
 FzpYV9B2rxAzLqHQXruPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mppyxD+vaE4=:2omN6QBuue7vZa9TV8MkCW
 CgF6MRYSwQDA6LxOty5giQIG+vTxNlLAAIT8aBTkOFK/qNmGvX6doK6km2aDTZ+fHTWiOe57M
 4piEzJJP0im96NjOzr4G8elJkz6j5mN/TruPUUSF+gxLRppyf7N6pCA851tvam4UVh17i0Koz
 RIVXijOaxcDNgfDKMJczo/x0P7eXw4WLIgrsy7M8ATBCTa8/pV2D09SE6DiYtDuVL/BYOdcnn
 onWlFiRIjMQSesNBjsGwb8ZlmCbf5t4O41iG+ZdsgDkAJLU3QogSk5LhDWuB1FJvMIqD9wSmU
 ODFRuyFLMAAr6bfd3NumZlsj2vlNtmy/RiOof7UxEkJ5lJfSAKEOA9pJeUNYmv0loJo1IMbnS
 tj4gLXLeVNRaPqYzeN7gxyU+iQ80up2AeexEYSDlcOfp4MLALe09b7BS9oMv1eIb2cllmYpoC
 JpiJADlN28xK5zQtMeuwg7DI7cErX0ZX39z/bVUWFQtk8slwDW3loyWSwQIeLpaLIhir5QpNr
 HJRbYnp2aXO2VwvxT75fmeHEGaNgYLt8Twa+xnCfZXouNx1bjC9qzakYbl1XQ2fXRtTYLZIt/
 da/YdDqFJ4Zs+nZ57CeAGYvZZrQzdtmRyBjzIppNWPsfij591HE52Bg1Na7L9v5ML3MsspBbW
 5xMG8zHmWT+tL5LJQ94/ZVRY9zglfOI3CZlaVSkwVybqhY9VaPu9PSjbM+l4cQbOxfExVKIw7
 b5tv5WnC9RIguDxc8P7dBIkpTsJx2cz14VLCfTM77EQ4zx6QppismBrPZ1D5pEZqf/i7yxSRa
 T5WcgfBfsFA1ZwVBW2dKiu2UPB/cFsURwHEXJbe/gXnKHNbI4s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If other strbuf add functions cause the first allocation and
subsequently encounter an error then they release the memory, restoring
the pristine state of the strbuf.  That simplifies error handling for
callers.

Do the same in strbuf_read_once(), and do it also in case no bytes were
read -- which may or may not be an error as well, depending on the
caller.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 strbuf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 323c49ceb3..ac5a7ab62d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -386,12 +386,15 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 {
+	size_t oldalloc = sb->alloc;
 	ssize_t cnt;
 
 	strbuf_grow(sb, hint ? hint : 8192);
 	cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
 	if (cnt > 0)
 		strbuf_setlen(sb, sb->len + cnt);
+	else if (oldalloc == 0)
+		strbuf_release(sb);
 	return cnt;
 }
 
-- 
2.15.1
