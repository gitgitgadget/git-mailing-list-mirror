Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A661F461
	for <e@80x24.org>; Fri,  6 Sep 2019 16:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbfIFQ7I (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 12:59:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51808 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfIFQ7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 12:59:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4527431602;
        Fri,  6 Sep 2019 12:59:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YD4TSyeVQE8HbQzpubrh4tF1uSA=; b=gO0BGz
        Vbj/0CvHCVOe/EdqlarUItG9myiTmYmftCITtlFuAAer6wdMKtJlw9OLmFeo7URX
        rwMfiZ5vFcQDfSkFzA9E0X1mtKeIwxFtLWjNfEcaBmkzmfbifs7h9Zs0dVsotrHc
        152mW6Hv9+hAYVsoaz/Q1b0U0+StJotfvna+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=INkevrUGGjVsTx2yYe5tplcjLvyZCYLx
        ja/ihq88mUwp1Cys9R6UmywI4mdTlLPnYiQDAwWH02/06glGRdI7Ms5KRCuT9t75
        k7Q77i7j3ASy32Dmsh6sFKhd7aXqwxk4HPhCMVOEdnzRFJuKAUC2IgbdaTw1mNgo
        Kc1TzescRZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37E0431601;
        Fri,  6 Sep 2019 12:59:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75E75315FF;
        Fri,  6 Sep 2019 12:59:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
References: <cover.1567563244.git.me@ttaylorr.com>
        <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
        <20190904030456.GA28836@sigill.intra.peff.net>
        <xmqqsgpao06z.fsf@gitster-ct.c.googlers.com>
        <20190906063503.GB5122@sigill.intra.peff.net>
Date:   Fri, 06 Sep 2019 09:59:04 -0700
In-Reply-To: <20190906063503.GB5122@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 6 Sep 2019 02:35:03 -0400")
Message-ID: <xmqqk1alnyxz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2822DA2-D0C7-11E9-9319-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So far so good. But now imagine we call parse_commit_buffer() again, and
> we re-parse. How does that interact with the half-parsed state? Some of
> it works OK (e.g., lookup_tree() would find the same tree). Some not so
> much (I think we'd keep appending parents at each call).
>
> I guess this might not be too bad to handle. Value fields like
> timestamp_t are OK to overwrite. Pointers to objects likewise, since the
> memory is owned elsewhere. If we see existing parent pointers in an
> object we're parsing, we could probably free them under the assumption
> they're leftover cruft. Likewise for the "tag" field of "struct tag",
> which is owned by the struct and should be freed.

Yeah, or clear them before returning with .corrupt bit set?
