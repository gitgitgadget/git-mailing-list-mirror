Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534EFC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCDD208C7
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgIGJRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgIGJR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 05:17:29 -0400
X-Greylist: delayed 748 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Sep 2020 02:17:29 PDT
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8257BC061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=To:Subject:Date:From;
        bh=D+sV2cwi1M2QVaaZ6P3E/V1bhKWDK4mis/CW+hGShVo=; b=VR1oXIDSXXmy8VmG5i+t1Z3/Md
        CYWK2agZ28Sg40JlNR95UqUnfg9MMosyDls0EqU3PMuEkVlxWZPFZa7a0Qdbdfiy38Gkx+xOPEWEi
        cV1yXaqUHOsBSdDBeVbsm+cod4Y1J6IYXYwmT6ATLeWGcqEDeJ635C2zufGAh+uKRId4qkJ61rLKI
        VQGLCGT7z/qNL8SiszPnnuSw4aOqyMjl6NTbz1AOy7htKJm/hJbNAjErlf/DrhGdGQgQQrbRAAOgb
        x3MFwHiL5kSv9aMlxLi0nd01LlioXZk1dF0tQdXH6lf6AaM2VOG3Zk6I1njTnC2pT7MNBHy+4R9ax
        UpQLppSA==;
Received: from [209.85.218.43] (port=34552 helo=mail-ej1-f43.google.com)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <ash@sorrel.sh>)
        id 1kFD55-0006bj-0G
        for git@vger.kernel.org; Mon, 07 Sep 2020 10:04:55 +0100
Received: by mail-ej1-f43.google.com with SMTP id gr14so16116349ejb.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 02:04:53 -0700 (PDT)
X-Gm-Message-State: AOAM532Nc2/zdiOld6s0o6LCq7FvyaM7plMXzy+VfuOAN5wzsR6RpkN2
        AaJ7IeBq8kKeLsyTSwdokAx3vSNeQCoBfRzx+vs=
X-Google-Smtp-Source: ABdhPJz9xJdSlLHHmyxHwrib6qdJn4fqaUAbeoJyuZjGQNu8/zXsP71LljSjMJryVucOH8ocZdFNefJCcbQV6THAmPY=
X-Received: by 2002:a17:906:aecb:: with SMTP id me11mr13615349ejb.217.1599469493436;
 Mon, 07 Sep 2020 02:04:53 -0700 (PDT)
MIME-Version: 1.0
From:   Ash Holland <ash@sorrel.sh>
Date:   Mon, 7 Sep 2020 10:04:17 +0100
X-Gmail-Original-Message-ID: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
Message-ID: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
Subject: `git describe --dirty` doesn't consider untracked files to be dirty
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BlackCat-Spam-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

There seems to be a discrepancy between how `git describe --dirty` is
documented and how it actually behaves. The documentation describes
the --dirty flag like this:

> If the working tree has local modification "-dirty" is appended to it.

but certain kinds of "local modification", namely untracked files,
don't cause "-dirty" to be included.

Please could this be fixed, either in the documentation or in git describe?

thanks,
Ash
she/they
