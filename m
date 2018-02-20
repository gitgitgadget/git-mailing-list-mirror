Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9C81F404
	for <e@80x24.org>; Tue, 20 Feb 2018 16:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeBTQUR (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 11:20:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:41429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752115AbeBTQUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 11:20:16 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MNIi1-1eqegR16Kn-006xVB; Tue, 20 Feb 2018 17:20:14 +0100
Date:   Tue, 20 Feb 2018 17:20:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: File locking issues with fetching submodules in parallel
Message-ID: <nycvar.QRO.7.76.6.1802201709570.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0spZxTvpZEwCiW8VJ1g7yufy5EfJMh6ospRhmHYlY/wVFnCVS2D
 Gv1BHEIWacKCg368LyPecv8cnMTBV5ol4UInatxEwz2NLX+UDhWbMeLoL01fDTPHRbV0Qxu
 UGCLTWUFoQqPPvksY3/GmppGZQoTT+0scsRx6w6yllqzR8a1XYmDUgrnty2WSHCAr1KLAqZ
 K1Pz5Jm2zsgTsGl0mk8VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NcCHWQTHx04=:cXRJi1cm0x8TO5BY5YAV97
 U4GHYVQUR64UXgieEIDYOeytLUL0MAFYk6UQibJhl3+aWS6aaEWCPgPmGUIdbHjpmFf1kmLMR
 UdxjzNcSSEC+m0Y7uwk6n5a+LGxuvRBeQBI/f9Fm3R0HfiTd0FLWwSEkThweyRl1RCmSxfmsV
 0XN45g08sw5YJeoRltXMOIBRu8Q6lDVyWd5UAGuov9r+xYMLeSjNAnbZAfZ67BDyvL49T4u0E
 JzRRzFzItgwnSq2teT6kJkg8gwv4YPKcpDqZUX343ZOPLWwBQTYxTstxKZbmnru9xm6wcVFDZ
 bWUKXwEtqLWMt70mvCPsUcOm8WqX2nLG/Dn/SnrLBmWgTi+QLnYNHQ+Hs4ZzclVmCZ64dLHxl
 Q9gBuKBMsRcYCcoylB7eglfpa2YJNECWmmSqbE3JuQWtWbD/5VkQbrhACHu0Qxeug/4emR3Yk
 G7dapRx4XeFvYVjGuhA/GIUGMyfxea9Mi8OIh0VD/ytu6fwDRUONcIIfFbNTG4Imb1CcBBpWJ
 DDREPBYfRUrXBrinbd6OjASL7al4N7e7ULSPkEgn9+H1/qGwtqggMfzpavGt+rja8Yyg6SHuc
 S6OSww2XrKktcDDBvIj9x1nqVjleL1Vgsf3ms0ED71ElAMsO19tCxSTnaSI7xkjouC1kcFzxk
 CpTvjZYlTwwlBKRRBOYdd9PdcsNF00M7SBLBvr2AAbqkQI5VWB7g6s2CzLRTO4xfMcTwgkC2S
 Aq3mjaaMXl7NzpWelELnR0s0PJHDZ8juchWm0aZPPf1X4DBCZ9s0fzCWlDlel1x2hN2q7kEWp
 R2HMxVz22+ncdgBG4er5Mu6QnCfks/r2hAHSlKBvyBi/oXylWM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan (and other submodule wizards),

Igor Melnichenko reported a submodule problem in a Git for Windows ticket:

	https://github.com/git-for-windows/git/issues/1469

Part of it is due to Windows' behavior where you cannot read the same file
in one process while you write it in another process.

The other part is how our submodule code works in parallel. In particular,
we seem to write the `.git` file maybe even every time a submodule is
fetched, unconditionally, not even testing whether the .git file is
already there and contains the correct contents?

For some reason, the bug reporter saw a "Permission denied" on the `.git`
file when we try to write it (and I am pretty certain that I tracked it
down correctly to the `connect_work_tree_and_git_dir()` function). The
intermittent "Permission denied" error seems to suggest that *another*
process is accessing this file while we are writing it.

It also seems that this problem becomes worse if the firewall is turned
on, in which case a couple of network operations become a little slower
(which I could imagine to be the factor making the problems more likely).

A plausible workaround would be to write the `.git` file only when needed
(which also would fix a bug on macOS/Linux, although the window is
substantially smaller: the reader could potentially read a
partially-written file).

But maybe we are simply holding onto an open handle to the `.git` file too
long?

I tried to put together a bit more information here:

https://github.com/git-for-windows/git/issues/1469#issuecomment-366932746

Do you think there is an easy solution for this? You're much deeper in the
submodule code than I ever want to be...

Thanks,
Dscho
