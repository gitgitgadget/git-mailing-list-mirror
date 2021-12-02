Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91D2C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 02:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348543AbhLBCz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 21:55:27 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:35355 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhLBCzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 21:55:23 -0500
Received: by mail-pj1-f48.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso1340455pji.0
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 18:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQ68E50PrWgyUrJUpkiKZfQ2r2M8Tkv4wNL6u56JFM8=;
        b=0R3wvEKfFuJ5v/sOcuBP7ZIZDG4A8gKNy0SsBNITG4MU8NrnDSkPcRDXEHv2FQB4lk
         FI1vl3KyVt8mwmbSWs2BTUUX9/TKsRxvwp2jctP/if+8Xe9Ga7CIuOMamTAAu+NUzYaT
         rUvW/5gNnGOIAjQwPMWqDTcAHbVO4WvFO0EOY3FQjtHYvmtHJCXdvVvqTq+40+mVjOgr
         yLKpdUHkT3pzQocS19pIOtaEZ2MUiVp/4squA8Uh4m3mNhT8Mmvk9MtAxAGOq7EIe9h/
         r3bf9owUI4h+ekx3uazbBLcLH5c+Jm7PGsAMUOP3PsqDRiTMnPjZHE9E1+JD5B8BRLbp
         iZpA==
X-Gm-Message-State: AOAM531JxnNSNu4a82GhAFIrgHBuHRShZD4w3hsa/MXQ739ArclUoa4z
        1edOFp2wPn2rEjemLHqPoLaj+C/U6vHv3QQozwo=
X-Google-Smtp-Source: ABdhPJwapTNpEzu9VOBNWj97IXoFhXRPgG5Y9/E9lfQiJB0AFKkuvVKc2i670OPIznzZsnOvtd3+P3FjWb6UOXmnKNY=
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id
 s15-20020a170902a50f00b001437dec0567mr12308164plq.18.1638413521880; Wed, 01
 Dec 2021 18:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20211201221547.1796213-1-andersk@mit.edu> <20211201221547.1796213-6-andersk@mit.edu>
In-Reply-To: <20211201221547.1796213-6-andersk@mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 21:51:51 -0500
Message-ID: <CAPig+cQudoq3QrF29W8p511s1rPtgZajtk1Rjm+N2SgoLY-Ltw@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] fetch: protect branches checked out in all worktrees
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 5:16 PM Anders Kaseorg <andersk@mit.edu> wrote:
> Refuse to fetch into the currently checked out branch of any working
> tree, not just the current one.
> [...]
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> @@ -868,16 +868,17 @@ static int update_local_ref(struct ref *ref,
> +       if (!update_head_ok &&
> +           (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
> +           !wt->is_bare && !is_null_oid(&ref->old_oid)) {
>                 /*
>                  * If this is the head, and it's not okay to update
>                  * the head, and the old value of the head isn't empty...
>                  */
>                 format_display(display, '!', _("[rejected]"),
> -                              _("can't fetch in current branch"),
> +                              wt->is_current ?
> +                                      _("can't fetch in current branch") :
> +                                      _("checked out in another worktree"),
>                                remote, pretty_ref, summary_width);

Minor observation: The "checked out in another worktree" message would
be much more helpful if it mentioned the worktree itself...

> @@ -1385,19 +1388,18 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
> -               if (ref_map->peer_ref && !strcmp(current_branch->refname,
> -                                       ref_map->peer_ref->name))
> -                       die(_("refusing to fetch into current branch %s "
> -                             "of non-bare repository"),
> -                           current_branch->refname);
> +               if (ref_map->peer_ref &&
> +                   (wt = find_shared_symref(worktrees, "HEAD",
> +                                            ref_map->peer_ref->name)) &&
> +                   !wt->is_bare)
> +                       die(_("refusing to fetch into branch '%s' "
> +                             "checked out at '%s'"),
> +                           ref_map->peer_ref->name, wt->path);

... much like this message has been updated to mention the worktree.

However, I didn't look to see how much work it would be to improve the
earlier message; such an improvement could always be done atop this
series later on by someone.
