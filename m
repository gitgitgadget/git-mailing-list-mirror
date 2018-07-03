Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F481F516
	for <e@80x24.org>; Tue,  3 Jul 2018 07:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeGCHQI (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 03:16:08 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44019 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeGCHQG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 03:16:06 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so339319ybl.10
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 00:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iS5X9mNjOpL1UqT0/hEeWHZhss6e3IH2xVgh1lzhyyM=;
        b=FgLfVQrYI88xAQhR3JyENs2XRXobo4ji2Af17Qeaob83rSgxMFGH4RpLwqR8Q46m1e
         5hAeijuHL+BQNaVGeypU7sL+j6wW9n56iXR+2GE/FxFl+EBHUrzRshis9iEFM9vQmRnj
         cnIvBwpqYwEsmbO4q10WZ6sNBha2L78IHppySG4Jbgs775S1l8BtjzqgRRrbEL3fV9Qn
         e3yvsRmrAGcGevd02s8TI3NNbx/33+hEXm465L9I+dO9I7TphFjkU1pDeQLf+ydmZZaJ
         jlyMChasJIfaRLS0NWr5kgeGOqI4AYlpM7Cozx0mEGvc7xxBI/URf5asWwtPw/2H4ANi
         yt3w==
X-Gm-Message-State: APt69E3+Qx/bMlLteepYv5Uv/dYkZ7ujDUE+Enek8BQ0hsgJDu2qaY1+
        07/sDk+Cs4T2G8+kZYOaHyNCLuoctcj/BGiDXYA=
X-Google-Smtp-Source: AAOMgpe1zwPBKFupyxjUMLR0jglbjN9T/79Hf66GoboDZwkXN6OXy34Rlj/KehGV2IcU8ACEAT8P/ZRaldhjUz4tixs=
X-Received: by 2002:a25:c04b:: with SMTP id c72-v6mr11196979ybf.12.1530602165497;
 Tue, 03 Jul 2018 00:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180703035802.24060-1-jyn514@gmail.com>
In-Reply-To: <20180703035802.24060-1-jyn514@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Jul 2018 03:15:54 -0400
Message-ID: <CAPig+cT9XB-nJFm0rD9RckBzcbk9vh8Hz=3XOA-HA-JoXssG_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
To:     jyn514@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for contributing to Git. As this seems to be your first
submission to the project, don't be alarmed by the extent and nature
of the review comments. They are intended to help you polish the
submission, and are not meant with ill-intent.

On Mon, Jul 2, 2018 at 11:58 PM Joshua Nelson <jyn514@gmail.com> wrote:
> use syntax similar to `git-checkout` to make <tree-ish> optional for
> `ls-tree`. if <tree-ish> is omitted, default to HEAD. infer arguments as
> follows:

Nit: Capitalize first word of each sentence.

This commit message explains what the patch changes (which is a good
thing to do), but it's missing the really important explanation of
_why_ this change is desirable. Without such justification, it's
difficult to judge if such a change is worthwhile. As this is a
plumbing command, people may need more convincing (especially if other
plumbing commands don't provide convenient defaults like this).

> 1. if args start with --
>         assume <tree-ish> to be HEAD
> 2. if exactly one arg precedes --, treat the argument as <tree-ish>
> 3. if more than one arg precedes --, exit with an error
> 4. if -- is not in args
>         a) if args[0] is a valid <tree-ish> object, treat is as such
>         b) else, assume <tree-ish> to be HEAD
>
> in all cases, every argument besides <tree-ish> is treated as a <path>

This and the other patches are missing your Signed-off-by: (which
should be placed right here).

The three patches of this series are all directly related to this one
change. As such, they should be combined into a single patch. (At the
very least, 1/3 and 2/3 should be combined; one could argue that 3/3
is lengthy enough to make it separate, but that's a judgment call.)

Now, on to the actual code...

> diff --git builtin/ls-tree.c builtin/ls-tree.c
> @@ -163,10 +163,39 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>             ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
>                 ls_options |= LS_SHOW_TREES;
>
> +       const char *object;
> +       short initialized = 0;

This project frowns on declaration-after-statement. Move these to the
top of the {...} block where other variables are declared.

Why use 'short'? Unless there's a very good reason that this needs to
be a particular size, you shouldn't deviate from project norm, which
is to use the natural word size 'int'.

'initialized' is too generic, thus isn't a great name.

>         if (argc < 1)
> -               usage_with_options(ls_tree_usage, ls_tree_options);
> -       if (get_oid(argv[0], &oid))
> -               die("Not a valid object name %s", argv[0]);
> +               object = "HEAD";
> +       else {
> +               /* taken from checkout.c;
> +                * we have a simpler case because we never create a branch */

Style: Multi-line comments are formatted like this:

    /*
     * Gobble
     * wobble.
     */

However, this comment doesn't belong in the code, as it won't be
particularly helpful to anyone reading the code in the future. This
sort of note would be more appropriate in the commit message or, even
better, in the commentary section just below the "---" lines following
your Signed-off-by:.

> +               short dash_dash_pos = -1, i = 0;

Same question about why you used 'short' rather than 'int' (especially
as 'dash_dash_pos' is declared 'int' in checkout.c).

Is there a good reason why you initialize 'i' in the declaration
rather than in the for-loop? A _good_ reason to do so in the for-loop
is that doing so makes the for-loop more idiomatic, reduces cognitive
load on readers (since they don't have to chase down the
initialization), and safeguards against someone adding new code
between the declaration and the for-loop which might inadvertently
alter the initial value.

> +               for (; i < argc; i++) {
> +                       if (!strcmp(argv[i], "--")) {
> +                               dash_dash_pos = i;
> +                               break;
> +                       }
> +               }
> +               if (dash_dash_pos == 0) {
> +                       object = "HEAD";
> +                       argv++, argc++;

'argc' is never accessed beyond this point, so changing its value is
pointless. Same observation for the 'else' arms. (And, even if there
was a valid reason to modify 'argc', I think you'd want to be
decrementing it, not incrementing it, to show that you've consumed an
argument.)

> +               } else if (dash_dash_pos == 1) {
> +                       object = argv[0];
> +                       argv += 2, argc += 2;
> +               } else if (dash_dash_pos >= 2)
> +                       die(_("only one reference expected, %d given."), dash_dash_pos);
> +               else if (get_oid(argv[0], &oid)) // not a valid object

Style: Use /* comments */ in this codebase, not // comments.

> +                       object = "HEAD";
> +               else {
> +                       argv++, argc++;
> +                       initialized = 1;
> +               }
> +       }
> +
> +       if (!initialized) // if we've already run get_oid, don't run it again
> +               if (get_oid(object, &oid))
> +                       die("Not a valid object name %s", object);

Can't you accomplish the same without the 'initialized' variable by
instead initializing 'object' to NULL and then checking it here?

    if (object && get_oid(object, &oid))
        die(_("not a valid object name: %s", object);
