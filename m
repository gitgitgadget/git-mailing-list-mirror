X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Computing delta sizes in pack files
Date: Sat, 25 Nov 2006 02:33:38 -0500
Message-ID: <20061125073338.GF4528@spearce.org>
References: <20061121053942.GA3149@spearce.org> <2c6b72b30611220844t4b341284q4bff914b91eac48d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 07:34:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <2c6b72b30611220844t4b341284q4bff914b91eac48d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32263>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gns2u-0000C7-19 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 08:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757263AbWKYHdo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 02:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757874AbWKYHdo
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 02:33:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:12720 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757263AbWKYHdn
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 02:33:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gns2e-0004Wo-TB; Sat, 25 Nov 2006 02:33:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 027E920FB09; Sat, 25 Nov 2006 02:33:38 -0500 (EST)
To: Jonas Fonseca <jonas.fonseca@gmail.com>
Sender: git-owner@vger.kernel.org

Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> I will not post the numbers here. They are available in
> http://jonas.nitro.dk/tmp/stats.pdf for those interested. The following
> is my "analysis" of the numbers.

Thanks, this was interesting stuff.

> As expected, the randomness of the content of both commit and tag objects
> results in a very poor packing performance of only 2%.

This is one reason why Jon Smirl was pushing the idea of dictionary based
compression.  git.git has only 276 unique author lines, yet 37 of them
are really the top committers.  Not surprisingly Junio C Hamano leads
the pack with 3529+ commits...  :-)

A dictionary based compression would allow us to easily compress
Junio's authorship line away from those 3529+ commits into a single
string, getting much better compression on the commits.

In trees this may work very well too for very common file names, e.g.
"Makefile".  Yes each tree delta compresses very well against its
base (and likely copies the file name from the base even when the
SHA1 changed) but if the bases were able to use a common dictionary
that would help even more.
 
> The data show that for minimal index files, the packs need to contain
> more than 2500 objects. The 24 bytes per-object for the optimal case
> includes 20-bytes for the object SHA1, and thus cannot be expected to
> become lower.

This is just a fundamental property of the pack index file format.
The file *MUST* be 1064 bytes of fixed overhead, with 24 bytes of
data per object indexed.  So the fixed overhead amortizes very
quickly over the individual object entries, at which point its
exactly 24 bytes per entry.  This all of course assumes a 32 bit
index (which is the current format).

The thing is the Mozilla index is 44 MiB.  That's roughly 1.9 million
objects.  The index itself is larger than the entire git.git pack.
On a large repository the index ain't trivial...  yet its essential
to performance!

On the other hand the 1064 bytes of fixed overhead in the index
is nothing compared to the overhead in say an RCS file.  Or an
SVN repository...  :-)

What I failed to point out in my script (or in my email) is that
the 24 bytes of index entry cannot be eliminated, and thus must
be added to the "revision cost".  In some cases its about the same
size as the deltafied revision in the pack file.  :-(

-- 
