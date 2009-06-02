From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH WIP 0/4] Special code path for large blobs
Date: Tue, 2 Jun 2009 07:45:55 -0700
Message-ID: <20090602144555.GH30527@spearce.org>
References: <1243488550-15357-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.00.0905281349320.3906@xanadu.home> <fcaeb9bf0906012146t7eab8dafm2b2b58aa96fb6220@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVFb-0000zF-Ah
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 16:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbZFBOpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 10:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbZFBOpy
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 10:45:54 -0400
Received: from george.spearce.org ([209.20.77.23]:33807 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbZFBOpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 10:45:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E3805381D1; Tue,  2 Jun 2009 14:45:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0906012146t7eab8dafm2b2b58aa96fb6220@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120513>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> 2009/5/29 Nicolas Pitre <nico@cam.org>:
> > However, like I said previously, I'd encapsulate large blobs in a pack
> > right away instead of storing them as loose objects. ??The reason is that
> > you can effortlessly repack/fetch/push them afterwards by simply
> > triggering the pack data reuse code path for them. ??Extracting large and
> > undeltified blobs from a pack is just as easy as from a loose object.
> 
> Makes sense. And the code looks nice too.
> 
> > To accomplish that, you only need to copy write_pack_file() from
> > builtin-pack-objects.c and strip it to the bone with only one object to
> > write.
> 
> write_pack_file() is too scary to me, I ripped from fast-import.c
> instead. BTW, how does git handle hundreds of single object packs? I
> don't know if prepare_packed_git scales in such cases.

Yea, its not going to do that great.

We may be able to improve that code path by sorting any pack whose
index is really small and pack file is really big to the end of
the list, where its least likely to be matched, so we don't even
bother to load the index into memory during normal commit traversal.

But even with that sorting, its still going to suck.  Lookup for
a large binary is O(N), where N is the number of large binary
*revisions*.  Yuck.

Really, objects in the 200MB+ range probably should just be in a lone
file named by its SHA-1... aka, a loose object.  Combining them into
a pack is going to be potentially expensive disk IO wise, and may
not gain you very much (its over 200 MB compressed with deflate, its
likely already compressed binary content that may not delta well).

Way back we had that pack-style loose object format, for exactly
these sorts of files, and exactly to avoid having many packs of
just 1 object, but that didn't go anywhere... indeed, Nico deleted
the code that creates that format.

-- 
Shawn.
