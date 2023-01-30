Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC4C54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 05:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjA3FiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 00:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA3FiP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 00:38:15 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00611DBBF
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 21:38:13 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id h9so1840987plf.9
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 21:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtYKFbD0F1JcjJLqfKzgP47XZnNbH1Vf8uFqWfBOQL8=;
        b=0iE0Y5pb5RgVyRvSBsEO/wCYVHkxT10qg88cxEovKqqaRwx4JgNUXUoGrFoknFOJZR
         tjhycMTy30fzjOMmLUqktRWwI4vHN9qx3vEzBPnXoIyN5VkrGt0H1TjG2SLVX5kE6/Pm
         T8w30t2e3QOlrdbG+MKUJHYlaEgbbw84mcOzjozwG7XtnHcIWl7l63HXEuWOkeYICBPo
         MxMzn9GMfFuX8dLZNbXsbokiQs//WHtO5Ns2nBg7IkfXwcBJinO8G/ZcAI/e75MiuB0p
         eRvrYyN67waeqnqmcHtLdv1jVy8O+mGxi5oZ5A61YRN8e7SvkR+pnYqaAQ/XusxpDZmu
         KWiQ==
X-Gm-Message-State: AO0yUKXCdPXZ5tJJvl+1aRWAQJ5vvAtRYamDcIwoo1QWoE74R9XvvvIZ
        ZXnefM1SMu5jYbDcUxrfBaMDF1QcbNG7twoV9+EMMAK1
X-Google-Smtp-Source: AK7set/4gR2uVPByiEGgCLlbd9ZsI5aIO3b5Ebb30JoebG7hXhGN0/HkmeAc7g1z3u1Npo16z36/5ZZJhRoApSAUZ3U=
X-Received: by 2002:a17:90a:6b03:b0:22c:172e:f577 with SMTP id
 v3-20020a17090a6b0300b0022c172ef577mr2366157pjj.191.1675057093026; Sun, 29
 Jan 2023 21:38:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cR5s3XzmY+L_jDW2g_PEgi5E791x0GuV+VPkxFA_6sB7A@mail.gmail.com>
 <20230128115027.57250-1-tenglong.tl@alibaba-inc.com>
In-Reply-To: <20230128115027.57250-1-tenglong.tl@alibaba-inc.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jan 2023 00:38:02 -0500
Message-ID: <CAPig+cTVMGcRQqntPuwtV9x=WxUh-37Uy5V95A3F4ekeQgFq2g@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] notes.c: drop unreachable code in 'append_edit()'
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 28, 2023 at 6:50 AM Teng Long <dyroneteng@gmail.com> wrote:
> Eric Sunshine writes:
> > > Situation of note "removing" shouldn't happen in 'append_edit()',
> > > unless it's a bug. So, let's drop the unreachable "else" code
> > > in "append_edit()".
> > >
> > > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > > ---
> > > -       } else {
> > > -               fprintf(stderr, _("Removing note for object %s\n"),
> > > -                       oid_to_hex(&object));
> > > -               remove_note(t, object.hash);
> > > -               logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
> > > +               commit_notes(the_repository, t, logmsg);
> > >         }
> > > -       commit_notes(the_repository, t, logmsg);
> >
> > This change breaks removal of notes using "git notes edit". Prior to
> > this change, if you delete the content of a note using "git notes
> > edit", then the note is removed. Following this change, the note
> > remains, which contradicts documented[1] behavior.
>
> As the commit msg describes, the subcommands I understand should have clear
> responsibilities as possible (documentaion may have some effect in my mind). So,
> the removal opertion under "append subcommand" here is little wired to me, but
> your suggestion makes sense, this may have compatibility issues. Although I
> think it's weird that someone would use this in the presence of the remove
> subcommand, and my feeling is that this code is actually copied from the add
> method (introduced by 52694cdabbf68f19c8289416e7bb3bbef41d8d27), but I'm not
> sure.
>
> So, it's ok for me to drop this one.

It's unfortunate, perhaps, that the git-notes command-set is not
orthogonal, but it's another case of historic accretion. According to
the history, as originally implemented, git-notes only supported two
commands, "edit" and "show", and "edit" was responsible for _all_
mutation operations, including deletion. git-notes only grew a more
complete set of commands a couple years later.

At any rate, even though the original behaviors may not make as much
sense these days now that git-notes has a more complete set of
commands, we still need to be careful not to break existing workflows
and scripts (tooling). That's why it would be nice to beef up the
tests so that the existing behaviors don't get broken by changes such
as this patch wants to make. But, as mentioned earlier, the additional
tests probably shouldn't be part of this series, but rather can be
done as a separate series (by someone; it doesn't have to be you).
