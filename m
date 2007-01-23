From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 12:32:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org>
 <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17846.20498.635623.173653@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mark Nudelman <markn@greenwoodsoftware.com>
X-From: git-owner@vger.kernel.org Tue Jan 23 21:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9SKN-0006Di-Pu
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 21:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbXAWUdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 15:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933131AbXAWUdF
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 15:33:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53531 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933116AbXAWUdC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 15:33:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0NKWJpa016877
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Jan 2007 12:32:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0NKWIj8030506;
	Tue, 23 Jan 2007 12:32:18 -0800
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17846.20498.635623.173653@lisa.zopyra.com>
X-Spam-Status: No, hits=-1.175 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.171 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37568>


[ Added "less" author Mark Nudelman to Cc: ]

On Tue, 23 Jan 2007, Bill Lear wrote:
> 
> I can't seem to get this to work, no matter what I do, using the
> latest 1.5.0-rc2 code.  I have the environment variables LESS, PAGER,
> PAGER_FLAGS, and I can't seem to get 'git diff' to not plough through
> my screen each time it is run, no matter the combinations...  Could
> someone post the magic?

I think "less" is actually seriously buggy with -F.

There are two bugs:

 - it will always screw up the screen and move to the end. It does this 
   even if you use -FX which should disable any init sequences, so it's 
   not about that problem.

 - if you resize the terminal while less is waiting for input, less
   will exit entirely without even showing the output. This is very
   noticeable if you do something like "git diff" on a big and cold-cache 
   tree and git takes a few seconds to think, and then you resize the 
   window while it's preparing. Boom. No output AT ALL.

Both bugs are easily seen with this simple command line

	clear ; (sleep 5 ; echo Hello) | less -F

where you would EXPECT that the "Hello" would show up at the first line of 
the screen (since we cleared the screen and moved to the top left corner), 
but in fact it doesn't.

And try resizing the terminal to make it bigger during the five-second 
pause, and now you'll see less not show the "Hello" at _all_. It's just 
gone (this is true even if the output was _more_ than a screen: try with

	(sleep 10 ; yes ) | less -F

and resize the screen, and it will exit silently after 10 seconds - never 
showing any output at all! Even though the output is obviously bigger than 
a screen..

Tested with Kterm, gnome-terminal and xterm. They all behave the same for 
me.

I don't know exactly what the bug is, but I find the "eof" handling very
confusing in the less sources. It makes me suspect that there is something 
that gets confused by the partial read, sets EOF (since we're on the last 
line), and then thinks that it should quit, since EOF is set.

I dunno. Mark?

		Linus
