Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E74C433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 08:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354946AbhLDIMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 03:12:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52401 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354766AbhLDIMr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 03:12:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B633BF7D20;
        Sat,  4 Dec 2021 03:09:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HuqxMiNdrflxkASOn3lNKsRVO8nxoK7RcAMS3y
        jQJR0=; b=YnSWzNgVBmv0OC4ogx6UjP0zfPObcgqJ8XZhILCctQG/gTKGMeRI7I
        y30/nnsaPHQBLrN6ISfSVNOvMZAVkdH46f0iq9hHJQrkdI67ameGYZyvuwgI5wQt
        6BWdYtP4d7S7Aswg8JVv0YzMk3ac9TNIpSubWGO3IqPfx6u0twNVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACA56F7D1E;
        Sat,  4 Dec 2021 03:09:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED45BF7D1D;
        Sat,  4 Dec 2021 03:09:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-backend: give a hint that web browser access is
 not supported
References: <xmqqee6vwj67.fsf@gitster.g>
        <20211202102855.23907-1-jengelh@inai.de>
Date:   Sat, 04 Dec 2021 00:09:19 -0800
In-Reply-To: <20211202102855.23907-1-jengelh@inai.de> (Jan Engelhardt's
        message of "Thu, 2 Dec 2021 11:28:55 +0100")
Message-ID: <xmqqee6spz9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C31B0A8-54D9-11EC-9DA2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> writes:

> When using a browser to access a URI that is served by http-backend,
> nothing but a blank page is shown. This is not helpful.
>
> Emit the same "Request not handled" messages, but to the CGI stream

Puzzled.  Same with what?  The closest one in the code without this
patch is "Request not supported" and one call (among the three) to
the not_found_2() function does use that string, so perhaps that is
what was meant here?

> +static NORETURN void not_found_2(struct strbuf *hdr, const char *dir,
> +				 const char *pathinfo, const char *err,
> +				 const char *hint)
> +{
> +	http_status(hdr, 404, "Not Found");
> +	hdr_nocache(hdr);
> +	strbuf_add(hdr, "\r\n", 2);
> +	if (pathinfo != NULL)
> +		strbuf_addf(hdr, "%s: ", pathinfo);
> +	strbuf_addf(hdr, "%s.\r\n", err);

What is in "pathinfo" parameter?  Can it safely be on the left side
of the colon?  I am reading that this part is emitting a series of
HTTP header lines, so I would understand it if it were producing
lines like 

    PATH-INFO: /hello+world

but it seems that you are instead writing

    /hello+world: <error string>.

here.

Notice that the above code already relies on err being non-NULL.

> +	if (hint != NULL)
> +		strbuf_addf(hdr, "%s\r\n", hint);

Likewise.  This just emits a random unstructured string.

By the way, do not compare pathinfo and hint pointers with != NULL;
with "git grep" in this file you'll notice no existing code does that.
Just write

	if (pathinfo)
		do_this();

> +	end_headers(hdr);

So here is where the HTTP headers end.

I think the use of internal API in http-backend.c in the new code is
wrong; I haven't seen how it is used until now, so take this with a
grain of salt, though.

Did you actually mean something different, that is:

	struct strbuf body = STRBUF_INIT;

	http_status(hdr, 404, "Not Found");
	hdr_nocache(hdr);
       
	/* stuff pathinfo, err, and hint into "body" strbuf ... */
	if (pathinfo)
		strbuf_addf(&body, "%s: ", pathinfo);
	strbuf_addf(&body, "%s.\r\n", err);
        if (hint)
		strbuf_addf(&body, "%s\r\n", hint);

	/* ... and send it out */
	send_strbuf(hdr, "text/plain", &body);
	strbuf_release(&body);

As end_headers() call emitted the necessary blank line after the
header, anything you write to fd #1 after this point will become
the body of the HTTP message.  And send_strbuf() seems to be a
helper that was designed for exactly this kind of usage.

> +	if (err && *err)
> +		fprintf(stderr, "%s: %s\n", dir, err);

We know err is not NULL already, so the first part "err &&" is way
too late to be useful safety.

I notice that this is still going to the standard error stream.  Is
the intention that the remote requestor may get a lightly redacted
error message while the log will leave detailed record to help
debugging?  In that case, I suspect that we may want to rename "dir"
and "pathinfo" to make the distinction clearer (my understanding is
that the former is the unredacted version and pathinfo is the
redacted one).

Why do we need the original not_found()?  It seems that there is
only one remaining caller, so I think you can make it also use the
new not_found_2() with NULL pathinfo and NULL dir (as that existing
caller does not need it), and make the caller prepare the error
string appropriately.

	char *p = git_pathdup("%s", name);
	size_t buf_alloc = 8192;
	char *buf = xmalloc(buf_alloc);
	int fd;
	struct stat sb;

	fd = open(p, O_RDONLY);
	if (fd < 0)
		not_found(hdr, "Cannot open '%s': %s", p, strerror(errno));

'p' is an unredacted one and we can use "dir" parameter for it,
while 'name' can be stuffed in the "pathinfo" parameter, I guess.
I wonder if something like this is close enough:

	not_found_2(hdr,
        	    p /* sensitive */,
                    name /* public */,
                    xstrfmt("Cannot open (%s)", strerror(errno)),
		    NULL);

ANd if we can get rid of the use of the original not_found(), we
could even take its nice name over. 
