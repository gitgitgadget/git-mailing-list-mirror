From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 23:11:43 +0200
Message-ID: <20070111211143.GG17999@mellanox.co.il>
References: <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57Cw-0002e6-JR
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbXAKVLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXAKVLb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:11:31 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:51385 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbXAKVLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 16:11:30 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o143.mxlogic.net)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id 208a6a54.2704460720.6362.00-501.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 11 Jan 2007 14:11:30 -0700 (MST)
Received: from unknown [194.90.237.34]
	by p02c11o143.mxlogic.net (mxl_mta-4.0.1-4)
	with SMTP id ff7a6a54.2599562160.6345.00-003.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 11 Jan 2007 14:11:27 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 11 Jan 2007 23:13:02 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 11 Jan 2007 23:09:58 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 11 Jan 2007 21:13:02.0314 (UTC) FILETIME=[4739ACA0:01C735C5]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14930.000
X-TM-AS-Result: No--10.776600-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36610>

> >
> > I hit a quota limit on a disk my tree was on, but did not notice.
> > Doing git pull on a tree seems to have corrupted it.
> > Now I have:
> > 
> > $ git-fsck-objects
> > error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
> > error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
> > missing tree 10147d79b2418168d9433067b6439971bd4f1261
> > broken link from  commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
> >               to    tree 10147d79b2418168d9433067b6439971bd4f1261
> > dangling commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
> > 
> > The tree can not be pulled into, or from.
> 
> That's nasty, but something as simple a "git reset --hard ORIG_HEAD" 
> should fix it (of course, if the disk-full happened earlier, or you've 
> done some other reset or something else that over-write your ORIG_HEAD, 
> you'd need to find the most recent commit that wasn't broken).
> 
> The good news is that there's no way your old data got corrupted. You just 
> need to _find_ it (and normally ORIG_HEAD points to it, so it's trivial to 
> find).

I did lots of resets and they did not seems to help.

Then, on a hunch, I just did git prune and
it cleaned the tree so I can pull/push fine.

How come?

mst@mst-lt:~/tmp/libmthca_bad$ git --version
git version 1.5.0.rc0.g244a7
mst@mst-lt:~/tmp/libmthca_bad$ git pull ~/scm/libmthca/
remote: Generating pack...
remote: Done counting 18 objects.
Result has 11 objects.
remote: Deltifying 11 objects.
remote:  100% (11/11) done
remote: Total 11 (delta 8), reused 1 (delta 1)
Unpacking 11 objects
error: failed to read delta-pack base object 4d4d30be967d3284cbf59afd4fba6ab536e295f5
fatal: unpack-objects died with error code 1
Fetch failure: /home/mst/scm/libmthca/
mst@mst-lt:~/tmp/libmthca_bad$ git prune
mst@mst-lt:~/tmp/libmthca_bad$ git pull ~/scm/libmthca/
remote: Generating pack...
remote: Done counting 18 objects.
Result has 11 objects.
Deltifying 11 objects.
 10remote: 0% (11/11) done
Total 11 (delta 8), reused 1 (delta 1)
Unpacking 11 objects
 100% (11/11) done
Updating 732a507..322a6c9
Fast forward
 Makefile.am      |   25 +++++++++++++++++--------
 configure.in     |   16 ++++++++++++++--
 debian/changelog |    4 +---
 mthca.driver     |    1 +
 src/mthca.c      |   23 ++++++++++++-----------
 5 files changed, 45 insertions(+), 24 deletions(-)
 create mode 100644 mthca.driver

So it seems the tree was more or less fine (it just has some useless objects
because of the disk full failure), the bug seems to be that pull/push fail.

I made a backup of the bad tree so that if someone wants to play with it, here it is:
http://www.openfabrics.org/~mst/libmthca_bad.tgz

-- 
MST
