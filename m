From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/4] pack v4: add v4_size to struct delta_base_cache_entry
Date: Fri, 13 Sep 2013 22:06:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309132155540.20709@syhkavp.arg>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
 <1378982284-7848-2-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309130913510.20709@syhkavp.arg>
 <CACsJy8DrxQqvKyAH0trd1nDbFTL2Gq7k5O-shK4j8W6PMirNYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_jI+QnhOBbtie79uXTi5Maw)"
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 04:06:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKfFU-0000aT-An
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 04:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab3INCGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 22:06:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62794 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038Ab3INCGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 22:06:07 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MT3007A7F651M70@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 13 Sep 2013 22:06:05 -0400 (EDT)
In-reply-to: <CACsJy8DrxQqvKyAH0trd1nDbFTL2Gq7k5O-shK4j8W6PMirNYw@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234786>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_jI+QnhOBbtie79uXTi5Maw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 13 Sep 2013, Duy Nguyen wrote:

> On Fri, Sep 13, 2013 at 8:27 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Thu, 12 Sep 2013, Nguyễn Thái Ngọc Duy wrote:
> >
> >> The intention is to store flat v4 trees in delta base cache to avoid
> >> repeatedly expanding copy sequences in v4 trees. When the user needs
> >> to unpack a v4 tree and the tree is found in the cache, the tree will
> >> be converted back to canonical format. Future tree_desc interface may
> >> skip canonical format and read v4 trees directly.
> >>
> >> For that to work we need to keep track of v4 tree size after all copy
> >> sequences are expanded, which is the purpose of this new field.
> >
> > Hmmm.... I think this is going in a wrong direction.
> 
> Good thing you caught me early. I was planning to implement a better
> version of this on the weekend. And you are not wrong about code
> maintainability, unpack_entry() so far looks very close to a real
> mess.

Yes.  We might have to break it into sub-functions.  However this has 
the potential to recurse rather deeply so it is necessary to limit its 
stack footprint as well.

> > Yet, pavkv4 tree walking shouldn't need a cache since there is nothing
> > to expand in the end.  Entries should be advanced one by one as they are
> > needed.  Granted when converting back to a canonical object we need all
> > of them, but eventually this shouldn't be the main mode of operation.
> 
> There's another case where one of the base tree is not v4 (the packer
> is inefficient, like my index-pack --fix-thin). For trees with leading
> zeros in entry mode, we can just do a lossy conversion to v4, but I
> wonder if there is a case where we can't even convert to v4 and the v4
> treewalk interface has to fall back to canonical format.. I guess that
> can't happen.

Well... There is little gain in converting loose tree objects into pv4 
format so there will always be a place for the canolical tree parser.

Eventually the base trees added by index-pack should be pv4 trees.  The 
only case where this might not work is for zero padded mode trees and we 
don't have to optimize for that i.e. a fallback to the canonical tree 
format will be good enough.

> > However I can see that, as you say, the same base object is repeatedly
> > referenced.  This means that we need to parse it over and over again
> > just to find the right offset where the needed entries start.  We
> > probably end up skipping over the first entries in a tree object
> > multiple times.  And that would be true even when the core code learns
> > to walk pv4 trees directly.
> >
> > So here's the beginning of a tree offset cache to mitigate this problem.
> > It is incomplete as the cache function is not implemented, etc.  But
> > that should give you the idea.
> 
> Thanks. I'll have a closer look and maybe complete your patch.

I've committed an almost final patch and pushed it out.  It is disabled 
right now due to some bug I've not found yet.  But you can have a look.


Nicolas

--Boundary_(ID_jI+QnhOBbtie79uXTi5Maw)--
