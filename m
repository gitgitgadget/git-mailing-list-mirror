Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A06AC433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7919161108
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 17:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhJVRgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhJVRga (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 13:36:30 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Oct 2021 10:34:12 PDT
Received: from srv1.79p.de (srv1.79p.de [IPv6:2a01:4f8:222:1281::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA83C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 10:34:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:ea:270e:d800:50f8:6c55:53f7:f07b] (p200300ea270ed80050f86c5553f7f07b.dip0.t-ipconnect.de [IPv6:2003:ea:270e:d800:50f8:6c55:53f7:f07b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id C8F0A600695;
        Fri, 22 Oct 2021 19:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2021; t=1634923635;
        bh=O1607ra4bQuFvF0hoBLXLbrGKsOSjx9mzp/umJYY9/w=;
        h=From:To:Subject:Date:From;
        b=qCvgn1yygNSA/KBbAoI8/jh/7KOWnLeaHDTPVaCOPUZ8R4Vbwx3h6d/dflhxWm8Mg
         jST/dTrmB+wnNeXpGYzy907YTB8ELLCjvQqk6FCilNFG0WvP1fgOi8p41ygUzTkO1R
         8nDlVdR4Jk3clSTNLZthioFtk0xBMGxxgh6LIPyI6bBUl5/otf0B1y9HoXRRQrsEHH
         53osxJi2/eUgl3me736WS1wxovclw3+PElbMK//YqTl2QzuwMVDmGNm0lah74ELbQT
         T3/bAOrGit79fw9Bfvzdejycoqe/1f2C5n7j0LLf0yRlFTzfmH6Eg+yfela69FMuad
         1A6CU/4cXVs6w==
From:   Sven Strickroth <sven@cs-ware.de>
To:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        bwilliams.eng@gmail.com
Subject: Git silently broke push-options over ssh?
Message-ID: <4aef40f2-43f8-eab3-a840-6e76c8b4afbb@cs-ware.de>
Date:   Fri, 22 Oct 2021 19:27:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using Git (for Windows) 2.33.1 and using push-options as described 
on <https://docs.gitlab.com/ee/user/project/push_options.html> does not 
work any more (IIRC it used to work with Git 2.16 and 2.17).

If I understood 
<https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html> 
correctly I have to enable the Git protocol version 2 and then the push 
options should work.

Now, when I try to use push options on Windows it does not work. I tried 
to debug it:

D:\TortoiseGit>set GIT_TRACE=2
D:\TortoiseGit>set GIT_SSH=ssh.exe
D:\TortoiseGit>set GIT_SSH_VARIANT=ssh
D:\TortoiseGit>set GIT_PROTOCOL=version=2
D:\TortoiseGit>git -c protocol.version=2 -c ssh.variant=ssh -c 
ssh.command=ssh push -v -o ci.skip origin master~23:testing
17:36:06.285346 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/bin
17:36:06.285346 git.c:455               trace: built-in: git push -v -o 
ci.skip origin 'master~23:testing'
Pushing to gitlab.com:tortoisegit/tortoisegit.git
17:36:06.295270 run-command.c:666       trace: run_command: unset 
GIT_CONFIG_PARAMETERS GIT_PREFIX; ssh.exe git@gitlab.com 
'git-receive-pack '\''tortoisegit/tortoisegit.git'\'''

As you can see, the "-o SendEnv" parameter not passed to ssh.exe and, 
therefore, I think the push option is not transferred to the server.

According to <https://github.com/git-for-windows/git/issues/3486> the 
reason is a commit that was shipped with Git 2.18 (in 2018):

<https://github.com/git/git/commit/1aa8dded3afff28d8f4c24a97b237a0d9e633173>

How to use push options with Git over SSH?

-- 
Best regards,
  Sven Strickroth
  PGP key id F5A9D4C4 @ any key-server
