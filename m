Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BABC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D22B2073E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 23:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbgFXXAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:00:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41563 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbgFXXAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 19:00:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so3893977wrq.8
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 16:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7nvdJUTnTfPdn3DqraeGgJseWjlwaBCWiCy4Yc37QU=;
        b=tAr1DVlA29BbgNQTrP2RqOpvcK3puAYhKQ/3Epbk81lOY+tz5e+76kZIpvkfFNJOPJ
         Z0xUfI98phqovRS3qdeziZX9ueg64AO1Y1Q+RyIoy00pI5Fng8aBbQdpVwdxCcO+QM5b
         AqZ1qUqYwdLox0vFlVd95aR9712YlwBwoJQWCR7Ut8QFdDLQDEQ4sMTZEr0BbHmKoqC7
         MrGxdcdOgUNAHMSEZzoqgCY9gcUukdE+l2IzpElrvwKOEJOzbA3G1GmjIwNLsF3jHDPJ
         pu6uLpSBGOsJRaQRVMLKAGHXMXtRAeSzu2Cv8LsUwRoi9yKuVv22D8YvLsVkRzqvVwkb
         2QsQ==
X-Gm-Message-State: AOAM533RwcOrRNsIoct1kBeLNF58H/rMmUL8+L5fhX0KFdIXQ1R+f4gE
        Irfzlg648j+QwpxvcVy5t4J7aqxKB/nq8qWR1zpxFKfU/bM=
X-Google-Smtp-Source: ABdhPJzd4nBoinxZ1Vd2D6ZE+Ve5bUcyYcjl7liogNYp2lrSMVQtO5vEQO0FaimrRdz8ZvfO4NdJCiHV0/Q2iibaP10=
X-Received: by 2002:adf:e2ce:: with SMTP id d14mr34061114wrj.415.1593039648686;
 Wed, 24 Jun 2020 16:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200624190541.5253-1-sunshine@sunshineco.com> <xmqqsgek5fg3.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgek5fg3.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Jun 2020 19:00:37 -0400
Message-ID: <CAPig+cRdRyWAjU7QADPt39rDgJ4njDtN_pwo8JMVD=YX09a-Vg@mail.gmail.com>
Subject: Re: [PATCH] worktree: avoid dead-code in conditional
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 5:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > get_worktrees() retrieves a list of all worktrees associated with a
> > repository, including the main worktree. The location of the main
> > worktree is determined by get_main_worktree() which needs to handle
> > three distinct cases for the main worktree after absolute-path
> > conversion:
> >
> >   * <bare-repository>/.
> >   * <main-worktree>/.git/. (when $CWD is .git)
> >   * <main-worktree>/.git (when $CWD is any worktree)
>
> It is unclear from the above but I would assume that you are talking
> about the returned path from get_git_common_dir().

No, I am talking about the result of strbuf_add_absolute_path()
applied to get_git_common_dir(). I intentionally explicitly stated
"after absolute-path conversion" in the commit message to be clear
about this, but perhaps I should have mentioned
strbuf_add_absolute_path() by name to avoid confusion.

> I can certainly understand why there needs two distinct cases
> (i.e.. bare vs non-bare), but why is this codepath (or any caller of
> get_git_common_dir()) forced to care about the two cases?

Callers of get_git_common_dir() aren't forced to care. But after
applying strbuf_add_absolute_path() we are forced to care. This is the
result of get_git_common_dir() for the three cases:

    .     (within bare repo)
    .git  (within any worktree)
    .     (within .git)

After applying strbuf_add_absolute_path(), we get:

    /whatever/proj.git/.   (within bare proj)
    /whatever/proj/.git    (within any worktree)
    /whatever/proj/.git/.  (within .git)

These need to be normalized, respectively, to:

    /whatever/proj.git  (within bare proj)
    /whatever/proj      (within any worktree)
    /whatever/proj      (within .git)

> I wonder if the right "fix" to this instance, at the same time
> preventing similar breakages in the future, is rather make sure
> get_git_common_dir() not to return the redundant path with ".git/."
> suffixed? For that matter, I do not know why the bare case must
> need "/." suffix. There seem to be about a dozen callers of the
> function, but don't some of them share a similar issue?
>
> Puzzled.

Your puzzlement may arise from the misunderstanding regarding
get_git_common_dir() vs. strbuf_add_absolute_path()?

It might be nice to refine strbuf_add_absolute_path() to return more
aesthetically pleasing results (i.e. not add trailing "." when
unneeded), but such a change is outside the scope of this small patch
and may have repercussions which could be a time sink (and I haven't
the time to devote to it).

> Let's look at the other two grep hits from worktree.c
>
>     strbuf_reset(&path);
>     strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
>
>     worktree = xcalloc(1, sizeof(*worktree));
>     worktree->path = strbuf_detach(&worktree_path, NULL);
>     worktree->id = xstrdup(id);
>     add_head_info(worktree);
>
> done:
>     strbuf_release(&path);
>     strbuf_release(&worktree_path);
>     return worktree;
> }
>
> This looks somewhat bogus. "sturct strbuf path" is populated, but
> is released without ever getting used, isn't it? Am I grossly
> misreading the code?

I think you're reading it just fine; that code is indeed dead. This
appears to be fallout from 5193490442 (worktree: add a function to get
worktree details, 2015-10-08), which unfortunately (I think) got
little or no review[1].

This could indeed use a "dead-code removal" patch of its own, though
it's unrelated to the current patch.

FOOTNOTES

[1] I had reviewed the very first version of the patch series which
    introduced these changes, but then effectively went offline for
    many, many months, thus was unable to review any of the re-rolls.
