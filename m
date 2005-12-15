From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Thu, 15 Dec 2005 15:38:07 -0800
Message-ID: <7vacf2lyn4.fsf@assigned-by-dhcp.cox.net>
References: <11344712912199-git-send-email-matlads@dsmagic.com>
	<7vy82p9rnb.fsf@assigned-by-dhcp.cox.net>
	<20051213170015.GD22159@pasky.or.cz>
	<7vu0dcalgo.fsf@assigned-by-dhcp.cox.net>
	<20051215222424.GA3094@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 00:39:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En2fw-0006RE-8j
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 00:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVLOXiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 18:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVLOXiN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 18:38:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10961 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751209AbVLOXiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 18:38:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215233730.SLCS3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 18:37:30 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13720>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Tue, Dec 13, 2005 19:41:27 +0100:
>> 
>> > Thank you both for the patch, but I'd be much more comfortable if at
>> > least quotes (both ' and "), backslashes, ? and * would be prohibited in
>> > the names as well.
>> 
>> I second that, and thanks for pointing it out.  Any objections?
>
> Just as a warning, perhaps? It's not like git is anywhere limited in
> this respect...

Yeah, after thinking about it a bit more, I changed my mind.

The wildcard letters like ? and * I understand and sympathetic
about somewhat.  Something like this:

        name="*.sh" ;# this also comes from the end user
        echo $name

ends up showing every shell script in the current directory,
and not literal '*.sh'.

However, I do not think covering five characters '"\?* gives us
anything, and sends a strong message that we do not know our
shell programming to whoever is reading our code.  For one
thing, the user can still say "foo[a-z]bar" to confuse you, so
you also need to forbid [].

The thing is, if you start to care about single and double
quotes, then what you are doing carelessly is not something
simple like this:

	name='frotz'\''nitfol"filfre\xyzzy' ;# this comes from the end user.
	echo $name ;# and this prints just fine.

For quotes to matter, you must be doing an "eval" carelessly,
and "eval" and careless should never go together.

        # do not try this in your repository without echo
	name="foo; echo rm -fr ."
        eval "git-rev-parse $name" 

You end up needing to forbid a lot more than the quoting and
wildcard, if you want to keep your shell scripts loose and lazy;
which may be a worthy goal in itself but pretty much defeats the
initial discussion of "why do we allow only these characters in
tags".

So in short, I am somewhat negative about the idea of adding
more "forbidden letters".  Let's make sure our scripts are
careful where safety matters.

Note that this does not forbid Porcelains to enforce additional
restrictions on their own.
