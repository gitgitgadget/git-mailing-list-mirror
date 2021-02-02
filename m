Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB85C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 00:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B9764EC5
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 00:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBBAsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 19:48:21 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:33028 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhBBAsV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 19:48:21 -0500
Received: by mail-ej1-f43.google.com with SMTP id sa23so10984563ejb.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 16:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPqPQo2fxtMYmay1N10bwfOV3bqsN18mIDsi3CzCzVg=;
        b=NqoZAaITSnZjCG2i6QNAKVx7quLo5QlN4uELFw40Ni/XAnXTQwKR6rIDk1e7TgBPhM
         zxK8TaPNJ8y42Nn4XrAOsFPow+FiIstjy8BHiXv0mWFsjqdTwQUBMXDa3znc2IEvfitS
         LKJEa8JxT+ZISCNlyWzwkYKBRIhSMLBGJc2Z63mM4olCzxhLeO2px1RQLROF2/q7HEgh
         vxKXyLBcjlFsxo0pejFvo7VdQQz9E6H3WxIA+jK3knxkL/X0/3OtIFvtZPhwkrQxbfFQ
         nUvQz8voZ0g5peil25lGCBKHuzTHPY4nr2OBliax+WvehG9zk8w7xg0NK6LbbbWi+X5Z
         DAQQ==
X-Gm-Message-State: AOAM533DamBebqm3ViZPGZhBh5sZAJqsN2xMQO592usSTOp53Hb2Tr9p
        8NO3WYfNT5SvNnnIZ64Z6Mwnuu0anzPrgdA8Q7ozp7ZgN/h3GQ==
X-Google-Smtp-Source: ABdhPJzvz+Xo1hGnUU/AJLc2E9M7MlxaVywPQVi4MDmFghZ0NcKEEzQbZfuFb5+t1S3Bx7cbku53JrbdixBYeivrPrw=
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr19509008ejk.311.1612226858833;
 Mon, 01 Feb 2021 16:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-7-charvi077@gmail.com>
In-Reply-To: <20210129182050.26143-7-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Feb 2021 19:47:27 -0500
Message-ID: <CAPig+cQeBE7m8wf1e_soVrpvL3==u50MPyb90NwWLnFiUz1Byw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] rebase -i: add fixup [-C | -c] command
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 1:24 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> Add options to `fixup` command to fixup both the commit contents and
> message. `fixup -C` command is used to replace the original commit
> message and `fixup -c`, additionally allows to edit the commit message.

In the cover letter for this series, you had this additional information:

    This convention is similar to the existing `merge` command in the
    interactive rebase, that also supports `-c` and `-C` options with
    similar meanings.

which helps to explain the choice of -c and -C. It might be nice to
include that explanation in this commit message, as well (but not
itself worth a re-roll).

> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> @@ -44,7 +44,9 @@ void append_todo_help(int command_count,
>  "s, squash <commit> = use commit, but meld into previous commit\n"
> -"f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
> +"f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
> +"                   commit's log message. Use -C to replace with this\n"
> +"                   commit message or -c to edit the commit message\n"

This change jarringly introduces the first and only use of a period
and capitalized word in the to-do help text. Perhaps instead say:

    ... like \"squash\", but discard this
    commit's log message; use -C to replace with this
    commit message or -c to edit the commit message

When `-c` says "edit the commit message" it's not clear what will be
edited. The original's commit message? The replacement's message? A
combination of the two? If you can come up with a succinct way to word
it such that it states more precisely what exactly will be edited, it
would be nice, but not necessarily worth a re-roll.

> diff --git a/sequencer.c b/sequencer.c
> @@ -1718,6 +1718,12 @@ static int is_pick_or_similar(enum todo_command command)
> +enum todo_item_flags {
> +       TODO_EDIT_MERGE_MSG    = (1 << 0),
> +       TODO_REPLACE_FIXUP_MSG = (1 << 1),
> +       TODO_EDIT_FIXUP_MSG    = (1 << 2),
> +};

I'm confused. These enumeration items are defined as bit flags,
implying that they may be combined, however...

> @@ -1734,32 +1740,176 @@ static size_t subject_length(const char *body)
> +static int check_fixup_flag(enum todo_command command,
> +                           enum todo_item_flags flag)

...here and elsewhere, you declare the argument as a strict
`todo_item_flags` enum item rather than `unsigned` which is the
typical declaration when combining bit flag values. So, the picture
thus far is confusing. Are the `todo_item_flags` values distinct
unique values which will never be combined, or are they meant to be
combined?

> +{
> +       return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
> +                                        (flag & TODO_EDIT_FIXUP_MSG));
> +}

