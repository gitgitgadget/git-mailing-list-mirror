Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E0C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C207622D71
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAFF7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 00:59:52 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:39933 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbhAFF7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 00:59:47 -0500
Received: by mail-ej1-f51.google.com with SMTP id n26so3596608eju.6
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 21:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8EyYg0gIYv7hb5eqYBvKQC9t5Do5/8uLkVprLjW8fs=;
        b=pfNgbUMyBx5HKTdljK1KGrAxjzR6nsdw87hKcNdnq+VG1R5vww2nu4yFWUvYZWOC+2
         +yM7INmwU3CtH9Q4BB1wfDH7mBneLnUZ3npUhG9MrrL+qj+bWaGN4sny+tHzGD36pXtg
         jdijT4EdHmpFWDBKCFoIHddvrBbsVqe+eciQU74C4oHtijgwLKaeiTSX++vupENK8o4R
         V7JcSlF9KOSqF2xBG6XHFseKPipOy4I9wsj934injWrSXpdt/4Z1SfPGF/MkmqyaXXJQ
         lnPHEJfNJ9cjUpDiz2wjq+/MdHocWx5t4nU55rmskViItsKFhH5g3MXKxw1J8pwHK9zl
         kL7A==
X-Gm-Message-State: AOAM532b7u3/MPq3GvJTVCIETPXaYSB2icdTe42aI352+iSp3yIA+iB+
        DjCTDHcf8LmPO26StuAdPEzB3lMXgBEuucZZZgciKWoHXDo1rQ==
X-Google-Smtp-Source: ABdhPJybrSZ+3g9q6pQCWxlm5ly+2ugjTbSwdomVuYATCGFf0w4QdlpU6XSZbVq1KXkMh6vfBR5TPc0wkHMM9z+kPcs=
X-Received: by 2002:a17:906:1ed6:: with SMTP id m22mr1904469ejj.231.1609912745024;
 Tue, 05 Jan 2021 21:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210104162128.95281-2-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-2-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 00:58:54 -0500
Message-ID: <CAPig+cThjBHn6AKaLvH5utD7rXMoj+gBXi-GVrfgoQ99v_38dg@mail.gmail.com>
Subject: Re: [PATCH 1/7] worktree: move should_prune_worktree() to worktree.c
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> worktree: move should_prune_worktree() to worktree.c

The subject is a bit confusing since this function already lives in
`worktree.c` (albeit within the `builtin` directory). An alternate way
to word this might be:

    worktree: libify and publish should_prune_worktree()

or just:

    worktree: libify should_prune_worktree()

> As part of teaching "git worktree list" to annotate worktree that is a
> candidate for pruning, let's move should_prune_worktree() from
> builtin/worktree.c to worktree.c in order to make part of the worktree
> public API.

Good.

> This function will be used by another API function, implemented in the
> next patch that will accept a pointer to "worktree" structure directly
> making it easier to implement the "prunable" annotations.

Okay, though I'm not sure this paragraph adds value since the reader
understands implicitly from the first paragraph that this is the
reason this patch is libifying the function. (I'd probably drop this
paragraph if I was composing the message.)

> should_prune_worktree() knows how to select the given worktree for pruning
> based on an expiration date, however the expiration value is stored on a
> global variable and it is not local to the function. In order to move the
> function, teach should_prune_worktree() to take the expiration date as an
> argument.

Rather than "on a global variable", it would be more accurate to say
"static file-scope variable".

> diff --git a/worktree.c b/worktree.c
> @@ -700,3 +700,76 @@ void repair_worktree_at_path(const char *path,
> +/*
> + * Return true if worktree entry should be pruned, along with the reason for
> + * pruning. Otherwise, return false and the worktree's path, or NULL if it
> + * cannot be determined. Caller is responsible for freeing returned path.
> + */
> +int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath, timestamp_t expire)

The function documentation which was moved here (worktree.c) from
builtin/worktree.c is duplicated in the header worktree.h. Having it
in the header is good. Having it here in the source file doesn't
necessarily hurt, but I worry about it becoming out-of-sync with the
copy in the header. For that reason, it might make sense to keep it
only in the header.

All of the above review comments are very minor and several of them
are subjective, thus not necessarily worth a re-roll.
