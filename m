Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B78F1F461
	for <e@80x24.org>; Fri, 17 May 2019 03:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfEQDZy (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 23:25:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58930 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfEQDZy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 23:25:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B7B57A2AF;
        Thu, 16 May 2019 23:25:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NjT5wzjV55VoeODnr3fHuVlMHaw=; b=E3pR8c
        UiL4y6LcdkVSZlYUL3ESmNXQp7BfM7CIGeXBScGOz4RMG2FNbML90K5oZ6QjF2kH
        +42qXGTYUrdOmPlHi4mYjuiA4XI4wjEYH2/8DoTXJ1vG4otCS8mZusSmcxQemyNT
        61IsRcgamCBL7Pzvu/yslrz9yO3f31CuiJC6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O12lhWLyoE97gpGBKlr8lV4eB+EFw9uj
        w6NcbIFTxEPJHRfA9D7eicvF3kat0mu6hDo3gfj2ahVtPSEaQzsuXeWRYGtRJXSe
        IZV228CBLXGlTywDpbvujIVmnSFedPnA0nPIbZwgMwgFj7CLzytr7u8bulawKLIy
        cFIsxIJJpqs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 539F57A2AE;
        Thu, 16 May 2019 23:25:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 839197A2AD;
        Thu, 16 May 2019 23:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        matvore@comcast.net
Subject: Re: [RFC PATCH 3/3] list-objects-filter: implement composite filters
References: <20190514001610.GA136746@google.com>
        <cover.1558030802.git.matvore@google.com>
        <02a8c9b017d8df056d7e90aff907d6e0b5506467.1558030802.git.matvore@google.com>
Date:   Fri, 17 May 2019 12:25:47 +0900
In-Reply-To: <02a8c9b017d8df056d7e90aff907d6e0b5506467.1558030802.git.matvore@google.com>
        (Matthew DeVore's message of "Thu, 16 May 2019 11:56:51 -0700")
Message-ID: <xmqqwoip3gp0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7797ABB6-7853-11E9-A404-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> Allow combining filters such that only objects accepted by all filters
> are shown. The motivation for this is to allow getting directory
> listings without also fetching blobs. This can be done by combining
> blob:none with tree:<depth>. There are massive repositories that have
> larger-than-expected trees - even if you include only a single commit.
>
> The current usage requires passing the filter to rev-list, or sending
> it over the wire, as:
>
> 	combine:<FILTER1>+<FILTER2>
>
> (i.e.: git rev-list --filter=combine:tree:2+blob:limit=32k). This is
> potentially awkward because individual filters must be URL-encoded if
> they contain + or %. This can potentially be improved by supporting a
> repeated flag syntax, e.g.:
>
> 	$ git rev-list --filter=tree:2 --filter:blob:limit=32k

Shouldn't the second one say "--filter=blob:limit=32k" (i.e. the
first colon should be an equal sign)?

> Such usage is currently an error, so giving it a meaning is backwards-
> compatible.

Two minor comments.  

If combine means "must satisfy all of these", '+' is probably a poor
choice (perhaps we want '&' instead).  Also, it seems to me that
having to worry about url encoding and parsing encoded data
correctly and securely would be far more work than simply taking
multiple command line parameters, accumulating them in a string
list, and then at the end of command line parsing, building a
combined filter out of all of them at once (a degenerate case may
end up attempting to build a combined filter that combines a single
filter), iow just biting the bullet and do the "potentially be
improved" step from the beginning.

> +The form '--filter=combine:<filter1>+<filter2>+...<filterN>' combines
> +several filters. Only objects which are accepted by every filter are
> +included. Filters are joined by "+" and individual filters are %-encoded
> +(i.e. URL-encoded). Only the "%" and "+" characters must be encoded. For
> +instance, 'combine:tree:3+blob:none' and
> +'combine:tree%3A2+blob%3Anone' are equivalent, and result in only tree

I do not quite get this part.  The way I read the justification for
encoding given in the proposed commit log message was because a
filter name or filter parameter might want to include the '+' sign,
so a filter whose name is frotz+nitfol that takes a param may be
invoked standalone as "--filter=frotz+nitfol:param=1" needs to
protect its '+' from getting mistaken when used in the combine
filter, it should not be mistaken as a combination of 'frotz' filter
(with no parameter) and 'nitfol' filter (with param set to one), and
the way to do so is to say

	--filter="combine:frotz%2Bnitfol:param=1"

(this is a degenerate 'combination of a single filter', but you can
add another one by following it with '+' and another URLencoded
string).

So why are we allowing %3A there that does not even have to be
encoded?  Shouldn't it be an error?

In any case, I am not quite convinced that we need to complicate the
parameters with URLencoding, so I'd skip reviewing large part this
patch that is about "decoding".

Once the combined filter definition is built in-core, the code that
evaluates the intersection of all conditions seems to be written
sanely to me.

Thanks.
