From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Mon, 21 May 2007 23:52:51 -0700
Message-ID: <7vtzu58i4c.fsf@assigned-by-dhcp.cox.net>
References: <46528A48.9050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 08:53:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqOEs-0000YF-KF
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbXEVGwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758040AbXEVGwx
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:52:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56210 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757430AbXEVGww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:52:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070522065252.HUFK15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 22 May 2007 02:52:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 26sr1X0081kojtg0000000; Tue, 22 May 2007 02:52:51 -0400
In-Reply-To: <46528A48.9050903@gmail.com> (Dana How's message of "Mon, 21 May
	2007 23:14:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48080>

Dana How <danahow@gmail.com> writes:

> Using fast-import and repack with the max-pack-size patch,
> 3628 commits were imported from Perforce comprising
> 100.35GB (uncompressed) in 38829 blobs,  and saved in
> 7 packfiles of 12.5GB total (--window=0 and --depth=0 were
> used due to runtime limits).  When using these packfiles,
> several git commands showed very large process sizes,
> and some slowdowns (compared to comparable operations
> on the linux kernel repo) were also apparent.
>
> git stores data in loose blobs or in packfiles.  The former
> has essentially now become an exception mechanism,  to store
> exceptionally *young* blobs.  Why not use this to store
> exceptionally *large* blobs as well?  This allows us to
> re-use all the "exception" machinery with only a small change.

Well, I had an impression that mmapping a single loose object
(and then munmapping it after done) would be more expensive than
mmapping a whole pack and accessing that object through window,
as long as you touch the same set of objects and the object in
the pack is not deltified.

> Repacking the entire repository with a max-blob-size of 256KB
> resulted in a single 13.1MB packfile,  as well as 2853 loose
> objects totaling 15.4GB compressed and 100.08GB uncompressed,
> 11 files per objects/xx directory on average.  All was created
> in half the runtime of the previous yet with standard
> --window=10 and --depth=50 parameters.  The data in the
> packfile was 270MB uncompressed in 35976 blobs.  Operations
> such as "git-log --pretty=oneline" were about 30X faster
> on a cold cache and 2 to 3X faster otherwise.  Process sizes
> remained reasonable.

I think more reasonable comparison to figure out what is really
going on would be to create such a pack with the same 0/0 window
and depth (i.e. "keeping the huge objects out of the pack" would
be the only difference with the "horrible" case).  With huge
packs, I wouldn't be surprised if seeking to extract base object
from a far away part of a packfile takes a lot longer than
reading delta and applying the delta to base object that is kept
in the in-core delta base cache.

Also if you mean by "process size" the total VM size, not RSS, I
think it is a wrong measure.  As long as you do not touch the
rest of the pack, even if you mmap a huge packfile, you would
not bring that much data actually into your main memory, would
you?  Well, assuming that your mmap() implementation and virtual
memory subsystem does a descent job... maybe we are spoiled by
Linux here...
