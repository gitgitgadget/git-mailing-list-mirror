From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: support sending custom HTTP headers
Date: Tue, 26 Apr 2016 10:03:14 -0700
Message-ID: <xmqq8u00i9pp.fsf@gitster.mtv.corp.google.com>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
	<921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6OQ-0003PZ-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbcDZRDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:03:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751798AbcDZRDS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:03:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4EB915062;
	Tue, 26 Apr 2016 13:03:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gCSUe0h+A2CTmp2/LqnhtoNyuSM=; b=onjRjE
	HVVnQTXpLln33HZoG2+hQrKjjc2TDUPrHKKn2SCrd0YBSOdlukr3hZpxmWdnSjVu
	DmvIAq6BKonuoxj5BpOBOKjdbogdd4dc/eYRora+BrBKL1f+D0rt0OKQYs0MjWZj
	0PFOucmM0ZO806OEcJkvHjGjN8rjVZjG0mi2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o+3T+hO/YkpRncYvezbr8Wbr5DWZ0TMs
	4mWFta5vIfOq7o41ZlRQObp4lcOKDLPXiBVflRFLJor12FzOkrYjmnK4pPphDxoz
	IbF0r5aQAsJhBV9UwVuPK2F/FNt8TdsPc+ujc1+A9ojy9NpI3TQtKuwvyqrzAqBq
	Oe9daG4cMS4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCCAA15061;
	Tue, 26 Apr 2016 13:03:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F7F91505F;
	Tue, 26 Apr 2016 13:03:16 -0400 (EDT)
In-Reply-To: <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Apr 2016 17:40:30 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4A1BA48-0BD0-11E6-887D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292618>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We introduce a way to send custom HTTP headers with all requests.
>
> This allows us, for example, to send an extra token from build agents
> for temporary access to private repositories. (This is the use case that
> triggered this patch.)
>
> This feature can be used like this:
>
> 	git -c http.extraheader='Secret: sssh!' fetch $URL $REF
>
> As `curl_easy_setopt(..., CURLOPT_HTTPHEADER, ...)` overrides previous
> calls' headers (instead of appending the headers, as this unsuspecting
> developer thought initially), we piggyback onto the `Pragma:` setting by
> default, and introduce the global helper `http_copy_default_headers()`
> to help functions that want to specify HTTP headers themselves.

My reading stuttered at "we piggyback onto the `Pragma:` setting by
default", which made me stop and wonder if a description about a
knob that changes this behaviour and makes us piggyback onto
something else follows.

I guess "by default" you meant that the majority of codepaths set
the headers using no_pragma_header or pragma_header variables, and
by [no_]pragma_header to mean more than just about "Pragma:" by
adding the extra headers to them, you did not have to touch them.
Other codepaths that do not use these two variables but start from
NULL you made them start from these extra headers.

Which makes sense.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 42d2b50..37b9af7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1655,6 +1655,12 @@ http.emptyAuth::
>  	a username in the URL, as libcurl normally requires a username for
>  	authentication.
>  
> +http.extraHeader::
> +	Pass an additional HTTP header when communicating with a server.  If
> +	more than one such entry exists, all of them are added as extra headers.
> +	This feature is useful e.g. to increase security, or to allow
> +	time-limited access based on expiring tokens.
> +

I think one-time/short-lived use case does not want to have this in
a configuration file, and instead want to do the command line thing
you illustrated in the proposed log message.  I however wonder if
there are other use cases where having this in $GIT_DIR/config for
repeated use is useful.  If there is, not being able to override a
configured value per invocation would become a problem.

Peff, what do you think?  I vaguely recollect that you did a hack to
one variable that declares "an empty value means discard accumulated
values so far" or something like that, and this variable deserves a
mechanism like that, too.

> diff --git a/http.c b/http.c
> index 4304b80..3d662bb 100644
> --- a/http.c
> +++ b/http.c
> @@ -1163,6 +1175,16 @@ int run_one_slot(struct active_request_slot *slot,
>  	return handle_curl_result(results);
>  }
>  
> +struct curl_slist *http_copy_default_headers()

struct curl_slist *http_copy_default_headers(void)

> +{
> +	struct curl_slist *headers = NULL, *h;
> +
> +	for (h = extra_http_headers; h; h = h->next)
> +		headers = curl_slist_append(headers, h->data);
> +
> +	return headers;
> +}
> +
> diff --git a/http.h b/http.h
> index 4ef4bbd..5f13695 100644
> --- a/http.h
> +++ b/http.h
> @@ -106,6 +106,7 @@ extern void step_active_slots(void);
>  extern void http_init(struct remote *remote, const char *url,
>  		      int proactive_auth);
>  extern void http_cleanup(void);
> +extern struct curl_slist *http_copy_default_headers();

extern struct curl_slist *http_copy_default_headers(void);
