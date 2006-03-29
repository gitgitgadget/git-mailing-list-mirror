From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Tue, 28 Mar 2006 18:26:00 -0800
Message-ID: <7vmzfac7gn.fsf@assigned-by-dhcp.cox.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 04:26:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOQNr-0000Gb-TR
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 04:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWC2C0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 21:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWC2C0E
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 21:26:04 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59842 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750782AbWC2C0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 21:26:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329022601.NWOK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 21:26:01 -0500
To: Matt McCutchen <hashproduct@verizon.net>
In-Reply-To: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net> (Matt
	McCutchen's message of "Tue, 28 Mar 2006 20:43:42 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18156>

Matt McCutchen <hashproduct@verizon.net> writes:

> I made a customized Linux kernel based on 2.6.15.6 by cloning the stable
> 2.6.15 kernel repository (which was then at version 2.6.15.6) and making
> several commits.  Now I would like a Linux kernel based on 2.6.16 with
> the same customizations.

Drawing ancestry graph would help visualizing what you want to
achieve.  You have:

       v2.6.15
    ---o
        \ 
         \
          \                 
           o---o---o v2.6.15.6
                    \
                     x---x---x v2.6.15.6-matt

where x---x---x are your own changes, and you want:

       v2.6.15           v2.6.16
    ---o---o---o---...---o---o
        \                     \
         \                     y---y---y 2.6.16-matt
          \                 
           o---o---o v2.6.15.6
                    \
                     x---x---x 2.6.15.6-matt

to happen, where y---y---y are analogous to x---x---x.

Assuming your branches are:

        origin - v2.6.15.6 (from stable team)
        master - your changes (2.6.15.6-matt)

you could:

        $ git fetch git://../torvalds/linux-2.6.git tag v2.6.16
        $ git checkout -b 2.6.16-matt v2.6.16
        $ git format-patch origin master | git am -3

Alternatively, you might want to do a real merge:

       v2.6.15           v2.6.16
    ---o---o---o---...---o---o
        \                     \
         \                     \ 
          \                     m 2.6.16-matt
           o---o---o v2.6.15.6 /
                    \         /
                     x---x---x 2.6.15.6-matt

Presumably the stable team backported safer changes from the
history between v2.6.15-v2.6.16, and the way things are fixed
are probably quite different from the equivalent fixes in the
development track that led to v2.6.16 (because what's being
patched has also changed), so it is very likely you would see
serious conflicts during this merge.  If you do not understand
what the stable team did in order to reimplement certain fixes,
you would have a very difficult time deciding on how to resolve
conflicts with this merge.

At that point it would not be a git question but the kernel
question I am not qualified to answer ;-), but it might be an
interesting exercise.
