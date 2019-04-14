Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D5220248
	for <e@80x24.org>; Sun, 14 Apr 2019 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfDNOeV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 14 Apr 2019 10:34:21 -0400
Received: from elephants.elehost.com ([216.66.27.132]:30472 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDNOeV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 10:34:21 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x3EEYFrn044238
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 10:34:16 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
References: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com> <874l71fxmg.fsf@evledraar.gmail.com> <20190413214736.GD15936@szeder.dev>
In-Reply-To: <20190413214736.GD15936@szeder.dev>
Subject: RE: [BUG] GIT_SSH_COMMAND is not being decomposed
Date:   Sun, 14 Apr 2019 10:34:07 -0400
Message-ID: <001401d4f2cf$21cafc10$6560f430$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGpuMnQep3MvtsjO/08o+Xas343GAFQ9z8cANXpddqmgPEg0A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 13, 2019 17:48, SZEDER Gábor wrote:
> To: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Cc: Randall S. Becker <rsbecker@nexbridge.com>; git@vger.kernel.org
> Subject: Re: [BUG] GIT_SSH_COMMAND is not being decomposed
> 
> On Sat, Apr 13, 2019 at 10:39:35PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > On Sat, Apr 13 2019, Randall S. Becker wrote:
> > > I am encountering a problem on one of our NonStop platform variants
> > > where the GIT_SSH_COMMAND string is not being broken into
> > > constituent parts. This is causing SSH to not run properly. As
> > > background, SSH is not in a standard location and has non-standard
> > > required arguments. This also occurs with core.sshCommand. The
> situation is:
> > >
> > > git config --global core.sshCommand '/G/system/zssh/sshossz5 -Q'
> > >
> > > which correctly sets .gitconfig as:
> > >
> > > [core]
> > >         sshCommand = /G/system/zssh/sshossz5 -Q
> > >
> > > When git is run with GIT_TRACE=true GIT_PACKET_TRACE=true git fetch
> > >
> > > We get the partial trace:
> > > 14:19:56.027088 trace: built-in: git fetch
> > > 14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5 -Q' -G
> > > user@host
> > >
> > > The same trace on our systems that actually do work results in:
> > > 14:19:56.029895 trace: run_command: '/G/system/zssh/sshossz5' '-Q'
> > > -G user@host
> > >
> > > I need help resolving why this is happening (as in where to look and
> > > debug the situation).
> >
> > This doesn't seem to be documented *explicitly* (except between the
> > lines & inferred), but it's only supported to pass a *command* there,
> > i.e. the path of the ssh binary.
> 
> 'man git' it quite explicit about this:
> 
>   $GIT_SSH_COMMAND takes precedence over $GIT_SSH, and is interpreted
>   by the shell, which allows additional arguments to be included.
>   $GIT_SSH on the other hand must be just the path to a program (which
>   can be a wrapper shell script, if additional arguments are needed).
> 
> Quick test shows that the implementation agrees with the
> documentation:
> 
>   $ GIT_TRACE=2 GIT_SSH_COMMAND='/usr/bin/ssh -v' git push -n github
>   23:39:02.048870 git.c:419               trace: built-in: git push -n github
>   23:39:02.060821 run-command.c:643       trace: run_command: unset
> GIT_PREFIX; '/usr/bin/ssh -v' git@github.com 'git-receive-pack
> '\''/szeder/git'\'''
>   OpenSSH_7.2p2 Ubuntu-4ubuntu2.8, OpenSSL 1.0.2g  1 Mar 2016
>   debug1: Reading configuration data /home/szeder/.ssh/config
>   <... snipt rest of the verbose ssh output ...>
> 
> And the config setting works, too:
> 
>   $ GIT_TRACE=2 git -c core.sshCommand='/usr/bin/ssh -v' push -n github
>   23:42:55.277776 git.c:439               trace: built-in: git push -n github
>   23:42:55.285149 run-command.c:663       trace: run_command: unset
> GIT_CONFIG_PARAMETERS GIT_PREFIX; '/usr/bin/ssh -v' git@github.com 'git-
> receive-pack '\''/szeder/git'\'''
>   OpenSSH_7.2p2 Ubuntu-4ubuntu2.8, OpenSSL 1.0.2g  1 Mar 2016
>   debug1: Reading configuration data /home/szeder/.ssh/config
>   <...>
> 
> Note that in both cases the trace shows '/usr/bin/ssh -v', IOW neither
> $GIT_SSH_COMMAND nor 'core.sshCommand' are broken up.
> 
> But this is just an avarage Linux box, so perhaps this is a NonStop-specific
> issue?

I'm sure it is a NonStop issue. It is interesting that 2.21.0 broke the string apart on the older NonStop variant and not the newer one. But looking at the code, I can't imagine how the string was broken up into parts. Makes no sense at all with xstrdup() and argv_array_push(). 

> > See the code around get_ssh_command()
> > in connect.c. The whole env/config value we look up gets passed as one.
> >
> > So if you need arguments you need to create a wrapper script and set
> > ssh command to that script.

Going forward, I'm going to use (and strongly recommend) a wrapper on both NonStop variants. It's the right way to go, and not only a trivial script but makes configuring communication with upstream servers much easier (there are potentially multiple TCP/IP stacks and multiple SSH d databases available that need to be selected on the sshoss command line). Managing all that in one place is easier than having each user worry about it changing over time.

Thanks again,
Randall

