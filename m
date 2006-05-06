From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2
Date: Sat, 06 May 2006 14:16:05 -0700
Message-ID: <7vvesirh0q.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605041627310.6713@iabervon.org>
	<Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
	<7vhd43vgnm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
	<BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE>
	<Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
	<BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE>
	<Pine.LNX.4.64.0605061008340.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sean <seanlkml@sympatico.ca>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 06 23:16:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcU8K-0001fb-1p
	for gcvg-git@gmane.org; Sat, 06 May 2006 23:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWEFVQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 17:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWEFVQI
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 17:16:08 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45742 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932075AbWEFVQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 17:16:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060506211606.EDNM27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 17:16:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605061008340.16343@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 6 May 2006 10:20:15 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19670>

Linus Torvalds <torvalds@osdl.org> writes:

> Finally, I think "git repo-config" is buggy. Try with this .config file:
> ...
> So we'd really be screwing with porcelain if we made them use this ;)

Thanks Linus and Sean for bringing this up and fixing it.

I have a vague feeling that this may not be the last breakage of
the repo-config command.  My first reaction to the repo-config
code was "eek".  It tries to reuse as much the existing material
as possible -- I understand it was done that way in order to
preserve the comments and blank lines from the original config
file intact, but it just felt very error prone (demonstrated by
cases like this and the other one Sean brought up) and generally
wrong.

It might make sense to rewrite it to parse and read the existing
configuration as a whole, do necessary manupulations on the
parsed internal representation in-core, and write the result out
from scratch.  That would fix another of my pet peeve: after an
invocation of repo-config to remove the last variable in a
section, it leaves an empty section header in.

        $ git repo-config foo.bar true
        $ cat .git/config 
        [core]
                repositoryformatversion = 0
                filemode = true
        [foo]
                bar = true
        $ git repo-config foo1.baz false
        $ git repo-config --unset foo.bar
        $ cat .git/config 
        [core]
                repositoryformatversion = 0
                filemode = true
        [foo]
        [foo1]
                baz = false
