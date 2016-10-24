Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C865320193
	for <e@80x24.org>; Mon, 24 Oct 2016 21:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbcJXVgf (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 17:36:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62626 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751096AbcJXVgf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 17:36:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC8CF48654;
        Mon, 24 Oct 2016 17:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0kYVmryLQxbFvIcvtYunPPUM6+0=; b=IutULi
        b9kHoPTli6lCWt2IrUPajpE6rH9Cm+9nnHZuwJ/E1MHgO2W3IDtXRRtgpYwR0632
        JiZJ+m4k3p3POz/OFgKtiMxm1dHVJfEsh3q+6o1nyOD1nkbsM1dMzfxbilNw7tQG
        Mrlb4J11l2yi2CDHh8QytsnzoXrPS5k1q9WqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T5oOqjmo85ggWRd7VyXiDAWZrfgU8xUM
        Pga8gsRkxVE9W+Z5FJB4RF61uqfeOkPMT2MxmsKWlYEJOdyxVA2VzAfzxEN2Y95D
        IYfubvfQS+n5tYHWIE5nNRGm00nxe3ZoPPdYKTsNZgVoe89qJElxwGgPSvgOPCkP
        qmQN9b079SQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E265B48653;
        Mon, 24 Oct 2016 17:36:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6278F48652;
        Mon, 24 Oct 2016 17:36:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: revisiting zstd timings
References: <20161023080552.lma2v6zxmyaiiqz5@sigill.intra.peff.net>
Date:   Mon, 24 Oct 2016 14:36:31 -0700
In-Reply-To: <20161023080552.lma2v6zxmyaiiqz5@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 23 Oct 2016 04:05:52 -0400")
Message-ID: <xmqqh981too0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEF029F2-9A31-11E6-95F5-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we were designing git today, it seems like a no-brainer to use zstd
> over zlib. But given backwards-compatibility issues, I'm not sure.
> 10-20% speedup on reading is awfully nice, but I don't think there's a
> good way to gracefully transition, because zlib is part of the
> on-the-wire format for serving objects. We could re-compress on the fly,
> but that gets expensive (in existing cases, we can quite often serve the
> zlib content straight from disk, but this would require an extra
> inflate/deflate. At least we wouldn't have to reconstitute objects from
> deltas, though).
>
> A transition would probably look something like:
>
>   0. The patch below, or something like it, to teach git to read both
>      zlib and zstd, and optionally write zstd. We'd probably want to
>      make this an unconditional requirement like zlib, because the point
>      is for it to be available everywhere (I assume the zstd code is
>      pretty portable, but I haven't put it to the test).
>
>   1. Another patch to add a "zstd" capability to the protocol. This
>      would require teaching pack-objects an option to convert zstd back
>      to zlib on the fly.
>
>      Servers which handle a limited number of updated clients can switch
>      to zstd immediately to get the benefit, and their clients can
>      handle it directly. Likewise, clients of older servers may wish to
>      repack locally using zstd to get the benefit. They'll have to
>      recompress on the fly during push, but pushes are rare than other
>      operations (and often limited by bandwidth anyway).
>
>   2. After a while, eventually flip the default to zstd=5.
>
>   3. If "a while" is long enough, perhaps add a patch to let servers
>      tell clients "go upgrade" rather than recompressing on the fly.
>
> I don't have immediate plans for any of that, but maybe something to
> think about.

Thanks for a write-up.  This is quite interesting.

Thanks to d98b46f8d, this does not have to impact the object naming
;-)

