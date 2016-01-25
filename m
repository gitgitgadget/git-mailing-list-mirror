From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push --force-with-lease: Fix ref status reporting
Date: Mon, 25 Jan 2016 11:37:33 -0800
Message-ID: <xmqqvb6hfo1u.fsf@gitster.mtv.corp.google.com>
References: <1453346248-4489-1-git-send-email-agwheeler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andrew Wheeler <awheeler@motorola.com>
To: Andrew Wheeler <agwheeler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:38:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmy6-0004NM-R9
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 20:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbcAYTiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 14:38:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932843AbcAYThh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 14:37:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E03003F8A5;
	Mon, 25 Jan 2016 14:37:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FAVGTClH0zt/Kv7TttWFKz2s5eg=; b=pGhESM
	nIxAjaIRclORPlhE041ejze8UkWpBU2/f1utaQJiGE4XkvzUPh7zlS+P7OFl/aYI
	k2XJ5ithV1hMPa2o1AgRAObUr3xYMCmjEfYqXYF5rWTVWo6rSaJhErO6qVTxvkUj
	KbbnCW7z+bpwHEdoNrLxeDnzeTv3fzzq7BlC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/9l5p9ccDMAD1V4wgFJ2o588yu8jxVC
	6FxSPwsQpt/EPpHrUy32oQ/KVAK+Cnq5dfNxzAdO7HhhaqddYqy8lDUOWwf/kXZO
	hyN0+0DPf4A9OfZpRYk9kXqAGAgQrAJ4sQl6prTWLE+eb4bbGfLsYHNd3WhLfFth
	V5LqwZuTlos=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDF153F8A4;
	Mon, 25 Jan 2016 14:37:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F30CB3F8A3;
	Mon, 25 Jan 2016 14:37:34 -0500 (EST)
In-Reply-To: <1453346248-4489-1-git-send-email-agwheeler@gmail.com> (Andrew
	Wheeler's message of "Wed, 20 Jan 2016 21:17:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1557DEA0-C39B-11E5-8CEF-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284752>

Andrew Wheeler <agwheeler@gmail.com> writes:

> From: Andrew Wheeler <awheeler@motorola.com>
>
> The --force--with-lease push option leads to less
> detailed status information than --force. In particular,
> the output indicates that a reference was fast-forwarded,
> even when it was force-updated.
>
> Modify the --force-with-lease ref status logic to leverage
> the --force ref status logic when the "lease" conditions
> are met.

The description of the observed problem makes sense.  Thanks for
working on this.

> Signed-off-by: Andrew Wheeler <awheeler@motorola.com>
> ---
>  remote.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 9d34b5a..bad6213 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1545,11 +1545,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  		}
>  
>  		/*
> -		 * Bypass the usual "must fast-forward" check but
> -		 * replace it with a weaker "the old value must be
> -		 * this value we observed".  If the remote ref has
> -		 * moved and is now different from what we expect,
> -		 * reject any push.
> +		 * If the remote ref has moved and is now different
> +		 * from what we expect, reject any push.
>  		 *

This simplification of the comment makes sense, especially with the
code that results from the change of the last "else if".

>  		 * It also is an error if the user told us to check
>  		 * with the remote-tracking branch to find the value
> @@ -1560,10 +1557,14 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  			if (ref->expect_old_no_trackback ||
>  			    oidcmp(&ref->old_oid, &ref->old_oid_expect))
>  				reject_reason = REF_STATUS_REJECT_STALE;
> +			else
> +				/* If the ref isn't stale then force the update. */
> +				force_ref_update = 1;
>  		}
>  
>  		/*
> -		 * The usual "must fast-forward" rules.
> +		 * If the update isn't already rejected then check
> +		 * the usual "must fast-forward" rules.
>  		 *
>  		 * Decide whether an individual refspec A:B can be
>  		 * pushed.  The push will succeed if any of the
> @@ -1580,9 +1581,10 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  		 *
>  		 * (4) it is forced using the +A:B notation, or by
>  		 *     passing the --force argument
> +		 *

This new blank line is probably unwanted.

>  		 */
>  
> -		else if (!ref->deletion && !is_null_oid(&ref->old_oid)) {
> +		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
>  			if (starts_with(ref->name, "refs/tags/"))
>  				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
>  			else if (!has_object_file(&ref->old_oid))

OK.  So the idea is that a successful force-with-lease push would
have a zero reject_reason at this point, and the if/else cascade
would still trigger and would set it to STATUS_REJECT_NEEDS_FORCE,
just like a usual forced push without a lease.  And then because the
local variable force_ref_update is set, it would report the forced
success exactly the same way as the usual forced push.

Sounds very sensible.

Do we want to make sure that other people will not break this fix in
the future by adding a few tests, perhaps to t/t5533?

Thanks.
