Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41C6C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiGYRhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGYRhT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 13:37:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B781C911
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 10:37:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EDE01A3570;
        Mon, 25 Jul 2022 13:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nJUY5vT/54oh
        qIJF6LlRjsN+LGkmyPqdDKh2NWirabE=; b=aSaZFx0tbVDEVJNjJM+0Nw96lfYC
        /+wjMdFfufY4jBWFM8/yyPdyQIjLmdd0wg0XO/ixkhL/mCZrV43EkR0rEMaE5p3i
        f12rdC1XN7V3v2XocHHkdN10S26OPAi8AjeVCe/hGxrDeeMrL3ezN5PkfMHQ8Rui
        Xizh/t0yhnRv9/Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 872CD1A356F;
        Mon, 25 Jul 2022 13:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CF581A356D;
        Mon, 25 Jul 2022 13:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 09/20] parse-options: add support for parsing subcommands
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
        <20220725123857.2773963-10-szeder.dev@gmail.com>
Date:   Mon, 25 Jul 2022 10:37:13 -0700
In-Reply-To: <20220725123857.2773963-10-szeder.dev@gmail.com> ("SZEDER
        =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 25 Jul 2022 14:38:46 +0200")
Message-ID: <xmqqa68x5c1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6BB20330-0C40-11ED-9962-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The approach is guided by the following observations:
> ...
> So in the end subcommand declaration and parsing would look something
> like this:
>
>     parse_opt_subcommand_fn *fn =3D NULL;
>     struct option builtin_commit_graph_options[] =3D {
>         OPT_STRING(0, "object-dir", &opts.obj_dir, N_("dir"),
>                    N_("the object directory to store the graph")),
>         OPT_SUBCOMMAND("verify", &fn, graph_verify),
>         OPT_SUBCOMMAND("write", &fn, graph_write),
>         OPT_END(),
>     };
>     argc =3D parse_options(argc, argv, prefix, options,
>                          builtin_commit_graph_usage, 0);
>     return fn(argc, argv, prefix);

All makes sense and exactly as I expected to see, after reading the
later steps [10-20/20] that make use of the facility.  Nicely designed.

> Here each OPT_SUBCOMMAND specifies the name of the subcommand and the
> function implementing it, and the same pointer to 'fn' where
> parse_options() will store the function associated with the given
> subcommand.

Puzzling.  Isn't parse_options() an read-only operation with respect
to the elements of the struct option array? =20

With s/store/expect to find/, I would understand the above, though.

> There is no need to check whether 'fn' is non-NULL before
> invoking it:

Again, this is puzzling.  "There is no need to"---to whom does this
statement mean to advise?  The implementor of the new codepath IN
parse_options() to handle OPT_SUBCOMMAND()?

> if there were no subcommands given on the command line
> then the parse_options() call would error out and show usage. =20

I think that you mean to say

    When one or more OPT_SUBCOMMAND elements exist in an array of
    struct option, parse_options() will error out if none of them
    triggers.

and that makes sense, but I cannot quite tell how it relates to the
previous sentence about fn possibly being NULL.

Ahh, OK.  Let's try to rephrase to see if I can make it easier to
understand.

    Here each OPT_SUBCOMMAND specifies ... with the given
    subcommand.

    After parse_options() returns, the variable 'fn' would have been
    updated to point at the function to call, if one of the
    subcommand specified by the OPT_SUBCOMMAND() is given on the
    command line.

    - When the PARSE_OPT_SUBCOMMAND_OPTIONAL flag is given to
      parse_options(), and no subcommand is given on the command
      line, the variable 'fn' is left intact.  This can be used to
      implement a command with the "default" subcommand by
      initializing the variable 'fn' to the default value.

    - Otherwise, parse_options() will error out and show usage, when
      no subcommand is given.

    - If more than one subcommands are given from the command line,
      parse_options() will stop at the first one, and treat the
      remainder of the command line as arguments to the subcommand.
   =20
> In case
> a command has a default operation mode, 'fn' should be initialized to
> the function implementing that mode, and parse_options() should be
> invoked with the PARSE_OPT_SUBCOMMAND_OPTIONAL flag.

OK.

> Some thoughts about the implementation:
>
>   - Arguably it is a bit weird that the same pointer to 'fn' have to
>     be specified as 'value' for each OPT_SUBCOMMAND, but we need a way
>     to tell parse_options() where to put the function associated with
>     the given subcommand, and I didn't like the alternatives:

I do not find this so disturbing.  This is similar to CMDMODE in
spirit in that only one has to be chosen.  CMDMODE needs to go an
extra mile to ensure that by checking the current value in the
variable pointed by the pointer because the parser does not stop
immediately after getting one, but SUBCOMMAND can afford to be
simpler because the parser immediately stops once a subcommand is
found.

In a sense, OPT_SUBCOMMAND() does not have to exist as the first-class
mechanism.  With just two primitives:

 - a flag that says "after seeing this option, immediately stop
   parsing".
 - something similar to OPT_SET_INT() but works with a function pointer.

we can go 80% of the way to implement OPT_SUBCOMMAND() as a thin
wrapper (there is "one of the OPT_SET_FUNC() must be triggered" that
needs new code specific to the need, which is the other 20%).

>   - I decided against automatically calling the subcommand function
>     from within parse_options(), because:
>
>       - There are commands that have to perform additional actions
>         after option parsing but before calling the function
>         implementing the specified subcommand.
>
>       - The return code of the subcommand is usually the return code
>         of the git command, but preserving the return code of the
>         automatically called subcommand function would have made the
>         API awkward.

Yes, the above makes perfect sense.  Also I suspect that we would
find some cases where being able to use two or more variables become
handy.

> +			case PARSE_OPT_COMPLETE:
> +			case PARSE_OPT_HELP:
> +			case PARSE_OPT_ERROR:
> +			case PARSE_OPT_DONE:
> +			case PARSE_OPT_NON_OPTION:
> +				BUG("parse_subcommand() cannot return these");
> +			}

"these" without giving the violating value?  A "%d" would be cheap
addition, but I see this was copied from elsewhere.

Thanks.
