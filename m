Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA0CC636D4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 00:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBKAjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 19:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKAja (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 19:39:30 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3850D2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 16:39:28 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16ab8581837so8747020fac.4
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 16:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bSZXXwqWMtveLojT0dZvh8PVKTS+zertbWVF8w2A5Jg=;
        b=XaJOvzm0DWfQav4YCkGlVw9HIZOuBgaJibXmfroPnRqUgrjg6PaX3gpzm3rgPDW/ld
         8NLEuKwROWc/ju/vbrCq+TSZpJOWvmMpETmS44mm6IV8JUacHnrYFLNrnImFU5uFIByb
         QuR5UHDAoFcY0sCHdQWacOgJXpVdJKfKGqfStt4DHM6DTQBVdLQzbzAtKx2ohsC8cYXH
         7v9k7YK9Zu2ZJQ+fYI4UcnyiG7t29Nrh8iryK0nFIkZB4sonrIUKbWotHCjVsoXFxRAR
         7W6Hu6iS+VbvEvB+XlNxIZ1yiY7v3Ivl5b9F+YYC+K0OiK3jN9G0PgqkQhqy0BxaPZ1V
         wzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSZXXwqWMtveLojT0dZvh8PVKTS+zertbWVF8w2A5Jg=;
        b=i0OxuI303NrDNfR8SCqnZijvcW0fYnRn+lQCG7EikiMV1mnmzUGXMidnljQf8As+Yd
         4muMc8sA6DbVsitDU8AYp09wi5LshE9h3cduNdg+B/o5GwNT/Wf19sD8NtJ5AGslIJGe
         KUVGE6+V9eAnt5DDeNb97oOySLRv4rvRNunVLrf9z836bqhqkZq6ZmLhzRAfd0p4ELqj
         b0P3BaKGPE5AMiL4q25T4/Zs5Ct1My/yArHh2XLjp34H9vHTkZheAWX701l4/xHOiN0n
         nW+gQDeny+VVLXUhRDhA8qZOEnEdAIv/FMZDhEVscyApTtUFBNsrBxRXgCKg97zACclB
         nbRw==
X-Gm-Message-State: AO0yUKXcpAf8hrdyrhS3LUhTughsyFprSrc07DMfsR5gB1ByybhIpk9j
        KxQr/QmCDsu4J2BRtAx3HPKSWHvuua6xZ7dJQ94PKqIEP16+KqYCLkr8Jg==
X-Google-Smtp-Source: AK7set9O/MZv/GSFBmpUeUgqhcnvUaQOKbjf4P09G24K6colaEZcu/ss72ppZobwPA7OJXZxuGCKHxipDS0ALs9m9+M=
X-Received: by 2002:a05:6871:721:b0:16a:941e:d2fe with SMTP id
 f33-20020a056871072100b0016a941ed2femr1100108oap.171.1676075967977; Fri, 10
 Feb 2023 16:39:27 -0800 (PST)
MIME-Version: 1.0
From:   Jade Lovelace <lists@jade.fyi>
Date:   Fri, 10 Feb 2023 16:39:17 -0800
Message-ID: <CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com>
Subject: BUG: git config --global --get ITEM ignores ~/.config/git/config when
 ~/.gitconfig is present
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear maintainers,

I have found what I think is a bug or at least a documentation flaw in
git-config: when both ~/.gitconfig and ~/.config/git/config exist,
`git config` can retrieve items set in the latter, but not with the
`--global` flag set. For context, I use ~/.gitconfig as a
non-checked-in machine-specific config, and ~/.config/git/config as my
checked-in all-machines configuration file.

The documentation states:
> When reading, the values are read from the system, global and repository =
local configuration files by default, and options --system, --global, --loc=
al, --worktree and --file can be used to tell the command to read from only=
 that location (see the section called =E2=80=9CFILES=E2=80=9D).

> FILES
>        $XDG_CONFIG_HOME/git/config, ~/.gitconfig
>           User-specific configuration files. When the XDG_CONFIG_HOME env=
ironment variable is not set or empty, $HOME/.config/ is used as $XDG_CONFI=
G_HOME.
>
>           These are also called "global" configuration files. If both fil=
es exist, both files are read in the order given above.

Based on this documentation, I would expect `--global` to consider
both global configuration files, but it does not.

Reproduction:

Set some setting in ~/.config/git/config, say:
[pull]
ff =3D only

Ensure that ~/.gitconfig exists.

Then:

 =C2=BB git config --global --get user.name
 =C2=BB git config --show-scope --show-origin --get user.name
global  file:/home/jade/.config/git/config      Jade Lovelace

=C2=BB git --version
git version 2.39.1

Regards,
Jade
