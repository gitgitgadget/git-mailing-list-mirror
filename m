Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E691F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 05:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbeKLOy5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 09:54:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51930 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeKLOy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 09:54:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F3EE2EDE1;
        Mon, 12 Nov 2018 00:03:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HzvjcfJbaj7XPM8szA+TaO+RXms=; b=Povwxc
        B/q95GwbrgET7tiPpHjLXXGwbzPnGq8x6PeJ6EcHCRBnkwJXgKzAJHXtRWzFa69k
        Y6p3BbLbwrYjEbNYHSwkZEuJuRsf/fBmIefuvZ20PKdL7zfb5EeXGDLoj9ydnW+R
        5jHKFjZtgSsrOc13CknSVXkZNZu3bZalZcGB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bAyXTclJ93NiQg6Kg9obaGqI8G7xVY1Z
        3xiHhInyvti6ouhgtYiJ/nNN2tZIPZkdETOicwT9mMcdfEkCq9Yial5hi2JvQZDn
        wtgCSnKUCGyrqRdEV++VvEs0uRQqk05d8yK7/hp05HD6rE1udRlQwbZy5EUuIjmJ
        +G+zHUb35i4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 148832EDDF;
        Mon, 12 Nov 2018 00:03:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 297F12EDDC;
        Mon, 12 Nov 2018 00:03:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
        <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
Date:   Mon, 12 Nov 2018 14:03:20 +0900
In-Reply-To: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 9 Nov 2018 07:44:01 +0000")
Message-ID: <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47CAF0E4-E638-11E8-B0ED-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> @@ -876,11 +882,13 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
>  			name++;
>  		if (!strcmp(name, "objecttype"))
>  			v->s = xstrdup(type_name(oi->type));
> -		else if (!strcmp(name, "objectsize")) {
> +		else if (!strcmp(name, "objectsize:disk")) {
> +			v->value = oi->disk_size;
> +			v->s = xstrfmt("%lld", (long long)oi->disk_size);

oi.disk_size is off_t; do we know "long long" 

   (1) is available widely enough (I think it is from c99)?

   (2) is sufficiently wide so that we can safely cast off_t to?

   (3) will stay to be sufficiently wide as machines get larger
       together with standard types like off_t in the future?

I'd rather use intmax_t (as off_t is a signed integral type) so that
we do not have to worry about these questions in the first place.

> +		} else if (!strcmp(name, "objectsize")) {
>  			v->value = oi->size;
>  			v->s = xstrfmt("%lu", oi->size);

This is not a suggestion but is a genuine question, but I wonder if
two years down the road somebody who meets this API for the first
time find the asymmetry between "objectsize" and "objectsize:disk" a
tad strange and suggest the former to have "objectsize:real" or some
synonym.  Or we can consider "objectsize" the primary thing (hence
needing no colon-plus-modifier to clarify what kind of size we are
asking) and leave these two deliberatly asymmetric.  I am leaning
towards the latter myself.

> -		}
> -		else if (deref)
> +		} else if (deref)
>  			grab_objectname(name, &oi->oid, v, &used_atom[i]);
>  	}
>  }
>
> --
> https://github.com/git/git/pull/552
