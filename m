Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E6EC4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E52261418
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFDTbw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 4 Jun 2021 15:31:52 -0400
Received: from elephants.elehost.com ([216.66.27.132]:20051 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhFDTbt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 15:31:49 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 154JTu94056541
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 4 Jun 2021 15:29:57 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Git Mailing List'" <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>
References: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com> <CABPp-BH6RgiMwGLz31nHmis3VTpuEUG--G_6Y+Wfwg24u4Zbag@mail.gmail.com> <012601d73ddf$3d0cf660$b726e320$@nexbridge.com> <CABPp-BE_5c1vXuxPWTO82cGmyajXxpxW+-ycZ+-5vy+tsV3bUA@mail.gmail.com> <012901d73de6$c25a4ff0$470eefd0$@nexbridge.com> <01dd01d745b0$875c6920$96153b60$@nexbridge.com>
In-Reply-To: <01dd01d745b0$875c6920$96153b60$@nexbridge.com>
Subject: RE: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
Date:   Fri, 4 Jun 2021 15:29:51 -0400
Message-ID: <00f101d75978$0074c840$015e58c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWGYGttp5Jdx88vf9L/5ZtrxnlMwG55eaXAXoXgPoC7mL63QI2zlGUAkuPwtyqMZJ+QA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 10, 2021 11:24 AM, I wrote:
>On April 30, 2021 1:32 PM, I wrote:
>>Subject: RE: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
>>
>>On April 30, 2021 1:17 PM, Elijah Newren wrote:
>>>On Fri, Apr 30, 2021 at 9:38 AM Randall S. Becker
>>><rsbecker@nexbridge.com>
>>>wrote:
>>>>
>>>> On April 30, 2021 12:25 PM, Elijah Newren wrote:
>>>> >On Fri, Apr 30, 2021 at 7:58 AM Randall S. Becker
>>>> ><rsbecker@nexbridge.com>
>>>> >wrote:
>>>> >>
>>>> >> From ba4beb8ed0dff67ae6b95692d346adce346e2871 Mon Sep 17
>>00:00:00
>>>> >2001
>>>> >> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>>> >> Date: Fri, 30 Apr 2021 09:56:09 -0400
>>>> >> Subject: [Patch 1/3] connect.c: add nonstopssh variant to the
>>>> >> sshVariant
>>set.
>>>> >>
>>>> >> This enhancement allows the NonStop SSH subsystem to be supported
>>>> >> by git without the need of a wrapper script. The command
>>>> >> arguments for the platform SSH client in /G/system/zssh/sshoss
>>>> >> are constructed based on optional supplied environment variables
>>>> >> SSH2_PROCESS_NAME (system defined), SSH_SUPPRESS_QUIET, and
>>>SSH_SUPPRESS_BANNER.
>>>> >
>>>> >Before introducing 3 new special environment variables, I think
>>>> >this commit message should explain why you can't just use
>>>> >
>>>> >GIT_SSH_COMMAND="/G/system/zssh/sshoss -Z -Q -S"
>>>>
>>>> No, it would be GIT_SSH_COMMAND='/G/system/zssh/sshoss -Z -Q -S
>>$ZSSH0'
>>>and that does not work correctly in the current git code base.
>>>
>>>Is the problem that $ZSSH0 may contain spaces, or that $ZSSH0 is
>>>expected to change over time and you don't want to have to re-run
>>>
>>>GIT_SSH_COMMAND="/G/system/zssh/sshoss -Z -Q -S $ZSSH0"
>>>
>>>each time?

I'm looking for a more general solution than what I originally proposed, but still think that we need the variant. With that said: there are multiple command arguments to sshoss that need to be supported and an environment variable for each is obviously not effective. I am thinking that this variant has value. The primary problem is supplying -S $ZSSH0 on the command line causes $ZSSH0 to be resolved as a shell variable. It is not. It is the process name of the SSH stack, which can vary. The current code, if -S $ZSSH0 is supplied, ends up resolving to nothing, so the -S argument eats the URL and the SSH operation fails. The other problem is that sshoss does not support a URL with a port number in it, so that must be resolved explicitly as -p port, but the other variants do not handle this situation, with -S. At the very least, those two parameters (-S, -p) have to be accounted for in the variant, and -Q (suppress local banner) is required or the dialog generally breaks because it com
 es back on stdout and confuses git. What I am considering is a single NONSTOP_SSH_ARGUMENTS environment variable to contain all other options that may be there today or in future, and have the internal code split the arguments up appropriately.

A bit of background on process names. $ZSSH0 is an example. On my system there is $ZSSGT (external subnets) and $ZSSH1 (internal subnets). There is a wide variety of naming, but they all begin with the annoying $ sign. Escaping the $ does not work consistently, I think because there are varying numbers of shells involved given different circumstances that only impacts the NonStop platform - it's not for lack of trying to get around this.

Looking for guidance on this use case - not expecting this for 2.32, obviously. Currently, we are forced to use a wrapper script, which is not ideal. The -p option has to be embedded in the script so using a GitHub, BitBucket, GitLab, etc., supplied URI does not work correctly. Of course, the script could parse out the :port, but URI parsing seems redundant given the variant mechanism.

Thanks,
Randall

