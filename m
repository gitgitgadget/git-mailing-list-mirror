Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A333202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 16:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbdCOQCK (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 12:02:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:44619 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754004AbdCOQAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 12:00:52 -0400
Received: (qmail 13134 invoked by uid 109); 15 Mar 2017 15:59:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 15:59:55 +0000
Received: (qmail 22169 invoked by uid 111); 15 Mar 2017 16:00:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 12:00:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 11:59:52 -0400
Date:   Wed, 15 Mar 2017 11:59:52 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Florian Adamus <florian-adamus@gmx.de>, git@vger.kernel.org
Subject: Re: Commiting files larger than 4 GB on Windows
Message-ID: <20170315155952.x2tpiudi6rbqidvi@sigill.intra.peff.net>
References: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66>
 <179b5d92-ee96-c2df-dbd8-eb96f7bbdb24@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179b5d92-ee96-c2df-dbd8-eb96f7bbdb24@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 02:48:57PM +0100, Thomas Braun wrote:

> I can not comment on the git-lfs issues. The issue that you can not
> properly use files larger than 4GB on windows (no matter if 32bit or
> 64bit) is known, see my findings from May last year [1]. Unfortunately
> nobody, including me, did find time to fix the underlying issue
> properly.

I suspect the fix is going to be quite involved. The use of "unsigned
long" for object sizes is all over the code base.

> My band-aid patch from [1]
> 
> diff --git a/pack-write.c b/pack-write.c
> index 33293ce..ebb8b0a 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -313,6 +313,9 @@ int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned
>         if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
>                 die("bad type %d", type);
> 
> +       if (bitsizeof(unsigned long) != bitsizeof(uintmax_t) && size > (unsigned long) size)
> +               die("Cannot handle files this big");
> +
>         c = (type << 4) | (size & 15);
>         size >>= 4;
>         while (size) {
> 
> would at least tell the user much earlier about the problem. I can
> submit the above diff as proper patch if it is deemed a worthy change.

I agree that detecting the situation in the meantime is a good idea.
The patch above probably handles the bulk-checkin code path, I'd guess.
It might be nice to have similar checks in other places, too:

  - when reading from an existing packfile

    Looks like we may already have such a check in
    unpack_object_header_buffer().

  - when taking in new objects via index-pack or unpack-objects (to
    catch a fetch of a too-big object)

    I think index-pack.c:unpack_raw_entry() would want a similar check
    to what is in unpack_object_header_buffer().

-Peff
