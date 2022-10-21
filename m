Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94904C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJUWUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJUWUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:20:04 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAEBF77
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:20:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E39C159529;
        Fri, 21 Oct 2022 18:19:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yWX3wHG3DTxlQzYtGBW4a7f2HaCC4+TIUIcsll
        wXcvk=; b=hTU7gV9XTIY1rGir5bnWLtTiyAdiBiGl9uhu6tFxQtbS8bp9e0UqZK
        sgC80Z2zFsY4p50cp6R0LcdUSHEffi52F+9VNRVyXhM19/m+Qvt59N+UkBj0B8rm
        SBiKSuW8GKmOEUBkfs80QPWeoUB5CNzbSegpJnSUiRJAejSUktzvQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44412159528;
        Fri, 21 Oct 2022 18:19:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB70A159527;
        Fri, 21 Oct 2022 18:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/4] repack: convert "names" util bitfield to array
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
        <Y1MSWAx+baTklfLL@coredump.intra.peff.net>
Date:   Fri, 21 Oct 2022 15:19:55 -0700
In-Reply-To: <Y1MSWAx+baTklfLL@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 21 Oct 2022 17:42:48 -0400")
Message-ID: <xmqqtu3wizuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E753666-518E-11ED-B386-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We keep a string_list "names" containing the hashes of packs generated
> on our behalf by pack-objects. The util field of each item is treated as
> a bitfield that tells us which extensions (.pack, .idx, .rev, etc) are
> present for each name.
>
> Let's switch this to allocating a real array. That will give us room in
> a future patch to store more data than just a single bit per extension.
> And it makes the code a little easier to read, as we avoid casting back
> and forth between uintptr_t and a void pointer.
>
> Since the only thing we're storing is an array, we could just allocate
> it directly. But instead I've put it into a named struct here. That
> further increases readability around the casts, and in particular helps
> differentiate us from other string_lists in the same file which use
> their util field differently. E.g., the existing_*_packs lists still do
> bit-twiddling, but their bits have different meaning than the ones in
> "names". This makes it hard to grep around the code to see how the util
> fields are used; now you can look for "generated_pack_data".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/repack.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index a5bacc7797..8e71230bf7 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -247,11 +247,15 @@ static struct {
>  	{".idx"},
>  };
>  
> -static unsigned populate_pack_exts(char *name)
> +struct generated_pack_data {
> +	char exts[ARRAY_SIZE(exts)];
> +};

OK, so instead of a single "unsigned" word holding six bits (the
number of elements in the exts[] array), we have one byte per the
file extension.  Since ...

> +static struct generated_pack_data *populate_pack_exts(const char *name)
>  {
>  	struct stat statbuf;
>  	struct strbuf path = STRBUF_INIT;
> -	unsigned ret = 0;
> +	struct generated_pack_data *data = xcalloc(1, sizeof(*data));

... this is allocated a real piece of storage and the function
returns a pointer to it, ...

> -		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
> +		item->util = populate_pack_exts(item->string);

... we no longer need to cast but the value can go straight to the
.util member, and ...

> -	string_list_clear(&names, 0);
> +	string_list_clear(&names, 1);

... we now need to free these structs pointed at by the .util
member.

All make sense.
