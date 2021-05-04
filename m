Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E588C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D44961168
	for <git@archiver.kernel.org>; Tue,  4 May 2021 15:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhEDP02 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 4 May 2021 11:26:28 -0400
Received: from elephants.elehost.com ([216.66.27.132]:50457 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhEDP02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 11:26:28 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 144FPPQn072203
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 May 2021 11:25:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Philip Oakley'" <philipoakley@iee.email>, <git@vger.kernel.org>
References: <043101d73aae$026409b0$072c1d10$@nexbridge.com> <fa8f81db-d470-130e-115d-7aef5e97e5a7@iee.email>
In-Reply-To: <fa8f81db-d470-130e-115d-7aef5e97e5a7@iee.email>
Subject: RE: Advise request on adding a new SSH variant
Date:   Tue, 4 May 2021 11:25:16 -0400
Message-ID: <004401d740f9$b3112a80$19337f80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQICl0JKo2eflaadgk4Zc8OO/4gdTgInfQGrqmuGTbA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>From: <philipoakley@iee.email>
On May 4, 2021 10:45 AM, Philip Oakley wrote:
>On 26/04/2021 16:08, Randall S. Becker wrote:
>> I am getting a bunch of requests from my team (and customers) to make
>> SSH configuration easier on the NonStop platform.
>> We are currently using a
>> wrapper script to drive the variant of SSH on the platform but that is
>> not convenient for many people.
>> I would like to add an ssh.Variant called "nonstopssh", or something
>> like that, which takes a few extra parameters.
>> -Q (quiet), -Z (don't display the banner), -p port (obvious but
>> typically required), -S (a system process name).
>https://git-scm.com/docs/git-config#Documentation/git-config.txt-sshvariant
>
>Sounds sensible to me. Maybe also look at past issues that Git-for-Windows had
>with folks having too much prior choice (plink, putty, tortoiseplink). May need
>more clarity in the docs ;-)

In this situation, NonStop SSH is pretty much the only real option for users. OpenSSH works and is an option, but the version is lagging a due to port difficulties and $DAYJOB. NonStop SSH is supplied by the OS vendor, so basically everyone uses it.

>> The code in connect.c looks pretty
>> straight forward, but I'm wondering about the best way to pass in a
>> process name (it would be something like "$ZSSHX" - usually an
>> environment variable "SSH2_PROCESS_NAME").
>Hopefully others can chime in.. Maybe see discussion at
><pull.913.git.1616511182942.gitgitgadget@gmail.com> about $ARG variable.
>> The program name for SSH, I assume, could come from GIT_SSH_COMMAND
>> (typically "/G/system/zssh/sshoss", or I could force it if not
>> supplied).
>https://git-scm.com/docs/git-config#Documentation/git-config.txt-
>coresshCommand
>> I'm also wondering about controls for the -Q and -Z parameters.
>> Should I just use the environment for this and build up args or is
>> there a more appropriate way of managing these values?

The $ZSSHX form causes a shell started for GIT_SSH_COMMAND to have issues. Much cleaner to pass the value as a raw argument - rather the point of this variant. I'm trying to decide whether to put through V2, which removes controls for -Q and -Z, but I think it might be better to leave the patch as is. The $ prefix on process names goes back to 1978 (maybe before that in prototypes), and isn't going to change. I'm not sure the $ARG variable has any benefit here. The SSH2_PROCESS_NAME is going to be in the user's environment on that platform, so the default situation (just that variable), seems to do exactly what the end user needs. The other form of a process name is cluster node qualified, for example, \MYNODE.$ZSSHX, which makes things even worse in a shell because of the backslash *and* $. We otherwise end up with all sorts of junk in the end command, and errors with -S thinking the user name is a poorly formed process name.

-Randall

