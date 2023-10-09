Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17A5CD6114
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377874AbjJIRZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377369AbjJIRZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:25:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD1DE
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:25:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CBD81E686;
        Mon,  9 Oct 2023 13:24:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=QdugviaAZPBqs9ZHpkR487y6C7WVJxDo5p3jtz
        Rcmnw=; b=tFsUP8WFWyIIAdGvdzmWu7dNuZlRqs1l1KC70JNYGxF+ZP5OsBJlHj
        Yuh0Q2ndrz5ZY8UfDt8KEnSAxRyLDlCyhZsT/RHX0mNUySL7xYxYPFVQoKH8fdbC
        ULT7wcgod/0+8p170E272SgzEacTLb0J/I7oNGGVYw1Trk3mCe0SY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 046611E685;
        Mon,  9 Oct 2023 13:24:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 97B1E1E682;
        Mon,  9 Oct 2023 13:24:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
        git@vger.kernel.org, "Eric W. Biederman" <ebiederm@gmail.com>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
In-Reply-To: <20231008173329.GA1557002@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 8 Oct 2023 13:33:29 -0400")
References: <cover.1696629697.git.me@ttaylorr.com>
        <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
        <xmqqil7j751u.fsf@gitster.g> <ZSCR7e6KKqFv8mZk@nand.local>
        <CABPp-BE+mJ4e==fWNqUNi5RVkoui_xeZN+axnM6vBykDqAzHiA@mail.gmail.com>
        <ZSLS9G1lHruig48a@nand.local>
        <20231008173329.GA1557002@coredump.intra.peff.net>
Date:   Mon, 09 Oct 2023 10:24:54 -0700
Message-ID: <xmqqy1gb1zfd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C39C8DAC-66C8-11EE-A04F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Yes, the bulk-checkin mechanism suffers from an even worse problem which
>> is the pack it creates will contain no deltas whatsoever. The contents
>> of the pack are just getting written as-is, so there's no fancy
>> delta-ficiation going on.
>
> I wonder how big a deal this would be in practice for merges.
> ...

Thanks for your experiments ;-)

The reason why bulk-checkin mechanism does not attempt deltifying
(as opposed to fast-import that attempts to deltify with the
immediately previous object and only with that single object) is
exactly the same.  It was done to support the initial check-in,
which by definition lacks the delta opportunity along the time axis.

As you describe, such a delta-less pack would risk missed
deltification opportunity when running a repack (without "-f"), as
the opposite of the well known "reuse delta" heuristics, aka "this
object was stored in the base form, it is likely that the previous
pack-object tried but did not find a good delta base for it, let's
not waste time retrying that" heuristics would get in the way.

