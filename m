Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12122207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755273AbdEDN4D (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:56:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:56059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbdEDNz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:55:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTjMy-1dWi260Wiu-00QQlb; Thu, 04
 May 2017 15:55:46 +0200
Date:   Thu, 4 May 2017 15:55:45 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 06/25] get_mail_commit_oid(): avoid resource leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <e05ac6ff3315ad809682dafa7e4542e223df8bf5.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0sGV+1rpSd1Xtfnz7bJIFhwQcyU7fpq2zWiqPdJpOlSuMIcjff3
 dGmgLtYunZkP7PtGqSeRYpesKNjT5u9Uu16SSqC6Zjn44G0VxLLWq678Su9G0Mr1eBMIcjL
 IyQagglv5N5s3lGiuuaoikV0p54xo5sfygbsA5uKD+PlqDw/YonNU15Ao2nwI5ZXhy8CZat
 vuTPcGIIKjmkcW9PtBkXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QmTL8/7/bcw=:rtAiv4GnIZD8cQJyerqROx
 RP6SNHepUB4pACo9vkz98PpRkPprjRgkiC4OMdhwaHrjVkX0RmhUlV6M9EUjmDJrN0D0/JJpK
 4+TFm1dViKBncF+cUnX4bP0I1jfCUw70Mh3ROXRbyYCPxs4d4i7suFgxb3wVMaT/KTCpUrUdn
 1HiGqbGjYMsIICRknUpoJnoCUiORpORHw3XHjRlIijCWtFpjP2ZJRgOkpcRO10/WNu6AM56so
 LDfBLvbvzslB79N5+gAP5td03fmmtSO8ryt1mCvadsgGRZFGiOCkFcCgK8XbExOdlfKoscJsL
 1xdz6gZnloQy29V7LNc+izd/HX0YwORjlGjXfzu5m5pHKlz3Uz84ebBfv/U79vwiQA4e6mgcy
 FiUKWAFAVG1iwjBykAgcqh3B//dLNDbYMjPvfhN28/VY4w90vTD08n3rBJC5nl05ZaP1cWWGY
 YpCgRn9AjfIP7cTjypuls9S9NJGN8ijars1nVW44T8aQPNUChhpVolf/xlf1n/bG135DDqIHZ
 2LSQjTN2unsSEH0V9SbynyGBo0z158jZjc3QBxQuAfLUs0zGxMXwaBMwJShp23AbAW9VeDVGH
 neCUTmaMNPMI1jbD3fIo++NAUn+U5zgtAOFkbXCs2xM+UcGodP+ndEvi3O8cxNcVK6GSpapN8
 bKaA0gDNcSuKVz5JTnNsTAK8h4yOz8Ecz1d4gtRF0bUfiMtLl6v4LZXaCRuBOSn3Wz2TQFZtK
 PbEc2jgpAHG8x/WPcosARULofe9/diMrupIOtzAEP61tvF8wBzUqNWWCZT0Nj7/dQQffpTNhk
 klOfa5R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we fail to read, or parse, the file, we still want to close the file
descriptor and release the strbuf.

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e6c..9c5c2c778e2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1351,19 +1351,16 @@ static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
 	struct strbuf sb = STRBUF_INIT;
 	FILE *fp = xfopen(mail, "r");
 	const char *x;
+	int ret = 0;
 
-	if (strbuf_getline_lf(&sb, fp))
-		return -1;
-
-	if (!skip_prefix(sb.buf, "From ", &x))
-		return -1;
-
-	if (get_oid_hex(x, commit_id) < 0)
-		return -1;
+	if (strbuf_getline_lf(&sb, fp) ||
+	    !skip_prefix(sb.buf, "From ", &x) ||
+	    get_oid_hex(x, commit_id) < 0)
+		ret = -1;
 
 	strbuf_release(&sb);
 	fclose(fp);
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.12.2.windows.2.800.gede8f145e06


