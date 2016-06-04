From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Sat, 04 Jun 2016 09:30:15 -0700
Message-ID: <xmqqeg8czzl4.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160603110843.15434-1-pclouds@gmail.com>
	<20160603110843.15434-4-pclouds@gmail.com>
	<575199E7.7000503@xiplink.com> <20160604003126.GA10430@ash>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 18:34:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9ESu-0006vQ-Gn
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 18:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbcFDQaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 12:30:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751000AbcFDQaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 12:30:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADC601FA8A;
	Sat,  4 Jun 2016 12:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9kfrNCwrUrR1WtySgFkqG8Go1gM=; b=bcXaSO
	BPF4pXTQ2XseQ5SAfOTGcslyLVrlnwb+KT1hFbpvdluFEFQOmUFBwRxJsJ21xwDt
	mcZtQAK0vssiXYqSlv4qp3HajX7ZzrxsLuqSYtIBHFALSf5YxE9XkqLRY2iBEMfx
	4hif6W8mRsdCiFnpyaF/YWDtk5mpsMROFDk0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKMuo4USZkCkjvLABeBw3oc3DBytIPUb
	86Cgmu4DO2PYV77PWhgoZOVUz4Anzh5V86rT0LGpIWRENfwB2It3z35/TGjzVB/e
	79WzdPgHhQbgIepUOOxxT7ffSak0d+lBZ0ivP9cbk4tiPysYtl3U0dix3H2jc5EZ
	0Z+4NE7t1sw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5E711FA89;
	Sat,  4 Jun 2016 12:30:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 315C31FA87;
	Sat,  4 Jun 2016 12:30:17 -0400 (EDT)
In-Reply-To: <20160604003126.GA10430@ash> (Duy Nguyen's message of "Sat, 4 Jun
	2016 07:31:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F35712C-2A71-11E6-A4C5-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296447>

Duy Nguyen <pclouds@gmail.com> writes:

>> Peff suggested that a two-pass approach might not be too bad, but had 
>> problems when he tried it with extra-long refs.  Maybe those problems 
>> could be dealt with, and we could get a simple, aligned output?
>
> The good thing about 2/3 is we can customize the output easily and
> even switch format with config variables. But let's play without
> config vars for now. A 3/3 replacement that adds another pass to
> calculate column width is at the end.

Yes, I agree with you that 2/3 lays a very good groundwork,
regardless of the final output format.

> The patch does not do fancy stuff like this yet, but it can because
> lines exceeding terminal width is already excluded from column width
> calculation. So far the output looks good on my terminal (192 chars,
> can't overflow or refnames are insanely long)

Sounds like a sensible approach....

> -- 8< --
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a7f152a..5e1e5c9 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -15,6 +15,7 @@
>  #include "submodule.h"
>  #include "connected.h"
>  #include "argv-array.h"
> +#include "utf8.h"
>  
>  static const char * const builtin_fetch_usage[] = {
>  	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
> @@ -449,14 +450,26 @@ fail:
>  			   : STORE_REF_ERROR_OTHER;
>  }
>  
> -#define REFCOL_WIDTH  10
> +static int refcol_width = 10;
> +
> +static void adjust_refcol_width(const char *remote, const char *local)
> +{
> +	int max = term_columns();
> +	int rlen = utf8_strwidth(remote);
> +	int llen = utf8_strwidth(local);
> +
> +	if (21 /* flag summary */ + rlen + 4 /* => */ + llen >= max)
> +		return;
> +	if (refcol_width < rlen)
> +		refcol_width = rlen;
> +}
>  
>  static void format_display(struct strbuf *display, char code,
>  			   const char *summary, const char *error,
>  			   const char *remote, const char *local)
>  {
>  	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
> -	strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
> +	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);

... and if I understand correctly, this is the only place where you
need to decide if you need to switch to two lines, right?  You would
measure width of the remote and compare it with refcol_width or
something like that.

>  	if (error)
>  		strbuf_addf(display, "  (%s)", error);
>  }
> @@ -618,6 +631,20 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		goto abort;
>  	}
>  
> +	/*
> +	 * go through all refs to determine column size for
> +	 * "remote -> local" output
> +	 */
> +	for (rm = ref_map; rm; rm = rm->next) {
> +		if (rm->status == REF_STATUS_REJECT_SHALLOW ||
> +		    !rm->peer_ref ||
> +		    !strcmp(rm->name, "HEAD"))
> +			continue;
> +
> +		adjust_refcol_width(prettify_refname(rm->name),
> +				    prettify_refname(rm->peer_ref->name));
> +	}
> +
>  	/*
>  	 * We do a pass for each fetch_head_status type in their enum order, so
>  	 * merged entries are written before not-for-merge. That lets readers
> -- 8< --
