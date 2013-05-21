From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] transport-helper: check if the dry-run is supported
Date: Tue, 21 May 2013 09:55:03 -0700
Message-ID: <7vli78p920.fsf@alter.siamese.dyndns.org>
References: <1369099924-13763-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 18:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UepqD-0002UW-E4
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 18:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab3EUQzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 12:55:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab3EUQzG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 12:55:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA7071EC8D;
	Tue, 21 May 2013 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9HP/hIs8E8tFuCCgV4gUEgP92/0=; b=PCRRfD
	Wu9Mg12pT894KVze4+x5A4mFhi252tMthxkhrEyHRepfzNMIhI+5jRujcKcDTS8a
	/KOQBzqWxf7S840Bkz7jBWafzMC+Y0OPcc9m6IrvAm4eFeAs6mekzSVwZ4Gs4AJm
	DyXwPFn92xI23WiRD+S1BwOQ/syvPyMwX1n8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FxXwh9UJgRfAsZzCMCYnSycBW/YhNl8W
	MCGd2HM+NN9P0EY0iK0GR89LCTy2rlBQIl+a0qcseNJkZIzVv2oW8UrjqID5ECPO
	vmCrU8/S8R0ch2hTAviXK9sFWq75h7KXqjQr6/jDdD9XdRB8lknhT8yBUPs2C2ex
	B19NBB88Q/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D079C1EC8B;
	Tue, 21 May 2013 16:55:05 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EB3C1EC89;
	Tue, 21 May 2013 16:55:05 +0000 (UTC)
In-Reply-To: <1369099924-13763-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 20 May 2013 20:32:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FA1B410-C237-11E2-8DBE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225043>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Certain remote-helpers (the ones with 'export') would try to push
> regardless.
>
> Obviously this is not what the user wants.
>
> Also, add a check for the 'dry-run' option, so remote-helpers can
> implement it.

This sounds like a good thing to do.  Perhaps the refspec mapping
can be handled the same way as a backend feature so that you do not
have to unconditionally disable it in the other patch.

Will queue both but not for 1.8.3.

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  transport-helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 522d791..c8c39fc 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -789,6 +789,11 @@ static int push_refs_with_export(struct transport *transport,
>  	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
>  	struct strbuf buf = STRBUF_INIT;
>  
> +	if (flags & TRANSPORT_PUSH_DRY_RUN) {
> +		if (set_helper_option(transport, "dry-run", "true") != 0)
> +			die("helper %s does not support dry-run", data->name);
> +	}
> +
>  	helper = get_helper(transport);
>  
>  	write_constant(helper->in, "export\n");
