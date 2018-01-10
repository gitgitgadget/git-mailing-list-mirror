Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2D81FAE2
	for <e@80x24.org>; Wed, 10 Jan 2018 23:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeAJXRl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 18:17:41 -0500
Received: from avasout03.plus.net ([84.93.230.244]:35931 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeAJXRj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 18:17:39 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id ZPcneWXHw6MuZZPcoeh6II; Wed, 10 Jan 2018 23:17:38 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=YqAhubQX c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=IqPUlTZAAAAA:8 a=jqIJi-bjKPfx0JSm4LgA:9 a=QEXdDO2ut3YA:10
 a=uJLxWluzARXgNwbH5uYh:22
X-AUTH: ramsayjones@:2500
Subject: Re: Test failure for v2.16.0-rc0 on cygwin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <519ac918-6b5f-bca3-05a0-0114683b9724@ramsayjones.plus.com>
 <20171230144019.GB29210@dinwoodie.org> <20180102113649.GC29210@dinwoodie.org>
 <3616d866-9a53-6e32-0a62-488342ae214f@ramsayjones.plus.com>
 <e69657de-9455-2b97-09d7-2bd58ce513f6@ramsayjones.plus.com>
 <alpine.DEB.2.21.1.1801042152570.32@MININT-6BKU6QN.europe.corp.microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <87f53af7-4f5b-22a7-b950-772eb67b0151@ramsayjones.plus.com>
Date:   Wed, 10 Jan 2018 23:17:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1801042152570.32@MININT-6BKU6QN.europe.corp.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMc2wXQnTOrOZy2IW/K9xpRSv5qb1wx7ebkoZ7d6YhYa/btiLKRkkpxrdPRii7wf+9fV5kufh2g+pNUxPDOswP5mXbo00dHR883ehfM01vgmXl7D4OO+
 KAghk/6LMZ9OXKZZ+2rpb074At8F1dZfQAtrThAvfRN+E6dkDpNZEQMZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/01/18 20:55, Johannes Schindelin wrote:
> On Tue, 2 Jan 2018, Ramsay Jones wrote:
[snip]
>> Also, when logged-in remotely it fails consistently, when logged-in
>> directly it passes consistently. :-D
> 
> You are most likely hitting cmd.exe at some point there. In cmd.exe, there
> are some restrictions that are inherited by spawned processes AFAIU. For
> example, the current directory cannot be a UNC path.
> 
> You are most likely running the interactive Cygwin session in MinTTY? Then
> you do not get those restrictions. If you start Cygwin in a cmd.exe
> window, you should see the exact same test failures again.

I actually don't see a difference when starting cygwin from a cmd.exe, it
passes just fine. The interactive cygwin session(s), either directly, or
most often via the X-server (with ssh-agent in between!), all have their
id's and group membership look like:

  $ who
  $ id
  uid=1001(ramsay) gid=513(None) groups=513(None),545(Users),4(INTERACTIVE),66049(CONSOLE LOGON),11(Authenticated Users),15(This Organization),113(Local account),66048(LOCAL),262154(NTLM Authentication),401408(Medium Mandatory Level)
  $

However, when remotely logged-in over shh, it looks like:

  $ who -H
  NAME     LINE         TIME             COMMENT
  ramsay   pty2         2018-01-02 19:48 (192.168.1.2)
  $ id
  uid=1001(ramsay) gid=513(None) groups=513(None),11(Authenticated Users),66048(LOCAL),66049(CONSOLE LOGON),4(INTERACTIVE),15(This Organization),545(Users),0(root),405504(High Mandatory Level)
  $

So, when remotely logged-in, we have:

  Additional groups: 0(root), 405504(High Mandatory Level)

  Missing groups: 113(Local account), 262154(NTLM Authentication),
                  401408(Medium Mandatory Level)

I haven't thought too much about what that means ...

After reading this[1], I have been meaning to try setting the
'LocalAccountTokenFilterPolicy' registry variable mentioned in
that article, to see if that would make any difference. I haven't
found the time yet ... :-D

ATB,
Ramsay Jones


[1] http://www.tomsitpro.com/articles/windows-10-administrative-shares,2-47.html
