From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/33] peel_ref(): fix return value for non-peelable,
 not-current reference
Date: Mon, 15 Apr 2013 10:38:27 -0700
Message-ID: <7va9ozwv70.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnMl-0004En-Dp
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388Ab3DORim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:38:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934290Ab3DORi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:38:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FDBB15C0A;
	Mon, 15 Apr 2013 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=uOpJVzglHvIh/idNctm0INql8hc=; b=J5jODkLML3LBQI16dlpE
	MTgYrWjhioW8EWyeDUjbUBNIPv4IjR+V2Vf4KBg504Ho+QiyddXgku9mXhStwZNQ
	+9yy+U4k4kLuykuIuT4lxFh1eB48jaesF73KCVTvohG9ZF56NdveFR3IuJAMCZU/
	awRn26KvalmXkuAXJ8jN2jU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oEPyDKvqV8pQ+A5034VlnpcemYiDEIqoOZI3TY9PcKJqIE
	Id8JJ8L/yKcs5I7GgLVfm0jxQPPx+smt0OUGUC8xB52wRGUxuw5mullp1Idb6tit
	LX47D2HDfkXVH5lDAXEFwnL6DaDxBhNNJQypSxDa4+9Bqu+6vVIR/7VzIoKvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2386715C09;
	Mon, 15 Apr 2013 17:38:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9916B15C05; Mon, 15 Apr
 2013 17:38:28 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 487D166A-A5F3-11E2-8DC8-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221261>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The old version was inconsistent: when a reference was
> REF_KNOWS_PEELED but with a null peeled value, it returned non-zero
> for the current reference but zero for other references.  Change the
> behavior for non-current references to match that of current_ref,
> which is what callers expect.  Document the behavior.
>
> Current callers did not trigger the previously-buggy behavior.

Is that because we were lucky by codeflow, or is it just that we
didn't have a testcase to trigger the behaviour?

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 5 ++++-
>  refs.h | 8 ++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 84c2497..a0d8e32 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -120,7 +120,8 @@ struct ref_value {
>  	/*
>  	 * If REF_KNOWS_PEELED, then this field holds the peeled value
>  	 * of this reference, or null if the reference is known not to
> -	 * be peelable.
> +	 * be peelable.  See the documentation for peel_ref() for an
> +	 * exact definition of "peelable".
>  	 */
>  	unsigned char peeled[20];
>  };
> @@ -1339,6 +1340,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
>  		struct ref_entry *r = get_packed_ref(refname);
>  
>  		if (r && (r->flag & REF_KNOWS_PEELED)) {
> +			if (is_null_sha1(r->u.value.peeled))
> +			    return -1;
>  			hashcpy(sha1, r->u.value.peeled);
>  			return 0;
>  		}
> diff --git a/refs.h b/refs.h
> index 17bc1c1..ac0ff92 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -74,6 +74,14 @@ extern void add_packed_ref(const char *refname, const unsigned char *sha1);
>  
>  extern int ref_exists(const char *);
>  
> +/*
> + * If refname is a non-symbolic reference that refers to a tag object,
> + * and the tag can be (recursively) dereferenced to a non-tag object,
> + * store the SHA1 of the referred-to object to sha1 and return 0.  If
> + * any of these conditions are not met, return a non-zero value.
> + * Symbolic references are considered unpeelable, even if they
> + * ultimately resolve to a peelable tag.
> + */
>  extern int peel_ref(const char *refname, unsigned char *sha1);
>  
>  /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
