From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/33] repack_without_ref(): silence errors for dangling packed refs
Date: Mon, 22 Apr 2013 15:21:29 -0700
Message-ID: <7vip3enr4m.fsf@alter.siamese.dyndns.org>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
	<1366660361-21831-18-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUP7A-0003Lx-Py
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab3DVWVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:21:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259Ab3DVWVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:21:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8319F18D4B;
	Mon, 22 Apr 2013 22:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UikvmPqQ6SgQfcQZ2y7AmXVn6to=; b=aOTrYu
	jTPp+UpcT5YgQtWbpVhzYuubwfVLrjPM3eUykAFd8+jA62NYwEaJDHp+pFEbxnYq
	SIL8Tlu1cfsrTwYwlnl+zlLSwRGubVGEYO2G2azkaXdcnbg120fMIKV/knvGptDU
	MSNyPk46T+wFulFp/3io6PljPg7g4MvpfyqMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BrJb70TumKxnlc0AApHI7Sn+sdwO5eGq
	P1qONEM0VsD9Qx9q28HRfJKt7etZWhjWPpAbp/m63tGFucAEsm5foTV2c6BsM4F8
	xnr3fc9E0i8vymbhFMsF8j1xrzsw5tGIgdRJ69130d7aLnr/8W5Mc33YD8r9uUxj
	ja2kTWW5olo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7729E18D4A;
	Mon, 22 Apr 2013 22:21:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A489318D45;
	Mon, 22 Apr 2013 22:21:30 +0000 (UTC)
In-Reply-To: <1366660361-21831-18-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 22 Apr 2013 21:52:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB78AA8E-AB9A-11E2-9CE8-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222117>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Stop emitting an error message when deleting a packed reference if we
> find another dangling packed reference that is overridden by a loose
> reference.  See the previous commit for a longer explanation of the
> issue.
>
> We have to be careful to make sure that the invalid packed reference
> really *is* overridden by a loose reference; otherwise what we have
> found is repository corruption, which we *should* report.
>
> Please note that this approach is vulnerable to a race condition
> similar to the race conditions already known to affect packed
> references [1]:
>
> * Process 1 tries to peel packed reference X as part of deleting
>   another packed reference.  It discovers that X does not refer to a
>   valid object (because the object that it referred to has been
>   garbage collected).
>
> * Process 2 tries to delete reference X.  It starts by deleting the
>   loose reference X.
>
> * Process 1 checks whether there is a loose reference X.  There is not
>   (it has just been deleted by process 2), so process 1 reports a
>   spurious error "X does not point to a valid object!"
>
> The worst case seems relatively harmless, and the fix is identical to
> the fix that will be needed for the other race conditions (namely
> holding a lock on the packed-refs file during *all* reference
> deletions), so we leave the cleaning up of all of them as a future
> project.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/211956
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Clean and straight-forward implementation that is very well
explained.  I like this much better than the previous round ;-).

Thanks, will re-queue.

>  refs.c               | 37 +++++++++++++++++++++++++++++++++++--
>  t/t3210-pack-refs.sh |  2 +-
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ed54ed4..2957f6d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1901,8 +1901,41 @@ static int repack_without_ref_fn(struct ref_entry *entry, void *cb_data)
>  
>  	if (!strcmp(data->refname, entry->name))
>  		return 0;
> -	if (!ref_resolves_to_object(entry))
> -		return 0; /* Skip broken refs */
> +	if (entry->flag & REF_ISBROKEN) {
> +		/* This shouldn't happen to packed refs. */
> +		error("%s is broken!", entry->name);
> +		return 0;
> +	}
> +	if (!has_sha1_file(entry->u.value.sha1)) {
> +		unsigned char sha1[20];
> +		int flags;
> +
> +		if (read_ref_full(entry->name, sha1, 0, &flags))
> +			/* We should at least have found the packed ref. */
> +			die("Internal error");
> +		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED))
> +			/*
> +			 * This packed reference is overridden by a
> +			 * loose reference, so it is OK that its value
> +			 * is no longer valid; for example, it might
> +			 * refer to an object that has been garbage
> +			 * collected.  For this purpose we don't even
> +			 * care whether the loose reference itself is
> +			 * invalid, broken, symbolic, etc.  Silently
> +			 * omit the packed reference from the output.
> +			 */
> +			return 0;
> +		/*
> +		 * There is no overriding loose reference, so the fact
> +		 * that this reference doesn't refer to a valid object
> +		 * indicates some kind of repository corruption.
> +		 * Report the problem, then omit the reference from
> +		 * the output.
> +		 */
> +		error("%s does not point to a valid object!", entry->name);
> +		return 0;
> +	}
> +
>  	len = snprintf(line, sizeof(line), "%s %s\n",
>  		       sha1_to_hex(entry->u.value.sha1), entry->name);
>  	/* this should not happen but just being defensive */
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index c032d88..559f602 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -142,7 +142,7 @@ test_expect_success 'delete ref with dangling packed version' '
>  	test_cmp /dev/null result
>  '
>  
> -test_expect_failure 'delete ref while another dangling packed ref' '
> +test_expect_success 'delete ref while another dangling packed ref' '
>  	git branch lamb &&
>  	git commit --allow-empty -m "future garbage" &&
>  	git pack-refs --all &&
