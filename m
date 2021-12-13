Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhLMWaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:30:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58460 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbhLMWaU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:30:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EB8E15E917;
        Mon, 13 Dec 2021 17:30:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uixJM7Jfn13r0e8oZNME4/OhU87r6ptv9S8tQt
        NZSy4=; b=dERk0mAcsw9ZPMQ3ae5rc5VqjELFB+V5v6UAV+tG9duGMTdTPxgZ2S
        5LFl6pI1S/mI5+L8x49RdrZe9rtzv3nO9zXHzh7ejk3av9CidOW4AZJk3excBskE
        BI32wRlRfaVJmgi7N7t/mqerRdmWVD06PB3R4bSXgrCW/XnvUa+6A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96EB615E914;
        Mon, 13 Dec 2021 17:30:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FD9815E90D;
        Mon, 13 Dec 2021 17:30:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V3 1/2] git-apply: add --quiet flag
References: <20211213220327.16042-1-jerry@skydio.com>
Date:   Mon, 13 Dec 2021 14:30:14 -0800
In-Reply-To: <20211213220327.16042-1-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 13 Dec 2021 14:03:26 -0800")
Message-ID: <xmqqmtl49lzd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E75FDB8-5C64-11EC-A068-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Replace OPT_VERBOSE with OPT_VERBOSITY.
>
> This adds a --quiet flag to "git apply" so the user can turn down
> the verbosity.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> V2->V3 
> - Reorganized into a patch series to capture
> dependencies between 2 git apply changes.
>
>  Documentation/git-apply.txt | 7 ++++++-
>  apply.c                     | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index aa1ae56a25..a32ad64718 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -14,11 +14,11 @@ SYNOPSIS
>  	  [--allow-binary-replacement | --binary] [--reject] [-z]
>  	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
>  	  [--ignore-space-change | --ignore-whitespace]
>  	  [--whitespace=(nowarn|warn|fix|error|error-all)]
>  	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
> -	  [--verbose] [--unsafe-paths] [<patch>...]
> +	  [--verbose | --quiet] [--unsafe-paths] [<patch>...]
>  
>  DESCRIPTION
>  -----------
>  Reads the supplied diff output (i.e. "a patch") and applies it to files.
>  When running from a subdirectory in a repository, patched paths
> @@ -226,10 +226,15 @@ behavior:
>  --verbose::
>  	Report progress to stderr. By default, only a message about the
>  	current patch being applied will be printed. This option will cause
>  	additional information to be reported.
>  
> +-q::
> +--quiet::
> +	Suppress stderr output. Messages about patch status and progress
> +	will not be printed.
> +
>  --recount::
>  	Do not trust the line counts in the hunk headers, but infer them
>  	by inspecting the patch (e.g. after editing the patch without
>  	adjusting the hunk headers appropriately).
>  
> diff --git a/apply.c b/apply.c
> index 64b226acd9..9f00f882a2 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -5071,11 +5071,11 @@ int apply_parse_options(int argc, const char **argv,
>  			N_("don't expect at least one line of context")),
>  		OPT_BOOL(0, "reject", &state->apply_with_reject,
>  			N_("leave the rejected hunks in corresponding *.rej files")),
>  		OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
>  			N_("allow overlapping hunks")),
> -		OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
> +		OPT__VERBOSITY(&state->apply_verbosity),
>  		OPT_BIT(0, "inaccurate-eof", options,
>  			N_("tolerate incorrectly detected missing new-line at the end of file"),
>  			APPLY_OPT_INACCURATE_EOF),
>  		OPT_BIT(0, "recount", options,
>  			N_("do not trust the line counts in the hunk headers"),

It is a bit surprising that this is the only change that is needed.

apply.h has

    enum apply_verbosity {
            verbosity_silent = -1,
            verbosity_normal = 0,
            verbosity_verbose = 1
    };

but OPT__VERBOSITY() cna take more than one --verbose or --quiet to
tune the verbosity level beyond the 1 and -1 limit.

I looked at the output from

    $ git grep -A3 -e '\([.]\|->\)apply_verbosity'

and made sure that there is no exact comparison with
verbosity_silent or verbosity_verbose, which means we are OK.

It would have saved time to have a note in the proposed log message
that the author already audited and found that the existing code is
ready to accept verbosity values outside the "enum apply_verbosity"
range.

Thanks, will queue.
