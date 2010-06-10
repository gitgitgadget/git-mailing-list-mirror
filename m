From: Brian Downing <bdowning@lavos.net>
Subject: Serious performance regression in diff between 1.6.6 and 1.7.0
Date: Wed, 9 Jun 2010 19:10:05 -0500
Message-ID: <20100610001005.GA2635@glaurung.lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 02:16:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMVRF-0007qf-5E
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 02:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703Ab0FJAP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 20:15:59 -0400
Received: from glaurung.lavos.net ([69.162.133.92]:34007 "EHLO
	glaurung.lavos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033Ab0FJAP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 20:15:58 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2010 20:15:58 EDT
Received: by glaurung.lavos.net (Postfix, from userid 1000)
	id 951097417D; Wed,  9 Jun 2010 19:10:05 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148826>

I've stumbled across a pretty serious performance regression in "git
diff" for a large (187456 files checked out on HEAD) repository of mine.

I bisected it and the first slow commit is:
commit 730f72840cc50c523fe4cdd796ea2d2fc4571a28
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Sep 20 00:03:39 2009 -0700

    unpack-trees.c: look ahead in the index

    This makes the traversal of index be in sync with the tree traversal.
    When unpack_callback() is fed a set of tree entries from trees, it
    inspects the name of the entry and checks if the an index entry with
    the same name could be hiding behind the current index entry, and

    ...

It is more than 10x worse for my case here:

before 730f72840cc50c523fe4cdd796ea2d2fc4571a28:
:; /usr/bin/time ~/src/git/git-diff HEAD >/dev/null
0.30user 0.50system 0:00.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+30119minor)pagefaults 0swaps

730f72840cc50c523fe4cdd796ea2d2fc4571a28:
:; /usr/bin/time ~/src/git/git-diff HEAD >/dev/null
5.58user 0.40system 0:05.98elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+30117minor)pagefaults 0swaps

Unfortunately this pushes everyday use past my pain threshold for this
repository.  (As a sidenote, it's amazing how much Git has adjusted my
pain threshold since the days of CVS!)

Is there any chance of algorithmic improvements to this fix to gain some
of this speed back, or am I stuck with this when using newer Git?

-bcd
