From: Junio C Hamano <junkio@cox.net>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 17:40:54 -0700
Message-ID: <7vsm097b6x.fsf@assigned-by-dhcp.cox.net>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
	<20050526004411.GA12360@vrfy.org>
	<Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>
	<20050526202712.GA6024@vrfy.org>
	<7vy8a18w1e.fsf@assigned-by-dhcp.cox.net>
	<20050526235944.GB6215@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 02:40:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbSsp-0006aF-56
	for gcvg-git@gmane.org; Fri, 27 May 2005 02:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVE0AlO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 20:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVE0AlN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 20:41:13 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61439 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261418AbVE0Ak5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 20:40:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527004055.XXEJ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 20:40:55 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050526235944.GB6215@vrfy.org> (Kay Sievers's message of
 "Fri, 27 May 2005 01:59:44 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

KS> I see what you mean, but allow to pass any charater through a cgi to a
KS> invoked shell as a command-line option is a nightmare without being very
KS> carful.

You are absolutely right that you must be careful.  But being
careful is not that hard.

I do not know what you are using to parse the data coming from
the browser (presumably application/x-www-form-urlencoded or
somesuch), but once you got the raw data out of it in a variable
in your host language (sorry I do not know what language you are
writing in, either), quoting that value safely for shell command
line is very simple and easy.  You can emulate what sq_expand()
in diff.c does.

Essentially you take advantage of single quote quoting which
lets you pass anything other than single quotes as literals, and
deal with single quotes by stepping out temporarily of the
single quote environment every time you see a single quote,
quote that single quote with a backslash, and immediately after
that you go back into single quote environment again and continue.

  original     sq_expand     result
  name     ==> name      ==> 'name'
  a b      ==> a b       ==> 'a b'
  a'b      ==> a'\''b    ==> 'a'\''b'

So in shell, using sed, you would do something like this:

------------
#!/bin/sh

orig="foo '"'\bar	b
az'

script="s/'/'\\\\\\''/g" ;# change (') to ('\'')

sq_inside=`echo "$orig" | sed "$script"`

echo "'$sq_inside'" ;# and enclose the whole thing in sq pair
------------

