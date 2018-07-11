Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927FE1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 14:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbeGKOca (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 10:32:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:55220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387949AbeGKOca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 10:32:30 -0400
Received: (qmail 10458 invoked by uid 109); 11 Jul 2018 14:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 14:27:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7366 invoked by uid 111); 11 Jul 2018 14:27:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 10:27:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 10:27:52 -0400
Date:   Wed, 11 Jul 2018 10:27:52 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 6/9] gpg-interface: do not hardcode the key string len
 anymore
Message-ID: <20180711142751.GF23835@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
 <20180710154931.GA23624@sigill.intra.peff.net>
 <20180711105459.57ed99cc@md1pvb1c.ad001.siemens.net>
 <20180711123425.GB23835@sigill.intra.peff.net>
 <20180711154619.7b574dff@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711154619.7b574dff@md1pvb1c.ad001.siemens.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 03:46:19PM +0200, Henning Schild wrote:

> > I think it's worth addressing in the near term, if only because this
> > kind of off-by-one is quite subtle, and I don't want to forget to deal
> > with it. Whether that happens as part of this patch, or as a cleanup
> > before or after, I'm not picky. :)
> 
> I get that and if anyone is willing to write that code, i will base my
> patches on it. What i want to avoid is taking responsibility for
> problems i did not introduce, just because i happen to work on that
> code at the moment. Keeping track of that (not forgetting) is also not
> for the random contributor like myself.

It doesn't make sense to do a patch before your series, since it would
just be:

  if (strlen(found) > 16)
    ...

which would get obliterated by your patch. The patch after is shown
below. But frankly, it seems a lot easier to just handle this while you
are rewriting the code.

-- >8 --
Subject: [PATCH] gpg-interface: handle off-by-one parsing gpg output

When parsing gpg's VALIDSIG lines, we look for a space
followed by the signer information. Because we use
strchrnul(), though, if the space is missing we'll end up
pointing to the trailing NUL. When we try to move past that
space, we have to handle the NUL case separately to avoid
accidentally stepping out of the string entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index bf8d567a4c..139b0f561e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -97,7 +97,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 			sigc->key = xmemdupz(found, next - found);
 			/* The ERRSIG message is not followed by signer information */
 			if (sigc-> result != 'E') {
-				found = next + 1;
+				found = *next ? next + 1 : next;
 				next = strchrnul(found, '\n');
 				sigc->signer = xmemdupz(found, next - found);
 			}
-- 
2.18.0.400.g702e398724

