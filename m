Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C9D1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeADWF3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:05:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52699 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeADWF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:05:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51067C9C32;
        Thu,  4 Jan 2018 17:05:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VInTU9eCBm9NmiH+WoRYSEkNXGw=; b=yjlyId
        C+HyTTCAcQDEJhtuSgy5Owe0oSo4E2aktEwe7x+096n6Cg1zhHYRnGhh8EiXvaDq
        izb8xvou8E4Da9jqaMgPb4QrIhyonUvDkPCu7IHh76jchWUkjUKRzo3PmIX2mn2T
        Zm3CcvW0Th0feIcSTS/ALx1nOzzMqprvYi2qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZPHRjTBOqv4fFxj3OhIlOcseFytHsidb
        nBfi76uRbczuKv59WURuc042hVp8HZMeAIZUAMBVRJDVHu0VOH3vtfRMtoPYhx5n
        D6oznWjfZ2Diz11Yp0eroKmOcXjzTdDLwkQ22l+FxHfJXUre81fqRElFN0zGHB5i
        TH0gEo3nOAo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45E92C9C31;
        Thu,  4 Jan 2018 17:05:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEECDC9C30;
        Thu,  4 Jan 2018 17:05:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 2/5] status: add --[no-]ahead-behind to status and commit for V2 format.
References: <20180103214733.797-1-git@jeffhostetler.com>
        <20180103214733.797-3-git@jeffhostetler.com>
Date:   Thu, 04 Jan 2018 14:05:25 -0800
In-Reply-To: <20180103214733.797-3-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Wed, 3 Jan 2018 21:47:30 +0000")
Message-ID: <xmqqlghde0uy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E97A17E-F19B-11E7-9A6E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +		sti = stat_tracking_info(branch, &nr_ahead, &nr_behind,
> +					 &base, s->ahead_behind_flags);
>  		if (base) {
>  			base = shorten_unambiguous_ref(base, 0);
>  			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
>  			free((char *)base);
>  
> -			if (ab_info)
> -				fprintf(s->fp, "# branch.ab +%d -%d%c", nr_ahead, nr_behind, eol);
> +			if (sti >= 0) {
> +				if (s->ahead_behind_flags == AHEAD_BEHIND_FULL)
> +					fprintf(s->fp, "# branch.ab +%d -%d%c",
> +						nr_ahead, nr_behind, eol);
> +				else if (s->ahead_behind_flags == AHEAD_BEHIND_QUICK)
> +					fprintf(s->fp, "# branch.equal %s%c",
> +						sti ? "neq" : "eq", eol);

This is related to what I said in the review of [1/5], but this
arrangement to require the caller to know that _QUICK request
results in incomplete information smells like a bit of maintenance
hassle.

We'd rather allow the caller to tell if it was given incomplete
information from the values returned by stat_tracking_info()
function (notice the plural "values" here; what is returned in
nr_{ahead,behind} also counts).  For example, we can keep the (-1 =>
"no relation", 0 => "identical", 1 => "different") as return values
of the function, but have it clear nr_{ahead,behind} when it only
knows the two are different but not by how many commits.  That way,
this step can instead do:

	ab_info = stat_tracking_info(...);
	if (base) {
		... do the base thing ...
		if (ab_info > 0) {
			/* different */
			if (nr_ahead || nr_behind)
				fprintf(... +%d -%d ... nr_ahead, nr_behind, ...);
			else
				fprintf(... "neq" ...);
		} else if (!ab_info) {
			/* same */
			fprintf(... +%d -%d ... nr_ahead, nr_behind, ...);
		}
		...

That would allow us to later add different kinds of _QUICK that do
not give full information without having to update this consumer
with something like

-	else if (s->ahead_behind_flags == AHEAD_BEHIND_QUICK)
+	else if (s->ahead_behind_flags == AHEAD_BEHIND_QUICK ||
+		 s->ahead_behind_flags == AHEAD_BEHIND_QUICK_DIFFERENTLY)

when it happens.

Two related tangents.  

 - I do not see why "eq" need to exist at all.  Even in _QUICK mode,
   when you determine that two are identical, you know your branch
   is ahead and behind by 0 commit each.

 - A short-format that is easy to parse by machines does not have to
   be cryptic to humans.  s/neq/not-equal/ or something may be an
   improvement.

Thanks.
