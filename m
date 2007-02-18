From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 17:03:23 -0800
Message-ID: <7vsld4p99g.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 02:03:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIaSl-0003qb-Fe
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992957AbXBRBDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 20:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXBRBDZ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:03:25 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:55995 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbXBRBDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:03:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218010323.GVFP22948.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 20:03:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qp3P1W0021kojtg0000000; Sat, 17 Feb 2007 20:03:23 -0500
In-Reply-To: <Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 18 Feb 2007 01:40:51 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40043>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 17 Feb 2007, Junio C Hamano wrote:
> ...
>> But I think Jeff is right.  It would make sense to let apply
>> and perhaps 'diff', if we can somehow merge 'diff2' into it,
>> still read from $HOME/.gitconfig if available.
>
> Yes, especially if you are soo used to colours as I grew to be used to 
> them. This was literally one of the reasons I wrote diff2 in the first 
> place. Another was --color-words.

True.  Paches welcome ;-).

> BTW any good ideas how to make diff fall back to diff2, so that no similar 
> case falls back to diff-index?
>
> I am really wondering if you can have a syntax which Does The Right Thing 
> at all times. Maybe we can teach diff that exactly two arguments, which 
> both exist in the filesystem, and at least one of them is not tracked, 
> then please use diff2? I wonder how often you do something like
>
> 	git diff object.c object-refs.c
>
> and how confusing it would be that it could mean two things, diff2 _and_ 
> diff-index?

I _think_ the case I would want to use diff2 are:

 (1) I am totally outside a git repository.

or

 (2) I am inside a git repository but I want to compare two
     specific managed files, say GIT-VERSION-GEN and
     git-gui/GIT-VERSION-GEN.

Now, (1) can be had by moving the RUN_SETUP bit out of entry for
"diff" in git.c, and do it only when we know we are in a repo
(maybe using "setup gently").  If we are outside of a
repository, any of the existing diff-* brothers do not make much
sense --- we can always do diff2.

For (2), I _think_ it may be useful sometimes but not very
often, so how about a specific option that you require upfront?

	git diff --fs --color-words GIT-VERSION-GEN git-gui/GIT-VERSION-GEN

I can do almost that with

	git diff --color-words :GIT-VERSION-GEN :git-gui/GIT-VERSION-GEN

but, it compares indexed ones, not from the working tree, so it
is not exactly the same.  However, the difference may not make
practical difference in this particular example, though.  When I
want to know the differences between two tracked files, it is
usually becausel I want to see if there are similarities to be
consolidated, and I would do that before starting to alter
working tree files.

Also, strictly speaking, there is third one:

 (3) I am inside a git repository but I want to compare files
     that do not have anything to do with the project I am
     currently working on:

	git diff --fs /etc/skel/profile $HOME/.profile

while I do not think this usage makes any sense, an explicit
flag upfront saves you from wondering what the user meant.
