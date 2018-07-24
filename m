Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DD51F597
	for <e@80x24.org>; Tue, 24 Jul 2018 09:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbeGXKcy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 06:32:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:57184 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388211AbeGXKcx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 06:32:53 -0400
Received: (qmail 7699 invoked by uid 109); 24 Jul 2018 09:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 09:27:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25640 invoked by uid 111); 24 Jul 2018 09:27:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 05:27:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 05:27:19 -0400
Date:   Tue, 24 Jul 2018 05:27:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] banned.h: mark sprintf() as banned
Message-ID: <20180724092719.GC3288@sigill.intra.peff.net>
References: <20180724092329.GA24250@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724092329.GA24250@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sprintf() function (and its variadic form vsprintf) make
it easy to accidentally introduce a buffer overflow. If
you're thinking of using them, you're better off either
using a dynamic string (strbuf or xstrfmt), or xsnprintf if
you really know that you won't overflow. The last sprintf()
call went away quite a while ago in f0766bf94e (fsck: use
for_each_loose_file_in_objdir, 2015-09-24).

Note that we respect HAVE_VARIADIC_MACROS here, which some
ancient platforms lack. As a fallback, we can just "guess"
that the caller will provide 3 arguments. If they do, then
the macro will work as usual. If not, then they'll get a
slightly less useful error, like:

  git.c:718:24: error: macro "sprintf" passed 3 arguments, but takes just 2

That's not ideal, but it at least alerts them to the problem
area. And anyway, we're primarily targeting people adding
new code. Most developers should be on modern enough
platforms to see the normal "good" error message.

Signed-off-by: Jeff King <peff@peff.net>
---
 banned.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/banned.h b/banned.h
index 32e0bae01d..c83d6cb9df 100644
--- a/banned.h
+++ b/banned.h
@@ -15,4 +15,14 @@
 #undef strcat
 #define strcat(x,y) BANNED(strcat)
 
+#undef sprintf
+#undef vsprintf
+#ifdef HAVE_VARIADIC_MACROS
+#define sprintf(...) BANNED(sprintf)
+#define vsprintf(...) BANNED(vsprintf)
+#else
+#define sprintf(buf,fmt,arg) BANNED(sprintf)
+#define vsprintf(buf,fmt,arg) BANNED(sprintf)
+#endif
+
 #endif /* BANNED_H */
-- 
2.18.0.542.g2bf2fc4f7e

