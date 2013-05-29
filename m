From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/25] object_array_remove_duplicates(): rewrite to reduce copying
Date: Wed, 29 May 2013 09:18:05 -0700
Message-ID: <7vk3mhwyiq.fsf@alter.siamese.dyndns.org>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
	<1369472904-12875-12-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 29 18:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhj4r-0001gR-JE
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 18:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782Ab3E2QSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 12:18:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932898Ab3E2QSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 12:18:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA9823CF4;
	Wed, 29 May 2013 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PBcQGAGOxHGwyjFS7U7p1e//oEM=; b=hsnjpN
	bJXfVdDWkO3cPJ18Asi2PxI2d2soRtwWWXBbmYHSuRT7EP499ll/UolREHq3tmLa
	+iR7ZeKU/DXjhjAC/wKQ3Nk6FQ6jiACuOYAa9EEiDJTDriBoqenSCkYhiNzKS8hT
	xGU45G2N/rsSyg5VVLtgpHg02ApAbVSxSCjNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIX+X5Mfejz5GRq4LwECstJvoaBWrHXq
	nM542hvWGXynhCLliZRpRVfN0//RaOJtuV9hZxulO+sjtBtNxCmSU7JCpsu6M7AO
	H20ynaZnBqxKGAuqN8Ab42FdWXq84h4/qTy0s1YM7/+mR0Tt5enLjfUB+WX7e9qH
	5lcuvEbAb4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8137823CF2;
	Wed, 29 May 2013 16:18:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B01FA23CF0;
	Wed, 29 May 2013 16:18:06 +0000 (UTC)
In-Reply-To: <1369472904-12875-12-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 25 May 2013 11:08:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58A25E60-C87B-11E2-8F49-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225837>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The old version copied one entry to its destination position, then
> deleted any matching entries from the tail of the array.  This
> required the tail of the array to be copied multiple times.  It didn't
> affect the complexity of the algorithm because the whole tail has to
> be searched through anyway.  But all the copying was unnecessary.
>
> Instead, check for the existence of an entry with the same name in the
> *head* of the list before copying an entry to its final position.
> This way each entry has to be copied at most one time.
>
> Extract a helper function contains_name() to do a bit of the work.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  object.c | 32 +++++++++++++++++++++-----------
>  object.h |  6 +++++-
>  2 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/object.c b/object.c
> index fcd4a82..10b5349 100644
> --- a/object.c
> +++ b/object.c
> @@ -294,22 +294,32 @@ void object_array_filter(struct object_array *array,
>  	array->nr = dst;
>  }
>  
> +/*
> + * Return true iff array already contains an entry with name.
> + */
> +static int contains_name(struct object_array *array, const char *name)
> +{
> +	unsigned nr = array->nr, i;
> +	struct object_array_entry *object = array->objects;
> +
> +	for (i = 0; i < nr; i++, object++)
> +		if (!strcmp(object->name, name))
> +			return 1;
> +	return 0;
> +}

Because some codepaths (e.g. patch 14/25) stuff NULL in the name
field, we may want to be more careful with this.

This is not a new problem, and I think the longer term solution is
to get rid of object_array_remove_duplicates(), so it is perfectly
fine to leave this function broken with respect to NULL input as-is.

The only caller of remove-duplicates is bundle.c, which gets many
starting points and end points from the command line and tries to be
nice by removing obvious duplicates, e.g.

	git bundle create t.bundle master master

but I think its logic of deduping is wrong.  It runs dwim_ref() on
the incoming refs after the remove-duplicates call, so

	git bundle create t.bundle master heads/mater

will end up with two copies of refs/heads/master.  To fix it, the
code must dedup the result of running dwim_ref(), and at that point,
there is no reason to call object_array_remove_duplicates().

> +
>  void object_array_remove_duplicates(struct object_array *array)
>  {
> -	unsigned int ref, src, dst;
> +	unsigned nr = array->nr, src;
>  	struct object_array_entry *objects = array->objects;
>  
> -	for (ref = 0; ref + 1 < array->nr; ref++) {
> -		for (src = ref + 1, dst = src;
> -		     src < array->nr;
> -		     src++) {
> -			if (!strcmp(objects[ref].name, objects[src].name))
> -				continue;
> -			if (src != dst)
> -				objects[dst] = objects[src];
> -			dst++;
> +	array->nr = 0;
> +	for (src = 0; src < nr; src++) {
> +		if (!contains_name(array, objects[src].name)) {
> +			if (src != array->nr)
> +				objects[array->nr] = objects[src];
> +			array->nr++;
>  		}
> -		array->nr = dst;
>  	}
>  }

>  
> diff --git a/object.h b/object.h
> index 0d39ff4..6c1c27f 100644
> --- a/object.h
> +++ b/object.h
> @@ -96,7 +96,11 @@ typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
>  void object_array_filter(struct object_array *array,
>  			 object_array_each_func_t want, void *cb_data);
>  
> -void object_array_remove_duplicates(struct object_array *);
> +/*
> + * Remove from array all but the first entry with a given name.
> + * Warning: this function uses an O(N^2) algorithm.
> + */
> +void object_array_remove_duplicates(struct object_array *array);
>  
>  void clear_object_flags(unsigned flags);
