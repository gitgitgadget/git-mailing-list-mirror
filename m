Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D09C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJUXeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJUXeO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:34:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E551D2AB11F
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:34:13 -0700 (PDT)
Received: (qmail 14979 invoked by uid 109); 21 Oct 2022 23:34:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 23:34:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18184 invoked by uid 111); 21 Oct 2022 23:34:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 19:34:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 19:34:12 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 2/4] repack: populate extension bits incrementally
Message-ID: <Y1MsdAgL8fdIRtxH@coredump.intra.peff.net>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MSkubbDBh0Ma1G@coredump.intra.peff.net>
 <Y1MpUHBQtq8uP5Uy@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MpUHBQtq8uP5Uy@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 07:20:48PM -0400, Taylor Blau wrote:

> On Fri, Oct 21, 2022 at 05:43:46PM -0400, Jeff King wrote:
> > There are two small problems with this:
> >
> >   - repack_promisor_objects() may have added entries to "names", and
> >     already called populate_pack_exts() for them. This is mostly just
> >     wasteful, as we'll stat() the filename with each possible extension,
> >     get the same result, and just overwrite our bits. But it makes the
> >     code flow confusing, and it will become a problem if we try to make
> >     populate_pack_exts() do more things.
> 
> Hmm. I agree with you that repack_promisor_objects() calling
> populate_pack_exts() itself is at best weird, and at worst wasteful.

I don't think it's weird, really. It is setting up the entries in the
string-list completely when we add them, rather than annotating later.
If there were some performance gain from doing them all at once, I could
see it, but otherwise I like that it means the entries are always in a
consistent state.

> But I'm sure future patch you're referring to cares about knowing
> these as soon as possible, since that's the point of this series ;-).

Yes. :)

> I think a reasonable middle ground here is to do something like the
> following on top of this patch:
> 
> --- >8 ---
> diff --git a/builtin/repack.c b/builtin/repack.c
> index b5bd9e5fed..16a941f48b 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1002,6 +1002,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  			return ret;
>  	}
> 
> +	for_each_string_list_item(item, &names) {
> +		if (!item->util)
> +			BUG("missing generated_pack_data for pack %s",
> +			    item->string);
> +	}
> +
>  	string_list_sort(&names);
> 
>  	close_object_store(the_repository->objects);
> --- 8< ---
> 
> which still lets you eagerly keep track of the generated pack extensions
> while also protecting against forgetful callers. Obviously we're relying
> on a runtime check which is going to be somewhat weaker. But I think

I don't think we need that. The renaming loop a few lines below will
happily segfault if anybody forgot to populate it. With a less nice
message, obviously, but if the point is to notice a bug, it will get the
job done.

-Peff
