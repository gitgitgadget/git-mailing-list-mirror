From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/7] invalidate_ref_cache(): take the submodule as
 parameter
Date: Wed, 12 Oct 2011 12:19:20 -0700
Message-ID: <7vwrca81c7.fsf@alter.siamese.dyndns.org>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
 <1318445067-19279-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:19:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE4Ku-0000JK-H4
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab1JLTTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:19:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab1JLTTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:19:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09E5B511F;
	Wed, 12 Oct 2011 15:19:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bCzIeA6DwVjBJTHLq7v6aU9K8co=; b=u0Q+N4
	IHoUnaXaS0OufxkJpiH/1ImwKykV5NQFGZHR5dt4LurOuy9mAGtI7y5vr3f3sZRF
	66ih2sAoro/mmBDJwLb9iFrLV/GMdb2aHpvnd1TqwFOvKqxbiTRb9ru0oRUXP+zS
	kWz45z7R5UIbKNIxwStJQqiRie3ScZ3gY8oXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gC+WzZ+qcOlda0a95PzU+mrk+MIFiOaP
	DdV6oTMpyKgFKjEv1K3g0gUhDvy0j/ZQy83efVtUx1hX7G2npRrqkdOgVWFX4lKk
	mLSVUigo4RAVro/l12n2qrrUeGrKYys+GU3HmT7tvm8OOkGp+Zv50GpK9Go6rGuy
	/AJZqggim9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00FDD511E;
	Wed, 12 Oct 2011 15:19:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81E38511D; Wed, 12 Oct 2011
 15:19:21 -0400 (EDT)
In-Reply-To: <1318445067-19279-3-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 12 Oct 2011 20:44:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16B59F60-F507-11E0-A5D9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183402>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Instead of invalidating the ref cache on an all-or-nothing basis,
> allow the cache for individual submodules to be invalidated.

That "allow" does not seem to describe what this patch does. It disallows
the wholesale invalidation and forces the caller to invalidate ref cache
individually.

Probably that is what all the existing callers want, but I would have
expected that an existing feature would be kept, perhaps like this
instead:

	if (!submodule) {
		struct ref_cache *c;
                for (c = ref_cache; c; c = c->next)
                	clear_ref_cache(c);
	} else {
		clear_ref_cache(get_ref_cache(submodule);
	}

Not a major "vetoing" objection, just a comment.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 120b8e4..cc72609 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -202,13 +202,9 @@ static struct cached_refs *get_cached_refs(const char *submodule)
>  	return refs;
>  }
>  
> -static void invalidate_ref_cache(void)
> +static void invalidate_ref_cache(const char *submodule)
>  {
> -	struct cached_refs *refs = cached_refs;
> -	while (refs) {
> -		clear_cached_refs(refs);
> -		refs = refs->next;
> -	}
> +	clear_cached_refs(get_cached_refs(submodule));
>  }
