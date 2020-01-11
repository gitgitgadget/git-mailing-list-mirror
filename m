Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAAAC33C9E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 13:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DBE20842
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 13:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgAKN1H convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 11 Jan 2020 08:27:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36679 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgAKN1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 08:27:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so4846166wma.1
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 05:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nHimEawmhgRrUjC7hYUAkxVBg6dC2rUhgCZpgONiQsY=;
        b=tTdbIFRqyJgTt//2gLXE8Qzx+OHzEQqATA9KGpn+hUQm/jJZGDQ0q9dYC+Q2EdSqOv
         h/RYe8a+Q8TPQobruaOJEtoyW6W1dj+ZWFjouIMdBbX+GNQlLZDjHzgF0rhdU4TyBHEx
         1HLfHfUSio2sEjpuf6pSkjeIAaBOaT2VA7lpWCyN0XwK8u9iMoyzCjy8qnRgTg3Actq1
         6+rfbYVKZ2K7ewKTJRpPQbSXzhcCaJJUwka5iN+6S9gfxXihj175Rokv0XPd9GPn7bD/
         e+G+4bjRJMAyy503dnVRLMRhAR90I//vpLiei+jHkEQFpUXwpKq08bsDTCzjUnL0cP0L
         hU8Q==
X-Gm-Message-State: APjAAAWORJ0TneoZEVSJdjNL9VrLPuLqg5jtVBAr459PuRNUIozR1we2
        WqHbU052Ro3vFlwA9zYFZBRLHKGciYlmjJ6WMQs=
X-Google-Smtp-Source: APXvYqwfB9BocD9pG8vv4dKyzxu9QiMy7hDRDZDMC9DbNMGqVZrybRPjOkSB/PnVNzOLuZYJxBLVUt61kxce+uyS5y0=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr10044774wmj.75.1578749224508;
 Sat, 11 Jan 2020 05:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Jan 2020 08:26:53 -0500
Message-ID: <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     marcandre.lureau@redhat.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 11, 2020 at 7:36 AM <marcandre.lureau@redhat.com> wrote:
> Defaulting to editing the description of the rebased branch without an
> explicit branchname argument would be useful.  Even the git bash prompt
> shows the name of the rebased branch, and then
>
>   ~/src/git (mybranch|REBASE-i 1/2)$ git branch --edit-description
>   fatal: Cannot give description to detached HEAD
>
> looks quite unhelpful.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -745,15 +745,27 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                 if (!argc) {
> -                       if (filter.detached)
> -                               die(_("Cannot give description to detached HEAD"));
> -                       branch_name = head;
> +                       if (filter.detached) {
> +                               struct wt_status_state state;
> +
> +                               memset(&state, 0, sizeof(state));
> +
> +                               if (wt_status_check_rebase(NULL, &state)) {
> +                                       branch_name = state.branch;
> +                               }

Style: drop unneeded braces.

> +
> +                               if (!branch_name)
> +                                       die(_("Cannot give description to detached HEAD"));
> +
> +                               free(state.onto);

Also, no need for all the blank lines which eat up valuable vertical
screen real-estate without making the code clearer.

> +                       } else
> +                               branch_name = xstrdup(head);

It would be easier to see what happens in the common case (when not
rebasing) if you invert the condition to `if (!filter.detached)` and
turn this one-line 'else' branch into the 'if' branch.

> @@ -772,6 +784,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                 if (edit_branch_description(branch_name))
>                         return 1;
> +
> +               free(branch_name);

That `return 1` just above this free() is leaking 'branch_name', isn't it?

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -1260,6 +1260,25 @@ test_expect_success 'use --edit-description' '
> +test_expect_success 'use --edit-description during rebase' '
> +       write_script editor <<-\EOF &&
> +               echo "Rebase contents" >"$1"
> +       EOF
> +       (
> +               set_fake_editor &&
> +               FAKE_LINES="break 1" git rebase -i HEAD^ &&
> +               EDITOR=./editor git branch --edit-description &&
> +               git rebase --continue
> +       ) &&
> +       write_script editor <<-\EOF &&
> +               git stripspace -s <"$1" >"EDITOR_OUTPUT"
> +       EOF
> +       EDITOR=./editor git branch --edit-description &&
> +       echo "Rebase contents" >expect &&
> +       test_cmp expect EDITOR_OUTPUT
> +'
> +test_done

Strange place for a test_done() invocation considering that existing
tests follow the new one added by this patch.

>  test_expect_success 'detect typo in branch name when using --edit-description' '
>         write_script editor <<-\EOF &&
>                 echo "New contents" >"$1"
