Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D2B20285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbdH3SU3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:20:29 -0400
Received: from mout.web.de ([212.227.15.14]:62416 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752674AbdH3SUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:20:18 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M09z2-1dWqCa3GAu-00uIWj for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:20:16 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 31/34] utf8: release strbuf on error return in strbuf_utf8_replace()
Date:   Wed, 30 Aug 2017 20:20:16 +0200
Message-Id: <20170830182016.21269-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:BBjQIE3w1021CV0caC5ywIuB3v+YtrBeTJR+X706lWtu0My7JcH
 XKMxfAb5CdKD2NXfoIVS1Z6NXwMUMcujRRBNyWhGR4m27qun0tTJBcLwNLvLThucjpKPf7g
 3I43tLfhCqJD+XQVtPZ4DEFqNsxDmyfBqcC8uFb7lDT/2kTy6atkhysWwi/tXleqwPDuwGg
 8eHbmm779x2WIxBxYUIVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PWuHNR1iuko=:nRWAoB9rv1zmXd3dzliHNa
 J+v49IFFwxbcX5p5h4cxYG/mRpATud6or5ZhYY7l1IVvPk4ePQKuiip7xKbEA8TOeaB1wb734
 GrQF0X8T9zoVlLWfbmyxCwQByOF0LwtrfPubrri31Iz7iGfvTfqM8K7+RGBrfC6WjG+EHHF1o
 tscRm8qrRh8mfa9d4MSBUtV0X7m0rzmncOKwPfYZcQJ3IEN5/om2FlTxTnOTNdfzal1hM2Y3B
 qr2NW6bbiH0ViiGTNAEXAKy2ziZXfVwyIeAqqxGyhU8cgH7RXBfylpAmj7mNuqkiSl9gjk0ta
 rl/x0CxF3oXwcHi3VV0F5qSWdlM6Z+Fb2C6SvrUPXYb3tTja/f8ofTyrNrSSlKJ4M3ugRuz+U
 q+ec8NoSkTGTEsJjyzbsGwRknIvZRD/foGE5VRyjRyIDh9Bq3MWWtj0LIzkh+v9BjizpboXHX
 JNdW6S87BKcAhqMcXiwXSZyCYCaqZNRUuWuum/KzldKEK+SUNQHKwUUu6WxT8jdfVewGl1Ult
 1u/P3uH/Ne8rZWPMMa8X7+XNgZSthL5WSwF6HGVJ8r3Lp+PDP9xAySkIavSsD7Eq0hTB3rCJT
 ggOuahJxenZlO3w+l0AFrlEdypJzYaDwq7+JY4grfcYyerfmSWwMWBPg+AzFXAnGzoOY600J4
 chIICgZPAPX0dKwuzZfDe0FjJCXVKP7rigH+VOPLZuZ8x8fefxhumUDhl5R+AP3DTEDTXbyhj
 fX4rTl758ddV3F83/ju4+3v/B9kdApyFRgdLSDoQWZYv0SHuPWCUPp38xopovFktiPLQ2mWUI
 CfBk/xGbyycPssBtooY1xoWfegMSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 utf8.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utf8.c b/utf8.c
index 0c8e011a58..47a42047c8 100644
--- a/utf8.c
+++ b/utf8.c
@@ -354,49 +354,50 @@ void strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
 void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 			 const char *subst)
 {
 	struct strbuf sb_dst = STRBUF_INIT;
 	char *src = sb_src->buf;
 	char *end = src + sb_src->len;
 	char *dst;
 	int w = 0, subst_len = 0;
 
 	if (subst)
 		subst_len = strlen(subst);
 	strbuf_grow(&sb_dst, sb_src->len + subst_len);
 	dst = sb_dst.buf;
 
 	while (src < end) {
 		char *old;
 		size_t n;
 
 		while ((n = display_mode_esc_sequence_len(src))) {
 			memcpy(dst, src, n);
 			src += n;
 			dst += n;
 		}
 
 		if (src >= end)
 			break;
 
 		old = src;
 		n = utf8_width((const char**)&src, NULL);
 		if (!src) 	/* broken utf-8, do nothing */
-			return;
+			goto out;
 		if (n && w >= pos && w < pos + width) {
 			if (subst) {
 				memcpy(dst, subst, subst_len);
 				dst += subst_len;
 				subst = NULL;
 			}
 			w += n;
 			continue;
 		}
 		memcpy(dst, old, src - old);
 		dst += src - old;
 		w += n;
 	}
 	strbuf_setlen(&sb_dst, dst - sb_dst.buf);
 	strbuf_swap(sb_src, &sb_dst);
+out:
 	strbuf_release(&sb_dst);
 }
 
-- 
2.14.1

