Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A7C05027
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 01:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjA3BAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 20:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjA3BAM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 20:00:12 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92218B13
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 16:59:32 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id jm10so9997919plb.13
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 16:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lynyQYCCVKyOiRTppJTrseymcUT+XNBCTq+0Z5XTKpQ=;
        b=ppXR4iunDOzs+RWYjPu6MgAl9ebwKIhOgWtXRc1XmKAElZX+pEl3Mv/Ed1uNfhixVr
         bBevgfrdQDSlzTDIk4dAbuGKY1QAcfaNoBrxl2yAadyFrqOBI5uj82rysk36MgB6oPIg
         Z4hisqu51c0g2UhhBRTxAnnmV+Lbn3qA57dL0Ry9+U6iu3h/RGMwm8T3bJP222ABq82H
         Euru6Lx4I0Anp1VspreW4jT+LMWi3NtWY6D0R4I4TVvZcvfULknD+ljaIy8rRN8TkF7e
         mgJ49rO7K8VUIEY1CYfFxtu6AsIMytzzZ3jfL5fvln7Upwp53xcg9fH3Qj+mV7dxyzZ6
         nmow==
X-Gm-Message-State: AO0yUKUEYyz9I63xSptCQniYyztT9JOz5+jb1b1B8M6fNAgTqiYv3qbS
        yddxH3uYVzdSUK+EMAD+nxxZlWGrbGSEMY2Efjg=
X-Google-Smtp-Source: AK7set9srH243DCvChwRQ1E2ZSeWQn3MTXjr0L3yl4JQ3BcnyKMDydmWVcyLH3IsOqibdd0hdwoGVkDHAv0oKxHSD4Q=
X-Received: by 2002:a17:902:cec1:b0:196:88b8:8625 with SMTP id
 d1-20020a170902cec100b0019688b88625mr152308plg.18.1675040355487; Sun, 29 Jan
 2023 16:59:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Jan 2023 19:59:04 -0500
Message-ID: <CAPig+cQPLMrUKp0aqLCknSYCs5TAso-VSBYsQbGZ8g8wgY2Liw@mail.gmail.com>
Subject: Re: [PATCH] credential: new attribute password_expiry_utc
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 28, 2023 at 9:08 AM M Hickford via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> If password has expired, credential fill no longer returns early,
> so later helpers can generate a fresh credential. This is backwards
> compatible -- no change in behaviour with helpers that discard the
> expiry attribute. The expiry logic is entirely in the git credential
> layer; compatible helpers simply store and return the expiry
> attribute verbatim.
>
> Store new attribute in cache.
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>

Just a few comments in addition to those already provided by Junio...

> diff --git a/credential.c b/credential.c
> @@ -234,11 +236,23 @@ int credential_read(struct credential *c, FILE *fp)
> +               // if expiry date has passed, ignore password and expiry fields
> +               if (c->password_expiry_utc != 0 && time(NULL) > c->password_expiry_utc) {
> +                       trace_printf(_("Password has expired.\n"));

Using `_(...)` marks a string for localization, but doing so is
undesirable for debugging messages which are meant for the developer,
not the end user (and it creates extra work for translators). No
existing[1] trace_printf() calls in the codebase use `_(...)`.

[1]: Unfortunately, a couple examples exist in
Documentation/MyFirstObjectWalk.txt using `_(...)` but they should be
removed.

> @@ -269,6 +283,13 @@ void credential_write(const struct credential *c, FILE *fp)
> +       if (c->password_expiry_utc != 0) {
> +               int length = snprintf( NULL, 0, "%ld", c->password_expiry_utc);
> +               char* str = malloc( length + 1 );

Style in this project is `char *str`, not `char* str`. Also, drop
spaces around function arguments:

    char *str = malloc(length + 1);

> +               snprintf( str, length + 1, "%ld", c->password_expiry_utc );

Same.

> +               credential_write_item(fp, "password_expiry_utc", str, 0);
> +               free(str);
> +       }

xstrfmt() from strbuf.h can help simplify this entire block:

    char *s = xstrfmt("%ld", c->password_expiry_utc);
    credential_write_item(fp, "password_expiry_utc", str, 0);
    free(s);
