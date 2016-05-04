From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] upload-pack.c: Refactor capability advertising
Date: Wed, 04 May 2016 13:05:58 -0700
Message-ID: <xmqq37pxh9ll.fsf@gitster.mtv.corp.google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	<1461972887-22100-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: dturner@twopensource.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 22:06:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay33h-0005yZ-4o
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbcEDUGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 16:06:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753114AbcEDUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:06:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF73A18F89;
	Wed,  4 May 2016 16:06:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YSQicBX7E7Jq3KPiRGG761UNvcY=; b=e178s2
	qjcqK2FjIeeUty6uu2xsIKuJZBjFnmz3YMdy/BshNp5CJG+HpKK0Vq1CfcwVY1lS
	9JNw9/PTX2Y79VyGU+ncH50aKwgojKfkbqzKhVBTHgsfi0w0LJKZoWYFwUp+LuzA
	HHtvSddrrtH9O5t2kNqeumns7pQjLw52Cv81o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cGpzeo/jphXvKwBCf96q8IVaCQzrm+UG
	Rl7Rx3534HW+ScNpEa2kOfOxOECP16x8Oxy11bFotaFXF3df5KufFnG6qKlm3Tv+
	++JN0TOGqVI/Vv2WV2/WgShnSUPa7e1AeUGy0jU4dj3J7yZdiNeJwCScyH34XvFV
	btpCzumMFNA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E80FB18F88;
	Wed,  4 May 2016 16:06:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A293A18F87;
	Wed,  4 May 2016 16:06:00 -0400 (EDT)
In-Reply-To: <1461972887-22100-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 29 Apr 2016 16:34:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F5D2600-1233-11E6-9576-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293579>

Stefan Beller <sbeller@google.com> writes:

> Instead of having the capabilities in a local string, keep them
> in a struct outside the function. This will allow us in a later patch
> to easily reuse the capabilities in version 2 of the protocol.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Between a flat string and a list, you may be able to enumerate the
elements in a list more easily, but my knee-jerk reaction is that
this does not go far enough, if you are to introduce a table.  It
for example does not allow us to lose the conditional writing of
some capabilties based on allow_*_request and replace that with a
more table-driven approach.

Perhaps that can come in a later step (in other words, the above is
not a basis for rejecting this change; just pointing it out that
this does not have to be the end of the story).

>  upload-pack.c | 59 ++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 19 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index aaaf883..85381d5 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -719,37 +719,58 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
>  		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
>  }
>  
> +static int advertise_capabilities = 1;
> +const char *all_capabilities[] = {
> +	"multi_ack",
> +	"thin-pack",
> +	"side-band",
> +	"side-band-64k",
> +	"ofs-delta",
> +	"shallow",
> +	"no-progress",
> +	"include-tag",
> +	"multi_ack_detailed",
> +	"allow-tip-sha1-in-want",
> +	"allow-reachable-sha1-in-want",
> +	"no-done",
> +};
> +
>  static int send_ref(const char *refname, const struct object_id *oid,
>  		    int flag, void *cb_data)
>  {
> -	static const char *capabilities = "multi_ack thin-pack side-band"
> -		" side-band-64k ofs-delta shallow no-progress"
> -		" include-tag multi_ack_detailed";
>  	const char *refname_nons = strip_namespace(refname);
>  	struct object_id peeled;
>  
>  	if (mark_our_ref(refname_nons, refname, oid))
>  		return 0;
>  
> -	if (capabilities) {
> -		struct strbuf symref_info = STRBUF_INIT;
> -
> -		format_symref_info(&symref_info, cb_data);
> -		packet_write(1, "%s %s%c%s%s%s%s%s agent=%s\n",
> -			     oid_to_hex(oid), refname_nons,
> -			     0, capabilities,
> -			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
> -				     " allow-tip-sha1-in-want" : "",
> -			     (allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1) ?
> -				     " allow-reachable-sha1-in-want" : "",
> -			     stateless_rpc ? " no-done" : "",
> -			     symref_info.buf,
> -			     git_user_agent_sanitized());
> -		strbuf_release(&symref_info);
> +	if (advertise_capabilities) {
> +		int i;
> +		struct strbuf capabilities = STRBUF_INIT;
> +
> +		for (i = 0; i < ARRAY_SIZE(all_capabilities); i++) {
> +			const char *cap = all_capabilities[i];
> +			if (!strcmp(cap, "allow-tip-sha1-in-want")
> +			    && !(allow_unadvertised_object_request & ALLOW_TIP_SHA1))
> +				continue;
> +			if (!strcmp(cap, "allow-reachable-sha1-in-want")
> +			    && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
> +				continue;
> +			if (!strcmp(cap, "no-done") && !stateless_rpc)
> +				continue;
> +			strbuf_addf(&capabilities, " %s", cap);
> +		}
> +
> +		format_symref_info(&capabilities, cb_data);
> +		strbuf_addf(&capabilities, " agent=%s", git_user_agent_sanitized());
> +
> +		packet_write(1, "%s %s%c%s\n", oid_to_hex(oid), refname_nons,
> +			     0, capabilities.buf);
> +		strbuf_release(&capabilities);
> +		advertise_capabilities = 0;
>  	} else {
>  		packet_write(1, "%s %s\n", oid_to_hex(oid), refname_nons);
>  	}
> -	capabilities = NULL;
>  	if (!peel_ref(refname, peeled.hash))
>  		packet_write(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
>  	return 0;
