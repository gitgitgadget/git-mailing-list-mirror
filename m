From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Fri, 20 May 2016 13:39:06 -0700
Message-ID: <xmqqlh34cvmd.fsf@gitster.mtv.corp.google.com>
References: <20160520103708.38308-1-gitter.spiros@gmail.com>
	<20160520103708.38308-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 22:39:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3rCV-000222-OV
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 22:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbcETUjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 16:39:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750961AbcETUjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 16:39:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E45E1BC3B;
	Fri, 20 May 2016 16:39:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R5SrQbbPr33jZlxXIl7aEVH76dA=; b=EV92w+
	rcXhtxwu2iZ41l/tOuiPoKomHYnItBpHY5Q88pFtWduEcFv8fjJjoeXapkyFX3bm
	lkGYv4Y2/i63axLfSZ8gqOPBZEktnwGNHYyyv3T+WkqGFKIFat7KwL1FsVaFFjQf
	h6+cuK7gdj1CMjol2mPmd4zhkurTP9ykmqL0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j5GMYR5LeAFGT+s4vRWus8z9Why/xLad
	bjxNLJVEkIPzgBsOXktNu4i8n6WNfeQwQe+xgJrf5qpoLc4/Ym0TBMexulnw7qp0
	ps7X78y/ZcmaebVwAD7ri1C4+9PY0dEW2SUlC2GRVhKN+3Mz4jfapxWd0nzG4/OV
	3CjcFmDvoZM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 145DB1BC3A;
	Fri, 20 May 2016 16:39:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51E4F1BC39;
	Fri, 20 May 2016 16:39:08 -0400 (EDT)
In-Reply-To: <20160520103708.38308-2-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Fri, 20 May 2016 10:37:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6B33794-1ECA-11E6-B958-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295207>

Elia Pinto <gitter.spiros@gmail.com> writes:

> diff --git a/http.c b/http.c
> index df6dd01..ba32bac 100644
> --- a/http.c
> +++ b/http.c
> @@ -11,6 +11,7 @@
>  #include "gettext.h"
>  #include "transport.h"
>  
> +static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
>  #if LIBCURL_VERSION_NUM >= 0x070a08
>  long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
>  #else
> @@ -477,6 +478,125 @@ static void set_curl_keepalive(CURL *c)
>  }
>  #endif
>  
> +static void curl_dump_header(const char *text, unsigned char *ptr, size_t size, int nopriv_header)
> +{
> +	struct strbuf out = STRBUF_INIT;
> +	const char *header;
> +	struct strbuf **header_list, **ptr_list;
> +
> +	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
> +		text, (long)size, (long)size);
> +	trace_strbuf(&trace_curl, &out);
> +	strbuf_reset(&out);
> +	strbuf_add(&out,ptr,size);
> +	header_list = strbuf_split_max(&out, '\n', 0);
> +
> +	for (ptr_list = header_list; *ptr_list; ptr_list++) {
> +	/*
> +	 * if we are called with nopriv_header substitute a dummy value
> +	 * in the Authorization or Proxy-Authorization http header if
> +	 * present.
> +	 */
> +	if (nopriv_header &&
> +		(skip_prefix((*ptr_list)->buf , "Authorization:", &header)
> +		|| skip_prefix((*ptr_list)->buf , "Proxy-Authorization:", &header))) { 
> +		/* The first token is the type, which is OK to log */
> +		while (isspace(*header))
> +			header++;
> +		while (*header && !isspace(*header))
> +			header++;
> +		/* Everything else is opaque and possibly sensitive */
> +		strbuf_setlen((*ptr_list),  header - (*ptr_list)->buf );
> +		strbuf_addstr((*ptr_list), " <redacted>");
> +	}
> +	strbuf_insert((*ptr_list), 0, text, strlen(text));
> +	strbuf_insert((*ptr_list), strlen(text), ": ", 2);
> +	strbuf_rtrim((*ptr_list));
> +	strbuf_addch((*ptr_list), '\n');
> +	trace_strbuf(&trace_curl, (*ptr_list));

This funny indentation makes me wonder why you didn't make it into a
helper function.  If it would require too many parameters, I could
understand the aversion, as it would end up looking like:

	for (header = headers; *header; header++) {
        	if (hide_sensitive_header)
			redact_sensitive_header(header, &too, &many, &other,
			                        &params, &you,
        					&need, &to, &pass);
		strbuf_insert(*header, 0, text, strlen(text));
                strbuf_insert(*header, strlen(text), ": ", 2);
                ...
                trace_strbuf(&trace_curl, *header);
	}

but I think redact_sensitive_header() helper would only need to take
a single strbuf, from the look of your actual implementation.

Yes, I am also suggesting to rename header_list and ptr_list to
headers and header, respectively.  header_list may be an OK name (as
it is "a list, each element of which is a header"), but ptr_list is
a poor name--"a pointer into a list" is a much less interesting thing
for the reader of the code to learn from the name than it represents
"one header".

And your "const char *header" does not have to be here (it would be
an implementation detail of redact_sensitive_header() function), so
such a renaming would not cause conflicts in variable names.

> +	}
> +	strbuf_list_free(header_list);
> +	strbuf_release(&out);
> +}
> +static void curl_dump_data(const char *text, unsigned char *ptr, size_t size)

