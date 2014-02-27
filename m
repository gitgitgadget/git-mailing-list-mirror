From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use ALLOC_GROW() instead of inline code
Date: Thu, 27 Feb 2014 14:44:07 -0800
Message-ID: <xmqqr46ow4zs.fsf@gitster.dls.corp.google.com>
References: <530FA3E7.8020200@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ9gs-0006Yl-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbaB0WoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 17:44:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63387 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbaB0WoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 17:44:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF0B70F0E;
	Thu, 27 Feb 2014 17:44:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oXAhZRzZHGfEI0zXOyNgVZCBuek=; b=agpWcB
	+NKBVg4yvWr/GvRQsuYPAVsu8Oj8uZ+vVXY5XkmYZy9qEpHQLWsOpBE3IM+QLzms
	ZMYC/jDni8UTMS4IvlCY+jEoxCK/jvtqiU20BlcMhlDAcnYPqJNuFOlmdyI06R1e
	m19ADZENP8uDy9982qscYfXyIHdhZOEp7aXDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AjhI10+I41++4td9y4JNW9wNkJE+gSNq
	6Tn3g/pK8mWTCDwumPlmZmAI97knsssL/1V/5UNv7CPseqximebdzD1xlC3DBBvJ
	gmjDiXR0Glh90zUWO0jzi5b+hArr5zATd6z0RDpmGXySMFOUf/ePTsbTRhkVbDtx
	fTZEiQKG+r0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E75A570F0C;
	Thu, 27 Feb 2014 17:44:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB91D70F04;
	Thu, 27 Feb 2014 17:44:11 -0500 (EST)
In-Reply-To: <530FA3E7.8020200@yandex.ru> (Dmitry S. Dolzhenko's message of
	"Fri, 28 Feb 2014 00:45:27 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD2D9064-A000-11E3-A661-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242871>

"Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru> writes:

> diff --git a/dir.c b/dir.c
> index b35b633..72f6e2a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1329,13 +1329,10 @@ static struct path_simplify *create_simplify(const char **pathspec)
>  
>  	for (nr = 0 ; ; nr++) {
>  		const char *match;
> -		if (nr >= alloc) {
> -			alloc = alloc_nr(alloc);
> -			simplify = xrealloc(simplify, alloc * sizeof(*simplify));
> -		}
>  		match = *pathspec++;
>  		if (!match)
>  			break;
> +		ALLOC_GROW(simplify, nr + 1, alloc);
>  		simplify[nr].path = match;
>  		simplify[nr].len = simple_length(match);
>  	}

What follows the post-context of this hunk is a NULL termination of
the array:

	simplify[nr].path = NULL;
        simplify[nr].len = 0;

If the first element in pathspec[] were NULL, we set nr to 0, break
the loop without calling ALLOC_GROW() even once, and try to NULL
terminate simplify[] array after the loop.

Don't we try to store to an unallocated piece of memory with this
change?

> diff --git a/read-cache.c b/read-cache.c
> index 33dd676..e585541 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1466,8 +1462,7 @@ int read_index_from(struct index_state *istate, const char *path)
>  
>  	istate->version = ntohl(hdr->hdr_version);
>  	istate->cache_nr = ntohl(hdr->hdr_entries);
> -	istate->cache_alloc = alloc_nr(istate->cache_nr);
> -	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
> +	ALLOC_GROW(istate->cache, istate->cache_nr, istate->cache_alloc);

This being the initial allocation, not growing reallocation, use of
ALLOC_GROW() looks somewhat strange.  I know that an realloc from
NULL ends up being the same as calloc(), but still.
