From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/17] lock_ref_sha1_basic(): on SCLD_VANISHED, retry
Date: Mon, 06 Jan 2014 09:54:25 -0800
Message-ID: <xmqq4n5hj8ry.fsf@gitster.dls.corp.google.com>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
	<1389015935-21936-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:54:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ENn-0000Uc-35
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbaAFRyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:54:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754601AbaAFRya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:54:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77AA55F7B6;
	Mon,  6 Jan 2014 12:54:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Y171ma/rC4jToebUdDMhjR+IE0=; b=VWJpkD
	OLrAAoptZWY5+qmdyvQsuORvH6BzcFNZHgv0Y+rKqF7WgJBwesudwgT8/4wc7Yf+
	jU6+jZ3hleS2CTzcMEb9wyzF77CMmT3mZhUSL+xBUdM+rCRcQou7vBKNX+DRGXe7
	rtslJgClvm0OaruOgsrG4nMEl2So1L43qfZv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f1QZHiH4jXGi7xPsuzu/VEeQaYULAA/Z
	TeoG6Es5y/x4zsZnt9PVSLDEvPopltq8W5rv1kfLiMe7VVjzYWxZwkyFfpDV/T/a
	l/QyrvVUWtlTHXxMrLMQQR0VSb0jeC2o/C/SmOtEMVKyJh+xxxk9ce/ieELm3aFS
	SjzqIr6ciBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3015F7B1;
	Mon,  6 Jan 2014 12:54:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85CB85F7B0;
	Mon,  6 Jan 2014 12:54:27 -0500 (EST)
In-Reply-To: <1389015935-21936-11-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 6 Jan 2014 14:45:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 95EF1D24-76FB-11E3-8E90-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240040>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If safe_create_leading_directories() fails because a file along the
> path unexpectedly vanished, try again (up to 3 times).
>
> This can occur if another process is deleting directories at the same
> time as we are trying to make them.  For example, "git pack-refs
> --all" tries to delete the loose refs and any empty directories that
> are left behind.  If a pack-refs process is running, then it might
> delete a directory that we need to put a new loose reference in.
>
> If safe_create_leading_directories() thinks this might have happened,
> then take its advice and try again (maximum three attempts).
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 3926136..6eb8a02 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2039,6 +2039,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	int type, lflags;
>  	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
>  	int missing = 0;
> +	int attempts = 3;
>  
>  	lock = xcalloc(1, sizeof(struct ref_lock));
>  	lock->lock_fd = -1;
> @@ -2093,7 +2094,15 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
>  		lock->force_write = 1;
>  
> -	if (safe_create_leading_directories(ref_file)) {
> + retry:
> +	switch (safe_create_leading_directories(ref_file)) {
> +	case SCLD_OK:
> +		break; /* success */
> +	case SCLD_VANISHED:
> +		if (--attempts > 0)
> +			goto retry;
> +		/* fall through */

Hmph.

Having no backoff/sleep at all might be OK here as long as the other
side that removes does not retry (and I do not think the other side
would, even though I haven't read through the series to the end yet
;-)).

This may be just a style thing, but I find that the variable name
"attempts" that starts out as 3 quite misleading, as its value is
not "the number of attempts made" but "the remaining number of
attempts allowed."  Starting it from 0 and then

	if (attempts++ < MAX_ATTEMPTS)
		goto retry;

would be one way to clarify it.  Renaming it to remaining_attempts
would be another.

> +	default:
>  		last_errno = errno;
>  		error("unable to create directory for %s", ref_file);
>  		goto error_return;
