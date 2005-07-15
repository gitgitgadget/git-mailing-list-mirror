From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch/pull: support Cogito-style remote branch information.
Date: Fri, 15 Jul 2005 16:12:03 -0700
Message-ID: <7v64vbpsu4.fsf@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
	<7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 01:12:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtZLt-0006bw-6P
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 01:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVGOXMH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 19:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVGOXMH
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 19:12:07 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:29648 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262020AbVGOXMG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 19:12:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050715231205.JEIZ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Jul 2005 19:12:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507151529590.19183@g5.osdl.org> (Linus Torvalds's message of "Fri, 15 Jul 2005 15:42:42 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

>  - I actually prefer code and documentation to be separated. ...
>    first the actual change, then the docs updates.

Understood.

>  - I'd much rather have a generic "address rewriting layer" than a "-b" 
>    flag.
>
>    I don't mind the shorthand at all, but I don't think it should be that
>    special. It's not "worthy" of a flag - if you have a shorthand that 
>    says "linus == rsync://kernel.org/pub/scm/git/git.git", then I think it 
>    should just work, and 
>
> 	git pull linus
>
>    should end up not needing a "-b" flag. It's not like there is any 
>    real ambiguity.

That makes sense.  Naturally,

	git pull linus experimental
        git pull linus tag v2.6.13

should expand to:

       git pull rsync://kernel.org/pub/scm/git/git.git/ experimental
       git pull rsync://kernel.org/pub/scm/git/git.git/ tag v2.6.13

If a user is usually interested in e100 driver work, we should
allow:

	echo rsync://kernel.org/pub/.../git/jgarzik/netdev-2.6.git#e100
	        >.git/branches/jgarzik-e100

and "git pull jgarzik-e100" should expand to:

	git pull rsync://kernel.org/pub/.../netdev-2.6.git/ e100

If the user says:

	git fetch jgarzik-e100 ieee80211-wifi

because the user wanted to peek his other branch just once, but
did not want to bother creating another remote reference
("jgarzik-wifi", perhaps) for this one-time use.  This should
expand to:

	git fetch rsync://kernel.org/pub/.../netdev-2.6.git/ ieee80211-wifi

> And it's not necessarily just the branch handling, but more of a generic
> shorthand: I'd love to be able to mix something like
>
> 	git pull jgarzik/misc-2.6 upstream
>
> and "jgarzik" would be expanded (through something like .git/branches) to 
> "master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/"), resulting in the 
> _full_ path being expanded to
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6 upstream

Nice, and sounds doable without too much ambiguities.  This last
one, however, needs to be coordinated with Pasky, if we want to
use .git/branches/$name convention.  I think Cogito would barf
with your partial URL that ends with "...git/jgarzik/".

I'll code something up.
