From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 08/10] send-pack.c: add --atomic command line argument
Date: Mon, 12 Jan 2015 13:57:22 -0800
Message-ID: <xmqq8uh77jct.fsf@gitster.dls.corp.google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
	<1420687404-13997-9-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:57:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAmzI-00008s-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 22:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbbALV50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 16:57:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751813AbbALV5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 16:57:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 472302F3D8;
	Mon, 12 Jan 2015 16:57:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a/KU2s1gPO+iJrQq8WBfhW7t03s=; b=pLSgMm
	ThU35woDb50NbwKWDSYj1YaP4hocPbzg8048tM50QZPHds73kdar/daSLDJyu3zR
	zYz0knzQruCqmCSW3IPQbvwlNFcyt3Clq8WYjEkEd8HV4fqWxJdNKxVMs+ThS1rs
	DscPdrkapdrjNwVj9rec6xKeziaX60uIqgNS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yS+HGpRICBzJg3jmXEfhTHXe9trwR0m6
	UPoC5ixzWngrPo02ZNWnI9NpAJGTpGw4JkmI1Mt17PXZKfWGpkqlBH82r6ggf+no
	yL8ghcUSFOrq0OiqDxMfANbUdGHR9lEsl+NmbMtzj4vi/rZd7ES0NKmy14vfOZMN
	OKApIcTBQCw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A53A2F3D7;
	Mon, 12 Jan 2015 16:57:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A26D62F3D6;
	Mon, 12 Jan 2015 16:57:23 -0500 (EST)
In-Reply-To: <1420687404-13997-9-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 7 Jan 2015 19:23:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD459420-9AA5-11E4-903A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262297>

Stefan Beller <sbeller@google.com> writes:

> +static int atomic_push_failure(struct send_pack_args *args,
> +			       struct ref *remote_refs,
> +			       struct ref *failing_ref)
> +{
> +	struct ref *ref;
> +	/* Mark other refs as failed */
> +	for (ref = remote_refs; ref; ref = ref->next) {
> +		if (!ref->peer_ref && !args->send_mirror)
> +			continue;
> +
> +		switch (ref->status) {
> +		case REF_STATUS_EXPECTING_REPORT:
> +			ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> +			continue;
> +		default:
> +			; /* do nothing */
> +		}
> +	}
> +	return error("atomic push failed for ref %s. status: %d\n",
> +		     failing_ref->name, failing_ref->status);
> +}

Given remote_refs, this will mark all refs that are still in the
"expecting" state as "failed".

> @@ -363,9 +396,21 @@ int send_pack(struct send_pack_args *args,
>  	 * the pack data.
>  	 */
>  	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (check_to_send_update(ref, args) < 0)
> +		switch (check_to_send_update(ref, args)) {
> +		case 0: /* no error */
> +			break;
> +		case CHECK_REF_STATUS_REJECTED:
> +			/*
> +			 * When we know the server would reject a ref update if
> +			 * we were to send it and we're trying to send the refs
> +			 * atomically, abort the whole operation.
> +			 */
> +			if (use_atomic)
> +				return atomic_push_failure(args, remote_refs, ref);
> +			/* Fallthrough for non atomic case. */
> +		default:
>  			continue;
> -
> +		}

And this loop stops when it sees one that would certainly get
rejected, letting the other function mark "expecting" ones as "would
fail".

We could have skipped refs that are OK (e.g. REF_STATUS_UPTODATE)
before we saw the first rejection, but it is OK not to go back and
mark them as "would fail", because the other side will not be seeing
our attempt to update these refs anyway.

OK, it makes sense to me.
