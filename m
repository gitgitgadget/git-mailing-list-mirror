From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Making ce_path_match() more useful by accepting globs
Date: Mon, 26 Nov 2007 20:38:13 +0100
Message-ID: <20071126193813.GB3675@steel.home>
References: <7vr6ienqxr.fsf@gitster.siamese.dyndns.org> <20071126001114.GA10286@steel.home> <7vlk8lj1b7.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:38:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwjmw-0006eZ-3m
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbXKZTiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754329AbXKZTiT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:38:19 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:61102 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbXKZTiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:38:18 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg79ik=
Received: from tigra.home (Fcbf4.f.strato-dslnet.de [195.4.203.244])
	by post.webmailer.de (fruni mo48) (RZmta 14.3)
	with ESMTP id R0034djAQFuEQU ; Mon, 26 Nov 2007 20:38:14 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 234A4277AE;
	Mon, 26 Nov 2007 20:38:14 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id F023756D22; Mon, 26 Nov 2007 20:38:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vlk8lj1b7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66101>

Junio C Hamano, Mon, Nov 26, 2007 01:30:20 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Junio C Hamano, Sun, Nov 25, 2007 19:03:12 +0100:
> >> Currently ce_path_match() only uses "the leading directory" match, and
> >> does not understand file globs.  These do not work:
> >> 
> >>    git diff-files 't/*.sh'
> >>    git diff-index HEAD 'xdiff/*.c'
> >>    git update-index -g 'Documentation/howto/*.txt'
> >
> > How should my scripts handle files with "*" in names?
> 
> We DO NOT CARE.
> 
> Why?
> 
> How would you handle such files from the command line session without
> git?  "ls such-*-a-file" will also show such-silly-a-file as well.

It will break existing setups. Something like

    #!/bin/bash

    git diff-files --quiet -- "$@" || do_something

will behave differently

> IOW, the user is shooting in the foot --- and at that point I am not all
> that interested in helping him.

What with? What's wrong with a name like "M*A*S*H" in your personal IMDB?

> Having said that, I would think that quoting the meta from fnmatch(3)
> like this:
> 
> 	git ls-files 'such-\*-a-file'
> 
> would work fine, just like
> 
> 	ls such-\*-a-file
> 
> would.

An existing system will still be broken.

> If "ls such-*-a-file" reports only one file,
> 
> 	git ls-files 'such-*-a-file'
> 
> would also report that file as well.
> 
> So in practice I do not see a problem.

I think I do. There is NO way to pass the filenames to git plumbing
(only the diff-, or is git update-index --stdin -z also subject to
glob expansion?) without being sure they are exactly they were on
filesystem. Quoting is just PITA for scripting.
