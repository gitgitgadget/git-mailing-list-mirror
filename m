From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push over http is very dangerous
Date: Fri, 20 Apr 2007 18:03:15 -0700
Message-ID: <7vfy6uwncc.fsf@assigned-by-dhcp.cox.net>
References: <462394AC.303@beronet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian <crich-ml@beronet.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 03:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf40W-00035B-1F
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 03:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbXDUBDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 21:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbXDUBDR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 21:03:17 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46814 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbXDUBDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 21:03:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421010316.NDVZ1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 21:03:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pd3F1W0081kojtg0000000; Fri, 20 Apr 2007 21:03:15 -0400
In-Reply-To: <462394AC.303@beronet.com> (crich-ml@beronet.com's message of
	"Mon, 16 Apr 2007 17:22:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45141>

Christian <crich-ml@beronet.com> writes:

> We found out that it was broken, because we could not do a pull or
> clone from the central repository anymore, but we got an error message.
>
> Then i did a "git log" which worked well. then i wanted to "show" the
> last 2 commits, so i did: "git show":
>
> error: corrupt loose object 'cd1aac1a43cfdac07118240f75c0ba7662eb8140'
> <crich1999> error: cd1aac1a43cfdac07118240f75c0ba7662eb8140: object
> corrupt or missing

Thanks.  I extracted that "corrupt" object, but all the archived
versions of git I have at hand can read that tree just fine.

  $ ~/git-snap-v1.0.0/bin/git ls-tree cd1aac
  100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
  100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
  040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
  $ ~/git-snap-v1.2.0/bin/git ls-tree cd1aac
  100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
  100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
  040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
  $ ~/git-snap-v1.3.0/bin/git ls-tree cd1aac
  100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
  100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
  040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
  $ ~/git-snap-v1.5.0/bin/git ls-tree cd1aac
  100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
  100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
  040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
  $ ~/git-snap-v1.5.1/bin/git ls-tree cd1aac
  100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
  100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
  040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN
  $ git ls-tree cd1aac ;# this is 'next'
  100644 blob 660424785bb8deda22ae5055fae1b16c466bc602	Kconfig.v2.6
  100644 blob 29553e41ee8d0941b1c119a3fdd4fcb9fa8cc44b	Makefile.v2.6
  040000 tree 3ba0db3caae4263808c925a598d707aaf4f82d68	mISDN

I am starting to suspect that the loose object is actually Ok
and you are suffering from something else (perhaps zlib).

We had a brief period that we had a bogusly strict error check
after calling zlib, which Linus fixed with 456cdf and ac54c2
(these fixes are both in v1.5.1).  The breakage was 7efbff,
which was post v1.5.0.3 breakage, but was never been part of any
official release without the two fixes from Linus.

HOWEVER (I mentioned the above paragraph to save people from
going wild goose chase), this does not seem to be related to the
breakage.  I specifically built that revision and ls-tree from
it reads the loose object just fine.

There is only one codepath that can emit this error message:

> error: corrupt loose object 'cd1aac1a43cfdac07118240f75c0ba7662eb8140'

so I am reasonably sure that you are running 7efbff or later
version, but now I am out of ideas.

What version of git do you run?  And on what platform?
