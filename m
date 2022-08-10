Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B775C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiHJVUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiHJVUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:20:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C19BC3
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:20:30 -0700 (PDT)
Received: (qmail 6915 invoked by uid 109); 10 Aug 2022 21:20:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 21:20:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15703 invoked by uid 111); 10 Aug 2022 21:20:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 17:20:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 17:20:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v4] rev-list: support human-readable output for
 `--disk-usage`
Message-ID: <YvQhHOkjZatIqlFr@coredump.intra.peff.net>
References: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
 <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
 <xmqqlerwm28n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlerwm28n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 10:34:32AM -0700, Junio C Hamano wrote:

> > +static void print_disk_usage(off_t size)
> > +{
> > +	struct strbuf sb = STRBUF_INIT;
> > +	if (human_readable)
> > +		strbuf_humanise_bytes(&sb, size);
> > +	else
> > +		strbuf_addf(&sb, "%"PRIuMAX, (uintmax_t)size);
> > +	puts(sb.buf);
> > +	strbuf_release(&sb);
> > +}
> 
> Hmph, I am not sure if we want to make it a helper like this.  The
> normal case does not need to prepare the string into a strbuf but
> just can send the output to the standard output stream.
> 
> It is probably easy to fix, like so:
> 
> 	if (!human_readable) {
> 		printf("%" PRIuMAX "\n", disk_usage);
> 	} else {
> 		strbuf sb = STRBUF_INIT;
> 		strbuf_humanise_bytes(&sb, disk_usage);
> 		puts(sb.buf);
> 		strbuf_release(&sb);
> 	}

It was my suggestion to turn it into a helper, because the same code
needs to be present in two distant spots (the bitmap and non-bitmap
cases).

I don't care much between "printf directly vs strbuf" for the non-human
case, but it was an earlier review suggestion to connect them. I do
think the result is a little easier to follow, but mostly I want to make
it clear that the author is getting stuck between warring review
comments here. ;)

> > @@ -481,8 +495,8 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
> >  	if (!bitmap_git)
> >  		return -1;
> >  
> > -	printf("%"PRIuMAX"\n",
> > -	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
> > +	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
> > +	print_disk_usage(size_from_bitmap);
> 
> It makes sense to make the function declare how it gets disk usage
> in its name, but once we call the function to get what we want,
> there is no need to keep saying we got it from bitmap.  If we ever
> gained another function that obtains the disk usage from other
> means, then this part of the code would become

Keep in mind that we are in try_bitmap_disk_usage() here. :) There is
indeed similar code to use other means, but it's far away, and this code
will always use bitmaps.

That said, I'd have just written:

  print_disk_usage(get_disk_usage_from_bitmap(bitmap_git, revs));

since the variable is not otherwise used. But arguably that's harder to
read.

-Peff
