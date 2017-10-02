Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF6420A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdJBALx (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:11:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60281 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751101AbdJBALw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:11:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9242A0ADD;
        Sun,  1 Oct 2017 20:11:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0qVWRuBSEWvN1UIX2esbg9WhuNs=; b=Z5VNWr
        mtIoacTijEAzNADjmXdQIYPwkMypn6uATTtpsvkPNSKpEPZu4bMyBltKsAVAf3C4
        eIdr7c3f7Dv//NumMaOLLh9nf/NHPY2xYitjf1XZnLzyE75MLfSqBQMp+q3PKTPu
        N3P+ZzEiqLc1fKrM68RRmcoL+OHWjkjCCmPXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kGxLtBpY/IkvhbO/QAVKL2u+SwdQ6ZxF
        ONR9hSb3U/ONzH9FcG/tEjPFwlzYRklFBoFd5NjEI8bUZqX5OuOa6z/0IZJAumm+
        v2yQAtwpXiLwnmiXydeCJD9qs93YiDNAqBkE+3jJVXRAkCRZc1/NWAnGzrz8ah3F
        9gC0alooyUo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF585A0ADC;
        Sun,  1 Oct 2017 20:11:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F2F9A0ADB;
        Sun,  1 Oct 2017 20:11:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 1/6] pretty.c: delimit "%(trailers)" arguments with ","
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161852.84571-1-me@ttaylorr.com>
Date:   Mon, 02 Oct 2017 09:11:50 +0900
In-Reply-To: <20171001161852.84571-1-me@ttaylorr.com> (Taylor Blau's message
        of "Sun, 1 Oct 2017 09:18:47 -0700")
Message-ID: <xmqqbmlqtnll.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A20EAFA-A706-11E7-8D71-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In preparation for adding consistent "%(trailers)" atom options to
> `git-for-each-ref(1)`'s "--format" argument, change "%(trailers)" in
> pretty.c to separate sub-arguments with a ",", instead of a ":".
>
> Multiple sub-arguments are given either as "%(trailers:unfold,only)" or
> "%(trailers:only,unfold)".
>
> This change disambiguates between "top-level" arguments, and arguments
> given to the trailers atom itself. It is consistent with the behavior of
> "%(upstream)" and "%(push)" atoms.

Looks good.  

Ignore the remainder unless you are interested in the recent "make
style" discussion.

>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pretty.c                      | 34 +++++++++++++++++++++++++++++-----
>  t/t4205-log-pretty-formats.sh |  4 ++--
>  2 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 94eab5c89..eec128bc1 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1056,6 +1056,25 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
>  	return 0;
>  }
>  
> +static int match_placeholder_arg(const char *to_parse,
> +				const char *candidate,
> +				const char **end)

"make style" wants to format this like so:

static int match_placeholder_arg(const char *to_parse, const char *candidate,
				 const char **end)

I think I can live with either versions ;-)

> +{
> +	const char *p;
> +	if (!(skip_prefix(to_parse, candidate, &p)))
> +		return 0;
> +	if (*p == ',') {
> +		*end = p + 1;
> +		return 1;
> +	}
> +	if (*p == ')') {
> +		*end = p;
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +

"make style" seems to be unhappy to see double blank here, and I
tend to agree.

>  static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  				const char *placeholder,
>  				void *context)
> @@ -1285,11 +1304,16 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  
>  	if (skip_prefix(placeholder, "(trailers", &arg)) {
>  		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> -		while (*arg == ':') {
> -			if (skip_prefix(arg, ":only", &arg))
> -				opts.only_trailers = 1;
> -			else if (skip_prefix(arg, ":unfold", &arg))
> -				opts.unfold = 1;
> +		if (*arg == ':') {
> +			arg++;
> +			for (;;) {
> +				if (match_placeholder_arg(arg, "only", &arg))
> +					opts.only_trailers = 1;
> +				else if (match_placeholder_arg(arg, "unfold", &arg))
> +					opts.unfold = 1;
> +				else
> +					break;
> +			}
>  		}
>  		if (*arg == ')') {
>  			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index ec5f53010..977472f53 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -588,8 +588,8 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
>  '
>  
>  test_expect_success ':only and :unfold work together' '
> -	git log --no-walk --pretty="%(trailers:only:unfold)" >actual &&
> -	git log --no-walk --pretty="%(trailers:unfold:only)" >reverse &&
> +	git log --no-walk --pretty="%(trailers:only,unfold)" >actual &&
> +	git log --no-walk --pretty="%(trailers:unfold,only)" >reverse &&
>  	test_cmp actual reverse &&
>  	{
>  		grep -v patch.description <trailers | unfold &&
