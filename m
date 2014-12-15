From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] send-pack.c: add an --atomic-push command line argument
Date: Mon, 15 Dec 2014 13:01:19 -0800
Message-ID: <xmqqsiggd3vk.fsf@gitster.dls.corp.google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
	<1418673368-20785-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 22:01:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0cll-0007Q5-7T
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 22:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbaLOVBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 16:01:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750716AbaLOVBX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 16:01:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEFAB2706C;
	Mon, 15 Dec 2014 16:01:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+IOQLU3BFNlOKJfO89IA4nxo88k=; b=MTnW8b
	5Xv6ThCyNDD46VebLAYCAaLi2CJzkfHpxO71mEsz8l/uC1q/oe/1aKHsaKK61NvS
	v+ktyMQ5jl3o6ycUp/euIMnpyCaT+6womnjkXHF2dAnalpk58I9xW0VwV2Z2XeKg
	40Gk2wtqUeGeMIJk02S+YKbKcs/5XaDsG+kKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SVHu0EtZxxqt1KQH2sIDwqW/77e4fxl4
	gMaWjhtL4Px1xWz5h82UCwPqJjwjvQartVCN7uLvsLyWNTByDpTuFMHXLILWF9vY
	9lvVwU4CkB9d3uMh/9zZgLhBfj/7nnY6zyTvpoZ3FEEClWSXAFAsgsCM9wWSNUOD
	7FyebmnxMps=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF98D2706B;
	Mon, 15 Dec 2014 16:01:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED9DD2706A;
	Mon, 15 Dec 2014 16:01:20 -0500 (EST)
In-Reply-To: <1418673368-20785-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 15 Dec 2014 11:56:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 85628B0C-849D-11E4-8AE3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261423>

Stefan Beller <sbeller@google.com> writes:

> -static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
> +static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args, int *atomic_push_failed)

Hmph.  Is "atomic push" so special that it deserves a separate
parameter?  When we come up with yet another mode of failure, would
we add another parameter to the callers to this function?

> @@ -203,6 +203,12 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
>  	case REF_STATUS_REJECT_NEEDS_FORCE:
>  	case REF_STATUS_REJECT_STALE:
>  	case REF_STATUS_REJECT_NODELETE:
> +		if (atomic_push_failed) {
> +			fprintf(stderr, "Atomic push failed for ref %s. "
> +				"Status:%d\n", ref->name, ref->status);
> +			*atomic_push_failed = 1;

All other error message that come from the codepaths around here
seem to avoid uppercase.  Also maybe you want to use error() here?

> +	if (args->use_atomic_push && !atomic_push_supported) {
> +		fprintf(stderr, "Server does not support atomic-push.");
> +		return -1;
> +	}

This check logically belongs to the previous step, no?

> +	atomic_push = atomic_push_supported && args->use_atomic_push;

>  
>  	if (status_report)
>  		strbuf_addstr(&cap_buf, " report-status");
> @@ -365,7 +376,8 @@ int send_pack(struct send_pack_args *args,
>  	 * the pack data.
>  	 */
>  	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (!ref_update_to_be_sent(ref, args))
> +		if (!ref_update_to_be_sent(ref, args,
> +			args->use_atomic_push ? &atomic_push_failed : NULL))
>  			continue;
>  
>  		if (!ref->deletion)
> @@ -377,6 +389,23 @@ int send_pack(struct send_pack_args *args,
>  			ref->status = REF_STATUS_EXPECTING_REPORT;
>  	}
>  
> +	if (atomic_push_failed) {
> +		for (ref = remote_refs; ref; ref = ref->next) {
> +			if (!ref->peer_ref && !args->send_mirror)
> +				continue;
> +
> +			switch (ref->status) {
> +			case REF_STATUS_EXPECTING_REPORT:
> +				ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> +				continue;
> +			default:
> +				; /* do nothing */
> +			}
> +		}
> +		fprintf(stderr, "Atomic push failed.");
> +		return -1;

The same comment as the other fprintf() applies here.

> @@ -728,6 +728,10 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
>  						 ref->deletion ? NULL : ref->peer_ref,
>  						 "remote failed to report status", porcelain);
>  		break;
> +	case REF_STATUS_ATOMIC_PUSH_FAILED:
> +		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
> +						 "atomic-push-failed", porcelain);

Why dashed-words-here?

> +		break;
>  	case REF_STATUS_OK:
>  		print_ok_ref_status(ref, porcelain);
>  		break;
