Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232C21F424
	for <e@80x24.org>; Fri, 27 Apr 2018 02:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757360AbeD0C4v (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 22:56:51 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:40138 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757356AbeD0C4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 22:56:50 -0400
Received: by mail-oi0-f45.google.com with SMTP id c203-v6so364638oib.7
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zQGInYu4++igMiFg7UsfAVPf7GbUDZ2B3y+/uQtnwwk=;
        b=BqvHjnrzAsOkyLLSbUhLSwz82lHtUs9rw4HPKPRz+e8PSDpFxM+4WQUkcpX4Lq2kB3
         aChitpk6HwmnkMxGULbZeJFQF4DQueECNKu5gQWP1eZPz7G7Zlz8rMOBV86+zhNIwdns
         RtD7ebQJM+4opcw2lg9sDRobc/0qDfSPEcqMmrLJaMYwx8Yt/PSxOOMyjFk/ywpIYGYA
         /o4tWUiAFdxmTwGWmD9MJ4D0wqZae1Nwkni2PtjcqKjAeDgZ2UN6wPGHi1NevYiZCSY+
         zEdznC65UrUXUSKXMQ90WIIdB0GWWlJQFBDMUCuGcykDui890NL311h9a+yPsOH9T+0Z
         GOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zQGInYu4++igMiFg7UsfAVPf7GbUDZ2B3y+/uQtnwwk=;
        b=HPo/UuswdSys4N5Hw6CtMTwuR1YUTKZYAKCAn1CwuvQ7lZkIj10aeLdw0ErQ1/nPfU
         b4xGXe/AApixweiJKK+ZmfZbGM+ZoOJqzEjFgLzSkPuDgaz6AqfbDz+NaaoeZWvh9X6k
         NwCu+b2SF2FsHQv6tsGIgv3CH4ncZlcCu/59KGO3dv8W1AP2UHCYPGqxeDrOODLr6TXI
         Fr1MtOBHsWb0t6d4MmEc2PkSF6fhXZWvEol6smd1FX4RXM1JC16lNKHVeIW/jC/s7YpK
         RX3pNA/UCZ40zQuZLPdluH5iUDPzUXrR9GhNzHDpQd68/IFQ+00t9ndEw0Uax32UZBQF
         xuXA==
X-Gm-Message-State: ALQs6tB0IEgFLA21OB/uGHfwfhI0by/etv4/djIyCJdgXLG7VeRP2bwG
        rbAwHe4g3+AU/C8WjuCdzzVlxZzP0IjgMZjG0/HX0sO8
X-Google-Smtp-Source: AB8JxZqq+zdsMhtIKD5gaiOTKrEpWN2SHXaFdUfaFHUgRao8ZA/2nvPq5VVFNsGa8bWFR/XWbPDJUFnQRigsq7lJyLM=
X-Received: by 2002:aca:6545:: with SMTP id j5-v6mr294981oiw.151.1524797809905;
 Thu, 26 Apr 2018 19:56:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.97.70 with HTTP; Thu, 26 Apr 2018 19:56:29 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
Date:   Thu, 26 Apr 2018 19:56:29 -0700
Message-ID: <CAFW+GMAJcCG4mKe4TxFXXrfdRhZKXv8ffC-rNShFLW2J1_FANA@mail.gmail.com>
Subject: In some rebases, `exec git -C ...` has wrong working directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a repro script:

    #!/bin/sh
    set -eux
    git --version
    tmpdir="$(mktemp -d)"
    cd "${tmpdir}"
    mkdir target repo
    cd repo
    git init
    touch file; git add file
    git commit -m "Initial commit"
    git rebase HEAD --exec "git -C ${tmpdir}/target init"

The end of this script prints something like

    Executing: git -C /tmp/tmp.gd2q51jO93/target init
    Reinitialized existing Git repository in /tmp/tmp.gd2q51jO93/repo/.git/
    Successfully rebased and updated refs/heads/master.

But this is wrong: the repository should be initialized in `target`, not
reinitialized in `repo`.

Notes:

  - This propagates to subprocesses: if you run `exec make test` and
    your test suite ends up calling `git -C`, then the same problem
    occurs.

  - Substituting `rebase --root` for `rebase HEAD` causes the problem to
    go away.

  - The `rebase HEAD` exec context adds the `GIT_DIR` environment
    variable, and this is sufficient to reproduce the problem:
    running `GIT_DIR="$PWD" git -C /tmp/target init` puts the repo in
    the current working directory. The `rebase --root` context adds no
    such environment variable. (You can use `--exec 'env >tempfile'` to
    verify these.)

My `git --version` is 2.16.2.
