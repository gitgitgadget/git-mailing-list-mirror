From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Thu, 13 Nov 2014 13:18:43 -0800
Message-ID: <xmqqmw7uztn0.fsf@gitster.dls.corp.google.com>
References: <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
	<20141107191745.GB5695@peff.net>
	<CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
	<CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
	<CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
	<20141108083040.GA15833@peff.net>
	<xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
	<20141113183033.GA24107@peff.net>
	<xmqqbnoa29ps.fsf@gitster.dls.corp.google.com>
	<20141113192655.GA3413@peff.net> <20141113200315.GA3869@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:18:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp1n2-0005Ab-Bu
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934041AbaKMVSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:18:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754189AbaKMVSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:18:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9A8F1D6B4;
	Thu, 13 Nov 2014 16:18:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/aHalM5GDwNgb2+DIiw7hFKCjq8=; b=fEUqut
	PdeiUIWnvwNeoEclWc2X7QQjZioUTDCiW2NA5z3ZXfCh8WewsUk7SQcKmGfRh9my
	hhs+kiMjK6sTIyLRVXMTN+AdxJAxNF6rYdqd2PzQ7rKvqqjvq3WyZx1wybKXs/q5
	S3cLZz1ZifbR/RT9QASpmd+YkzIlimCEBiU60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wL8/yNOOtEmHeJ7Zl9ni7RFg+iP7i6XT
	x3uhtZ2nJHbTe+GF37St5x1vyYnrbZXRLDUq2iopv3EFryWhWXSDJkcUBO6KYC2y
	a/gi/zPIXC2WtRzZrg5UjaA05a0xAk7ZI9tqtjMwVB6Ys1t5WDn/aeEVcmDu9mta
	6mbe2er2OCU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF53E1D6B3;
	Thu, 13 Nov 2014 16:18:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4593E1D6B1;
	Thu, 13 Nov 2014 16:18:44 -0500 (EST)
In-Reply-To: <20141113200315.GA3869@peff.net> (Jeff King's message of "Thu, 13
	Nov 2014 15:03:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5FD9A46-6B7A-11E4-8DD9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 13, 2014 at 02:26:55PM -0500, Jeff King wrote:
>
>> > Makes sense, including the use of strbuf (otherwise you would
>> > allocate ce and then discard when it turns out that it is not
>> > needed, which is probably with the same allocation pressure, but
>> > looks uglier).
>> 
>> Exactly. Constructing it in ce->name does save you an allocation/memcpy
>> in the case that we actually use the new entry, but I thought it would
>> look weirder. It probably doesn't matter much either way, so I tried to
>> write the most obvious thing.
>
> Actually, it is not that bad:

Yeah, actually it does look better; want me to squash it into the
patch before queuing?

>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5410dac..5a78758 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -67,6 +67,7 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
>  {
>  	int len;
>  	struct cache_entry *ce;
> +	int pos;
>  
>  	if (S_ISDIR(mode))
>  		return READ_TREE_RECURSIVE;
> @@ -79,6 +80,23 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
>  	ce->ce_flags = create_ce_flags(0) | CE_UPDATE;
>  	ce->ce_namelen = len;
>  	ce->ce_mode = create_ce_mode(mode);
> +
> +	/*
> +	 * If the entry is the same as the current index, we can leave the old
> +	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
> +	 * do the right thing.
> +	 */
> +	pos = cache_name_pos(ce->name, ce->ce_namelen);
> +	if (pos >= 0) {
> +		struct cache_entry *old = active_cache[pos];
> +		if (ce->ce_mode == old->ce_mode &&
> +		    !hashcmp(ce->sha1, old->sha1)) {
> +			old->ce_flags |= CE_UPDATE;
> +			free(ce);
> +			return 0;
> +		}
> +	}
> +
>  	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
>  	return 0;
>  }
>
> and in some ways more readable, as you form the whole thing, and then as
> the final step either add it, or realize that what is there is fine (I'd
> almost wonder if it could be a flag to add_cache_entry).
>
> -Peff
