From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/33] refs: extract a function ref_resolves_to_object()
Date: Mon, 15 Apr 2013 09:51:59 -0700
Message-ID: <7v7gk3zqhc.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmdV-0007tQ-UZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933395Ab3DOQwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:52:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46650 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998Ab3DOQwC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:52:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07B9A161B1;
	Mon, 15 Apr 2013 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xm7Zbv/HF7HtX/gjFOSaXM5NAEI=; b=XrOlEi
	lHcMcOLy1y8l6FvGJtWbc7IETBegSmAwBOlMgjBsSdoEwcuM5ZCRN7H8NxMUS5vm
	AlILBx8dUMAFpT+PYfJgljuOXHCR9g78H+VM0vZcxEeg3tRgOcDnoZYTrzaNZwo6
	FC7Bdpc8UXDlYMUPK4n+F5mNQV/n8r9NirxJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uv3i/qNeFLFJ0aN60t3gcBYVIJbdZ3Gb
	9LMKIhyx1p+8A72vtoIZKmnWHRK9BSTR7SF/LzTBybY7c2Bk5fF38qNhigcs5kpg
	8S+wS1kMvB7RP9YHn7+mgqgqY1IzbQ6R/QL+++spSrUvWbuKfPbob+uBsMWpHGiW
	H3vvtg7ABSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2EDB161B0;
	Mon, 15 Apr 2013 16:52:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B86A161AA; Mon, 15 Apr
 2013 16:52:01 +0000 (UTC)
In-Reply-To: <1365944088-10588-11-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sun, 14 Apr 2013 14:54:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB1E59F0-A5EC-11E2-949A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221253>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It is a nice unit of work and soon will be needed from multiple
> locations.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index c523978..dfc8600 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -529,6 +529,22 @@ static void sort_ref_dir(struct ref_dir *dir)
>  #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
>  
>  /*
> + * Return true iff the reference described by entry can be resolved to
> + * an object in the database.  Emit a warning if the referred-to
> + * object does not exist.
> + */
> +static int ref_resolves_to_object(struct ref_entry *entry)
> +{
> +	if (entry->flag & REF_ISBROKEN)
> +		return 0;
> +	if (!has_sha1_file(entry->u.value.sha1)) {
> +		error("%s does not point to a valid object!", entry->name);
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +/*
>   * current_ref is a performance hack: when iterating over references
>   * using the for_each_ref*() functions, current_ref is set to the
>   * current reference's entry before calling the callback function.  If
> @@ -549,14 +565,10 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
>  	if (prefixcmp(entry->name, base))
>  		return 0;
>  
> -	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
> -		if (entry->flag & REF_ISBROKEN)
> -			return 0; /* ignore broken refs e.g. dangling symref */
> -		if (!has_sha1_file(entry->u.value.sha1)) {
> -			error("%s does not point to a valid object!", entry->name);
> -			return 0;
> -		}
> -	}
> +	if (!((flags & DO_FOR_EACH_INCLUDE_BROKEN) ||
> +	      ref_resolves_to_object(entry)))
> +		return 0;
> +

The original says "Unless flags tell us to include broken ones,
return 0 for the broken ones and the ones that point at invalid
objects".

The updated says "Unless flags tell us to include broken ones or the
ref is a good one, return 0".

Are they the same?  If we have a good one, and if we are not told to
include broken one, the original just passes the control down to the
remainder of the function.  The updated one will return 0.

Oh, wait, that is not the case.  The OR is inside !( A || B ), so
what it really wants to say is:

	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
            !ref_resolves_to_object(entry))
		return 0;

that is, "When we are told to exclude broken ones and the one we are
looking at is broken, return 0".

Am I the only one who was confused with this, or was the way the
patch wrote this logic unnecessarily convoluted?

>  	current_ref = entry;
>  	retval = fn(entry->name + trim, entry->u.value.sha1, entry->flag, cb_data);
>  	current_ref = NULL;
