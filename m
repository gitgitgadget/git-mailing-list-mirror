From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 17:14:02 -0800
Message-ID: <7virsf7lb9.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	<cda58cb80601170932o6f955469y@mail.gmail.com>
	<7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 02:14:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezkqy-0001X9-Dz
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 02:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbWATBOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 20:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWATBOF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 20:14:05 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:14756 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030450AbWATBOE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 20:14:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120011150.OGCW26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 20:11:50 -0500
To: Franck <vagabon.xyz@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14948>

Junio C Hamano <junkio@cox.net> writes:

> It _might_ work if you tell your downloader to have a proper
> graft file in his repository to cauterize the commit ancestry
> chain _before_ he pulls from you, though.  I haven't tried it
> (and honestly I did not feel that is something important to
> support, so it might work by accident but that is not by
> design).

I just tried it and it actually works.

	$ git clone git.git junk
        $ cd junk ;# I am not brave enough to risk the real thing ;-)
	$ git rev-parse master~4 >.git/refs/info/grafts
        $ cd ..
        $ mkdir cloned
        $ cd cloned
        $ git init-db
        $ cp ../junk/.git/info/grafts .git/info/
	$ git clone-pack ../baz
	$ git fsck-objects --full
	$ git log --pretty=short | cat

This "only the tip of the git.git" repository has about 450
objects in it, fully packed because of clone-pack, with one 680K
packfile.  I think the true full history of git.git/ packed into
one is aruond a 5MB packfile.  I suspect a bigger repository
would not see that much size reduction, as Linus already
explained here.

You could emulate what I just did above to prepare the
equivalent of "baz" above, and make it available over git://
protocol, say at git://franck.example.com/franck.git/.

Then you tell your downloaders something like this:

	This repository has been cauterized, and cannot be
	cloned in a usual manner, but once you make a clone
	everything including further incremental updates should
	work.

        To clone this repository:

		$ mkdir franckproject ;# make a new repository
		$ cd franckproject && git init-db
		$ echo 'XXxxxxXXxxx' >.git/info/grafts
		$ git clone-pack git://franck.example.com/franck.git/
