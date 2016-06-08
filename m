From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tree-diff: avoid alloca for large allocations
Date: Tue, 07 Jun 2016 17:36:59 -0700
Message-ID: <xmqq8tygo6s4.fsf@gitster.mtv.corp.google.com>
References: <20160607225300.GA2285@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 02:37:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bARUd-0007Bt-E4
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 02:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbcFHAhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 20:37:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754008AbcFHAhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 20:37:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C9C923AB5;
	Tue,  7 Jun 2016 20:37:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VkPoX/tEelFejDmgdfwRYkfO9WA=; b=ajEbR5
	wkAT/wD5vrnLp/k0wSug+IQYCN0PIWYuMyIZQaJ48eeUEAho9jtYAsNa1u91BrvY
	NFJyyoLxh0EMWkcuqBgCWkvHxtvzW3As7mEISmopgRdmn2009MTpV3lkfL4zRyGJ
	6Rw5QwwVHyJbJ0dpeXCUB1lTaUhIBVhuePO5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n1SBGrYEocCaoOszwvlTwXC2QEJeXB6z
	hAcf53OZSExmst5omjRCYQ90VN6TaNl0krlzwsdwc3KCXlhIbMHyT/6D7yEXvmXJ
	Kv4z0WKUG1pJhNAll0Fes3kokbYhxyCriZ670hIFSzoa8bTiEky2kJPDD0vw4wzt
	C27EcfIF3r0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05BBE23AB3;
	Tue,  7 Jun 2016 20:37:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8666123AB2;
	Tue,  7 Jun 2016 20:37:01 -0400 (EDT)
In-Reply-To: <20160607225300.GA2285@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jun 2016 18:53:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D98890E-2D11-11E6-A3A4-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296751>

Jeff King <peff@peff.net> writes:

> An alternative to this would be implement something like:
>
>   struct tree *tp, tp_fallback[2];
>   if (nparent <= ARRAY_SIZE(tp_fallback))
>           tp = tp_fallback;
>   else
> 	  ALLOC_ARRAY(tp, nparent);
>   ...
>   if (tp != tp_fallback)
> 	  free(tp);
>
> That would let us drop our xalloca() portability code
> entirely. But in my measurements, this seemed to perform
> slightly worse than the xalloca solution.

It indeed is curious why this "obvious" alternative performed
worse.

> +#define FAST_ARRAY_ALLOC(x, nr) do { \
> +	if ((nr) <= 2) \
> +		(x) = xalloca((nr) * sizeof(*(x))); \
> +	else \
> +		ALLOC_ARRAY((x), nr); \
> +} while(0)
> +#define FAST_ARRAY_FREE(x, nr) do { \
> +	if ((nr) > 2) \
> +		free((x)); \
> +} while(0)

An obvious and clean implementation of the idea.

The only slight worry I have is that nr must stay constant until the
time the caller calls FREE(), but for the only three callsite pairs
it is clear nparent will stay constant and this is local to the
file.

Thanks.

>  static struct combine_diff_path *ll_diff_tree_paths(
>  	struct combine_diff_path *p, const unsigned char *sha1,
> @@ -265,7 +275,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
>  	if (recurse) {
>  		const unsigned char **parents_sha1;
>  
> -		parents_sha1 = xalloca(nparent * sizeof(parents_sha1[0]));
> +		FAST_ARRAY_ALLOC(parents_sha1, nparent);
>  		for (i = 0; i < nparent; ++i) {
>  			/* same rule as in emitthis */
>  			int tpi_valid = tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
> @@ -277,7 +287,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
>  		strbuf_add(base, path, pathlen);
>  		strbuf_addch(base, '/');
>  		p = ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
> -		xalloca_free(parents_sha1);
> +		FAST_ARRAY_FREE(parents_sha1, nparent);
>  	}
>  
>  	strbuf_setlen(base, old_baselen);
> @@ -402,8 +412,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  	void *ttree, **tptree;
>  	int i;
>  
> -	tp     = xalloca(nparent * sizeof(tp[0]));
> -	tptree = xalloca(nparent * sizeof(tptree[0]));
> +	FAST_ARRAY_ALLOC(tp, nparent);
> +	FAST_ARRAY_ALLOC(tptree, nparent);
>  
>  	/*
>  	 * load parents first, as they are probably already cached.
> @@ -531,8 +541,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  	free(ttree);
>  	for (i = nparent-1; i >= 0; i--)
>  		free(tptree[i]);
> -	xalloca_free(tptree);
> -	xalloca_free(tp);
> +	FAST_ARRAY_FREE(tptree, nparent);
> +	FAST_ARRAY_FREE(tp, nparent);
>  
>  	return p;
>  }
