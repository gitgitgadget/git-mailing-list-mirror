From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 17:52:45 -0400
Message-ID: <20070527215245.GD28023@spearce.org>
References: <20070526052419.GA11957@spearce.org> <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net> <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com> <20070527033429.GY28023@spearce.org> <alpine.LFD.0.99.0705271110550.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun May 27 23:53:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsQfc-00077q-7t
	for gcvg-git@gmane.org; Sun, 27 May 2007 23:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824AbXE0Vww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 17:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757446AbXE0Vww
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 17:52:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58095 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbXE0Vwv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 17:52:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HsQfG-0005sR-Ij; Sun, 27 May 2007 17:52:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C2DD620FBAE; Sun, 27 May 2007 17:52:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0705271110550.3366@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48585>

Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 26 May 2007, Shawn O. Pearce wrote:
> 
> > Dana How <danahow@gmail.com> wrote:
> > > Shawn:  When I first saw the index-loading code,  my first
> > > thought was that all the index tables should be
> > > merged (easy since sorted) so callers only need to do one search.
> 
> There is also the question of memory footprint.  If you have a global 
> index, then for each object you need to have a tupple containing SHA1 + 
> pack offset + reference to corresponding pack.  Right now we only need 
> SHA1 + pack offset.

I'm about half-way through a super-index implementation.  Right now
the super-index is defined to be just one index file per repository
(objects/pack/super.index) with a format that looks like the
following:

  header:
    uint32_t sdx_signature ('PSDX')
    uint32_t sdx_version (1)
    uint16_t sdx_packs
    uint8_t  sdx_prefix_len;
    uint8_t  __reserved;

  pack table:
    /* SHA-1 of each pack's sorted SHA-1 object list */
    unsigned char pack_sha1[20][sdx_packs];

  fan-out table:
    /* This is the standard fan-out also used in a tOc/.idx */
    uint32_t fan_out[256];

  records:
    unsigned char prefix[hdr.sdx_prefix_len - 1];
    int8_t        splits[hdr.sdx_packs];

  trailer:
    unsigned char sha1_of_the_above[20];

I build the super-index by merging the .idx of all available
packfiles; since they are already sorted the merge is obviously
quite trivial.

The sdx_prefix_len field is initialized to something that gives a
reasonably unique object name; e.g. in git.git an sdx_prefix_len
of 3 or 4 gets pretty good at narrowing the set of objects down
very small.  The idea here is that the sdx_prefix_len should be
almost the unique abbreviation length for this repository.

We store 1 less byte of the prefix in the record because of the
fan-out table already accounting for the first byte of the prefix.

The splits array contains a single signed integer for each packfile;
if the integer is 0 then that packfile does not contain any object
that starts with that corresponding prefix.  In such a case we
can completely avoid looking at that corresponding packfile.
With my lazy index loading change, I may not even need to open
that index.  ;-)

If the splits array entry is non-zero and is negative, its the number
of times we need to halve down (towards 'lo') to get to entries
that start with this prefix and that are in that packfile's fan-out
table entry range.  If its positive its the number of times we have
to halve up (towards 'hi').  This way we can jump more directly to
the relevant index records and avoid redoing binary search work we
have already accomplished in the super index.

So we can generally build super index records at a cost of 3 or
4 bytes + sdx_packs.  We can also determine which packfile(s) we
need to scan quite quickly, and we can jump further into the part
of the index avoiding a number of expensive hashcmp() calls.  It
may actually be a good savings at runtime, well worth the slightly
higher memory footprint.

My testing is not yet complete, so I cannot offer any hard numbers
against any interesting/common data sets...
 
> BTW I think the Newton-Raphson based index lookup approach should be 
> revived at some point.

That doesn't help with 10 packfiles though, does it?

-- 
Shawn.
