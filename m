From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Mon, 25 Aug 2014 10:21:58 -0700
Message-ID: <xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:22:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLxyA-0003F8-HC
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087AbaHYRWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 13:22:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54733 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187AbaHYRWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 13:22:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 39A5A32BCB;
	Mon, 25 Aug 2014 13:22:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=USAF3uy4e5LSJGx++1maHCM2960=; b=HJw4SE
	RVJlAXOVH3mj8Tnp+DGMcVizdF0uQ/eYyh2NAZrx6FtmYX/LKA41msn6WZ8iBBOR
	04xschTbcregjTpv6ZjznsxpMfk2GCxKJxhTL8UOZysfaWjTEXX9TOOJj1uyfYk3
	WByDjSOMTZ5QgWmR3wxqloj0PNfwuhVqvNplg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUi5Us2+C5P9gTXWmrFvB0ZmA1jBaM2H
	be5lHjWSSWDm5iSsB+EMNa4Pc85ShSAifynbW/Mwk9N4wDgvA//DyD0YBsBvh42S
	dHm3Vv3lwCF5XZuWujimy3evWaB4WcG+hADz0dqrlTnNfpAyQ2c5tWw89bLI3cOw
	IShgqXy8Pe0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E87532BCA;
	Mon, 25 Aug 2014 13:22:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 201A932BBD;
	Mon, 25 Aug 2014 13:22:00 -0400 (EDT)
In-Reply-To: <1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	(Jaime Soriano Pastor's message of "Sun, 24 Aug 2014 19:57:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 529B6C9E-2C7C-11E4-82F4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255839>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> Subject: Re: [PATCH 1/2] Check order when reading index

Please be careful when crafting the commit title.  This single line
will be the only one that readers will have to identify the change
among hundreds of entries in "git shortlog" output when trying to
see what kind of change went into the project during the given
period.  Something like:

    read_index_from(): catch out of order entries while reading an index file

perhaps?

> Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
> ---
>  read-cache.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 7f5645e..c1a9619 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1438,6 +1438,21 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
>  	return ce;
>  }
>  
> +void check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce)

Does this have to be global, i.e. not "static void ..."?

> +{
> +	int name_compare = strcmp(ce->name, next_ce->name);
> +	if (0 < name_compare)
> +		die("Unordered stage entries in index");
> +	if (!name_compare) {
> +		if (!ce_stage(ce))
> +			die("Multiple stage entries for merged file '%s'",
> +				ce->name);

OK.  If ce is at stage #0, no other entry can have the same name
regardless of the stage, and next_ce having the same name violates
that rule.

> +		if (ce_stage(ce) >= ce_stage(next_ce))
> +			die("Unordered stage entries for '%s'",
> +				ce->name);

Not quite.  We do allow multiple higher stage entries; having two or
more stage #1 entries is perfectly fine during a merge resolution,
and both ce and next_ce may be pointing at the stage #1 entries of
the same path.  Replacing the comparison with ">" is sufficient, I
think.

Thanks.

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
> +			check_ce_order(istate->cache[i - 1], ce);
> +
>  		src_offset += consumed;
>  	}
>  	strbuf_release(&previous_name_buf);
