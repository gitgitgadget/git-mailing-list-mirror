Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E6EC46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 21:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjAOV3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 16:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjAOV3A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 16:29:00 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A61630B
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:29:00 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id v23so23549903plo.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YU1SxInfsLIc3DoZbgHi0tibbinheDuXQXBMY4vBKEQ=;
        b=7AmBoCZrmXrrjl+R7EZzdVa4WU7xcnjJvFpQTUkhfRg7DgtSOpk1yAYAL1W7VPI+FV
         dWPuUwDHfhwxLapn91eWTNrqaq5zkmWs2SPxPdRVWnAFxzmbVnEhvkOmSiLouR4JKjjW
         Yuav82fsJ9+G16KMDX05i8BeMzji6P01RSdP221h7FcWsjimaRrcTtj9xOVYXVS6q0fe
         w6auXkQ9L0r1WlDBkokU2ivHAijqNcdD2V2TjLHLH225qp8gPbKinqL086DAVGoPUrmE
         w5bFsMQIwVFF3qhgI39CLv2S8tRi/uXsy4L0zyha39i1VFlicKqzbZ/JoZiB4OGRMKPU
         ce+A==
X-Gm-Message-State: AFqh2kpylkB7KoIL1mfU2kKUTHX7KdZenCznKxKgHA4LaBzdFitiXed3
        cR7GlHZ5EuCVkFg4oi4gsNfGHgplldqVy84yyEM=
X-Google-Smtp-Source: AMrXdXs2rvaFtXvJxKlAbiDhOiMu7FSVDxpZULoxB1lE2UIcPFDVFuXPXbA4uthBtESVdgbgCQbO2FvAZxbpq4BUYjk=
X-Received: by 2002:a17:902:cccd:b0:191:2b33:606f with SMTP id
 z13-20020a170902cccd00b001912b33606fmr440819ple.32.1673818139680; Sun, 15 Jan
 2023 13:28:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673490953.git.dyroneteng@gmail.com> <d41ba140505aa3459330afd652ff6a0f456222a0.1673490953.git.dyroneteng@gmail.com>
In-Reply-To: <d41ba140505aa3459330afd652ff6a0f456222a0.1673490953.git.dyroneteng@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Jan 2023 16:28:48 -0500
Message-ID: <CAPig+cTtWStcDipNPHWvCVeuvtUdJtvotVH4ghtiND7-mpseeQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] notes.c: provide tips when target and append note
 are both empty
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 9:48 PM Teng Long <dyroneteng@gmail.com> wrote:
> When "git notes append <object>" is executed, if there is no note in
> the given object and the appended note is empty too, we could print
> the exact tips to end-user.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -631,7 +631,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> +       } else if (!d.buf.len && !note)
> +               fprintf(stderr,
> +                       _("Both original and appended notes are empty in %s, do nothing\n"),
> +                       oid_to_hex(&object));

My knee-jerk reaction is between "meh" and "thumbs down". The commit
message says we "can do this" but doesn't explain "why we should do
this". Is this condition important enough to break the Unix maxim of
"Rule of Silence" (or "Silence is Golden")?

I also wonder if this change is going to cause problems (or at least
annoyance) for automated tooling. At present, tooling doesn't have to
worry whether or not the existing or new note is empty; everything
just works as expected without complaint. However, following this
change, such tooling may now be greeted with an unexpected diagnostic
message.
