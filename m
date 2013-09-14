From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/4] pack v4: add v4_size to struct delta_base_cache_entry
Date: Sat, 14 Sep 2013 00:22:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309132351310.20709@syhkavp.arg>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
 <1378982284-7848-2-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309130913510.20709@syhkavp.arg>
 <CACsJy8DrxQqvKyAH0trd1nDbFTL2Gq7k5O-shK4j8W6PMirNYw@mail.gmail.com>
 <alpine.LFD.2.03.1309132155540.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 06:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKhNG-0008GH-QW
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 06:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704Ab3INEWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 00:22:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13540 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab3INEWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 00:22:17 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MT30063TLH4Q400@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 14 Sep 2013 00:22:16 -0400 (EDT)
In-reply-to: <alpine.LFD.2.03.1309132155540.20709@syhkavp.arg>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234788>

On Fri, 13 Sep 2013, Nicolas Pitre wrote:

> On Fri, 13 Sep 2013, Duy Nguyen wrote:
> 
> > On Fri, Sep 13, 2013 at 8:27 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > > However I can see that, as you say, the same base object is repeatedly
> > > referenced.  This means that we need to parse it over and over again
> > > just to find the right offset where the needed entries start.  We
> > > probably end up skipping over the first entries in a tree object
> > > multiple times.  And that would be true even when the core code learns
> > > to walk pv4 trees directly.
> > >
> > > So here's the beginning of a tree offset cache to mitigate this problem.
> > > It is incomplete as the cache function is not implemented, etc.  But
> > > that should give you the idea.
> > 
> > Thanks. I'll have a closer look and maybe complete your patch.
> 
> I've committed an almost final patch and pushed it out.  It is disabled 
> right now due to some bug I've not found yet.  But you can have a look.

Found the bug.

The cache is currently updated by the caller.  The caller may ask for a 
copy of 2 entries from a base object, but that base object may itself 
copy those objects from somewhere else in a larger chunk.

Let's consider this example:

tree A
------
0 (0) copy 2 entries from tree B starting at entry 0
1 (2) copy 1 entry from tree B starting at entry 3

tree B
------
0 (0) copy 6 entries from tree C starting at entry 0
1 (6) entry "foo.txt"
2 (7) entry "bar.txt"

Right now, the code calls decode_entries() to decode 2 entries from tree 
B but those entries are part of a copy from tree C.  When that call 
returns, the cache is updated as if tree B entry #2 would start at 
offset 1 but this is wrong because offset 0 in tree B covers 6 entries 
and therefore offset 1 is for entry #6.

So this needs a rethink.

I won't be able to work on this for a few days.


Nicolas
