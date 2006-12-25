From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] git-add: add ignored files when asked explicitly.
Date: Mon, 25 Dec 2006 09:27:15 -0800
Message-ID: <7vslf3khsc.fsf@assigned-by-dhcp.cox.net>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 25 18:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gytbf-0002gy-83
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 18:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWLYR1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 12:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWLYR1R
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 12:27:17 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:53523 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbWLYR1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 12:27:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225172716.UIBL2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Dec 2006 12:27:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 35SY1W00P1kojtg0000000; Mon, 25 Dec 2006 12:26:33 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 25 Dec 2006 14:47:13 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35391>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 25 Dec 2006, Junio C Hamano wrote:
>
>>     $ git add foo.o
>>     $ git add '*.o'
>
> Most people do
>
> 	$ git add *.o
>
> instead, where bash expands the expression. Maybe this new behaviour 
> should be hidden between a "-f" option?

When would anybody do "git add *.o"?

A more plausible situation is that you have '*.o' in .gitignore
because you do not want to keep track of object files generated
from your source, but your project needs to keep track of one
third-party object file that you do not have the source to, and
helping that situation is what this patch is about.

An alternative is to use the mechanism I added here to _detect_
the attempt to add an ignored file with explicitly spelled out
pathspec, and issue an info message that says something like:

	Path 'xyzzy/filfre.o' is not being ignored by one of
	your .gitignore files.  If you really want to add it,
	please add this entry to .gitignore file:

        !/xyzzy/filfre.o

One advantage of this is that it would help guiding the user in
the right direction, giving a reusable piece of knowledge,
without changing the behaviour of the command (what is refused
is refused).  But I can already see people's complaints: if the
tool knows how to fix that situation why forces the user to do
so?

Although the reason why the alternative does not do so is "The
user earlier said *.o files are uninteresting but came back with
a conflicting request to add xyzzy/filfre.o, which could be a
mistake.  We ask for a confirmation", which is very sensible,
another alternative would be to add the path anyway and issue an
warning, like this:

	$ ls xyzzy
        filfre.c	filfre.o
	$ git add xyzzy/filfre.?
	added ignored path xyzzy/filfre.o
