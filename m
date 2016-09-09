Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F311F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbcIIOiM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:38:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:52909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbcIIOiK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:38:10 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Meh8S-1bOVg60S3k-00OFpl; Fri, 09 Sep 2016 16:37:58
 +0200
Date:   Fri, 9 Sep 2016 16:37:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 15/17] sequencer: lib'ify fast_forward_to()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <5da26b12bcc1a118c32c52f452aaac879f848543.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9mp8sniFLjt3EEltItksaK21mOzty52juYIo958K0xSUG/fm0w7
 AQvENqYROqT8WGdcb1lNPMO7skuvxpYJpIAOU6AN7gF/6cg7piV7VDlSnN8zkfDDQmn9HAP
 pB6BsEy/VOL7Hf8rSqs8qmVpArAwAmykEB5nFBl2jgmhjjOvxUX7JNGegS/Vcu5mbGGgdrw
 qH2cZM6/jdIUBw6didAjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jnBMb/NDFJQ=:dPhT8r0/sI+4ypnd0RyNeW
 hKVA/zMwP7zL5V0aDVF8IxEbdnrBjRGU4reh7lOa2Wh7JImvN6U11kVtLLjf1j2pGciYQeyzy
 +labGtMme7qR7Nfra+LUIXKC1yRuwhfJQfCSRZV7ThwTAUNe4Y6d4b3FS9sDTlhqP4jlQpGqx
 UW0TqwRCC7j3VrM+/5Qfumgw5HlE5jxBBwmLg5XP6uNy8Xj9pG0vxebYa6lqjQz9aY2uIZe4c
 wSl3GA3FiK00iav1w4WngQ8GN0Kh+m+r+ExF9TjZ5lcKslTfuFRAh20/lgYag24Yxvy0sq0hz
 wBbyRNbNiZ/gqQvOTP+9v4j31z79p8v4Rn+Kx6Cy+RqO5egNraauDkvewI3hsmD/hgkdQD3zI
 Fgkcy9lxlJZVlTFcyhSItAXbi39LVo2XSaRdQmWFN0QCBWaP92wTodsQaD64IPyo5HRhsl+x6
 3NSqIcr26GrsING6FqAT/dodbrCLZ2NAwg65r1yMJa87sbAq6WD4Pc9W31R1nJqHkaLmcMHbh
 ZLs9Et6ybrJneLTM8i5f9aMRtObjYxqL+tK1MX7VsSc16hKQu9/awvmmzILjFLjUFtwsEh4+Q
 8K+X3eRKL0mh81Ig/HBlxKfanPylkOjN5Yv9310cVa7dzQ13FG61+33i72XE23h3PwGMTaMWr
 YNXaHhuG7fbIoyknhMrrfqR5RrNdQ211v4n4C1BySZ1glBRGj7lfrxN1C0KvqPa8ixgm/38QD
 3g+GQjaVNH3WvJZGrFCzz8HAiYIyXnPN4K8T2Ce5mnT8jguG1GPzOy7IFeDdAcDwgk/BsJ5Tb
 GDD9n2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The only caller of fast_forward_to(), do_pick_commit() already checks
the return value and passes it on to its callers, so its caller must
be already prepared to handle error returns, and with this step, we
make it notice an error return from this function.

So this is a safe conversion to make fast_forward_to() callable from
new callers that want it not to die, without changing the external
behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 021ddf3..d92a632 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -226,7 +226,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
-		exit(128); /* the callee should have complained already */
+		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
 
-- 
2.10.0.windows.1.10.g803177d


