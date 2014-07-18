From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/12] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Fri, 18 Jul 2014 15:37:03 -0700
Message-ID: <xmqq8unql2eo.fsf@gitster.dls.corp.google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-7-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 00:37:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8GmG-0006dw-Tc
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 00:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762542AbaGRWhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 18:37:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61767 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762424AbaGRWhN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 18:37:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3F65288C4;
	Fri, 18 Jul 2014 18:37:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=20KNPHonRfNTczCB+zYUJnW7a4k=; b=rVuATU
	0noeKv+cvK8OHE5fK8JI90jRafyYFWpsIVl96A6wLni1nMEZPSMBDvynzsrs1hNN
	RPHkftT1kh63Stheb7ERGtQVTU4koFSp+6WIPq4llKXELOPm/6cYK1WSxd9Ce7jv
	Em18GXDEFEc2O/rsYwur0ZSrVbIoBvjhzLHZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SWDvCTvMeVbrPWMVA1Gdiqy3InO6MH7k
	rNDwvsUR5OYitvMD49q+4zTW3yljOeBassWM+upZcSSwJlw7Pt1J1TvSvhnm5rvK
	cqoMfXeI5wUy6ZGmNJylYUfsVQ9foUlWh+rwJH/9/2Qac/WY9/Uw0SDdibTUn9ol
	ztPKcE7vI5c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B935288C3;
	Fri, 18 Jul 2014 18:37:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5994C288BC;
	Fri, 18 Jul 2014 18:37:06 -0400 (EDT)
In-Reply-To: <1405549392-27306-7-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 16 Jul 2014 15:23:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0BE6F9DA-0ECC-11E4-8A78-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253856>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Move the check for check_refname_format from lock_any_ref_for_update
> to lock_ref_sha1_basic. At some later stage we will get rid of
> lock_any_ref_for_update completely.
>
> If lock_ref_sha1_basic fails the check_refname_format test, set errno to
> EINVAL before returning NULL. This to guarantee that we will not return an
> error without updating errno.
>
> This leaves lock_any_ref_for_updates as a no-op wrapper which could be removed.
> But this wrapper is also called from an external caller and we will soon
> make changes to the signature to lock_ref_sha1_basic that we do not want to
> expose to that caller.

That might be sensible if our only goal were to remove
lock-any-ref-for-updates, but I wonder what the impact of this
change to other existing callers of lock-ref-sha1-basic.  I may be
recalling things incorrectly, but I suspect that it was deliberate
to keep the lowest-level internal helper function (i.e. _basic()) to
be lenient so that those who do not want the format checks can
choose to pass refnames that are not exactly kosher.

> If we need such recovery code we could add it as an option to git fsck and have
> git fsck be the only sanctioned way of bypassing the normal API and checks.

But fsck is about checking and never about recovering, isn't it?
Does it offer to remove misnamed refs?  Should it?



> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 0df6894..f29f18a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2088,6 +2088,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	int missing = 0;
>  	int attempts_remaining = 3;
>  
> +	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +		errno = EINVAL;
> +		return NULL;
> +	}
> +
>  	lock = xcalloc(1, sizeof(struct ref_lock));
>  	lock->lock_fd = -1;
>  
> @@ -2179,8 +2184,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
>  					 const unsigned char *old_sha1,
>  					 int flags, int *type_p)
>  {
> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> -		return NULL;
>  	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
>  }
