Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A11CC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414C6206DB
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dropbox.com header.i=@dropbox.com header.b="l7OSW1DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgEKTx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgEKTx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:53:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E53C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:53:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s21so876657ejd.2
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:from:date:message-id:subject:to;
        bh=Vfv8FIhf2LH9QQQZrYMTv2ngYsNWxvXS3wZ++mN8JJk=;
        b=l7OSW1DXZNEZTCQxcn+pDAtslk6R65cukGK7nLIzwqzXWugvoyELgXEIteSTjjXv3S
         zDXnP+s2OqZYsBVlJSe5sibnVeQIGq1I/a2jq035rVjPpIhphue+Fu7a8KfwFRtfqBvl
         oknCqmWSkFqq7RLXwnrHJuDYWbHdmHM+PGJpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Vfv8FIhf2LH9QQQZrYMTv2ngYsNWxvXS3wZ++mN8JJk=;
        b=rlXGVUa7GRFFNlOHpNVYP8g7Fb18EuqvzuB3Ulx5jhSNcGNK2PVnFjbrC2BETX7azN
         TNX3e6cz3x45vovxghBAskBaFgzOMlg2WA60weBgk7igQKlqdtpzj+z6qOAgkI2emePF
         l3kZ/LD4gMipV8LnkYRGnfpVIsnryRRs2WnD3f7m3RDi3T3hfIVdW00w5kwYszElnD3E
         vt/6mplIDeRp1atLSX1gNxzOgbDRxE+a5c2jVwNNMjVZgq22CWV609iZNjECl74WFuzr
         Prqxzi0rIYt9V3Fgf/844TBxkRCPf6J/viJ87bBgcpqKFgXW99NkQ275QvOAbJmmqmor
         uKjg==
X-Gm-Message-State: AOAM533qRK3mOIE+PnuQIH6Q+ZIW2HYqaom87QnWRN2BOVGWwcK+VEpf
        9wa1b5++9Jqn4hWFyQInE8ON4ave5BbsMHST9nQ9SAYRsQbX/w==
X-Google-Smtp-Source: ABdhPJwvDYHZQpJF9JHM8XnjITOoe1/yaDm89YTyXoRI7eZDPq3kYcEjrE8IIk/FIAzUmLc9o3pwMm+ClLP5kgqczdg=
X-Received: by 2002:a17:906:f84b:: with SMTP id ks11mr2959113ejb.114.1589226803279;
 Mon, 11 May 2020 12:53:23 -0700 (PDT)
MIME-Version: 1.0
From:   Utsav Shah <utsav@dropbox.com>
Date:   Mon, 11 May 2020 12:53:12 -0700
Message-ID: <CAPYzU3MRTkBH5fAUCydnM8uvuAsv_dAi1B680aB_A5BOU=pyzA@mail.gmail.com>
Subject: Suboptimal performance of git add -A with untracked cache enabled
To:     git@vger.kernel.org, Kevin Willford <Kevin.Willford@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm running git 2.27 on MacOS catalina on a repo with a size of
roughly ~300k files. Also, I'm using fsmonitor and untracked cache.
Operations like git status are fast as expected and complete under 1s.
But git add -A often takes 10 seconds to complete. The trace output
shows most of the time spent in "read directory" and "diff-files". I'm
mostly interested in solving the slowness in "read directory".

It seems that the untracked cache is skipped by git add -A since the
dir_flags are different between git status and git add
(https://github.com/git/git/blob/master/dir.c#L2671), which leads to
the slowness. In the specific case of add -A, the DIR_COLLECT_IGNORED
flag is set, (https://github.com/git/git/blob/master/builtin/add.c#L543),
which is one reason why the untracked cache is not used. Another is
that git status sets DIR_SHOW_OTHER_DIRECTORIES |
DIR_HIDE_EMPTY_DIRECTORIES
(https://github.com/git/git/blob/master/wt-status.c#L709).

I'm wondering if we can leverage knowledge from fsmonitor to relax
some constraints on using the untracked cache, or skip directory
traversal. In theory, if fsmonitor is aware that there haven't been
any changes to files (tracked or not), it seems that we can skip
opening and iterating over directories.

If anyone has guidance if this is something that can be fixed and has
a recommendation for an approach, I'd love to hear it. I tried working
on a patch, but it seems that the untracked cache is correctly being
skipped for correctness reasons, and I'm not sure if relaxing its
constraints is the right approach.

Thanks
