From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] checkout(-index): do not checkout i-t-a entries
Date: Mon, 30 Nov 2015 11:17:07 -0800
Message-ID: <xmqq1tb78fgs.fsf@gitster.mtv.corp.google.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
	<1440205700-19749-1-git-send-email-pclouds@gmail.com>
	<1440205700-19749-6-git-send-email-pclouds@gmail.com>
	<xmqq8u8z1d8r.fsf@gitster.dls.corp.google.com>
	<20151129153122.GA3719@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, phiggins@google.com, snoksrud@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Twp-0007Ni-42
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbbK3TRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 14:17:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751237AbbK3TRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 14:17:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99EDA2F2BC;
	Mon, 30 Nov 2015 14:17:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3i2ud460lFcxztvdP+WHFDRx1eE=; b=uCldjU
	pN1JY+eEIr1p0yRUCXhmUGFjz6RFxWRMaQuMgN8qi4vraWQp2XpesLwLSgLBPgDn
	MKoz9oCL8WTMATgzC4asvVnUfkffLxeocWxfQVmgOoFz4N0LRuClxdaRRDn6FHnX
	7tJ//Rk/zpIU23x6rkQKhTkrNQ/3C+tWCP/T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lhz82RZizWy7K5cvMzRr54TcygQcsUMB
	sWM7rUDTAokDFoUv6/uLF1+JGZbILMGDVEU5TAvEYoySU4SY4FUlZmpes3PYV5kh
	Lre9ghey9DQwuUPI7fCDNZRNu+AYCtJpMCbQdMp0UHRx1rZRton1zsSBJgByYIDy
	tzG7W3Eit2E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 911AA2F2BB;
	Mon, 30 Nov 2015 14:17:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0E6912F2BA;
	Mon, 30 Nov 2015 14:17:08 -0500 (EST)
In-Reply-To: <20151129153122.GA3719@duynguyen-vnpc.dek-tpc.internal> (Duy
	Nguyen's message of "Sun, 29 Nov 2015 16:31:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F37F3C22-9796-11E5-9D96-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281814>

Duy Nguyen <pclouds@gmail.com> writes:

> Sorry for this waaay too late response, everything (of the series
> nd/ita-cleanup) is addressed so far except this..
>
> On Tue, Aug 25, 2015 at 10:36:52AM -0700, Junio C Hamano wrote:
>> > diff --git a/builtin/checkout.c b/builtin/checkout.c
>> > index e1403be..02889d4 100644
>> > --- a/builtin/checkout.c
>> > +++ b/builtin/checkout.c
>> > @@ -300,6 +300,8 @@ static int checkout_paths(const struct checkout_opts *opts,
>> >  			 * anything to this entry at all.
>> >  			 */
>> >  			continue;
>> > +		if (ce_intent_to_add(ce))
>> > +			continue;
>> >  		/*
>> >  		 * Either this entry came from the tree-ish we are
>> >  		 * checking the paths out of, or we are checking out
>> 
>> Hmm, while this does prevent the later code from checking it out, I
>> am not sure how well this interacts with ps_matched[] logic here.
>> If the user told Git that 'foo' is a path that she cares about with
>> "add -N foo", and said "git checkout -- foo", should we be somehow
>> saying that 'foo' did match but there is nothing to check out, or
>> something?
>
> How about this? It does not mess with ps_matched logic. But it does
> not say "nothing to checkout" at the end either. While we could do
> that (in general case, not just because all we are checking out is ita
> entries), I'm not sure if such verbosity helps anyone. I'm thinking of
> dropping the new warning I added here too..

I agree that these warnings are unwanted when you run "checkout ."
in a repository with tons of i-t-a paths (but on the other hand,
having tons of i-t-a paths is unusual so the user might want to be
reminded of them--I dunno).

With or without the new warning(), this one looks an improvement
over the previous one to me.

Thanks.

> -- 8< --
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 3e141fc..c11fe71 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -328,12 +328,17 @@ static int checkout_paths(const struct checkout_opts *opts,
>  	if (opts->merge)
>  		unmerge_marked_index(&the_index);
>  
> -	/* Any unmerged paths? */
>  	for (pos = 0; pos < active_nr; pos++) {
>  		const struct cache_entry *ce = active_cache[pos];
>  		if (ce->ce_flags & CE_MATCHED) {
> -			if (!ce_stage(ce))
> +			if (!ce_stage(ce)) {
> +				if (ce_intent_to_add(ce)) {
> +					warning(_("path '%s' is only intended to add"), ce->name);
> +					ce->ce_flags &= ~CE_MATCHED;
> +				}
>  				continue;
> +			}
> +			/* Any unmerged paths? */
>  			if (opts->force) {
>  				warning(_("path '%s' is unmerged"), ce->name);
>  			} else if (opts->writeout_stage) {
> -- 8< --
> --
> Duy
