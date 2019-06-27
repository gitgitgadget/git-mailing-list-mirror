Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02AA1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfF0FRL (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:17:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36643 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfF0FRL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:17:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so898087wrs.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 22:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eH0/baXLGPyzEw36poCV6cx3Rjk8byK83uP+dRPZZHo=;
        b=dYjt8TJgiHKy762cOqtS//ghpaWq7+fBh7r0m5iTPz1m/KTY+0hbPzlNc+g4TT5Yi1
         elljIeYci/vDalEizEgEUqdnk7b22ylKGUOolQtUgK7OQPqtVSOEyO6lxkSFfLm3pzyo
         ULSDp6V+Gzud9bQh8bDWlJkWbAcUDYwRntJ1FlaSF7aifkQsh41ne9wjKZrpoALqtA0r
         r/beFOkUFA6y1t18fx9xTRqa+pJvqrCMaCMxhyOPiSc0Kjl7xTkm/MQ7P8YZbRe39PaL
         XSOtAo0PDxaK5ZS4vSFuRKTQtLOsKgjZq6WAC92E4VQeiHFu/VyurvlD7j2AZ4vcrUJk
         jjwQ==
X-Gm-Message-State: APjAAAXSMjTgrMy9GCrLqN2H/tLclTLvZ2scv4cKq97TBs+AbkalxQjt
        Xt9Gppmyw+T7xq+tE3qM/P12MZelAc+5MzLM6DE=
X-Google-Smtp-Source: APXvYqyJwym0ws70OTd0hTbYbj9tv0x9PjcBJHz7Srid7OxmNO5Nl6erdDwt9B3yLvLdsBq8DNc1fAMzKRaYgeTIyJU=
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr1289736wrw.231.1561612629204;
 Wed, 26 Jun 2019 22:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-7-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-7-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 01:16:58 -0400
Message-ID: <CAPig+cQAf6ds6Fobcf+mux-93D09WQJACUXSvwgdyoOznNjsUg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/13] walken: perform our basic revision walk
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> Add the final steps needed and implement the walk loop itself. We add a
> method walken_commit_walk() which performs the final setup to revision.c
> and then iterates over commits from get_revision().
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> +/*
> + * walken_commit_walk() is invoked by cmd_walken() after initialization. It
> + * does the commit walk only.
> + */

"only" as opposed to what? Maybe just say:

    ... after initialization. It performs the actual commit walk.

> +static void walken_commit_walk(struct rev_info *rev)
> +{
> +       struct commit *commit;
> +       struct strbuf prettybuf = STRBUF_INIT;
> +
> +       /*
> +         * prepare_revision_walk() gets the final steps ready for a revision
> +        * walk. We check the return value for errors.
> +         */

You have some funky mix of spaces and tabs indenting the comment
lines. Same for the next comment block.

> +       if (prepare_revision_walk(rev)) {
> +               die(_("revision walk setup failed"));
> +       }
> +
> +       /*
> +         * Now we can start the real commit walk. get_revision grabs the next
> +        * revision based on the contents of rev.
> +        */

s/get_revision/&()/

> +       rev->diffopt.close_file = 0;

Why this? And, why isn't it set up where other 'rev' options are initialized?

> +       while ((commit = get_revision(rev))) {
> +               if (!commit)
> +                       continue;

If get_revision() returns NULL, then the while-loop exits, which means
that the "if (!commit)" condition will never be satisfied, thus is
unnecessary code.

> +               strbuf_reset(&prettybuf);
> +               pp_commit_easy(CMIT_FMT_ONELINE, commit, &prettybuf);
> +               /*
> +                * We expect this part of the output to be machine-parseable -
> +                * one commit message per line - so we must not localize it.
> +                */
> +               puts(prettybuf.buf);

Meh, but there isn't any literal text here to localize anyway, so the
comment talking about not localizing it is just confusing.

> +       }

Leaking 'prettybuf'. Add here:

    strbuf_release(&prettybuf);

> +}
