Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3035C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBGWPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBGWPm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:15:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9F3C22
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:15:39 -0800 (PST)
Received: (qmail 13727 invoked by uid 109); 7 Feb 2023 22:15:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Feb 2023 22:15:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25327 invoked by uid 111); 7 Feb 2023 22:15:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Feb 2023 17:15:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Feb 2023 17:15:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Message-ID: <Y+LNitGAude1vogv@coredump.intra.peff.net>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
 <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
 <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
 <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
 <Y94866yd3adoC1o9@coredump.intra.peff.net>
 <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
 <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
 <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2023 at 09:39:48PM +0100, Ævar Arnfjörð Bjarmason wrote:

> *nod* I'll just note that you elided the part where I noted that I don't
> really care, and will submit some re-roll that's compatible with the
> current imap.{host,tunnel} interaction.

Yeah, sorry, I should have said "yes, thank you" there. :) I wasn't
meaning to continue arguing, but just trying to answer your "how would
they even find this?" confusion.

> I.e. if we just say that we're not going to support this use-case
> anymore we can get rid of all of the OpenSSL reliance in-tree, except
> for the optional (and hardly ever used) OPENSSL_SHA1, and
> uses-only-one-API-function "HAVE_OPENSSL_CSPRNG" use.

Yeah, getting rid of that openssl code is a reasonable goal. And this
may seem counter-intuitive, but I'm actually _more_ in favor of that
than the change you proposed here, even though it potentially breaks
more users. That's because I feel like we're buying something useful
with it, whereas with the patch we've been discussing, the tradeoff was
less clear to me.

That said, it seems like there should be a path forward for supporting
tunnels via curl, and then we could be getting rid of the openssl
dependency _and_ all of the custom and rarely-run imap code. But that's
an even bigger task, and I not only wouldn't want to work on it, I'm not
even sure I'd want to review it. I'm slightly regretting getting
involved here at all, because it seems like none of us actually care at
all about imap-send, and this has turned into a big discussion. I mostly
chimed in because it seemed like I had a perspective you didn't on how
people might use tunnels, and it felt like I should speak up for folks
whose use cases might be getting broken.

  Side note: If somebody were proposing to add imap-send at all today,
  I'd probably say "no, that should be a separate project, and you
  should probably write it in some language that has a decent imap
  library". It really has nothing at all to do with Git in terms of
  implementation, and I suspect it's not super well maintained in
  general. But perhaps it is too late for that.

> So your example of:
> 
> 	[imap]
> 	host = internal.example.com
> 	tunnel = "ssh bastion-server nc internal.example.com 143"
> 
> Would instead be:
> 
> 	1. Arrange for the equivalent of that to run outside of
> 	   git-imap-send, e.g.:
> 
> 	    ssh -N -R 1430:internal.example.com:143 bastion-server
> 
> 	2. Use "imap.host" to connect to that "remote" box with libcurl,
> 	   but just use "localhost:1430"

Having done something like that before, the "arrange" step is more
finicky than you might think (because sometimes it goes away, and you
really want to trigger it on demand).

-Peff
