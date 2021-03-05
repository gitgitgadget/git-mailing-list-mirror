Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4C4C433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F266509F
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCETqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:46:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58320 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCETql (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 14:46:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37ECCB0C4C;
        Fri,  5 Mar 2021 14:46:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gHZ0sYx+9BwNgZD59pdGsGCcbyI=; b=D/rVqP
        7wZr9badSNmzAhQGGgJqg4Xhsrhhnu66PIBrY0lZvXmfyQ8qAkiMuFIOcFeXIazj
        vOqGxg2TkYQEBH1IDEGv9fM7WMhM4p7vl7VQmlvNCXWLWyCkj4gZGYGNvOcqyU+Q
        OqgF9xsNuH/X30+Wqa7iV/X0sZ3Wf9nV4uSQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=os1dN3mM5np1zG9ZQm+WQRriKQ3lMJ8f
        RXhB/Bxa1J5ZAyUQ1mhVVupVl3qMNUQb//dSMikyYKsTqGpSHwLOhFYJgadtMbqB
        tCRPYpbAkNnwhvTVjT/ypnocuJRoxeg2WHwAlLpr01wsNS4E62GMhNLcw9a9ocFQ
        hFgAv0rRhgg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FFE0B0C4B;
        Fri,  5 Mar 2021 14:46:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6E13B0C4A;
        Fri,  5 Mar 2021 14:46:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <YEF5BfE6eXmhhiAf@google.com>
        <20210305011621.599649-1-jonathantanmy@google.com>
        <xmqqzgzha0z5.fsf@gitster.c.googlers.com>
Date:   Fri, 05 Mar 2021 11:46:39 -0800
In-Reply-To: <xmqqzgzha0z5.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 05 Mar 2021 10:50:54 -0800")
Message-ID: <xmqqmtvh9ye8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 816B75F6-7DEB-11EB-9EBA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Avoiding the condition that exhibits the breakage is possible, and I
> think it is what is done here, but I actually think that the only
> right fix is to pass correct argument to commands we invoke in the
> first place.  Why are we reusing the same argument array to begin
> with?
>
>     ... goes back and reads the offending commit ...
>
> commit b664e9ffa153189dae9b88f32d1c5fedcf85056a
> Author: Jonathan Tan <jonathantanmy@google.com>
> Date:   Mon Feb 22 11:20:08 2021 -0800
>
>     fetch-pack: with packfile URIs, use index-pack arg
>     
>     Unify the index-pack arguments used when processing the inline pack and
>     when downloading packfiles referenced by URIs. This is done by teaching
>     get_pack() to also store the index-pack arguments whenever at least one
>     packfile URI is given, and then when processing the packfile URI(s),
>     using the stored arguments.
>
> THis makes it sound like the entire idea of this offending commit
> was wrong, and before it, the codepath that processed the packfile
> fetched from the packfile URI were using the index-pack correctly
> by using index-pack arguments that are independent from the one that
> is used to process the packfile given in-stream.  Why isn't the fix
> just a straight revert of the commit???

By the way, the band-aid in this patch may be OK for the upcoming
release (purely because it is easy to see that is sufficient for
today's codebase), but I said the above because I worry about the
health of the codebase in the longer term.  The "pass_header" may
not stay to be the only difference between the URI packfile and
in-stream packfile in the way they make index-pack invocations.

>> This is on jt/transfer-fsck-across-packs.
>
> Ouch.  This definitely is an -rc material.

Thanks.
