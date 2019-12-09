Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD7C2BD09
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E548420692
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLIQ0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:26:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38345 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQ03 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:26:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so15633001wmi.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Fk6AGh84xMBN3pxBJwx5qjn3Txgm3XErqHu5zYLAUE=;
        b=cnIPTHNN6vq2GPCYhe/ea0tMxvRV58z0oQqbAtGn7MuRI1gHVy38F1iQ0JCohl0FV/
         hfg0YoCM4LMmZcFNWKkjnB5g8vRdrcmU9ly1vq24+ohdXQVwIt1NhXQhgMekx5YYjtY5
         KKtKdDuAuJWlz9xGvjh8mlWKwQfyuzBUBqZA4p/B8yV1y91ojwCnGyxn1lVPFxs9GfUn
         v8tn7cO0xHhPIdZ5Y7AtN4kNtPy+gbKaUfk685A1JZnh4WCijIrdViECm2czj0Dlph1X
         eea9LiPMpdoYZZwq2gV05s74n7BL8wN6JStZRwnIde3O2hTC1YZS7fMAZ+nNU1sjXmdH
         09lA==
X-Gm-Message-State: APjAAAXaSdgR+JT0KwXt99j4P4a1Xm04f4VK4IbUemzlpOVCcUtkEozr
        xQS1//6zvYTuvy41lD35AqrTexY+PXS2PalfCZE=
X-Google-Smtp-Source: APXvYqyaoTFNDj95CWqXlYs/qxiiBB6TUa6xOjzE3j0XGvCt5BBFt/RQra6jlKef9HFSEBlxaxX5D5lh9GPVq3nyOSc=
X-Received: by 2002:a1c:2dc8:: with SMTP id t191mr25495578wmt.75.1575908786959;
 Mon, 09 Dec 2019 08:26:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575896661.git.liu.denton@gmail.com> <62543250c4ea0e0327f974cb90b294c60b525982.1575896661.git.liu.denton@gmail.com>
In-Reply-To: <62543250c4ea0e0327f974cb90b294c60b525982.1575896661.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Dec 2019 11:26:15 -0500
Message-ID: <CAPig+cToM+sHj-C5N_F2F+5B3LTPLVf39_-kCSih_WkuBOV+mA@mail.gmail.com>
Subject: Re: [PATCH 3/5] notes: extract logic into set_display_notes()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 8:11 AM Denton Liu <liu.denton@gmail.com> wrote:
> Instead of open coding the logic that tweaks the variables in
> `struct display_notes_opt` within handle_revision_opt(), abstract away the
> logic into set_display_notes() so that it can be reused.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/notes.c b/notes.c
> @@ -1045,6 +1045,30 @@ void init_display_notes(struct display_notes_opt *opt)
> +int set_display_notes(struct display_notes_opt *opt, int show_notes, const char *opt_ref)
> +{
> +       if (show_notes) {
> +               if (opt_ref) {
> +                       struct strbuf buf = STRBUF_INIT;
> +                       strbuf_addstr(&buf, opt_ref);
> +                       expand_notes_ref(&buf);
> +                       string_list_append(&opt->extra_notes_refs,
> +                                          strbuf_detach(&buf, NULL));
> +               } else {
> +                       opt->use_default_notes = 1;
> +               }
> +       } else {
> +               opt->use_default_notes = -1;
> +               /* we have been strdup'ing ourselves, so trick
> +                * string_list into free()ing strings */
> +               opt->extra_notes_refs.strdup_strings = 1;
> +               string_list_clear(&opt->extra_notes_refs, 0);
> +               opt->extra_notes_refs.strdup_strings = 0;
> +       }
> +
> +       return !!show_notes;
> +}

When you find yourself creating a function in which the entire body is
(effectively) a single giant 'if' statement and in which the 'then'
and 'else' arms are chosen by an input argument to that function (and
remaining input arguments are used only by one or the other branch),
it is usually a good sign that you should really be creating two
distinct functions. Doing so would reduce cognitive load of people
reading and trying to understand the code (as well as reduce the
indentation level). For instance, you might introduce these functions:

    void enable_display_notes(struct display_notes_opt *opt, const
char *opt_ref);
    void disable_display_notes(struct display_notes_opt *opt);

> diff --git a/notes.h b/notes.h
> @@ -265,6 +265,16 @@ struct display_notes_opt {
> +/*
> + * Set a display_notes_opt to a given state. 'show_notes' is a boolean
> + * representing whether or not to show notes. 'opt_ref' points to a
> + * string for the notes ref, or is NULL if the default notes should be
> + * used.
> + *
> + * Return 'show_notes' normalized to 1 or 0.
> + */
> +int set_display_notes(struct display_notes_opt *opt, int show_notes, const char *opt_ref);

Please drop the meaningless return value. While I understand you did
this as a convenience to make calling code a bit more concise, it
nevertheless doesn't belong here since it conflates that convenience
code with the true purpose of this function (which to enable or
disable note display). Worse, it increases cognitive load on people
trying to comprehend the code since it requires that they consult the
documentation for set_display_notes() to understand what is going on.
That is, this is far less obvious:

    revs->show_notes = set_display_notes(&revs->notes_opt, 1, optarg);

than this:

    revs->show_notes = 1;
    enable_display_notes(&revs->notes_opt, optarg);

Alternately, if revs->show_notes and revs->notes_opt really ought
always be set in lockstep, then maybe it makes more sense to have the
"enable" and "disable" functions accept 'revs' directly in order to be
able to adjust both revs->show_notes and revs_notes_opt together:

    void enable_display_notes(struct rev_info *revs, const char *opt_ref);
    void disable_display_notes(struct rev_info *revs);
