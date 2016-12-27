Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2E4200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 21:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755453AbcL0VSp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 16:18:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61018 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752993AbcL0VSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 16:18:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54E5459718;
        Tue, 27 Dec 2016 16:17:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=LrrfScU0qboBKgiyNu5Sgv5K6JU=; b=t43Lw8sxpXTUnLxehFrg
        W3skXwqlkOU0oQbY8t9rgOVJ7wlhAFh2fRVGX6sL2KWTmPwPL8vlnA+LxQ3bNtUi
        6xq/bjEr3+qeBMxm92dDglFUJMpWP4W86Xg78yYV8W8rXXdvrnWrT72pDiUWM/sP
        +bEmslB1OSKvoCnoP7f+PeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=UlZ2DooORs3pfPqiUXwTqiEyiFn8u6uETo9pzOLsGgPfFR
        Ja+eLek/hn6+UXj/N8rcfeQUpx/7IYwIScrxrOSUhU0Vnz0dlo8lDQM0equj19mL
        0IM0lGx7JE+S8/6oOjKlGlHDloa6L6p3daAHl+TtRwC9TWnVktmWK6WI1PiRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D6A059717;
        Tue, 27 Dec 2016 16:17:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C21C159716;
        Tue, 27 Dec 2016 16:17:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v9 15/20] ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
Date:   Tue, 27 Dec 2016 13:11:43 -0800
References: <20161227162357.28212-1-Karthik.188@gmail.com>
        <20161227162357.28212-16-Karthik.188@gmail.com>
Message-ID: <xmqqo9zx6phw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1855510-CC79-11E6-B89C-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> Currently the 'lstrip=<N>' option only takes a positive value '<N>'
> and strips '<N>' slash-separated path components from the left. Modify
> the 'lstrip' option to also take a negative number '<N>' which would
> only _leave_ behind 'N' slash-separated path components from the left.

"would only leave behind N components from the left" sounds as if
the result is A/B, when you are given A/B/C/D/E and asked to
lstrip:-2.  Given these two tests added by the patch ...

> +test_atom head refname:lstrip=-1 master
> +test_atom head refname:lstrip=-2 heads/master

... I somehow think that is not what you wanted to say.  Instead,
you strip from the left as many as necessary and leave -N
components that appear at the right-most end, no?

> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -98,7 +98,8 @@ refname::
>  	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
>  	slash-separated path components from the front of the refname
>  	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
> -	`<N>` must be a positive integer.
> +	if `<N>` is a negative number, then only `<N>` path components
> +	are left behind.

I think positive <N> is so obvious not to require an example but it
is good that you have one.  The negative <N> case needs illustration
more than the positive case.  Perhaps something like:

    (e.g. %(refname:lstrip=-1) strips components of refs/tags/frotz 
    from the left to leave only one component, i.e. 'frotz').

Would %(refname:lstrip=-4) attempt to strip components of
refs/tags/frotz from the left to leave only four components, and
because the original does not have that many components, it ends
with refs/tags/frotz?

I am debating myself if we need something like "When the ref does
not have enough components, the result becomes an empty string if
stripping with positive <N>, or it becomes the full refname if
stripping with negative <N>.  Neither is an error." is necessary
here.  Or is it too obvious?
