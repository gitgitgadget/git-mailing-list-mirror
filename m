Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A1420D09
	for <e@80x24.org>; Sun, 16 Apr 2017 16:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756486AbdDPQz6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 12:55:58 -0400
Received: from mout.web.de ([217.72.192.78]:57195 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756312AbdDPQz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 12:55:56 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOL4-1ceR7b00YQ-00Nfnz; Sun, 16
 Apr 2017 18:55:49 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] files_for_each_reflog_ent_reverse(): close stream and free
 strbuf on error
Message-ID: <a77dfa47-3153-3f8c-3c37-30147f93e61b@web.de>
Date:   Sun, 16 Apr 2017 18:55:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:fIkY5pxflx9a0Glrn0ATV8TkXlfLWYrAB7ne4dal/NzMoeUiJnq
 Fz/yE8kmUoIJj9Z+Kmp4+wpt2hJxPXqGYjqwcs7LUkZYI4hv1+p4EF63F3OXid4CZZaBPnG
 YrpiSFBzR1Yp1mP+gpmww2jXtayU/xh6KhoOkeG9vqxsibmifA74lGGzQB2oHbCWkbi+z3M
 MR96iRQH4bUB6bO6rY19A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/q13WaI8m8E=:m5gHF/7sHI8LV3lnDolVQA
 Nm0QeReO6Ep8RhflKEVvuPZ+3tOku+EwQszMEXA+s6JnrPSm/00pSO11Vb2Sfy3O6LH1xy2pu
 57wc6qTiXYlCwXJbqwst9XASB4KTJTQQWVsfHSVbqN0DlNbib6O81+WKY7SgI/hIIltPJDvYW
 evNGI8g998p5Xrl5M/5RgPeseG7U73y74b6NxE0raXfqyKiIhrRguokRGsB7hmBVUj9J9Dk5I
 oSivjeXol36MdtHxNHp/1exaAT5JjaUR05bZm3BodMN23E/waKZDkGb73VnCQ8vs1k8BxCbb1
 kC5RDpEHR0h39hjrGn6uNoNVomUESSo1j8CoKhxn1aqnSnc1M1xu8lj2rA0enTNOpe/njlQVs
 lqquWlL89xTvalVqjpLMAxmG/bhRl1xSdb0jNPkBsWrZ9lVytD0qrIjarHWdcMdAYfWINDvfh
 Tg3NPgTrBzWFrXDMInB5nZ0n2iwabVCTkAMGtD7REiI6SNJceH3UWU9Ezm/wPpCIX/z9od47o
 1+61O3a9HDTBwn/zY0Mo2/ykKawykUAkV8qi7IGxIwc6kA0/tZNm4HNPaYOejc5cbSx04ysD+
 EnsjPhCJL6pshbntKtIubSuJB36xXo6J50RBaw+M/17Dom14p3JftcN8QdbiBNw32vPKVt3qk
 w0p5IpHe5WB64WPMlesZbEBe0CeXxiOYfW66wHTgWRWDYLoWSw5eCygc61QNYn9SjvXr0jhKZ
 6CRSeEEsggoMOI7d9A6E3V7/cilV1HKaq6VZZqNpIJQNT6FDu8Gvc30oCY9f/lsoXKX7kijrR
 UmIUUYk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exit the loop orderly through the cleanup code, instead of dashing out
with logfp still open and sb leaking.

Found with Cppcheck.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 refs/files-backend.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50188e92f9..2889f21568 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3159,8 +3159,8 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 
 	/* Jump to the end */
 	if (fseek(logfp, 0, SEEK_END) < 0)
-		return error("cannot seek back reflog for %s: %s",
-			     refname, strerror(errno));
+		ret = error("cannot seek back reflog for %s: %s",
+			    refname, strerror(errno));
 	pos = ftell(logfp);
 	while (!ret && 0 < pos) {
 		int cnt;
@@ -3170,13 +3170,17 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 
 		/* Fill next block from the end */
 		cnt = (sizeof(buf) < pos) ? sizeof(buf) : pos;
-		if (fseek(logfp, pos - cnt, SEEK_SET))
-			return error("cannot seek back reflog for %s: %s",
-				     refname, strerror(errno));
+		if (fseek(logfp, pos - cnt, SEEK_SET)) {
+			ret = error("cannot seek back reflog for %s: %s",
+				    refname, strerror(errno));
+			break;
+		}
 		nread = fread(buf, cnt, 1, logfp);
-		if (nread != 1)
-			return error("cannot read %d bytes from reflog for %s: %s",
-				     cnt, refname, strerror(errno));
+		if (nread != 1) {
+			ret = error("cannot read %d bytes from reflog for %s: %s",
+				    cnt, refname, strerror(errno));
+			break;
+		}
 		pos -= cnt;
 
 		scanp = endp = buf + cnt;
-- 
2.12.2

