Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316BDC43217
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 16:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKYQB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 11:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKYQBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 11:01:25 -0500
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 08:01:23 PST
Received: from srv1.79p.de (srv1.79p.de [IPv6:2a01:4f8:222:1281::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501451EAFF
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:01:23 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPV6:2001:9e8:2bc5:500:3514:8a82:52b8:1f83] (unknown [IPv6:2001:9e8:2bc5:500:3514:8a82:52b8:1f83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id 4B9DB600098;
        Fri, 25 Nov 2022 16:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2022; t=1669391771;
        bh=9UU6fApmNUyjb3J9kEJiHZAKK4WPgwScGbFjfqG5DW4=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=ZpvRxoxBfk+5hs5/UC11yqBfARNQwQ7bsqH3FHBmQ2dI+hFVdeKxrJv2Ps8to9GDa
         J3VWvtUH7jmK/ZLe4+C2J72g/6LRpoKX1s0w0A2sZu91quQyfSjs820gmpHAHlEhKg
         WZcWJey4dhxAbznvL0XyGjHy9BVfE42f6MJ5w0ucLbS/j9wdetZK/42EblvfpYUhLk
         3u44xndJOv9FQ9ZsC36cMwMpQSVqnYEpvYkfBJI92iLHEQrBiCfuujJEPvD/s1mMHz
         C3+tAQSrAmkE/ye+rWnSvNxUvFFgBXdKE3Zlw87SUSGORhq4REvxFNkP+oKe9caSI6
         McjH0/WsaRhWA==
Message-ID: <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
Date:   Fri, 25 Nov 2022 16:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: git pull --verbose with submodules ends in error message
To:     git <git@vger.kernel.org>
References: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>
From:   Sven Strickroth <sven@cs-ware.de>
In-Reply-To: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

the reason for the failure of the submodule command after issuing
"git pull -v --recurse-submodules"
is that the verbosity of the pull command is passed to the submodules. 
Commit a56771a668dd4963675914bc5da0e1e015952dae introduced this regression.

I suppose the intention was to pass the '-q' flag to the submodule 
command, but the issue is that also '-v' is passed which, however, is 
not supported by the submodule command.

So, either don't pass '-v' to the submodule command or add it there...

Best,
  Sven

Am 24.11.2022 um 13:47 schrieb Fink, Mike:
> Dear Sir or Madam,
> 
> 
> Bug Description
> ===============
> 
> when doing a git pull on a repository with submodules, the --verbose option causes an error message like:
> usage: git submodule [--quiet] [--cached]
>     or: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> ... and so on.
> Exit code is 1
> 
> This happens, when recursing the submodules. Either add to .gitconfig:
> [submodule]
> 	recurse = true
> or use --recurse-submodules for the git pull command.
> 
> Version 2.37.3-64-bit is OK.
> Version 2.38.1-64-bit is shows the error.
> Reproducible on Windows and Linux
> 
> 
> How to Reproduce
> ================
> # steps to reproduce:
> # run the following commands in a debian:sid container,
> # e.g. "docker container run -it debian:sid".
> 
> # Any other environment with git 2.38.1 should be fine, too.
> # Git for windows 2.38.1 also shows the same behaviour.
> 
> # install git 2.38.1 (at the time of writing) and clone a public repo with submodules
> $ apt update && apt install git
> $ git clone --recurse-submodules https://gitlab.com/tortoisegit/tortoisegit.git
> $ cd tortoisegit
> 
> # this one succeeds
> $ git pull --recurse-submodules
> 
> # this one fails after fetching the submodules, showing
> # the "git submodule" help text as if we had made a "git submodule"
> # call with insufficient/wrong arguments.
> $ git pull --recurse-submodules --verbose
> 
> 
> Workaround
> ==========
> 1) Do not use --verbose when pulling a repository with submodules.
>     Unfortunately this workaround does not apply to our workflow,
>     since we happily use TortoiseGit as our graphical Git client on windows.
>     TortoiseGit automatically uses the option -v (--verbose).
>     $ git.exe pull --progress -v --no-rebase "origin"
> 2) Use Version 2.37.3-64-bit.
> 
> 
> Questions
> =========
> Any questions regarding this bug description? Happy to help.
> 
> 
> Kind regards, Mike.

