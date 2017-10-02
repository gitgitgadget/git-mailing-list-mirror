Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4BEB20A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdJBATt (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:19:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58641 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750943AbdJBATs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:19:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E201B610A;
        Sun,  1 Oct 2017 20:19:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j15xx2+8RsVsdT7tCT581Ugj/1o=; b=wfb9uQ
        b2wAIRg5HcdQmgJIIby3PS8x0vD9q746ntSJWkCDlT+x9lZu4fi/Xvpjudg0P+CS
        v3Qyyv2ONBcdr6aqbTknH0h3XDF0d+TRq6Ca/nRPLx31AMYQ6fgqGC+EhIoPh45x
        Nu3Othapdy4shRFYZJRP/N+fKIxhRU5Dw0U/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Apo+JjVn98AF+zLDIn2x5vvF/SsQO/hW
        vcKtA4h13NzbcviUEzz7GSDS7+wQsbUEGxWEVqSdjaSiy08FHC4C117PblblzEsX
        OZ0JHTojuLgOOWU442K5aotXldeeTVO0KUaB6I1FpyENrkk4Vgn9VAOQV/2onrlQ
        dlNQ5lC4Okg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7D05B6109;
        Sun,  1 Oct 2017 20:19:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 556D0B6108;
        Sun,  1 Oct 2017 20:19:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 6/6] ref-filter.c: parse trailers arguments with %(contents) atom
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161852.84571-1-me@ttaylorr.com>
        <20171001161852.84571-6-me@ttaylorr.com>
Date:   Mon, 02 Oct 2017 09:19:46 +0900
In-Reply-To: <20171001161852.84571-6-me@ttaylorr.com> (Taylor Blau's message
        of "Sun, 1 Oct 2017 09:18:52 -0700")
Message-ID: <xmqqy3ous8nx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65DCBAFC-A707-11E7-A0D6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The %(contents) atom takes a contents "field" as its argument. Since
> "trailers" is one of those fields, extend contents_atom_parser to parse
> "trailers"'s arguments when used through "%(contents)", like:
>
>   %(contents:trailers:unfold,only)
>
> A caveat: trailers_atom_parser expects NULL when no arguments are given
> (see: `parse_ref_filter_atom`). To simulate this behavior without
> teaching trailers_atom_parser to accept strings with length zero,
> conditionally pass NULL to trailers_atom_parser if the arguments portion
> of the argument to %(contents) is empty.

I got an impression during the earlier rounds' review discussion
that trailers_atom_parser() will happily accept an empty string and
work correctly, so this paragraph and the conditional *arg ? NULL :
arg were both unneeded.

 - arg == "" is not NULL, so we first do string_list_split() on ','
 - which yields an empty list i.e. params.nr == 0
 - we do not loop and leave atom->u.contents.trailer_opts untouched.
 - and we set u.contents.option to C_TRAILERS
 - and we clear &params string list before we leave.

which is exactly the same as what happens when arg == NULL.  Sooo....

>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ref-filter.c            |  6 ++++--
>  t/t6300-for-each-ref.sh | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 43ed10a5e..2c03c2bf5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -212,8 +212,10 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
>  		atom->u.contents.option = C_SIG;
>  	else if (!strcmp(arg, "subject"))
>  		atom->u.contents.option = C_SUB;
> -	else if (!strcmp(arg, "trailers"))
> -		atom->u.contents.option = C_TRAILERS;
> +	else if (skip_prefix(arg, "trailers", &arg)) {
> +		skip_prefix(arg, ":", &arg);
> +		trailers_atom_parser(atom, *arg ? NULL : arg);
> +	}
>  	else if (skip_prefix(arg, "lines=", &arg)) {

Merge these two lines i.e.

	} else if (skip_prefix(arg, "lines=", ...) {

> +test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
> +	cat >expect <<-EOF &&
> +	fatal: unknown %(trailers) argument: unsupported
> +	EOF
> +  test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
> +  test_cmp expect actual

Funny indentation.
