From: Junio C Hamano <junkio@cox.net>
Subject: Re: x86 asm SHA1 (draft)
Date: Fri, 23 Jun 2006 17:18:33 -0700
Message-ID: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
References: <20060623171809.5689.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Jun 24 02:18:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtvrD-0003M3-7f
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 02:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFXASf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 20:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWFXASf
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 20:18:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:15550 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751090AbWFXASe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 20:18:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624001834.EVKK18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 20:18:34 -0400
To: git@vger.kernel.org
In-Reply-To: <20060623171809.5689.qmail@science.horizon.com>
	(linux@horizon.com's message of "23 Jun 2006 13:18:09 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22459>

The series to revamp SHA1 is good but judging the merit of each
is outside my expertise, so I'd appreciate help to evaluate
these changes.  For example, I cannot choose between competing
three implementations for ppc without having access to a variety
of ppc machines, and even if I did, ppc is not what I normally
use, so incentive to try picking the best one for everybody is
relatively low on my part.

What we would want are obviously (1) no regression, (2) an easy
way for people who build git for their own machine to decide
which one suits them the best, and (3) an easy way to tell the
build mechanism to use the one that is chosen.

The only external interface for the set of SHA1 implementation
alternatives to the outside world is a well established SHA_CTX
type, and three functions SHA1_Init(), SHA1_Update() and
SHA1_Final(), and the alternative implementations are supposed
to be drop-in replaceable.

So let's do something like this:

 - When adding a new SHA1 implementation, we need to come up
   with a Makefile symbol (similar to PPC_SHA1, MOZILLA_SHA1 and
   friends) and set up the build machinery to use the one that
   is chosen;

 - We need a test program and a build rule in the Makefile that
   links with the chosen SHA1 implementation.

 - We need a test script that feeds the above program with known
   vectors to validate the SHA1 implementation (make sure the
   test covers large input to avoid the recent half-gig-limit
   problem), and bench the speed on the platform it was built.

 - If we wanted to go fancier, another script that builds all
   applicable alternatives on the building platform, run the
   bench for all of them and automatically pick the right one
   for the platform would be a plus.

We probably would want to collect the benchmark results from
popular platforms, have a summary to help people to choose a
sensible one in the toplevel INSTALL file, and include the raw
numbers in Documentation/technical/sha1-implementations.txt.

Once we go the above path, we may want to include both of the
the two new ppc implementations as separate choices as I
understand their performance depends on which ppc you are
talking about.

Any takers?
