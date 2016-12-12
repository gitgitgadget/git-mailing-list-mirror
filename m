Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C67203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 22:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbcLLWTS (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 17:19:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62210 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752112AbcLLWTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 17:19:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D14755FAB;
        Mon, 12 Dec 2016 17:19:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0LTzcg5PHVGeOoDFNNS1NdkZsXw=; b=GnGKVn
        SRCdp4C8dr6aGuVjnbIX47LQiz46TpajyvCJCvTafcJHWhTCIARPQt+RuZrEa5s+
        8IlCs78tlXRmSDinpTkGcuumOjWrmGf9kJsyhE0oG/9amrDvExBYNU3RQiSeK6Se
        LiuzKOXuE4NGb33Q/ZotAJWXKJ2RVtrH1lMFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ugVd8hIpVURV10LWU2vlYBDJ4Iyg0vGN
        W31Xkwk3waJtj9+5LhTpVZH2tb7oI+BWdSiaOmvMM+peNSwqfbt0eWzyfBpaMN+V
        chZcTJylK2jPa3lKsMBVMMIHpSX1KoArykzEN1/psMyx4R9Y3HlvPkgtCtFgpupN
        0IyFDGkOnIk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14F6655FAA;
        Mon, 12 Dec 2016 17:19:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87B4955FA9;
        Mon, 12 Dec 2016 17:19:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com
Subject: Re: [PATCH v3 1/4] real_path: resolve symlinks by hand
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
        <1481566615-75299-1-git-send-email-bmwill@google.com>
        <1481566615-75299-2-git-send-email-bmwill@google.com>
Date:   Mon, 12 Dec 2016 14:19:14 -0800
In-Reply-To: <1481566615-75299-2-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 12 Dec 2016 10:16:52 -0800")
Message-ID: <xmqqd1gw94f1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 045C63A2-C0B9-11E6-9F83-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +/* removes the last path component from 'path' except if 'path' is root */
> +static void strip_last_component(struct strbuf *path)
> +{
> +	size_t offset = offset_1st_component(path->buf);
> +	size_t len = path->len;
> +
> +	/* Find start of the last component */
> +	while (offset < len && !is_dir_sep(path->buf[len - 1]))
> +		len--;

If somebody at a higher level in the callchain has already
normalized path, this is not a problem, but this will behave
"unexpectedly" when path ends with a dir_sep byte (or more).

E.g. for input path "foo/bar/", the above loop runs zero times and
then ...

> +	/* Skip sequences of multiple path-separators */
> +	while (offset < len && is_dir_sep(path->buf[len - 1]))
> +		len--;

... the slash at the end is removed, leaving "foo/bar" in path.

> +	strbuf_setlen(path, len);
> +}
> ...
> +/* get (and remove) the next component in 'remaining' and place it in 'next' */
> +static void get_next_component(struct strbuf *next, struct strbuf *remaining)
> +{
> +	char *start = NULL;
> +	char *end = NULL;
> +
> +	strbuf_reset(next);
> +
> +	/* look for the next component */
> +	/* Skip sequences of multiple path-separators */
> +	for (start = remaining->buf; is_dir_sep(*start); start++)
> +		; /* nothing */
> +	/* Find end of the path component */
> +	for (end = start; *end && !is_dir_sep(*end); end++)
> +		; /* nothing */
> +
> +	strbuf_add(next, start, end - start);
> +	/* remove the component from 'remaining' */
> +	strbuf_remove(remaining, 0, end - remaining->buf);
> +}

Unlike the strip_last_component(), I think this one is more
carefully done and avoids getting fooled by //extra//slashes// at
the beginning or at the end, which does help in the correctness of
the loop we see below.

> @@ -58,74 +88,112 @@ static const char *real_path_internal(const char *path, int die_on_error)
>  			goto error_out;
>  	}
>  
> +	strbuf_reset(&resolved);
> +
> +	if (is_absolute_path(path)) {
> +		/* absolute path; start with only root as being resolved */
> +		int offset = offset_1st_component(path);
> +		strbuf_add(&resolved, path, offset);
> +		strbuf_addstr(&remaining, path + offset);
> +	} else {
> +		/* relative path; can use CWD as the initial resolved path */
> +		if (strbuf_getcwd(&resolved)) {
> +			if (die_on_error)
> +				die_errno("unable to get current working directory");
> +			else
> +				goto error_out;
>  		}
> +		strbuf_addstr(&remaining, path);
> +	}
>  
> +	/* Iterate over the remaining path components */
> +	while (remaining.len > 0) {
> +		get_next_component(&next, &remaining);
> +
> +		if (next.len == 0) {
> +			continue; /* empty component */
> +		} else if (next.len == 1 && !strcmp(next.buf, ".")) {
> +			continue; /* '.' component */
> +		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
> +			/* '..' component; strip the last path component */
> +			strip_last_component(&resolved);

Wouldn't this let "resolved" eventually run out of the path
components to strip for a malformed input e.g. "/a/../../b"?

> + ...
> +			/*
> +			 * if there are still remaining components to resolve
> +			 * then append them to symlink
> +			 */
> +			if (remaining.len) {
> +				strbuf_addch(&symlink, '/');

This can add duplicate dir_sep if readlink(2)'ed contents of the
symbolic link already ends with a slash, but I think it (together
with the fact that the code does nothing to normalize what is read
from the symbolic link) probably does not matter, given the way how
get_next_component() is implemented.

> +				strbuf_addbuf(&symlink, &remaining);
> +			}
> +
> +			/*
> +			 * use the symlink as the remaining components that
> +			 * need to be resloved
> +			 */
> +			strbuf_swap(&symlink, &remaining);
> +		}
>  	}
>  
> +	retval = resolved.buf;
> +
>  error_out:
> +	strbuf_release(&remaining);
> +	strbuf_release(&next);
> +	strbuf_release(&symlink);
>  
>  	return retval;
>  }

