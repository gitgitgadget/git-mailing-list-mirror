From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] receive-pack.c: only accept push-cert if push_cert_nonce was advertised
Date: Fri, 09 Jan 2015 14:39:33 -0800
Message-ID: <xmqqsifjbmu2.fsf@gitster.dls.corp.google.com>
References: <1420836437-11068-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 23:39:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9iDa-000253-J8
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 23:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758191AbbAIWji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 17:39:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752355AbbAIWjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 17:39:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF5382D473;
	Fri,  9 Jan 2015 17:39:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UDAwoc2YMgoo300ewI4O7+CbMPo=; b=Z61XsZ
	7YLLNDeVpAFG1Z74uWOrv3CTVW2EhSspSGlb4VjDoReDdMbNifOPZx9jnfCms+Yf
	m/Njrf8PnF0zQLqnHVECx3OH1Vs8HjVE9X7ql8uNPtveHkdagkWqSaVCMPg5HNLD
	KqVtlK80qKbxs29U3BDHp9Sic4ebuPhfGNtv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EHqeAdjwvj5HBZNzjV+S9lqZbNhOsnOI
	4Tz8So5+dCM39QTnMg9iwrEIClM2oni71GhyNgXsWGsYXewsd2PxLVqK1jNrG+3u
	+W0OITUO6fvFItaGcum9DB8hVHs63O8KP25GoT8z7TBtzeO4HhsjPaRlKxgrYl4U
	L4ajX20P9Z0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E55752D472;
	Fri,  9 Jan 2015 17:39:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 634DC2D46F;
	Fri,  9 Jan 2015 17:39:34 -0500 (EST)
In-Reply-To: <1420836437-11068-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 9 Jan 2015 12:47:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 626E6D48-9850-11E4-BEDC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262247>

Stefan Beller <sbeller@google.com> writes:

> If the server did not advertise the capability to have signed pushes
> it should not accept signed pushes as stated in
> Documentation/technical/protocol-capabilities.txt:
>
>     Client will then send a space separated list of capabilities it wants
>     to be in effect. The client MUST NOT ask for capabilities the server
>     did not say it supports.
>
>     Server MUST diagnose and abort if capabilities it does not understand
>     was sent.  Server MUST NOT ignore capabilities that client requested
>     and server advertised.  As a consequence of these rules, server MUST
>     NOT advertise capabilities it does not understand.
>
> After rereading the second paragraph I think they should also be reworded to
>
>     Server MUST diagnose and abort if capabilities it did not advertise
>     was sent.

Except for s/was sent/was requested/, I think that rule makes sense
very much.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 4c069c5..628d13a 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1276,7 +1276,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
>  				use_atomic = 1;
>  		}
>  
> -		if (!strcmp(line, "push-cert")) {
> +		if (push_cert_nonce &&
> +		    !strcmp(line, "push-cert")) {
>  			int true_flush = 0;
>  			char certbuf[1024];

This implementation is somewhat questionable.

The server knows how to parse "push-cert" line, knows that what
follows after that line up to "push-cert-end" line are shaped very
differently from protocol commands outside the push-cert block.  In
other words, it knows how to parse the request meant for the capable
server; it just wants to refuse to serve that request.

The patched code will make it fail by hoping that queue_command()
that only handles "40-hex 40-hex ref" will reject the line that
begins with "push-cert".  Instead of relying on such a hidden
dependency, wouldn't it be cleaner to actually parse the push-cert
block and then at the end notice and explictly say "Your requests
were syntactically correct, but I am not going to honor your request
to use the push-cert extension, because I never told you that I'd
offer you that capability", instead of rejecting the request with "I
was expecting old/new/ref but you sent a line with 'push-cert' on
it; what are you talking about?"
