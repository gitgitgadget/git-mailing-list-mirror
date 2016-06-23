Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CEE1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 20:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbcFWUZg (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 16:25:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750785AbcFWUZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 16:25:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 17BB226415;
	Thu, 23 Jun 2016 16:25:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=di3YHs+n7cQE
	2siZK6ZPQtua+sk=; b=CjOyknfDuboGn9NnHWRrq370edyrn3o0ZZUGbXPWRoXZ
	lA25D5PK7mb7i6AOt/ceggML8s8qZrkzUQjW9FHI7f8AONBfCXPoA8r5jHyUmuZ3
	6c02tJHl1XEqSSoUTQedUubkmqUq+z0sK3ObaihphDeoybg8tvgUTTCdQRFxKyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F9XfRF
	3wJ9flC6ygbzGL+1dpRVO2v+tbH+bEGc/HZvmecwAO7w2UBAnGWqo23uhzz7qT9v
	L71hFiLuzkzfBzwnfi7ZrqLtzv+gkC36s26CvlFgFP8eWptovV1NVaOHIzSVKdKA
	9ma74cBBehxNvXkkcCjiISPRvdSyaLWU4epZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F1FA126414;
	Thu, 23 Jun 2016 16:25:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7741926413;
	Thu, 23 Jun 2016 16:25:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 05/11] grep/icase: avoid kwsset when -F is specified
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160623162907.23295-6-pclouds@gmail.com>
Date:	Thu, 23 Jun 2016 13:25:32 -0700
In-Reply-To: <20160623162907.23295-6-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Thu, 23 Jun 2016 18:29:01 +0200")
Message-ID: <xmqqtwgjhcub.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A39DAB6C-3980-11E6-9A0D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> @@ -408,7 +427,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  	ascii_only     = !has_non_ascii(p->pattern);
>  
>  	if (opt->fixed) {
> -		p->fixed = 1;
> +		p->fixed = !icase || ascii_only;
> +		if (!p->fixed) {
> +			compile_fixed_regexp(p, opt);
> +			return;
> +		}
>  	} else if ((!icase || ascii_only) &&
>  		   is_fixed(p->pattern, p->patternlen))
>  		p->fixed = 1;

Makes me feel somewhat dirty to see that we do the same "!icase ||
ascii_only" on both sides of the if/else cascade.

I wonder if it would be more readable to structure it like this
instead?

	if (opt->fixed || is_fixed(...))
		p->fixed = (!icase || ascii_only);
	else
        	p->fixed = 0;

	if (p->fixed)
        	/* do the kws thing and return */
	else if (opt->fixed)
        	/* do the "quote into regexp" thing and return */

	/* pcre and other from the original follows */

