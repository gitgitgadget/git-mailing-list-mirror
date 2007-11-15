From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Odd .gitignore behaviour
Date: Thu, 15 Nov 2007 20:15:19 +0000
Message-ID: <80ir43e04o.fsf@tiny.isode.net>
References: <80ir431xny.fsf@tiny.isode.net>
            <alpine.LFD.0.9999.0711151044150.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 21:15:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isl7n-00031v-2Q
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 21:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760612AbXKOUP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 15:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757830AbXKOUP0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 15:15:26 -0500
Received: from rufus.isode.com ([62.3.217.251]:38991 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758652AbXKOUPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 15:15:25 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <Rzyo1wBBVIJK@rufus.isode.com>; Thu, 15 Nov 2007 20:15:21 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Thu, 15 Nov 2007 20:15:19 +0000
X-Hashcash: 1:20:071115:torvalds@linux-foundation.org::A5dRvJ+4P6NRgtNE:000000000000000000000000000000002Gdf
X-Hashcash: 1:20:071115:git@vger.kernel.org::wvT7eAqCWnj/j5+4:0000000000000000000000000000000000000000008koa
In-Reply-To: <alpine.LFD.0.9999.0711151044150.2786@woody.linux-foundation.org> (Linus Torvalds's message of "Thu\, 15 Nov 2007 10\:56\:27 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65155>

Linus Torvalds <torvalds@linux-foundation.org> writes:

[...]

> So what you describe sounds wrong.
>
> But my quick test didn't actually support the behaviour you see. In this 
> situation:
>
> 	[torvalds@woody git-test]$ cat .gitignore
> 	a*
> 	[torvalds@woody git-test]$ cat subdir/.gitignore
> 	!a-ok
> 	[torvalds@woody git-test]$ find *
> 	all-files
> 	subdir
> 	subdir/a-ok
> 	[torvalds@woody git-test]$ git ls-files -o --exclude-per-directory=.gitignore
> 	.gitignore
> 	subdir/.gitignore
> 	subdir/a-ok
>
> ie we *do* show "showdir/a-ok" (but we don't show "all-files") because 
> a-ok is explicitly marked to be not ignored by a higher-priority rule.

OK, and if I say "git add subdir/a-ok" I get no error, as expected.

So extend it just a tiny bit, moving a-ok down a directory and using
the negative pattern "!subsubdir/a-ok" to match:

    brs% cat .gitignore
    a*
    brs% cat subdir/.gitignore
    !subsubdir/a-ok
    brs% find *
    all-files
    subdir
    subdir/.gitignore
    subdir/subsubdir
    subdir/subsubdir/a-ok
    subdir/a-ok
    brs% git ls-files -o --exclude-per-directory=.gitignore
    .gitignore
    subdir/.gitignore
    subdir/subsubdir/a-ok
    brs% git add subdir/subsubdir/a-ok
    The following paths are ignored by one of your .gitignore files:
    subdir/subsubdir/a-ok
    Use -f if you really want to add them.
    fatal: no files added

So I think the output from git-ls-files is as expected (as I interpret
the manpage and your explanation).  So is git-add just using some
different code?

[...]
