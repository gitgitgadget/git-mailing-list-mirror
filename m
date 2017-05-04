Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4EA207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755192AbdEDNzl (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:55:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:63942 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755182AbdEDNzf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:55:35 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEFIm-1dHEWs02bw-00FQPe; Thu, 04
 May 2017 15:55:26 +0200
Date:   Thu, 4 May 2017 15:55:24 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 01/25] mingw: avoid memory leak when splitting PATH
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <1857475d4f75b811f16802daaf1303855e3ea4f1.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pUIPT16MHx9Af+YxTsdPz4tBs4gScSSTTpA2N2P1RLo5VU3EtJs
 6M1Vq9vLVmRLeLMR/WqVBzONhFB06qhnIqhYhaK8mpCaFGnCXmJ3gCTj/OSr20FMhPZHZDn
 iqtEibjWa2kkYoP4NPJKvaUN+JNrVk4jN31uDUiI8ZEp98qPz6KozCvv5VzoHAzEUanKmPf
 kBPd+mfbrbTpMtn+Q0PyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3m3OWjJziPs=:5hLEexf4MvyXJLaPXMgbFl
 jOzxArMOVN+e2mDRZzx0+lVUUuDQXXKpUiFwcHuthtv/Wk4hhEKduLf3ulz65uSCwrHyE0SSp
 TReeVQLqCkd0r6L/Ucg5TcCApPxKuQi5+odOrdvzzeUH50G3ckLKWxM2Vf32po79zT5CfrVum
 xFtTZWZwcYOROU/fVfXXLSPzPs+/qu/zCxsCq9Wu/9SIceU+jZUlYvD5sfAKOKRgUaWkWO9h+
 tFsOo+V4fmPiAVrEP0Mv6szjHIIWkRq4iULLdlQEZl2umJj1u9tbG/6S3klf8+By5JzvWvVDB
 DovwFWoXHHmTLbPa9DUu7m8R1yNNp4Z4OlFayy0u/Z08dRv5jhX2wePNnMHzw+dA8kQoBOul1
 f8r6bwq3djrVenLyvDNVKUkXfE2RbU1EB0xxqqPq7zfAOxZHgLLaxYwjikboeDRHsB18oRIn+
 TW9Rt6/JoNKnTzpl5f80pApTgf5dsfh3KC9y11WkermlIlGAwc/1H32eKVqP0j+Y8uuhuhtd9
 Vbuh3aC4d9lR1R1FZojoabGtQ0RiTtmqv6y/L4Ji0kxxFn7yW5kLwS3g1EAtznRQ9Ea8534S4
 jF9YkfHKB2JjCWT1WWzy1va1HToS5VIww02Ee4wd0hAfyO2FXNaoVu1uHzG6GlPBeJD1K5KyU
 kt/TD5TMAnNw6BQEvcJdkg7RO2d0GjrI+otFoOB7Nsj7lq3Dq0wlVQOAoW54ZxeqhSP2RyOnc
 d8elXMgVe9dkyv41BDuH4V+2owdnMnJg4rw+D19YdUS6JVzrEWmygh36E8gnER9ZFgc2k5r9u
 7cpwPLb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the (admittedly, concocted) case that PATH consists only of path
delimiters, we would leak the duplicated string.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3fbfda5978b..fe0e3ccd248 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -961,8 +961,10 @@ static char **get_path_split(void)
 			++n;
 		}
 	}
-	if (!n)
+	if (!n) {
+		free(envpath);
 		return NULL;
+	}
 
 	ALLOC_ARRAY(path, n + 1);
 	p = envpath;
-- 
2.12.2.windows.2.800.gede8f145e06


