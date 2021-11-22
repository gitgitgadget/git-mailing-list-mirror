Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6028DC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 23:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhKVXyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:54:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39336 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhKVXyv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:54:51 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AMNpdTr038979
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 Nov 2021 18:51:40 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Carlo Arenas'" <carenas@gmail.com>, <git@vger.kernel.org>
References: <xmqqr1b8gkhg.fsf@gitster.g>        <CAPUEsphNH9pfQoHqVgJfkQCU-Li45dz4QtGtDjWu5bDV9A3PEg@mail.gmail.com>        <nycvar.QRO.7.76.6.2111222319100.63@tvgsbejvaqbjf.bet> <xmqqmtlvbynr.fsf@gitster.g> <nycvar.QRO.7.76.6.2111230025440.63@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2111230025440.63@tvgsbejvaqbjf.bet>
Subject: RE: preparing for 2.34.1
Date:   Mon, 22 Nov 2021 18:51:34 -0500
Organization: Nexbridge Inc.
Message-ID: <039401d7dffb$e5198800$af4c9800$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHGoR0gTaIcVJxxdjmNpWp+zr5ahADSYqyOArMe3lMCJktwKgHjekNzq/Y45+A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 22, 2021 6:30 PM, Johannes Schindelin wrote:
> On Mon, 22 Nov 2021, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > The quickest workaround for this is probably to special-case the
> > > editor
> > > `echo`:
> >
> > "GIT_EDITOR=: git cmd" would also be a common trick people would use
> > to bypass editor and take whatever is given as an initial template.
> 
> GIT_EDITOR=: is not a problem because of
> https://github.com/git/git/blob/v2.34.0/editor.c#L59:
> 
> 	if (strcmp(editor, ":")) {
> 		[...]
> 		term_fail = save_term(1);
> 		if (start_command(&p) < 0) {
> 			if (!term_fail)
> 				restore_term();
> 			[...]
> 		}
> 
> 		[...]
> 		if (!term_fail)
> 			restore_term();
> 		[...]
> 	}
> 
> > > However, I could imagine that other scenarios call for an editor
> > > that _also_ does not run in the terminal, and where also no real
> > > terminal is available for saving and restoring.
> > >
> > > I was tempted to suggest an `isatty(2)`, but that probably comes
> > > with its own problems, too.
> >
> > I think isatty(2) is pretty much our synonym to "are we talking to an
> > end-user sitting in front of the terminal".  Mostly we use it as a way
> > to control the progress bars, and use of editor on terminal would be
> > in line with these existing uses.
> 
> Indeed, I think that isatty(2) is a better indicator than isatty(1). We
> sometimes _do_ redirect the output of, say, `git commit`, to capture the
> commit hash that was generated. We typically do not redirect stderr,
though,
> unless calling from an application and capturing everything via pipes. So
> isatty(2) strikes me as the best balance we can strike here.

Please be careful of this one. isatty(2) may not be the issue, but the
filedes provided by Jenkins and other CI/CD systems over SSH often
mischaracterises the results from this call. Hacking the file descriptor
(2>&1 etc) prior to going to git is a common thing in scripts. Stdin is
frequently wrong when Jenkins sets up the environment to prompt for an SSH
passphrase - happens in non-Docker nohup situations - where git will end up
thinking it is interactive when it is not - not on NonStop fortunately, but
this happens with a Gentoo Hypervisor and Ubuntu VM. Also, stderr gets
redirected in scripts frequently in my experience - particularly on exotic
operating systems, crossing over from say, legacy NonStop or IBM TSO to
each's POSIX environment. I would expect breakages from this assumption, so
please be cautious.

-Randall

