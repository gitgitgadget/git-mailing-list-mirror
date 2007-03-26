From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rm: don't remove newly added file without -f
Date: Mon, 26 Mar 2007 14:33:22 -0700
Message-ID: <7vslbrvgf1.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com>
	<20070326185539.GA1650@coredump.intra.peff.net>
	<7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703262314090.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:33:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVwoi-0003hh-3B
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 23:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbXCZVdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbXCZVdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 17:33:25 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54571 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbXCZVdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 17:33:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326213323.OZAS321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 17:33:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fZZN1W0091kojtg0000000; Mon, 26 Mar 2007 17:33:22 -0400
In-Reply-To: <Pine.LNX.4.63.0703262314090.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 26 Mar 2007 23:17:14 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43190>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 26 Mar 2007, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Given this set of commands:
>> >
>> >   $ echo "newly added file" >new
>> >   $ git add new
>> >   $ git rm new
>> >
>> > the file "new" was previously removed from the working
>> > directory and the index. Because it was not in HEAD, it is
>> > available only by searching for unreachable objects.
>> 
>> I am not sure if this is a problem, as the user asked it to be
>> removed.  It somehow feels to me that the change (I am not
>> convinced your patch should be called a "fix" rather than a
>> "behaviour change") would cause more confusion.
>
> I agree it would add to confusion.
>
> It is well established that "git rm" also removes the file _in the working 
> directory_.
>
> If you don't want the file to be deleted, but only the corresponding 
> entry _in the index_, use "git rm --cached".

Actually, thinking about it a bit more, I think Jeff's patch is
in line with the current behaviour.

Looking at the cases where we prevent 'git rm' without '-f'
succeeding currently, the motivation is to save the user from
mistakenly saying "remove" when the user earlier said "this
change matters in the next commit" to us.

For example, with "edit existing-file; git add existing-file",
the user said the new state of the file matters in the next
commit.  And we refuse to remove, saying "foo has changes
staged".

By saying "edit new-file; git add new-file", the user expressed
the intent to add that content to the upcoming commit.  Saying
"git rm" later is reverting that intent.  Jeff's patch does
exactly the same thing for new files what we already do for
existing ones --- we ask for a confirmation when "git rm" is
given for existing files that has staged changes, saying "you
earlier said you want changes to this file in the next commit.
are you sure you have changed your mind?"

Having said that, we do _not_ ask for confirmation when you do
"git add existing-file" after doing "edit ; git add", which is
theoretically inconsistent, but rm is special so that is
probably Ok.
