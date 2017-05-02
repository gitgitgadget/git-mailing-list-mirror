Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2164D1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750818AbdEBQA7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:00:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:60188 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750769AbdEBQA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:00:58 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyR1G-1eB8q408zG-015u3h; Tue, 02
 May 2017 18:00:50 +0200
Date:   Tue, 2 May 2017 18:00:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 01/25] mingw: avoid memory leak when splitting PATH
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <10fc0a4a37b4167f49c967ece08f531cb1e8d6b1.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hMY97gg28xt8QbZTIwb1x/hsNd8nzTCuR7k40pqtokVLVzoBDNw
 MZ3A6JS+hlzLs59Cq9duQ8uL9LAQDmPayb1XK5QOl9qSK9QhEtRLkOzwzGqE+gWVhO6gI6J
 t2ZjW94sTXfLGD74B2C4iA6KnK7cJowY8GHvMeZ+h4qkScvh03IiDodnNBVTb5EUAmOAWS1
 lI1OcegrTS8zZhxy+nv4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bP4Hu2YmZ/0=:uV0AOoyf95Kk7U9ZZKPFQp
 B3Ee+ZOBbn0VsQawtKk70MfFaaut9OFTin85bx/NMi6rw6GaV8v3LIPNzYGJlBRR+rgehPHge
 8tc0SW2idqVYl9unhhIYv7dYCXdIYD63HMmRXm3zNQ9EtVm0wn0zuSXgZM6jvo/m3ku22YerM
 DaeZqsUIhHNt7Q6cyr4uUegddhmlKQ6aw+Fz1aWQJDfMNOJSky5/0+JblNjDJRCSqjiRxwUtR
 rU8n3ZXF+9Ml3JIeksHgKcPbIu9Hr3Cz4yQG/vBOFYzTU3kSrQ6WS/VKiMMa1Y1zG+rEZ3Kcz
 mL1QkVoFh9of53o1Xd2oduz7yj+uuTOmj0YCvyeuncsV9C/SkewythJtXCZHBIDGVpimdGT1Y
 BLIs9rAoqEZm1+8H8q2SObtNA5UoSZEEptPYVBUL71k6DG1NKXUGPHAE084qkey2dSM8fR5E/
 Ere+QJk1BehrRq7nVpulU6gh05iEtT4JlQM2B/5OhB49v3d/O2nkjxiD6kdn6vYmn/aIzUSSr
 AMXuRoCzh2ivB3SOZ2cFzCeYsadJA5Ng/ZiZi9J1qPPqjhYxiZ3GpCDjSQom2T+ieXo2ryg4x
 K/CXUZTL581IHXS7h2l/03+b9UV0S4OyfPYqoHatXJ01YtG+nFCLuKUfXzWCm+eZzDCqgGnTm
 JRZM0uxe6Qidm4N9f5I7iRwM8/LgVPL/76wr+SO9TLxvuirnbh+ZoRP2hoWKiX2sM6zanRm1D
 kL637cQvrjB0UF8OJqdaxukftd9K4zb8kuExwjwMfC6iJhnpNmFVLKdcO4pV7mSswHU88NYjS
 uKvh5yR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the (admittedly, concocted) case that PATH consists only of colons, we
would leak the duplicated string.

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


