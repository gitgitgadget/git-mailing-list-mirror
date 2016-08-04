Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0430F20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933460AbcHDQH0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:07:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:63692 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756858AbcHDQHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:07:24 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ma1tv-1bpLQh3SCF-00Lkuv; Thu, 04 Aug 2016 18:07:08
 +0200
Date:	Thu, 4 Aug 2016 18:07:08 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
In-Reply-To: <cover.1470326812.git.johannes.schindelin@gmx.de>
Message-ID: <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qITfmTxOwmsBEGlvEEeuCz/ekhce4AgflBTGq9Y2jqjvtNFClFk
 CRmwAk3aKDUpv95f96XhU+WgK7VUMtloxgkXoDO1zjUzshssbAhdf03pgsa+8S0Z7SNGcR4
 Nf5hRPJF/HmlC+k3L/1oOctCepCx2iAfY+4MF9UUag2WpdPRytXXHPk+qsy7WjpJJjwfZFu
 vaNCuYABhdG2D5TmHgJkA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2OGQHBrCM4c=:CLlxDNEv2qTiatfgHJ+HcA
 9aVuvYh1fLFRgRRSxtAgFH1+GmOYcOgPzo6lxNFvjylgrm7PH4WIhQE6GzTFixZb/DMSajHfw
 5ZopXRPM4zhEkOlSyKa4MJ8DfZWi6lFL36sTzhOHRvXpVWr271/rTTfGt4M4CxhjcN+35ey9c
 YieZKXxhcwi+14qFhddG/WQqFrHF8MU7QT6wWBEOSDcB3vN/sMJHFdVtU7FS0y8HCIvchUXn6
 4u5XfKrEFqNrzWKmimC03bduhvSdFC/HgUxZgrUBQI1lkDAcJpIW/Dlo4/PITtb8PcB+Pw91Q
 nZeRwsBMXJdC4zNUmtSyxWZ+UE6DlZnSrfwWwo408LYyBPUrRKeECqo3hPRLFiR73dWw5FhTw
 sCfHWQfMXtcobfapIWQxQVAFaQ+6hPtMtMT99Xj5Fv3ltqqT0H8AKpKtICRUtHwMKc/flBXP7
 XDswB3jWozmeoCEZIPKkbMtl3ypSeuNdgsYKnvs6iwSLzJV1O+AkuUFyx6KMl9oq/fRedvkhl
 x4K8seEm9tWf9sRhRaKSIPZ51aqhUgcXRrkAkEYXHINJ1+n5bdUwjZFsPRjXtclddAp+Jw9g4
 mtQj1bff/FKI9Ok3bM41mnjpicnTg/4Hd3c/Vcuz1aFmk7wkhxWfR/IxZQsf/RT7piDFz0eEV
 72YYR9avtTErWQCGh8deo/EcaEHaxNU7Ol3C4me/evw8Es/e9oAHg9RQgyOAD8jGpAdB2A54E
 mlCsS4Pi06eN4A72R9VIFvC5IvA8QwZ2ykalZNovhsd07sIQ53REKCZ1dAsnVb/h0Oc6x04N4
 j/zsonK
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

With GCC 6, the strdup() function is declared with the "nonnull"
attribute, stating that it is not allowed to pass a NULL value as
parameter.

In nedmalloc()'s reimplementation of strdup(), Postel's Law is heeded
and NULL parameters are handled gracefully. GCC 6 complains about that
now because it thinks that NULL cannot be passed to strdup() anyway.

Let's just shut up GCC >= 6 in that case and go on with our lives.

See https://gcc.gnu.org/gcc-6/porting_to.html for details.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/nedmalloc/nedmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 677d1b2..3f28c0b 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -956,6 +956,9 @@ void **nedpindependent_comalloc(nedpool *p, size_t elems, size_t *sizes, void **
 char *strdup(const char *s1)
 {
 	char *s2 = 0;
+#if __GNUC__ >= 6
+#pragma GCC diagnostic ignored "-Wnonnull-compare"
+#endif
 	if (s1) {
 		size_t len = strlen(s1) + 1;
 		s2 = malloc(len);
-- 
2.9.0.281.g286a8d9
