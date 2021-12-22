Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC3C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhLVAY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:24:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63488 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLVAY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:24:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BAAEFA6F6;
        Tue, 21 Dec 2021 19:24:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u/mz1SDZ1jO/Mv7L3iBLB2dlxE5iXlc3KzmNSO
        OurE8=; b=mmD9ODZuZOF7wUZDnO0NsN83nvKT+EjVAuPBuS0ZS1oju1gUM+myzv
        OiXfmHhOdkbXOIX0TDYHFIRD7tDVon0SjQgSWPqkMjZYVWaP9hv6yL/Bw7wLcC6N
        mvcaAZ5CRWkEYsrlg4wfkorMBQQbKL1SWLM8q6cWf63JTiN5zDjOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 725ADFA6F5;
        Tue, 21 Dec 2021 19:24:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCBD2FA6F4;
        Tue, 21 Dec 2021 19:24:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 6/9] diff: add ability to insert additional headers for
 paths
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <15600df925fb06ecf2c12afecd514f551a1bf7c2.1640109948.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 16:24:54 -0800
In-Reply-To: <15600df925fb06ecf2c12afecd514f551a1bf7c2.1640109948.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 21 Dec 2021
        18:05:45 +0000")
Message-ID: <xmqqlf0dmqp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96C15012-62BD-11EC-BB10-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In support of a remerge-diff ability we will add in a few commits, we
> want to be able to provide additional headers to show along with a diff.
> Add the plumbing necessary to enable this.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  diff.c | 34 +++++++++++++++++++++++++++++++++-
>  diff.h |  1 +
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 861282db1c3..a9490b9b2ba 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -27,6 +27,7 @@
>  #include "help.h"
>  #include "promisor-remote.h"
>  #include "dir.h"
> +#include "strmap.h"
>  
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -3406,6 +3407,33 @@ struct userdiff_driver *get_textconv(struct repository *r,
>  	return userdiff_get_textconv(r, one->driver);
>  }
>  
> +static struct strbuf* additional_headers(struct diff_options *o,

Style.

> +					 const char *path)
> +{
> +	if (!o->additional_path_headers)
> +		return NULL;
> +	return strmap_get(o->additional_path_headers, path);
> +}
> +
> +static void add_formatted_headers(struct strbuf *msg,
> +				  struct strbuf *more_headers,
> +				  const char *line_prefix,
> +				  const char *meta,
> +				  const char *reset)
> +{
> +	char *next, *newline;
> +
> +	next = more_headers->buf;
> +	while ((newline = strchr(next, '\n'))) {
> +		*newline = '\0';
> +		strbuf_addf(msg, "%s%s%s%s\n", line_prefix, meta, next, reset);
> +		*newline = '\n';
> +		next = newline + 1;
> +	}

The above is not wrong per-se, but we do not need to do the
"temporarily terminate and then recover" dance, and avoiding it
would make the code cleaner.

Once you learn the value of "newline" [*], you know the number of
bytes between "next" and "newline" so you can use safely "%.*s"
format specifier without temporarily terminating the subsection of
the string.

	Side note. I would actually use strchrnul() instead, so that
        we do not have to special case the end of the buffer.  For a
        readily available example, see advice.c::vadvise().

> +	if (*next)
> +		strbuf_addf(msg, "%s%s%s%s\n", line_prefix, meta, next, reset);
> +}

> @@ -4328,9 +4356,13 @@ static void fill_metainfo(struct strbuf *msg,
>  	const char *set = diff_get_color(use_color, DIFF_METAINFO);
>  	const char *reset = diff_get_color(use_color, DIFF_RESET);
>  	const char *line_prefix = diff_line_prefix(o);
> +	struct strbuf *more_headers = NULL;
>  
>  	*must_show_header = 1;
>  	strbuf_init(msg, PATH_MAX * 2 + 300);
> +	if ((more_headers = additional_headers(o, name)))
> +		add_formatted_headers(msg, more_headers,
> +				      line_prefix, set, reset);

So, we stuff what came via path_msg() without anything that allows
readers to identify them to the header part?  Just like we have
fixed and known string taken from a bounded vocabulary such as
"index", "copy from", "old mode", etc., don't we want to prefix the
hints that came from the merge machinery with some identifiable
string?

> @@ -5852,7 +5884,7 @@ int diff_unmodified_pair(struct diff_filepair *p)
>  
>  static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
>  {
> -	if (diff_unmodified_pair(p))
> +	if (diff_unmodified_pair(p) && !additional_headers(o, p->one->path))
>  		return;

This does not feel quite right.  At least there needs a comment that
says the _current_ callers that add additional_headers() would do so
only for paths that the end-users cares about, even when there is no
change in the contents.  It is quite plausible that future callers
may want to add additional information to only paths that have some
changes that need to be shown, no?  And at that point, they want to
tweak this condition we place here, but without explanation they
wouldn't know what they would be breaking if they did so.

