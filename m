Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205A51F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403977AbfJQR2W (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:28:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52799 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQR2W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:28:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so3404143wmh.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUWcsTJHZHmcSXepfpEECXu3NjOoJXr8XP8JBzZUIFw=;
        b=hit2QdkT0QjH/XXkkuyM8ttJNv+FGtdyOtMSpRxNsW4sxWBAq4un5qdGgY34bpUwzQ
         8W8aFL/79PlB2Y81onFJcDl/pAxrl2twx+TR9DtKOJ7pMEfXui3mF6vey3JmfaYRROaU
         tQoZg8K7XVh8e8DWJnH7Euc6vPEPEEFuYWhz/5EfmGPrUqaBjyGMpN1ESQibOXHasYOc
         ZOykxcGvYH+SY3k8LmdZZo+3Ilp5ToVcuZ6GgLVRkBJPJfEL8Iz3sTTmh9AlbItFXZRH
         PR4p35lL27abvASXsKrnhkZCrMxR3xV1LylD1C4IkWDtRUdraMUZ2e0+5gQppQ8oWq4N
         MtLg==
X-Gm-Message-State: APjAAAWvlp1YQlMjimXB709cnOIg9+UXlJQE7zFNdb/maYtr+8d94RJ9
        pRTArZ+j5/G7T30mahOC0JbQiMde2KcbcUpBrfokXkP+
X-Google-Smtp-Source: APXvYqxqlkbYjtuyn9ridv9BC892HTqfY5BHN5kDxBhCvM8XGEwVHkzA/xoeXgHtMjSytGkjBsHuUxNUMFcAuHZEwF4=
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr3969285wme.101.1571333299647;
 Thu, 17 Oct 2019 10:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191017162826.1064257-1-pjones@redhat.com> <20191017162826.1064257-2-pjones@redhat.com>
In-Reply-To: <20191017162826.1064257-2-pjones@redhat.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Oct 2019 13:28:09 -0400
Message-ID: <CAPig+cS6SzLdgmzffNkg72YSiDQ9eQRqTK12NsraKpGbkJFY_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Make "git branch -d" prune missing worktrees automatically.
To:     Peter Jones <pjones@redhat.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 12:28 PM Peter Jones <pjones@redhat.com> wrote:
> Currently, if you do:
>
> $ git branch zonk origin/master
> $ git worktree add zonk zonk
> $ rm -rf zonk
> $ git branch -d zonk
>
> You get the following error:
>
> $ git branch -d zonk
> error: Cannot delete branch 'zonk' checked out at '/home/pjones/devel/kernel.org/git/zonk'
>
> It isn't meaningfully checked out, the repo's data is just stale and no
> longer reflects reality.

Echoing SEZDER's comment on patch 1/2, this behavior is an intentional
design choice and safety feature of the worktree implementation since
worktrees may exist on removable media or remote filesystems which
might not always be mounted; hence, the presence of commands "git
worktree prune" and "git worktree remove".

A couple comment regarding this patch...

> Signed-off-by: Peter Jones <pjones@redhat.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -133,6 +133,20 @@ static int prune_worktree(const char *id, struct strbuf *reason)
> +int prune_worktree_if_missing(const struct worktree *wt)
> +{
> +       struct strbuf reason = STRBUF_INIT;
> +
> +       if (access(wt->path, F_OK) >= 0 ||
> +           (errno != ENOENT && errno == ENOTDIR)) {
> +               errno = EEXIST;
> +               return -1;
> +       }
> +
> +       strbuf_addf(&reason, _("Removing worktrees/%s: worktree directory is not present"), wt->id);
> +       return prune_worktree(wt->id, &reason);
> +}

"git worktree" tries to clean up after itself as much as possible. For
instance, it is careful to remove the .git/worktrees directory when
the last worktree itself is removed (or pruned). So, the caller of
this function would also want to call delete_worktrees_dir_if_empty()
to follow suit.

> diff --git a/worktree.h b/worktree.h
> @@ -132,4 +132,10 @@ void strbuf_worktree_ref(const struct worktree *wt,
> +/*
> + * Prune a worktree if it is no longer present at the checked out location.
> + * Returns < 0 if the checkout is there or if pruning fails.
> + */
> +int prune_worktree_if_missing(const struct worktree *wt);

It's rather ugly that this function is declared in top-level
worktree.h whereas the actual implementation is in builtin/worktree.c.
I'd expect to see a preparatory patch which moves prune_worktree()
(and probably delete_worktrees_dir_if_empty()) to top-level
worktree.c.

These minor implementation comments aside, before considering this
patch series, it would be nice to see a compelling argument as to why
this change of behavior, which undercuts a deliberate design decision,
is really desirable.
