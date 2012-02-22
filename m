From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/5] refs: add match_pattern()
Date: Tue, 21 Feb 2012 22:33:05 -0800
Message-ID: <7vobsrbcny.fsf@alter.siamese.dyndns.org>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
 <1329874130-16818-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 07:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S05ln-0007b0-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 07:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab2BVGdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 01:33:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2BVGdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 01:33:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 235A64DC3;
	Wed, 22 Feb 2012 01:33:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=TTZn7rg5JYVyZfHlB6ggGy6mY9g=; b=refxShENUGSuf8bqbCtH
	/Ib71xIInBFk6qOn3iS4TxULpJ8z0DdpVK6b+0Po4ynI5tYCKMd3LKC8C2ZUtQPj
	9qruziWg1U8SURP2jVDvvhNqaE6tYtzwnOPa7W47Vp5sfhYJ/EM5jOHjwYJkM5kO
	oSz8/vnLxaYzaKxC7kwSl88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=AhrlfVeBCJ0pqEmOU8f3/bVtEEUmVi3JC1KBIgcROpej5P
	3qiU3cJ+JWHXiuiZbVE0nqIjR2YxISJIYpuOMJZE85yDKs0wMSKfun/Ux3492GjW
	uJ2UaPfEKYYRfWVmi13d0N4iHwScSLKA49f7ZhBpJGpytvovcCuzKoKulM0qE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A54E4DC2;
	Wed, 22 Feb 2012 01:33:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B49F4DC1; Wed, 22 Feb 2012
 01:33:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14DE0044-5D1F-11E1-84A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191231>

Tom Grennan <tmgrennan@gmail.com> writes:

> +static int match_path(const char *name, const char *pattern, int nlen)
> +{
> +	int plen = strlen(pattern);
> +
> +	return ((plen <= nlen) &&
> +		!strncmp(name, pattern, plen) &&
> +		(name[plen] == '\0' ||
> +		 name[plen] == '/' ||
> +		 pattern[plen-1] == '/'));
> +}

This is a counterpart to the tail match found in ls-remote, so we would
want to call it with a name that makes it clear this is a leading path
match not just "path" match.  Perhaps match_leading_path() or something.

> +int match_pattern(const char *name, const char **match,
> +		  struct string_list *exclude, int flags)
> +{
> +	int nlen = strlen(name);
> +
> +	if (exclude) {
> +		struct string_list_item *x;
> +		for_each_string_list_item(x, exclude) {
> +			if (!fnmatch(x->string, name, 0))
> +				return 0;
> +		}
> +	}
> +	if (!match || !*match)
> +		return 1;
> +	for (; *match; match++) {
> +		if (flags == FNM_PATHNAME)
> +			if (match_path(name, *match, nlen))
> +				return 1;
> +		if (!fnmatch(*match, name, flags))
> +			return 1;
> +	}
> +	return 0;
> +}

As an API for a consolidated and generic function, the design needs a bit
more improving, I would think.

 - The name match_pattern() was OK for a static function inside a single
   file, but it is way too vague for a global function. This is to match
   refnames, so I suspect there should at least be a string "ref_"
   somewhere in its name.

 - You pass "flags" argument, so that later we _could_ enhance the
   implementation to cover needs for new callers, but alas, it uses its
   full bits to express only one "do we do FNM_PATHNAME or not?" bit of
   information, so essentially "flags" does not give us any expandability.

 - Is it a sane assumption that a caller that asks FNM_PATHNAME will
   always want match_path() semantics, too?  Aren't these two logically
   independent?

 - Is it a sane assumption that a caller that gives an exclude list will
   want neither FNM_PATHNAME semantics nor match_path() semantics?

 - Positive patterns are passed in "const char **match", and negative ones
   are in "struct string_list *". Doesn't the inconsistency strike you as
   strange?

Perhaps like...

#define REF_MATCH_LEADING       01
#define REF_MATCH_TRAILING      02
#define REF_MATCH_FNM_PATH      04

static int match_one(const char *name, size_t namelen, const char *pattern,
		unsigned flags)
{
       	if ((flags & REF_MATCH_LEADING) &&
            match_leading_path(name, pattern, namelen))
		return 1;
       	if ((flags & REF_MATCH_TRAILING) &&
            match_trailing_path(name, pattern, namelen))
		return 1;
	if (!fnmatch(pattern, name, 
		     (flags & REF_MATCH_FNM_PATH) ? FNM_PATHNAME : 0))
		return 1;
	return 0;
}

int ref_match_pattern(const char *name,
		const char **pattern, const char **exclude, unsigned flags)
{
	size_t namelen = strlen(name);
        if (exclude) {
		while (*exclude) {
			if (match_one(name, namelen, *exclude, flags))
				return 0;
			exclude++;
		}
	}
        if (!pattern || !*pattern)
        	return 1;
	while (*pattern) {
		if (match_one(name, namelen, *pattern, flags))
			return 1;
		pattern++;
	}
        return 0;
}

and then the caller could do something like

	ref_match_pattern("refs/heads/master",
        		  ["maste?", NULL],
                          ["refs/heads/", NULL],
                          (REF_MATCH_FNM_PATH|REF_MATCH_LEADING));

Note that the above "ref_match_pattern()" gives the same "flags" for the
call to match_one() for elements in both positive and negative array and
it is very deliberate.  See review comment to [3/5] for the reasoning.

Thanks.
