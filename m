Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A0C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 21:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiKCVQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 17:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiKCVQW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 17:16:22 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4506F22501
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 14:16:13 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-367cd2807f2so27803407b3.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0O4YAcyffAb8CZ/T5UXChAZ5fvyv++3HNbcegsIkYTo=;
        b=MlAcXw1tgw87aqRV53FHh3T3jk4cHY/JwbneDfyM5SSbYVNNQDaSG2/d9S6BJuzB5c
         9YxWO8j7VfWDpP7FlUYZrhZEj83ivCc6zWn4WlZ48x1JdutLFu0bkaqd8o6Xb52kPAt9
         XmgyedvhgEFmp8+ii9sGuiowD0K8cBnLw8KSB3RSVrTsRT1of4DgPN9IyWbnAPpB7i4B
         uBy7x++AntnHY16RaoIr8qbmOE6aOyq3LcDiTtjqfo4/lm+6fqM+8NZuA4Ph6tmwwf1+
         dtNtcsnw3e13A5z/NcgNgZh7Jxj60/Rbhqo4QYgY3BYEx0i5tjMLnrggwniE7ZJVwAGh
         raAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0O4YAcyffAb8CZ/T5UXChAZ5fvyv++3HNbcegsIkYTo=;
        b=uOenWkMQTHX9yPOnjz2p5qQOdsZ32VutrolIW5wdPcJZVgfQmknKT8492p3rM3p/Xl
         pBA7WVcbmZWpaCwjqmz1jm9PdUar7CmNOlMqeVWnuRzD9kKoFWVvKVZro4VvPFgdDJzh
         SQdIYQPyrh3tilJd/2yhS7CeGH1HJ4jcQFjR+9ITh2T+sbzFbC4qOWBmE3JAudtITFvG
         oAmLheuhEg6zIoInZVKQzzgF440QjwdEkUrGTNdfmLESDqy7dh4yf79f6Hc6XV+W+25F
         3i+V3R+idfvgkZ6U0/NH9ejqUEczWXVEBtMNzLpwLMViU/JKNB3mxIhUk+WKQ83fXv7b
         peIQ==
X-Gm-Message-State: ACrzQf3OI6vfoorIo4wjaezqasYTyrE+6GXt5cN+PGi5lIfc6pbJ44Co
        xRGzwxyeGWyw4GJUL4GoFbvNA4fND+zf86sNQnPU3A==
X-Google-Smtp-Source: AMsMyM4ftQ05LYxhd2OziK0L5b27KAUcv/MYw8blxyokEcm8DdX2uu/4v/E4eT8aamd67PsFyVIdHO4ivcsu7J+yXKM=
X-Received: by 2002:a05:690c:82e:b0:369:2982:8f61 with SMTP id
 by14-20020a05690c082e00b0036929828f61mr32947720ywb.378.1667510172269; Thu, 03
 Nov 2022 14:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221020232532.1128326-7-calvinwan@google.com> <221021.86pmemeyiu.gmgdl@evledraar.gmail.com>
In-Reply-To: <221021.86pmemeyiu.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 3 Nov 2022 14:16:01 -0700
Message-ID: <CAFySSZDgo7Ny+u4cvi7D-+Xx4jSZqKDsH_OKgtpQvKTJ7Fbc5w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] diff-lib: parallelize run_diff_files for submodules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And, I may be missing something, but later in that function we do:
>
>         if (repo_read_index(r) < 0)
>                 die(_("index file corrupt"));
>
> Do we need to read the index there if we're just invoking a "status"
> command, isn't it reading it for us & reporting back?

You're correct I don't need to read the index there

> > +static struct status_task *
> > +get_status_task_from_index(struct submodule_parallel_status *sps,
> > +                        struct strbuf *err)
> > +{
> > +     for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
> > +             struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
> > +             const struct cache_entry *ce = util->ce;
> > +             struct status_task *task;
> > +             struct strbuf buf = STRBUF_INIT;
> > +             const char *git_dir;
> > +
> > +             strbuf_addf(&buf, "%s/.git", ce->name);
> > +             git_dir = read_gitfile(buf.buf);
>
> Okey, so the "NULL" variant of read_gitfile_gently(), as we don't care
> about the sort of error we got, but...
>
> > +             if (!git_dir)
> > +                     git_dir = buf.buf;
> > +             if (!is_git_directory(git_dir)) {
>
> Isn't this something we could have asked read_gitfile_gently() about
> instead, i.e. the READ_GITFILE_ERR_NOT_A_REPO condition?
> > +                     if (is_directory(git_dir))
> > +                             die(_("'%s' not recognized as a git repository"), git_dir);
>
> It would be a detour from this, but perhaps setup.c can be tasked with
> knowing about this edge case and returning an error code, but even if we
> punt on that we can just do the is_directory() here, but get the
> !is_git_directory() for free it seems.

So there are two non-fatal errors in read_gitfile_gently() that return
NULL rather than dieing:
READ_GITFILE_ERR_STAT_FAILED
READ_GITFILE_ERR_NOT_A_FILE

Then the edge case becomes:
Not a git file (or stat failed)
Not a git directory
Is a directory

I'm not seeing how we would get !is_git_directory() for free.

> > +             task->path = ce->name;
> > +             task->dirty_submodule = util->dirty_submodule;
> > +             task->ignore_untracked = util->ignore_untracked;
>
> Cn do we the same readability trick here that we did with "struct
> submodule_status_util tmp = {" earlier & the memcpy()? Looks like it...

Yes, if I make the readability change, then I should still be able to
use xmalloc

> > +
> > +     child_process_init(cp);
> > +     prepare_submodule_repo_env_in_gitdir(&cp->env);
> > +
> > +     strvec_init(&cp->args);
> > +     strvec_pushl(&cp->args, "status", "--porcelain=2", NULL);
> > +     if (task->ignore_untracked)
> > +             strvec_push(&cp->args, "-uno");
>
> Nit: Maybe worth spelling out --untracked-files=no (or maybe "-uno" is
> more idiomatic at this point...)

Same spelling as in is_submodule_modified(). Probably not worth
changing /shrug.

> > +int get_submodules_status(struct repository *r,
> > +                       struct string_list *submodules,
> > +                       int max_parallel_jobs);
>
> s/int/size_t/ because at this point you've already die()'d in the one
> caller if it's <0 from the config parser, so we know it's unsigned
> (actually >1, but unsigned will have to do :).

The caller is passing in an int anyways so I'm going to keep it as is
for consistency.

Took the rest of your suggestions. Thanks!
