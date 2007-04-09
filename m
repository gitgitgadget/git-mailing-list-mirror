From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 9 Apr 2007 13:38:58 -0400
Message-ID: <20070409173858.GT5436@spearce.org>
References: <46197950.3080804@gmail.com> <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704082012220.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 21:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Haxpn-0005H6-2e
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 19:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbXDIRjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 13:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXDIRjO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 13:39:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38666 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbXDIRjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 13:39:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HaxpN-0006cK-Jz; Mon, 09 Apr 2007 13:38:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CE0FF20FBAE; Mon,  9 Apr 2007 13:38:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704082012220.28181@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44062>

Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 8 Apr 2007, Junio C Hamano wrote:
> 
> > Dana How <danahow@gmail.com> writes:
> > 
> > > +/*
> > > + * Move this, the version in fast-import.c,
> > > + * and index_pack.c:readjust_pack_header_and_sha1 into sha1_file.c ?
> > > + */
> > > +static void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
> > > +				char *pack_name, uint32_t object_count)
> > > +{
> > 
> > Indeed that is a very good point.
> > 
> > I admit I did not notice we already had the duplication between
> > fast-import.c and index-pack.c
> > 
> > Shawn, Nico, what do you think?  Wouldn't it be better to
> > refactor them first, independent of Dana's series?
> 
> Probably, yes.  But probably not in sha1_file.c though.  This file is 
> getting a bit large already, and it deals with pack reading only not 
> pack writing.
> 
> I think another file with common pack writing functions could be 
> created.  Pack index writing is another item that is currently 
> duplicated in pack-objects and index-pack for example.

I agree entirely.  And I'd like to see that refactoring occur
before this series, or as part of it.  At least for the nr_objects
correction routine.  To be honest we should have done that when
fast-import.c and index-pack.c both needed that logic, but we didn't.
I don't remember whose version showed up first in Junio's tree
(I think it was index-pack.c) but the other one (probably me with
fast-import.c) should have done the refactoring then.

We already have *waaay* too many functions that know packfile
structure.  I'd like to see that decline, but unfortunately a number
of them are using rather specialized data structures so it makes
things somewhat difficult.

For example, writing objects to a packfile: we have 3
implementations.  fast-import.c doesn't use sha1write_compressed
because that was a waste of time to compute the SHA_CTX when we
know we have to go back and fixup nr_objects.  It also doesn't use
it because fast-import.c's pack-splitting logic is based on the
final object size, not the starting offset.  It does the deflate
itself, decides if the end of the object will overflow, and if so,
jumps to a new packfile.

-- 
Shawn.
