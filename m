Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C88A20285
	for <e@80x24.org>; Thu, 24 Aug 2017 13:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbdHXNfc (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 09:35:32 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:55297 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdHXNfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 09:35:32 -0400
Received: from [192.168.2.201] ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id ksIEdLa5nAp17ksIEdYRR9; Thu, 24 Aug 2017 14:35:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1503581731; bh=IQaZqN2D4e714Hpo3grqsMReKdKG5ix8HrYRcEFc0EI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iyM5EgkkO8OC/wXsScVa51i6uaLprcZ/O33wA061VPwiE3w73fegSJs7Od+AhnaEi
         vjuN1AhkZ4QgB+5ivlnV4ZbbRwkarLHdIadCd/YmF9nfYWp86glb2eiRS3OfvX94ft
         wg4d8SDDCzEjNce3hPYMrPm14pDuFOebhsMb6Nac=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=nN7BH9HXAAAA:8 a=LUsUHP340ExWBTmaJVgA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase -i with only empty commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stephan Beyer <s-beyer@gmx.net>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com>
 <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net>
 <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <374688cd-1d62-ef4f-a989-346ad1953ae8@talktalk.net>
Date:   Thu, 24 Aug 2017 14:35:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKxXxeoDPUis2TnJbK/yKWORY1PsBtJtiY4EXrdD7F5sGrXWm/Lxjh1Xjh3ASjfoRxyY8ZW735n8TtO90Whr0JTwtvk4qBbRPHAIbiF+pufSPCbeiRDW
 4tihvpz1zKOjdSv0aNrys1mgQRt6YvkI4D5ZJCFFMyxjOpKQIvdl0d5l0bPXV3VxljbUfOK7ziCV+/Hpi+dd1wULkLEZbFOlGA6LPzhTWfJ/3EsAiegS1+rA
 pl1NnIcBTIpweEaa/VaJbEyYVrCmeufr9j8aMtAqyvo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/17 15:40, Johannes Schindelin wrote:
> 
> These days, I reflexively type `rebase -ki` instead of `rebase -i`. Maybe
> you want to do that, too?
> 
> Ciao,
> Dscho
> 

This is slightly off topic but when I was preparing the patches for [1]
I noticed a couple of potential bugs with rebase --keep-empty that I
haven't got around to doing anything about.

1 - If 'rebase --keep-empty' stops for a conflict resolution then it
cannot resume. This is because it uses cherry-pick rather than
format-patch/am and does not create $GIT_DIR/rebase-apply so there is no
saved rebase state for continue to use. In any case the --continue code
does not have the cherry-pick special case for --keep-empty that the
startup code does. I think this could be fixed by using an implicit
interactive rebase.

2 - The opt-spec allows '--no-keep-empty' but as far as I could see that
option is never checked for in the rebase code.

Best Wishes

Phillip


[1]
https://public-inbox.org/git/20170726102720.15274-1-phillip.wood@talktalk.net/
