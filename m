Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1BC61FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 23:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755550AbcK1XDV (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 18:03:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57760 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753405AbcK1XDU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 18:03:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23B83533C6;
        Mon, 28 Nov 2016 18:03:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BlQX51lpkEfbh9rAjlXAwy74D74=; b=kku7Yq
        TvT4OgBM3RWtX3SM05o1jUtIxHYMm4OYvL3ri/veTm6E0SuK6750u+oul4w6fG0A
        rQUKF9hv9pDs2OyWsFD7fp7JB78vNr+IermoPWNVZAPpE3xfKMe//C/LCbEkt5cn
        5a3/G61ebRTY+SVN0jzKPaQYFDKaZtXP0GPgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iQ1HrMu1H9/hCnDuZWRWyEYvFsWD1ETP
        V3jTlLZ6B24xjo72BCBRcQssS/0Bf0Xsk25989wP82kc5ZvltwqeAW8T7HODk73Q
        SD5auyk0m1H7c2czCOGAYtv6W//7uKvpPSw9RU6NdnZH+Ch2eIwO23t4D4uLXtkQ
        vjK+0TQj5fU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C704533C5;
        Mon, 28 Nov 2016 18:03:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C166533C4;
        Mon, 28 Nov 2016 18:03:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org, Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH] diff: handle --no-abbrev outside of repository
References: <20161128182508.10570-1-jack@nottheoilrig.com>
Date:   Mon, 28 Nov 2016 15:03:17 -0800
In-Reply-To: <20161128182508.10570-1-jack@nottheoilrig.com> (Jack Bates's
        message of "Mon, 28 Nov 2016 11:25:08 -0700")
Message-ID: <xmqqbmwzi4wa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9EB57D6-B5BE-11E6-B1B1-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jack Bates <bk874k@nottheoilrig.com> writes:

> The "git diff --no-index" codepath doesn't handle the --no-abbrev
> option.
>
> Signed-off-by: Jack Bates <jack@nottheoilrig.com>
> ---

This patch also needs a new test to protect the fix from future
breakages.

It is unfortunate that parsing of these options that are done in
diff_opt_parse() are not used by most of the codepaths; they instead
rely on revision.c parser to parse them into revs->abbrev and then
copied to revs->diffopt.abbrev in setup_revisions().  We would want
to rethink the structure of the code around this, and possibly move
towards using setup_revisions() more when appropriate and removing
diff_opt_parse() or something like that; the three-way fallback
codepath in builtin/am.c is the only other caller of this function
and it uses it to parse a fixed "--diff-filter=AM" option into
rev_info.diffopt and manually sets up rev_info as if revision parser
was given "diff --cached HEAD", which we should be able to replace
with a call to setup_revisions() of "--diff-filter=AM --cached HEAD",
I would suspect.  But that is a much larger change.

In any case, for now, the fix in this patch is a single best step
that moves us forward.  

Thanks.

>  diff.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index ec87283..0447eff 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3106,7 +3106,8 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
>  			abbrev = FALLBACK_DEFAULT_ABBREV;
>  		if (abbrev > GIT_SHA1_HEXSZ)
>  			die("BUG: oid abbreviation out of range: %d", abbrev);
> -		hex[abbrev] = '\0';
> +		if (abbrev)
> +			hex[abbrev] = '\0';
>  		return hex;
>  	}
>  }
> @@ -4024,6 +4025,8 @@ int diff_opt_parse(struct diff_options *options,
>  			    offending, optarg);
>  		return argcount;
>  	}
> +	else if (!strcmp(arg, "--no-abbrev"))
> +		options->abbrev = 0;
>  	else if (!strcmp(arg, "--abbrev"))
>  		options->abbrev = DEFAULT_ABBREV;
>  	else if (skip_prefix(arg, "--abbrev=", &arg)) {
