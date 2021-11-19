Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC71DC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 22:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhKSWZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:25:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61000 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbhKSWZE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 17:25:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3975615AA3F;
        Fri, 19 Nov 2021 17:22:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RCE4JWJk8PzJ/RB+IB1PLqaaCZ7ZPKgyf18Nxo
        yhSz8=; b=ds8RWus1h7ASytqPxrpuLiX48/hQ0SJDHVQIgB0o/koxqdB0xTjRxS
        hJxy79iAXEAxp5PwHJCcNaBE8ZpDdCE2rcMjtCzpMFgXwaVXXn+jeeN32xSzo+Rb
        VQMqZZuIt4Qr0oolMR836Kmu6ZCCLvpqltWMd8aFrU8U49oshl0mg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32E4215AA3D;
        Fri, 19 Nov 2021 17:22:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6490615AA3B;
        Fri, 19 Nov 2021 17:21:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch-pack: ignore SIGPIPE when writing to index-pack
References: <YZgQD3lrw4+i4EMd@coredump.intra.peff.net>
Date:   Fri, 19 Nov 2021 14:21:58 -0800
In-Reply-To: <YZgQD3lrw4+i4EMd@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 19 Nov 2021 15:58:55 -0500")
Message-ID: <xmqqy25jokft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CCD3DBA-4987-11EC-AED4-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When fetching, we send the incoming pack to index-pack (or
> unpack-objects) via the sideband demuxer. If index-pack hits an error
> (e.g., because an object fails fsck), then it will die immediately. This
> may cause us to get SIGPIPE on the fetch, as we're still trying to write
> pack contents from the sideband demuxer (which is typically a thread,
> and thus takes down the whole fetch process).

So, ... we'd die anyway and won't update the refs and anything that
leaves permanent damage to the repository either way, but we choose
a better way to die by not taking SIGPIPE, but to get an error from
one of the write()s or the final close(), which will lead us to more
"controlled" death using the normal error path?

> This is mostly cosmetic. The actual error of interest (in this case, the
> object that failed the fsck check) comes from index-pack straight to
> stderr, so the user still sees it. They _might_ even see fetch-pack
> complaining about index-pack failing, because the main thread is racing
> with the sideband-demuxer. But they'll definitely see the signal death
> in the exit code, which is what the test is complaining about.

OK.

> We can make this more predictable by just ignoring SIGPIPE. The sideband
> demuxer uses write_or_die(), so it will notice and stop (gracefully,
> because we hook die_routine() to exit just the thread). And during this
> section we're not writing anywhere else where we'd be concerned about
> SIGPIPE preventing us from wasting effort writing to nowhere.

OK.

> +#include "sigchain.h"
>  
>  static int transfer_unpack_limit = -1;
>  static int fetch_unpack_limit = -1;
> @@ -956,6 +957,8 @@ static int get_pack(struct fetch_pack_args *args,
>  			strvec_push(index_pack_args, cmd.args.v[i]);
>  	}
>  
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
>  	cmd.in = demux.out;
>  	cmd.git_cmd = 1;
>  	if (start_command(&cmd))
> @@ -986,6 +989,8 @@ static int get_pack(struct fetch_pack_args *args,
>  	if (use_sideband && finish_async(&demux))
>  		die(_("error in sideband demultiplexer"));
>  
> +	sigchain_pop(SIGPIPE);
> +
>  	/*
>  	 * Now that index-pack has succeeded, write the promisor file using the
>  	 * obtained .keep filename if necessary

Thanks.
