Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C7920248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbfCASXE (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 13:23:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53274 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbfCASXE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:23:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so13303598wmg.3
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 10:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVRKOdzJKIkuviET4EtuWD5rfNaEDS1QssZUSh4wE1w=;
        b=MQExQTJBATj9VDog8InxeRolc6aYrI+6R8SVB5zI1aLhftfK/c2KD1dEO8ho5usT3g
         NE4uwKx/LoxfcYYmKfKfecgkdbxuPN1oHj8z3o49sSQLK99hCNXA3duthOfWh/64pRp6
         Hcr3J0mZSg4IF6rdd1svn1kezMb72HGzNGk6Lv8Fc9Zkx/8HDlpg8Mi5Z5FFDHQMgW+V
         jeX9h6dx0KDqitKr3kVR+ui68MYoyWkXa4keB5LaIUXjTYz6koxnEcN5KggKjobe2bOV
         F0jZIV0TYZjF8ktWC/WJca0nvpI2xuKhx+MNzDnwybpcEaHWhAYv5rHM4JoVie4VJP48
         Mlhg==
X-Gm-Message-State: APjAAAWOCLgQoAy+z3QnjXPDpd5zcAKrI1QamM1JjkBa4wCP3RYtg7ei
        ZklC8W/DRT610RfwTxHXcFhi+dEtu83cp8PLrrs=
X-Google-Smtp-Source: APXvYqxx9iz9P50en1cYyG+g+TpG3Iajj/zL8rcSmjn5sM4NH9ocxX1FhSt4YCXCOtd4OV6jgyfBYaAfkqrr9KhaTcA=
X-Received: by 2002:a1c:c010:: with SMTP id q16mr2535378wmf.134.1551464582541;
 Fri, 01 Mar 2019 10:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20190228230506.GA20625@sigill.intra.peff.net> <20190301173443.16429-3-tmz@pobox.com>
In-Reply-To: <20190301173443.16429-3-tmz@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Mar 2019 13:22:52 -0500
Message-ID: <CAPig+cTQG+yLGs1Ur2awhLyrpSWj0QyrDpuxCnMNOqc2bBz3pQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] t9902: test multiple removals via completion.commands
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 12:35 PM Todd Zullinger <tmz@pobox.com> wrote:
> 6532f3740b ("completion: allow to customize the completable command
> list", 2018-05-20) added the completion.commands config variable.
> Multiple commands may be added or removed, separated by a space.
>
> Demonstrate the failure of multiple removals.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> @@ -1483,6 +1483,14 @@ test_expect_success 'git --help completion' '
> +test_expect_failure 'completion.commands removes multiple commands' '
> +       echo cherry-pick >expected &&
> +       test_config_global completion.commands "-cherry -mergetool" &&
> +       git --list-cmds=list-mainporcelain,list-complete,config |
> +               grep ^cherry >actual &&
> +       test_cmp expected actual
> +'

We normally avoid placing a Git command upstream of a pipe. Instead,
the Git command output would be redirected to a file and then the file
grep'd. However, in this case, you might consider simplifying the test
like this:

    test_expect_failure 'completion.commands removes multiple commands' '
        test_config_global completion.commands "-cherry -mergetool" &&
        git --list-cmds=list-mainporcelain,list-complete,config >actual &&
        grep cherry-pick actual
    '
