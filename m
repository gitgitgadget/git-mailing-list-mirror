From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 02:16:11 -0400
Message-ID: <20070904061611.GY18160@spearce.org>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com> <20070904025153.GS18160@spearce.org> <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com> <e1dab3980709032119r381f7a91ia84ba09039c21be1@mail.gmail.com> <9e4733910709032252x1fe6f436wdd13bcb1a6f76636@mail.gmail.com> <46DCF361.2090402@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Smirl <jonsmirl@gmail.com>,
	David Tweed <david.tweed@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 08:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRi2-0005oO-Gh
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 08:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXIDGQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 02:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbXIDGQT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 02:16:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35581 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbXIDGQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 02:16:18 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ISRht-0004V6-BO; Tue, 04 Sep 2007 02:16:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 09B8020FBAE; Tue,  4 Sep 2007 02:16:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46DCF361.2090402@op5.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57531>

Andreas Ericsson <ae@op5.se> wrote:
> Jon Smirl wrote:
> >On 9/4/07, David Tweed <david.tweed@gmail.com> wrote:
> >>On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> >>>Git has picked up the hierarchical storage scheme since it was built
> >>>on a hierarchical file system.
...
> >>One of the nice things about tree nodes is that for doing a diff
> >>between versions you can, to overwhelming probability, decide
> >>equality/inequality of two arbitrarily deep and complicated subtrees
> >>by comparing 40 characters, regardless of how remote and convoluted
> >>their common ancestry. With delta chains don't you end up having to
> >>trace back to a common "entry" in the history? (Of course, I don't
> >>know how packs affect this - presumably there's some delta chasing to
> >>get to the bare objects as well.)
> >
> >While it is a 40 character compare, how many disk accesses were needed
> >to get those two SHAs into memory?
> 
> One more than there would have been to read only the commit, and one more
> per level of recursion, assuming you never ever pack your repository.
> 
> If you *do* pack it, the tree(s) needed to compare are likely already
> inside the sliding packfile window. In that case, there are no extra
> disk accesses.

Even better, lets do some back of the napkin math on the Linux
kernel tree.  My local (out of date but close enough) copy has
22,730 files in the tip revision.  Values shown are uncompressed
and compressed (gzip -9 | wc -c), but are excluding deltification.

                 Current Scheme       Jon's Flat Scheme
                 -----------------    -----------------
commit raw       932                  932 + 22,730*20 = 455,532
(compressed)     521                  456,338

root tree raw    876                  0
(compressed)     805                  0

I'm not even bothering with the individual subtrees.  The numbers
will fall off quickly when you start to do subtree elimination and
only load the levels you need.

You are talking about doing disk IO for less than 4KiB with
the current scheme, and almost 456 KiB for the flat scheme.
That's before deltification.  So if you also assume deltification
its going to be higher as you need to read back to a base object
that is roughly the final size and then unpack the smaller deltas
to reach the real commit.

Remember, SHA-1s can be stored as 20 bytes of binary data but they
are also generally uncompressible.  That's why the root tree does
not compress very well, the SHA-1 data inside the tree cannot be
compressed and only the filenames have any shot at being compressed.

-- 
Shawn.
