Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134341F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 19:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755023AbdKMTv2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 14:51:28 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:51239 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754631AbdKMTv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 14:51:27 -0500
Received: by mail-ot0-f169.google.com with SMTP id b54so2556786otd.8
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 11:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6urntfBSHr9xwUcB+GM/Zh9MzlZnpNMvmAT9E7W0qV8=;
        b=Vv7nZ5zLvjtrsqDDCyDbfXwqqP53RUzSHvlxjz+jyJPrhjCsKgrAsx+hkBPR6nEkuO
         7olOEreuZe9pyvhzPfSzAqWa1I5yYxjkZCFw6rlrfCl3z1UdsVff3Ae9py9KtGcwRbZs
         xyHnRmtDr2G2ZwWWGyO9cVQOuk5yCxg7oqZl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6urntfBSHr9xwUcB+GM/Zh9MzlZnpNMvmAT9E7W0qV8=;
        b=fMhQ8ctFdmn3Wvln+1CaDR5feWoPQs8hlv4C8jw+WYZkHo9IMq6NpUGkep7cRdP7bC
         mPfQtvvZERQeKIfUtvuFv5f1IR72NDbwTrmubo0hxCvEgHam4jQCoxc057jcee5HZqCE
         K0rQUPVPvOCz25jpTu1mBAJcemwP8FobciXwyNuBB0x4lPA8VoOOQcNRzk7dUjMtOPzO
         /MZL/tX8+r2TwrqX5FnThMbk5uZ+gvC1AiOvWAQwLeO/GksBSTl9rKN0hcCZpNv226B3
         eiMqxQpfCmgB2LEK3yYR4N3/lQoogtf9BkTutSMRxtsHX9yIgn3Tqm+Dfx3Q6m3Jnuzu
         xjYw==
X-Gm-Message-State: AJaThX4ih/saD/GPZ2EPhN9QN2sO/Oj03NoR1vDTXs1onJGRMS2tFzWm
        9MWABLmOi8WKD+XNsuvLshKzoE+i4n4d2Xj6oeb+VpdW
X-Google-Smtp-Source: AGs4zMaJgDVptqfjV3yJl55nL/c1CFeQCDKsi0R/P7Sr4xC9nVrHYiLkxWDil+rxCGdtUbxkxqwKy8yIZU42gDReHwo=
X-Received: by 10.157.82.41 with SMTP id e41mr7792317oth.291.1510602686530;
 Mon, 13 Nov 2017 11:51:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.12.236 with HTTP; Mon, 13 Nov 2017 11:51:26 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 13 Nov 2017 19:51:26 +0000
Message-ID: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
Subject: Bug in "revision.c: --all adds HEAD from all worktrees" ?
To:     Git Users <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I think there may be a regression caused by this change which means
that "git fetch origin" doesn't work:

commit d0c39a49ccb5dfe7feba4325c3374d99ab123c59 (refs/bisect/bad)
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Wed Aug 23 19:36:59 2017 +0700

    revision.c: --all adds HEAD from all worktrees

$ git fetch origin
fatal: bad object HEAD
error: ssh://my_remote_host/reponame did not send all necessary objects

I used git bisect to find the problem, and it seems pretty consistent.
"git fetch" with the previous revision works fine.

FWIW, I've got a lot of git worktrees associated with this repo, so
that may be why it's failing. The remote repo is actually a git-p4
clone, so HEAD there actually ends up pointing at
refs/remote/p4/master.

Thanks,
Luke
