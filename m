Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AF3C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 20:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAOU7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 15:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjAOU7c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 15:59:32 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D010F13519
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 12:59:31 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso29291904pjf.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 12:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AIs0oILo2xj2Br8xN4IX/peFBbF/gsTuD2yMSn+JVM=;
        b=UU5oLJUPwIhNqfIeR3jKo/NHITiNTOJAxN6VGMt8WHKrnIvUxj2ffkmcD+g+u6ynwo
         3gqBcUxn/Mvs1jhtePSxYjJoODlWu/u+f/h+ev/zfmekOv3rmiskQcYnZcAdFjQo8ZHq
         jStN3M/tSFqeKXTad1cAtXHX3tRfFJcv9XQpOwK2kalzu6Cm22tIevp06HlaY7j/vXj0
         92lI2o6TPmdbJBsoSVvPjlxf/AL4SHWFy9ovX5xff/AljwjlJYwpA5vmrj/OJSQZWY8z
         nR8gXx4c2aGIqm4KSJvfQwFQ889u+Pgp7CxJWbs+Hiaf1dKePE3CvJ/bhDDC34Yo5qmX
         GJbQ==
X-Gm-Message-State: AFqh2koP6PsXfAXki79Cew2A65B32S8R6M2cq6M2YchuzWu3mHK6LZpF
        Gil/a5eabc2gAl5ZOGY08TDbOqnc8kMzKqCkCpTYL7za
X-Google-Smtp-Source: AMrXdXvsyrMboSSOtR4f7BnwveOGOSkHElT7SB5WZ6mrs6RVlY9izTLby4Su/oWAPPK4CEuoyvPLz0uO7R7dwN1UFPw=
X-Received: by 2002:a17:903:26d4:b0:194:706c:d074 with SMTP id
 jg20-20020a17090326d400b00194706cd074mr426410plb.94.1673816371256; Sun, 15
 Jan 2023 12:59:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673490953.git.dyroneteng@gmail.com> <7b756b4c605e148f6938fee74882091661382173.1673490953.git.dyroneteng@gmail.com>
In-Reply-To: <7b756b4c605e148f6938fee74882091661382173.1673490953.git.dyroneteng@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Jan 2023 15:59:20 -0500
Message-ID: <CAPig+cR5s3XzmY+L_jDW2g_PEgi5E791x0GuV+VPkxFA_6sB7A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] notes.c: drop unreachable code in 'append_edit()'
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 9:48 PM Teng Long <dyroneteng@gmail.com> wrote:
> Situation of note "removing" shouldn't happen in 'append_edit()',
> unless it's a bug. So, let's drop the unreachable "else" code
> in "append_edit()".
>
> The notes operation "append" is different with "add", the latter
> supports to overwrite the existing note then let the "removing"
> happen (e.g. execute `git notes add -f -F /dev/null` on an existing
> note), but the former will not because it only does "appends" but
> not doing "overwrites".
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -630,13 +630,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>                 if (add_note(t, &object, &new_note, combine_notes_overwrite))
>                         BUG("combine_notes_overwrite failed");
>                 logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
> -       } else {
> -               fprintf(stderr, _("Removing note for object %s\n"),
> -                       oid_to_hex(&object));
> -               remove_note(t, object.hash);
> -               logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
> +               commit_notes(the_repository, t, logmsg);
>         }
> -       commit_notes(the_repository, t, logmsg);

This change breaks removal of notes using "git notes edit". Prior to
this change, if you delete the content of a note using "git notes
edit", then the note is removed. Following this change, the note
remains, which contradicts documented[1] behavior.

[1]: Unfortunately, perhaps, this behavior is documented under the
"remove" subcommand rather than the "edit" subcommand, but it is
nevertheless documented and has worked this way for ages, so this
patch causes a regression.
