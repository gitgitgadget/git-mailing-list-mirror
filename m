Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7716D1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 07:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBQHO1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 02:14:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41142 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBQHO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 02:14:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id u188so8295849qkh.8
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 23:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtkOL1f/i017XH9kLQc15kiahojxgRcR3zcJKk3/Tug=;
        b=A/tvbFRTnR2PJkeOpNZ26z1Fl7zecutJmkBOMGq3ysLVY50h4rzC16QyQ9bza9geOv
         bUxoVQd6/tfCN6xrskz5PoOqqOWyadYuVQu9h2CoV7gAl1II7zhV5vN770NYo4Bz+3aL
         +w0R/apUb8G4HU7rKtKlz2srQRO3jDcVqPlxqJaene+WS7ODfDAa9IrXCTN9ILiQFzNC
         lye6CR7miBTdrNI7jOwL3NqhmX9AmypWtGC1nunax1+CsBpzmnW/j9UCxjceTwCZEpiA
         f4tiJFgcSSYpahvOYAVvEHmcYs8o8FyKywQw2yXJJ+psB/38bLZx13hgsUZq3/ZPE5ff
         3O4A==
X-Gm-Message-State: AHQUAubLpRKnUFePdhv9Gp6MtrPfw0XvkRrKmKeG2yiahbye9U5hP4bE
        RVUPI9YCnrm0qjgcaHfsZXg4HF2lvqfIwrkHcQD8+nYu
X-Google-Smtp-Source: AHgI3IZ3TZ+Sg0456n1EuVsbqkcnRgQg2UQrW8U+y0NQspVlGd9e7rmTAxzpHMzLrnkUwnov9ac6iKNEUZVl7AWr2a8=
X-Received: by 2002:a37:a4c2:: with SMTP id n185mr12494543qke.152.1550387665658;
 Sat, 16 Feb 2019 23:14:25 -0800 (PST)
MIME-Version: 1.0
References: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
 <dd42ab7054077c7d29ad62e7481c00ab5c1bf864.1550254374.git.msuchanek@suse.de>
In-Reply-To: <dd42ab7054077c7d29ad62e7481c00ab5c1bf864.1550254374.git.msuchanek@suse.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Feb 2019 02:14:14 -0500
Message-ID: <CAPig+cTS0MNvwx67ZVbYUvi9bA63KWnNnSmWdFjLuqc_SNAy8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir is deleted.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 1:16 PM Michal Suchanek <msuchanek@suse.de> wrote:
> When adding wotktrees git can die in get_common_dir_noenv while
> examining existing worktrees because the commondir file does not exist.
> Handle ENOENT so adding a worktree does not fail because of incompletely
> set-up other worktree.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> diff --git a/setup.c b/setup.c
> @@ -274,22 +274,25 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
> +               if (strbuf_read_file(&data, path.buf, 0) <= 0) {
> +                       if (errno != ENOENT)
> +                               die_errno(_("failed to read %s"), path.buf);

Documentation for strbuf_read_file() in strbuf.h does not state that
'errno' has any meaningful value when this function fails, however,
the actual implementation in strbuf.c is careful to preserve 'errno'
when something goes wrong. Therefore, it is safe to consult 'errno'
here. Fine.

It might be a good idea to fix the documentation of strbuf_read_file()
to mention 'errno' explicitly, as a preparatory patch of this series
(though not at all a requirement when re-rolling; just a suggestion to
assist reviewers).
