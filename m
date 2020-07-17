Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699FAC433E0
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 23:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3C520717
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 23:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGQXrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:47:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46329 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXrc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 19:47:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id r12so12701174wrj.13
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 16:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsquUwMRCjWKCsWGiMTY+y30jHbmmh7HtkYy+F05KIU=;
        b=agG/ziuzOh01m3fA5tTMbkzQu4tRXabV8IYX7oEJfNkYtR4k9aNmzf3ORkPAdiACRf
         SYmiLslTmUoiT6wLaK2CKEDPJh8Y9NH7GUH4T/t2OR9mBQQbEj4ojy96JbA++EEtMzr0
         MosOP2IxfFuIfD93bb9w44BZyOPoOR2uO/EcGIuWlceVMJEJ+lnkl7/BBsBdhT3nkuit
         I3GLov4oRIYaXcLl2uvnzJvinC0mRquzH//89Zm2zbR1ptrgYB0njM/llXtj93+pxjYs
         gfEaqOKm8knBq5ODFf6u6NOa8f/5TCuL11Oobt+yiwfBub53CnwAKalbVrnvmI9C5bqp
         ocsA==
X-Gm-Message-State: AOAM533rM6OHekXWWuLiz2mdZqT3KqPFr/v8Epkpe4HZyzbJohoLiEv9
        XYdpmtWMjoHFyi6WA2SSgFiuj7c31lGHUxfgYR8=
X-Google-Smtp-Source: ABdhPJwVjr8VzwhdnE7+dvMqfmfXyZYSPLHcFRI4OoEXCKd/EEvplrlOLvp9+Dzngd39SizWF6rw7u6tKs3DTftpg7c=
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr12846765wrw.386.1595029649926;
 Fri, 17 Jul 2020 16:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
In-Reply-To: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Jul 2020 19:47:18 -0400
Message-ID: <CAPig+cQaqg7MbyNZakuWVzezhPCXu=LonCVAw_p13c=0YNBdPw@mail.gmail.com>
Subject: Re: [PATCH] git-mv: improve error message for conflicted file
To:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 17, 2020 at 7:25 PM Chris Torek via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> 'git mv' has always complained about renaming a conflicted
> file, as it cannot handle multiple index entries for one file.
> However, the error message it uses has been the same as the
> one for an untracked file:
>
>     fatal: not under version control, src=...
>
> which is patently wrong.  Distinguish the two cases and
> add a test to make sure we produce the correct message.
>
> Signed-off-by: Chris Torek <chris.torek@gmail.com>
> ---

A few nits below...

> diff --git a/builtin/mv.c b/builtin/mv.c
> @@ -220,9 +220,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> +               } else if (cache_name_pos(src, length) < 0) {
> +                       /*
> +                        * This occurs for both untracked files *and*
> +                        * files that are in merge-conflict state, so
> +                        * let's distinguish between those two.
> +                        */
> +                       struct cache_entry *ce = cache_file_exists(src, length, ignore_case);
> +                       if (ce == NULL)
> +                               bad = _("not under version control");
> +                       else
> +                               bad = _("must resolve merge conflict first");

Style: write `!ce` rather than `ce == NULL`:

    if (!ce)
        bad = _("not under version control");
    else
        bad = _("must resolve merge conflict first");

or reverse the arms and skip the `!` altogether:

    if (ce)
        bad = _("must resolve merge conflict first");
    else
        bad = _("not under version control");

Or even:

   bad = ce ? _("must resolve merge conflict first") : _("not under
version control");

though it's subjective whether that is more readable.

As for bikeshedding the message itself, perhaps:

    _("conflicted");

Though, perhaps that's too succinct.

> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> @@ -248,6 +248,24 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
> +test_expect_success 'git mv error on conflicted file' '
> +       rm -fr .git &&
> +       git init &&
> +       touch conflicted &&

If the timestamp of the file is not relevant to the test -- as is the
case here -- then we avoid using `touch`. Instead:

    >conflicted &&

> +       cfhash=$(git hash-object -w conflicted) &&
> +       git update-index --index-info <<-EOF &&
> +       $(printf "0 $cfhash 0\tconflicted\n")
> +       $(printf "100644 $cfhash 1\tconflicted\n")
> +       EOF

This can probably be written more easily and clearly like this:

    git update-index --index-info <<-EOF &&
    0 $cfhash 0    conflicted
    100644 $cfhash 1    conflicted
    EOF

That is, use literal TABs and let the here-doc provide the newlines.
Alternately, you could take advantage of the q_to_tab() function to
convert literal "Q" to TAB:

    q_to_tab <<-EOF | git update-index --index-info &&
    0 $cfhash 0Qconflicted
    100644 $cfhash 1Qconflicted
    EOF

> +       test_must_fail git mv conflicted newname 2>actual &&
> +       test_i18ngrep "merge.conflict" actual
> +'
> +
> +rm -f conflicted

I realize that this test script is already filled with this sort of
thing where actions are performed outside of tests, however, these
days we frown upon that, and there really isn't a good reason to avoid
taking care of this clean up via the modern idiom of using
test_when_finished(), which you would call immediately after creating
the file in the test. So:

    ...
    >conflicted &&
    test_when_finished "rm -f conflicted" &&
    ...
