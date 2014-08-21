From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Check order when reading index
Date: Thu, 21 Aug 2014 11:51:05 -0700
Message-ID: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
References: <CAPuZ2NEksZzt29XpAaszK8oc4iXH4OTGzRSsHUrtwgrv6bU_0Q@mail.gmail.com>
	<1408628606-12975-1-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 20:51:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKXSE-0007tV-5k
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 20:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbaHUSvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 14:51:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65249 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbaHUSvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 14:51:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3C6E31929;
	Thu, 21 Aug 2014 14:51:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RjDigNRvmvDdcNE6vph+bqFCIvY=; b=irwSZx
	qeXvjniTWRNNo/CYnheGR3TMG55BvkMISPff3hgEixl+K0GGf/UpK7HXAbWyF/D3
	aUkmeFTb2fuOJC+Cz3TPKEz2N0Y91NrVvg5B4noqcRi+1MSTO0dB5qCCTvorEE4p
	7m7US5LL4kcgRHxRzDTkwvjRO+LdB66exLbX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgf9F9MkSNBaU0gv9qC8ORgMlUhf7KkI
	rsewb/Dw6fz9qfiqUVL0SXgFgV6IG4woBQSqk1PDWBCnrUhox1szUUSKfs8uIfhr
	QDjbE4Mp3FZtkhU0GdNot6Bk/ba+llPOOvPAy9r3TfsesxgDgngmRB2kp/r3Yi9R
	3TLRkkNIyeU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EBACE31928;
	Thu, 21 Aug 2014 14:51:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 088783191E;
	Thu, 21 Aug 2014 14:51:07 -0400 (EDT)
In-Reply-To: <1408628606-12975-1-git-send-email-jsorianopastor@gmail.com>
	(Jaime Soriano Pastor's message of "Thu, 21 Aug 2014 15:43:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C8DD832-2964-11E4-9D9B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255631>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
> ---
>  read-cache.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 7f5645e..e117d3a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1438,6 +1438,21 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
>  	return ce;
>  }
>  
> +void check_next_ce(struct cache_entry *ce, struct cache_entry *next_ce) {

Have opening brace for the function on its own line, i.e.

	void check_next_ce(struct cache_entry *ce, struct cache_entry *next_ce)
	{

The function might be misnamed (see below), though.

> +	if (!ce || !next_ce)
> +		return;

Hmph, would it be either a programming error or a corrupt index
input to see a NULL in either of these variables?

> +	if (cache_name_compare(ce->name, ce_namelen(ce),
> +						   next_ce->name, ce_namelen(next_ce)) > 1)

An odd indentation that is overly deep to make it hard to read.

	if (cache_name_compare(ce->name, ce_namelen(ce),
			       next_ce->name, ce_namelen(next_ce)) > 1)

should be sufficient (replacing 7-SP before next_ce with a HT is OK
if the existing code nearby does so).

What is the significance of the return value from cache_name_compare()
that is strictly greater than 1 (as opposed to merely "is it positive?")?

Perhaps you want something that is modeled after ce_same_name() that
ignores the stage, i.e.

	int ce_name_compare(const struct cache_entry *a, const struct cache_entry *b)
	{
		return strcmp(a->ce_name, b->ce_name);
	}

without reimplementing the cache-name-compare() as

	int bad_ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
	{
        	return !ce_same_name(a, b);
	}

to keep the "two names with different length could never be the
same" optimization.

	- if (0 <= ce_name_compare(ce, next)) then the names are not sorted

        - if (!stage(ce) && !name_compare(ce, next)) then the merged
          entry 'ce' is not the only entry for the path



> +		die("Unordered stage entries in index");
> +	if (ce_same_name(ce, next_ce)) {
> +		if (!ce_stage(ce))
> +			die("Multiple stage entries for merged file '%s'",
> +				ce->name);

> +		if (ce_stage(ce) >= ce_stage(next_ce))
> +			die("Unordered stage entries for '%s'", ce->name);
> +	}
> +}
> +
>  /* remember to discard_cache() before reading a different cache! */
>  int read_index_from(struct index_state *istate, const char *path)
>  {
> @@ -1499,6 +1514,9 @@ int read_index_from(struct index_state *istate, const char *path)
>  		ce = create_from_disk(disk_ce, &consumed, previous_name);
>  		set_index_entry(istate, i, ce);
>  
> +		if (i > 0)
> +			check_next_ce(istate->cache[i-1], ce);

Have a SP each on both sides of binary operator "-".

Judging from the way this helper function is used, it looks like
check_with_previous_ce() is a more appropriate name.  After all, you
are not checking the next ce which you haven't even created yet ;-)


Thanks.
