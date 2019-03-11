Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA0420248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCKDh5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:37:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:45378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727072AbfCKDh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:37:57 -0400
Received: (qmail 19449 invoked by uid 109); 11 Mar 2019 03:37:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Mar 2019 03:37:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19784 invoked by uid 111); 11 Mar 2019 03:38:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 10 Mar 2019 23:38:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2019 23:37:55 -0400
Date:   Sun, 10 Mar 2019 23:37:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: disabling sha1dc unaligned access, was Re: One failed self test on
 Fedora 29
Message-ID: <20190311033755.GB7087@sigill.intra.peff.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 11:00:25AM +0900, Junio C Hamano wrote:

> Jeffrey Walton <noloader@gmail.com> writes:
> 
> > I think this is the patch for sha1dc/sha1.c . It stops using unaligned
> > accesses by default, but still honors SHA1DC_FORCE_UNALIGNED_ACCESS
> > for those who want it. Folks who want the undefined behavior have to
> > do something special.
> 
> Hmph, I somehow thought that folks who want to stick to the
> standard printed on paper penalizing what practicaly works well in
> the real world would be the one doing extra things.

Unfortunately, I don't think sha1dc currently supports #defines in that
direction. The only logic is "if we are on intel, do unaligned loads"
and "even if we are not on intel, do it anyway". There is no "even if we
are on intel, do not do unaligned loads".

I think you'd need something like this:

diff --git a/Makefile b/Makefile
index 148668368b..705c54dcd8 100644
--- a/Makefile
+++ b/Makefile
@@ -1194,6 +1194,7 @@ BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
 BASIC_CFLAGS += -fno-omit-frame-pointer
 ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
+BASIC_CFLAGS += -DSHA1DC_DISALLOW_UNALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index df0630bc6d..0bdf80d778 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -124,9 +124,11 @@
 #endif
 /*ENDIANNESS SELECTION*/
 
+#ifndef SHA1DC_DISALLOW_UNALIGNED_ACCESS
 #if defined(SHA1DC_FORCE_UNALIGNED_ACCESS) || defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
 #define SHA1DC_ALLOW_UNALIGNED_ACCESS
 #endif /*UNALIGNMENT DETECTION*/
+#endif
 
 
 #define rotate_right(x,n) (((x)>>(n))|((x)<<(32-(n))))

but of course we cannot touch sha1dc/*, because we might actually be
using the submodule copy instead. And AFAIK there is no good way to
modify the submodule-provided content as part of the build. Why do we
even have the submodule again? ;P

I guess the same would be true for DC_SHA1_EXTERNAL, too, though.

So anyway, I think this needs a patch to the upstream sha1dc project.

-Peff
