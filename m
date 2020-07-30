Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB015C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 04:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35F52072A
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 04:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EXfMZ9R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgG3EcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:32:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57339 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgG3EcT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 00:32:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 969088377A;
        Thu, 30 Jul 2020 00:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XZmJL4Lpr6XP2j9Axr/fRcih6Sw=; b=EXfMZ9
        R1xx/m0Lx35DksswM42irDz/ChbDgMckxYwSxoOiyzaYCo6N6J7gdWp/UjNVIcF/
        9KyOKJ3lkoYQKFNBi9IkWUumug7EFdSbYNCZBTvdJO9662zkkhRnBIJx1ywynJzo
        8IqcUZhsbyHjC3eVncTrXytgnDPv5UQ9E8SpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ehAnPXwGopTIcckdCGg44uTAZe8AK5GK
        QUmf41F1ZhIguITm+bHLGl8/Hfoou7ijL/QsPvT+8bOK/SDS7fGH7zD2ulyH4Fmw
        idaulfwF4wICFd986nyppjXlOeZwXbq2f4Ir+fTuQQgwc4aoSCMwtOOAyZar8AIJ
        i8vnQdiN4R0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E89A83779;
        Thu, 30 Jul 2020 00:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A85E83778;
        Thu, 30 Jul 2020 00:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] bisect: combine args passed to find_bisection()
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
        <20200730002735.87655-1-alipman88@gmail.com>
        <20200730002735.87655-4-alipman88@gmail.com>
Date:   Wed, 29 Jul 2020 21:32:14 -0700
In-Reply-To: <20200730002735.87655-4-alipman88@gmail.com> (Aaron Lipman's
        message of "Wed, 29 Jul 2020 20:27:35 -0400")
Message-ID: <xmqqr1st7hdd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4EF2ACE-D21D-11EA-9F39-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

> Now that find_bisection() accepts multiple boolean arguments, these may
> be combined into a single unsigned integer in order to declutter some of
> the code in bisect.c

I'd rather call them "flags" without "bisect_".  If we are passing
two sets of flags, one set about "bisect" and the other set about
something else, it would make quite a lot of sense to call the first
set "bisect_flags", but what we are seeing here is not like that.

> +	if (read_first_parent_option())
> +		bisect_flags |= BISECT_FIRST_PARENT;
> +
> +	if (!!skipped_revs.nr)
> +		bisect_flags |= BISECT_FIND_ALL;
> +

You do not care what kind of "true" you are feeding "if()", so I do
not think you would want to keep !! prefix here.  Older API into
find_bisection() may wanted to say "pass 1 to find_all", in which
case, normalizing with !! prefix may have made perfect sense, but 
that no longer holds here.

> +
> +	revs.first_parent_only = !!(bisect_flags & BISECT_FIRST_PARENT);

On the other hand, this !! may make sense; especially since .first_parent_only
could just be a one-bit unsigned bitfield.

>  	revs.limited = 1;
>  
>  	bisect_common(&revs);
>  
> -	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr, first_parent_only);
> +	find_bisection(&revs.commits, &reaches, &all, bisect_flags);

> @@ -23,6 +23,9 @@ struct commit_list *filter_skipped(struct commit_list *list,
>  #define BISECT_SHOW_ALL		(1<<0)
>  #define REV_LIST_QUIET		(1<<1)
>  
> +#define BISECT_FIND_ALL		(1u<<0)
> +#define BISECT_FIRST_PARENT	(1u<<1)

The set of bits to go to your "bisect_flags" are only these two new
ones, and the existing BISECT_SHOW_ALL does not belong to it (it is
a bit in rev_list_info.flags), but it is not apparent.  I wonder if
there is a good way to help readers easily tell these two sets apart.
These are flags passed to find_bisection(), so perhaps

    #define FIND_BISECTION_ALL (1U<<0)
    #define FIND_BISECTION_FIRST_PARENT_ONLY (1U<<1)

    unsigned flags = 0;
    if (first_parent)
	flags |= FIND_BISECTION_FIRST_PARENT_ONLY;
    ...
    find_bisection(..., flags);

would be a reasonable compromise?

Thanks.
