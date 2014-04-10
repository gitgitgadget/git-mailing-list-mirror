From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] refs.c: sort the refs by new_sha1 and merge the two update/delete loops into one
Date: Thu, 10 Apr 2014 12:01:23 -0700
Message-ID: <xmqqy4zdvwjg.fsf@gitster.dls.corp.google.com>
References: <1397154625-11884-1-git-send-email-sahlberg@google.com>
	<1397154625-11884-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:01:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKE9-0002v6-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758514AbaDJTB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:01:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbaDJTB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:01:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A84397BEA6;
	Thu, 10 Apr 2014 15:01:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6EOEsMZHXXOSXBi4W7Fy1Uqxojw=; b=v+5p8C
	FqAlqQuYJ0oTnekZMejqX+oDJFOqvMJcp14fNLRv6fgxI1c53GbPEy5WXp7MEJM6
	FruWBS0zOs8CkAr5XnsG4TZqTiFf9VKL1EjPMwEOadi1OX8Dfd5b5NFTmjpQeXcC
	HWKvUM1lR8yLu4pkEBAE2hsud6CVkAxLJuFVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XmdATYWcRsB/E4AaKTdipYFbQPzKsuTH
	WWliukLYhiEG7Pg1dQHyvVL2ZgdCAIMWn2sFnkyUcMfuJ6+X19e/zrucZx8i2wWl
	e57q0UEjMsHslLQzQX6k25BvTHtWPAUHGZZBIXqb16aPLEeJiVYAZqWnIec9r//9
	dvGoUR+gSLI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 936297BEA5;
	Thu, 10 Apr 2014 15:01:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 385097BEA2;
	Thu, 10 Apr 2014 15:01:25 -0400 (EDT)
In-Reply-To: <1397154625-11884-5-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Thu, 10 Apr 2014 11:30:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 837D1E58-C0E2-11E3-BE0B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246035>

Ronnie Sahlberg <sahlberg@google.com> writes:

> We want to make sure that we update all refs before we delete any refs
> so that there is no point in time where the tips may not be reachable
> from any ref in the system.
> We currently acheive this by first looping over all updates and applying
> them before we run a second loop and perform all the deletes.
>
> If we sort the new sha1 for all the refs so that a deleted ref,
> with sha1 0{40} comes at the end of the array, then we can just run
> a single loop and still guarantee that all updates happen before
> any deletes.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 1678e12..453318e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3309,6 +3309,15 @@ static int ref_update_compare(const void *r1, const void *r2)
>  	return strcmp((*u1)->ref_name, (*u2)->ref_name);
>  }
>  
> +static int ref_delete_compare(const void *r1, const void *r2)
> +{
> +	const struct ref_update * const *u1 = r1;
> +	const struct ref_update * const *u2 = r2;
> +
> +	/* -strcmp so that 0{40} sorts to the end */
> +	return -strcmp((*u1)->new_sha1, (*u2)->new_sha1);

Two glitches:

 - Didn't you mean hashcmp()?

 - Don't you have an explicit ->delete_ref field that is a more
   direct way, than relying on the convention "updating to 0{40}
   is to delte", to express this?

In other words, wouldn't it be more like

	return !(*u1)->delete_ref - !(*u2)->delete_ref;

or something (I may be wrong about the sign, tho---I didn't think
carefully)?


> +}
> +
>  static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>  					enum action_on_err onerr)
>  {
> @@ -3388,13 +3397,8 @@ int update_refs(const char *action, const struct ref_update **updates_orig,
>  		unlink_or_warn(git_path("logs/%s", delnames[i]));
>  	clear_loose_ref_cache(&ref_cache);
>  
> -	/* Perform updates first so live commits remain referenced */
> -	for (i = 0; i < n; i++)
> -		if (locks[i] && !locks[i]->delete_ref) {
> -			ret |= commit_ref_lock(locks[i]);
> -			locks[i] = NULL;
> -		}
> -	/* And finally perform all deletes */
> +	/* Sort the array so that we perform all updates before any deletes */
> +	qsort(updates, n, sizeof(*updates), ref_delete_compare);
>  	for (i = 0; i < n; i++)
>  		if (locks[i]) {
>  			ret |= commit_ref_lock(locks[i]);
