From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 1/2] Use remote information in .git/config
Date: Mon, 21 Nov 2005 11:29:44 -0800
Message-ID: <7v4q65sst3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511211452470.13775@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 20:32:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeHMf-0006EF-3y
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVKUT3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVKUT3q
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:29:46 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46514 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932189AbVKUT3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 14:29:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121192908.JGPW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 14:29:08 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12472>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch allows to store shortcuts for fetch/pull into the config:
>
> 	[remote.junio]
> 		url = http://www.kernel.org/pub/scm/git/git.git
> 		pull = master:junio
> 		pull = todo:todo
> 		pull = +pu:pu
>
> Note that there is only one pair per "pull" line, to allow for spaces
> (urgh!) in the branch names.

I think "allow for spaces" nonsense can be removed by now.  I
did it initially that way before making the ref name validation
tighter with check-ref-format.  And if I understand what you
wrote about multivalues correctly, your intent is that "orders
do not matter"; with pull refspecs, orders do matter, so it
probably is a good idea to allow only a single line.

Personally I do not mind moving remotes/branches information
there, except that I suspect the git-config-set interface makes
it cumbersome to (1) find out what remotes I defined (i.e. an
equivalent of "ls .git/remotes") and (2) remove a single remote
when I do not want it anymore (--unset-all would remove the keys
but would leave the empty section).

I am unsure if putting everything in .git/config file is the
right approach, though.  What will we put there next?  ls-files
ignore patterns?  grafts?  alternates?  We should be able to
even get rid of .git/refs directory hierarchy and replace that
with something like this:

	[refs]
        	head = ABCD1234ABCD1234ABCD1234ABCD1234ABCD1234	for master
        	head = ABCD1234ABCD1234ABCD1234ABCD1234ABCD1234	for pu
		tag = ABCD1234ABCD1234ABCD1234ABCD1234ABCD1234 for v1.0rc1
	...

Where will we stop, and why?

I am worried about people later asking "why do we have X in
config but not Y"?
