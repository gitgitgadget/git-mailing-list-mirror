From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pack-objects: cache small deltas between big objects
Date: Tue, 22 May 2007 01:04:26 -0700
Message-ID: <7vhcq58et1.fsf@assigned-by-dhcp.cox.net>
References: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at>
	<56b7f5510705202135s8c9cd9qf4489b2b5bb2e264@mail.gmail.com>
	<20070521175950.GA13818@auto.tuwien.ac.at>
	<56b7f5510705220001q78b42d08kffd95d25c0af478e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 10:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqPM8-00041D-94
	for gcvg-git@gmane.org; Tue, 22 May 2007 10:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbXEVIE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 04:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755359AbXEVIE3
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 04:04:29 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60957 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbXEVIE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 04:04:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070522080426.FFXY13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 22 May 2007 04:04:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 284S1X0041kojtg0000000; Tue, 22 May 2007 04:04:26 -0400
In-Reply-To: <56b7f5510705220001q78b42d08kffd95d25c0af478e@mail.gmail.com>
	(Dana How's message of "Tue, 22 May 2007 00:01:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48085>

"Dana How" <danahow@gmail.com> writes:

> If I simply refuse to insert enormous blobs in the packfiles,  and keep
> them loose,  the performance is better.  More importantly,  my packfiles
> are now sized like everyone else's, so I'm in an operating regime which
> everyone is testing and optimizing.  This was not true with 12GB+ of packfiles.
> Of course, loose objects are slower, but slight extra overhead to access
> something large enough to be noticeable already doesn't bother me.
>
> Finally, loose objects don't get deltified.  This is a problem,  but I would
> need to repack at least every week,  and nonzero window/depth would
> be prohibitive with large objects included.

Here are a few quick comments before going to bed.

 * The objects in the packfile are ordered in "recency" order,
   as "rev-list --objects" feeds you, so it is correct that we
   get trees and blobs mixed.  It might be an interesting
   experiment, especially with a repository without huge blobs,
   to see how much improvement we might get if we keep the
   recency order _but_ emit tags, commits, trees, and then
   blobs, in this order.  In write_pack_file() we have a single
   loop to call write_one(), but we could make it a nested loop
   that writes only objects of each type.

 * Also my earlier "nodelta" attribute thing would be worth
   trying with your repository with huge blobs, with the above
   "group by object type" with further tweak to write blobs
   without "nodelta" marker first and then finally blobs with
   "nodelta" marker.

I suspect the above two should help "git log" and "git log --
pathspec..."  performance, as these two do not look at blobs at
all (pathspec limiting does invoke diff machinery, but that is
only at the tree level).

The "I want to have packs with reasonable size as everybody
else" (which I think is a reasonable thing to want, but does not
have much technical meaning as other issues do) wish is
something we cannot _measure_ to judge pros and cons, but with
the above experiment, you could come up with three set of packs
such that, all three sets use "nodelta" to leave the huge blobs
undeltified, and use the default window and depth for others,
and:

 (1) One set has trees and blobs mixed;

 (2) Another set has trees and blobs grouped, but "nodelta" blobs
     and others are not separated;

 (3) The third set has trees and blobs grouped, and "nodelta"
     blobs and others are separated.

Comparing (1) and (2) would show how bad it is to have huge
blobs in between trees (which are presumably accessed more
often).  I suspect that comparing (2) and (3) would show that
for most workloads, the split is not worth it.

And compare (3) with another case where you leave "nodelta"
blobs loose.  That's the true comparison that would demonstrate
why placing huge blobs in packs is bad and they should be left
loose.  I'm skeptical if there will be significant differences,
though.