A blank line, between the end of previous function body and the
begining of this function, is missing.

> +{
> +	size_t i;
> +	struct strbuf out = STRBUF_INIT;
> +	unsigned int width = 80;

In a few places Git limits the width of the output, like using function
name in hunk header lines and drawing diffstat in "diff --stat", we
do default to limit the total width to 80 display columns.

Given that this routine prefixes each and every line with a short
heading like "=> Send header: " that costs at around 15-20 columns,
and the loop we see below only counts the true payload without
counting the heading, you would probably want to reduce this
somewhat so that the whole thing would fit within 80 columns.

> +	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
> +		text, (long)size, (long)size);
> +	trace_strbuf(&trace_curl, &out);
> +
> +	for (i = 0; i < size; i += width) {
> +		size_t w;
> +
> +		strbuf_reset(&out);
> +		strbuf_addf(&out, "%s: ", text);
> +		for (w = 0; (w < width) && (i + w < size); w++) {
> +			strbuf_addch(&out, (ptr[i + w] >= 0x20)
> +				&& (ptr[i + w] < 0x80) ? ptr[i + w] : '.');

Please think twice to make sure a long expression that has to span
multiple lines is cut at a sensible place.  This cuts at the worst
place where the syntactic element that binds strongest sits in the
expression.

The weakest binding is the comma between two parameters given to
addch(), so let's cut it there:

                for (w = 0; (w < width) && (i + w < size); w++) {
                        unsigned char ch = ptr[i + w];
                        strbuf_addch(&out,
                                     (0x20 <= ch && ch < 0x80) ? ch : '.');
                }

If you find the second line still too long, then cut it before '?', i.e.

                        strbuf_addch(&out,
                                     (0x20 <= ch && ch < 0x80) 
                                     ? ch : '.');

or alternatively:


                        strbuf_addch(&out, ((0x20 <= ch && ch < 0x80) 
                                            ? ch : '.'));

> +static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
> +{
> +	const char *text;
> +	int nopriv_header = 0;	/*
> +				 * default: there are no sensitive data
> +				 * in the trace to be skipped
> +				 */
> +
> +	switch (type) {
> +	case CURLINFO_TEXT:
> +		trace_printf_key(&trace_curl, "== Info: %s", data);
> +	default:		/* we ignore unknown types by default */
> +		return 0;
> +
> +	case CURLINFO_HEADER_OUT:
> +		text = "=> Send header";
> +		nopriv_header = 1;
> +		curl_dump_header(text, (unsigned char *)data, size, nopriv_header);
> +	case CURLINFO_HEADER_IN:
> +		text = "<= Recv header";
> +		nopriv_header = 0;
> +		curl_dump_header(text, (unsigned char *)data, size, nopriv_header);
> +		break;

I do not think an extra variable nopriv_header gives us any
readability advantage.  If you looked at these two calls to
curl_dump_header() and its parameters alone, you cannot tell
which one is sensitive.

Wouldn't it be easier to read if they were like this?

        static int curl_trace(..., char *data_, ...)
        {
                enum { NO_FILTER = 0, DO_FILTER = 1 };
                unsigned char *data = (unsigned char *) data_;

                curl_dump_header("Send header", data, size, DO_FILTER);
                curl_dump_header("Recv header", data, size, NO_FILTER);