This code adds to the confusion. In the function argument list, `flag`
has been declared as a single enum item, yet this code is treating
`flag` as if it is a combination of bits. So, it's not clear what the
intention is here. Is `flag` always going to be a specific enum item
in this context or is it going to be a combination of bits? If it is
only ever going to be a distinct enum item, then one would expect this
code to be written like this:

    return command == TODO_FIXUP &&
        (flag == TODO_REPLACE_FIXUP_MSG ||
        flag == TODO_EDIT_FIXUP_MSG);

Otherwise, if `flag` will actually be a bag of bits, then the argument
should be declared as such:

    static int check_fixup_flag(enum todo_command command,
        unsigned flag)

By the way, the function name check_fixup_flag() doesn't necessarily
do a good job conveying the purpose of this function. Based upon the
implementation, I gather that it is checking whether the command is a
"fixup" command, so perhaps the name could reflect that. Perhaps
is_fixup() or something?

> +static int append_squash_message(struct strbuf *buf, const char *body,
> +                        enum todo_command command, struct replay_opts *opts,
> +                        enum todo_item_flags flag)
> +{
> +       /*
> +        * amend is non-interactive and not normally used with fixup!
> +        * or squash! commits, so only comment out those subjects when
> +        * squashing commit messages.
> +        */
> +       if (starts_with(body, "amend!") ||
> +           ((command == TODO_SQUASH || seen_squash(opts)) &&
> +            (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
>                 commented_len = subject_length(body);

I understand from the cover letter that "amend!" is being added by
this series, however, no patch up to this point, nor this patch
itself, adds "amend!" functionality, so it's surprising to see it
being tested here. As a reader, I would expect code/comments related
to "amend!" to be added in the patch which actually introduces
"amend!" rather than doing it here.

> +       /* fixup -C after squash behaves like squash */
> +       if (check_fixup_flag(command, flag) && !seen_squash(opts)) {
> +               if (opts->signoff)
> +                       append_signoff(buf, 0, 0);
> +
> +               if ((command == TODO_FIXUP) &&
> +                   (flag & TODO_REPLACE_FIXUP_MSG) &&
> +                   (file_exists(rebase_path_fixup_msg()) ||
> +                    !file_exists(rebase_path_squash_msg()))) {

Is the expression `command == TODO_FIXUP` redundant here considering
that the only way we got this far is if check_fixup_flag() returned
true, in which case we know that command is TODO_FIXUP? Or am I
missing something?

> @@ -2281,6 +2436,18 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
> +       if (item->command == TODO_FIXUP) {
> +               if (skip_prefix(bol, "-C", &bol) &&
> +                  (*bol == ' ' || *bol == '\t')) {
> +                       bol += strspn(bol, " \t");
> +                       item->flags |= TODO_REPLACE_FIXUP_MSG;
> +               } else if (skip_prefix(bol, "-c", &bol) &&
> +                                 (*bol == ' ' || *bol == '\t')) {
> +                       bol += strspn(bol, " \t");
> +                       item->flags |= TODO_EDIT_FIXUP_MSG;
> +               }
> +       }

I was wondering if the above could be rephrased like this to avoid the
repetition:

    if (bol[0] == '-' && tolower(bol[1]) == 'c' &&
        (bol[2] == ' ' || bol[2] == '\t') {
        item->flags |= bol[1] == 'C' ?
            TODO_REPLACE_FIXUP_MSG :
            TODO_EDIT_FIXUP_MSG;
        bol += 2 + strspn(bol + 2, " \t");
    }

but perhaps it's too magical and ugly.
