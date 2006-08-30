From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Tue, 29 Aug 2006 23:10:29 -0400
Message-ID: <20060830031029.GA23967@spearce.org>
References: <20060829165811.GB21729@spearce.org> <9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com> <20060829175819.GE21729@spearce.org> <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com> <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com> <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com> <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 05:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIGTO-0002Bf-Eh
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 05:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWH3DKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 23:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWH3DKe
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 23:10:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:28356 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751335AbWH3DKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 23:10:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GIGT5-0008HL-5b; Tue, 29 Aug 2006 23:10:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A997220FB7F; Tue, 29 Aug 2006 23:10:29 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26221>

Jon Smirl <jonsmirl@gmail.com> wrote:
> sha1s are effectively 20 byte pointer addresses into the pack. With 2M
> objects you can easily get away with 4 byte address and a mapping
> table. Another idea would be to replace the 20 byte sha1 in tree
> objects with 32b file offsets - requiring that anything the tree
> refers to has to already be in the pack before the tree entry can be
> written.

I've thought of that, but when you transfer a "thin" pack over the
wire the base object may not even be in the pack.  Thus you can't
use an offset to reference it.  Otherwise there's probably little
reason why the base couldn't be referenced by its 4 byte offset
rather than its full 20 byte object ID.  Added up over all deltas
in the mozilla pack it saves a whopping 23 MiB.

> The Mozilla license has changed at least five times. That makes 250K
> copies of licenses.

Cute.
 
> I suspect a tree specific zlib dictionary will be a good win.  But
> those trees contain a lot of uncompressible data, the sha1. Those
> sha1s are in binary not hex, right?

Yup, binary.
 
> The git tools can be modified to set the compression level to 0 before
> compressing tree deltas. There is no need to change the decoding code.
> Even with compression level 0 they still get slightly larger because
> zlib tacks on a header.

See my followup email to myself; I think we're talking a zlib
overhead of 9.2 bytes on average per tree delta.  That's with a
compression level of -1 (default, which is 6).
 
> I'm still interested in getting an idea of how much a Clucene type
> dictionary compression would help. It is hard to see how you can get
> smaller than that method. Note that you don't want to include the
> indexing portion of Clucene in the comparison. Just the part where
> everything gets tokenized into a big dictionary, arithmetic encoded
> based on usage frequency, and then the strings in the orginal
> documents are replaced with the codes. You want to do the diffs before
> replacing everything with codes. Encoding this way is a two pass
> process so it is easiest to work from an existing pack.

>From what I was able to gather I don't think Clucene stores the
documents themselves as the tokenized compressed data.  Or if it
does you lose everything between the tokens.  There's a number of
things we want to preserve in the original "document" like whitespace
that would be likely stripped when constructing tokens.

But it shouldn't be that difficult to produce a rough estimate of
what that storage size would be.
 
-- 
Shawn.
