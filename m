From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 2 Mar 2009 20:58:33 +0100
Message-ID: <200903022058.33392.robin.rosenberg.lists@dewire.com>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se> <49ABD24B.5060005@viscovery.net> <alpine.DEB.2.00.0903021404000.17877@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeEJH-0003UQ-RS
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 21:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbZCBT6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 14:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755280AbZCBT6s
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 14:58:48 -0500
Received: from mail.dewire.com ([83.140.172.130]:4468 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904AbZCBT6s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 14:58:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3AD001484140;
	Mon,  2 Mar 2009 20:58:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUgMgLsNtnuW; Mon,  2 Mar 2009 20:58:35 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id CFDD0147EA9F;
	Mon,  2 Mar 2009 20:58:35 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <alpine.DEB.2.00.0903021404000.17877@perkele.intern.softwolves.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111959>

> Johannes Sixt:
> 
> > Can you set the local codepage per program? (I don't know.)
> 
> The locale is set per thread, and gets reset when the program exits. So 
> setting the codepage to UTF-8 before outputting should work. That should 
> also work for displaying the log to the terminal if you have UTF-8 log 
> messages.

Messing with locale is probably going to break subtly. An explicit approach
is better, respecting the user's locale when necessary.

> Converting it to wchar_t and using wprintf and similar should be safer, 
> though (and I have no idea what happens if you try to pipe the output to 
> something else).
> 
> > - What encoding should 'ls-files' use for its output? Certainly not always 
> > UTF-8: stdout should use the local code page so that the file names are 
> > interpreted correctly by the terminal window (it expects the local code 
> > page).
> 
> That is exactly why trying to mix "protocol" data ("plumbing" in Git's case) 
> and user output will always come back and bite you, one way or another. I 
> haven't really the faintest how pipes work with Unicode on Windows. 
> Somewhere along the line there will probably be some conversions, which 
> would cause interesting issues.

Pipes are just bytes so you have to know what you're piping by convention
or protocol. You can ask for the console output page, which may be set to
a multibyte locale or unicode and maybe trust that.... (just guessing, really).

> Better not use pipes, then. Heh. I sense that there is a slight problem with 
> the architecture of Git and trying to get it to behave on Windows... :-)

architecture? Like the "architecture" of species? No, it's evolution.
If that applies to the linux kernel, it's not so strange it applies to git too.

> > - What encoding should 'update-index' expect from its input? Can you be 
> > sure that other programs generate UTF-8 output?
> 
> Theoretically, if all the internal stuff is hacked around to output Unicode, 
> and the thread codepage is set up to use UTF-8, it should "just work". And 

msys doesn't seem to understand UTF-8 at all, so depending on that to work
seems futile. Simply bypassing the locale for any internal work is probably the 
most sane thing. That also won't depend of the quality of the locale support in 
the runtime. Start by making the git commands working without msys bash,
and figure a way to fix msys later, unless someone has a very good idea on
how to fix msys.

> if run directly from the shell, it should still be converted to whatever the 
> system is set up to emit. That would mean, however, that a Git program that 
> internally runs
> 
>    git-foo | git-bar | git-gazonk
> 
> might behave differently compared to if a user would enter it on the 
> command-line.
> 

You might also want to check out my work in the area. See 

http://www.jgit.org/cgi-bin/gitweb/gitweb.cgi?p=GIT.git;a=shortlog;h=i18n

The goal is locale neutrality yielding the "expected", in the users eyes, result regardless
of locale as much as possible. Junio didn't want to have it for five years, so I
guess there's still three and half to go. Hopefully he can change his mind. That branch
is heavily outdated by now, as some of functionality have been introduced by other
means like logoutputencoding and other parts of git have been rewritten.

Related to this, JGit assumes UTF-8 on reading. If it's not valid UTF-8 we try the user's 
locale (rougly) and on writing object meta data, including any sort of identifier, 
we always write UTF-8 when have to be explicit. We let the runtime decide on how
to encode file names in the file system using the user's locale.

I'd be almost happy with a solution that works when people are interacting using
the subset that is convertible between the character sets in use.

-- robin
