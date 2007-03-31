From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Packing large repositories
Date: Sat, 31 Mar 2007 14:51:23 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0703311112340.28181@xanadu.home>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
 <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
 <20070330062324.GU13247@spearce.org>
 <alpine.LFD.0.83.0703300851270.3041@xanadu.home>
 <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 20:51:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXifg-0004FO-OM
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 20:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbXCaSv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 14:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbXCaSv0
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 14:51:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21947 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbXCaSvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 14:51:25 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFS00B5971NFK30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 31 Mar 2007 14:51:24 -0400 (EDT)
In-reply-to: <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43565>

On Sat, 31 Mar 2007, Geert Bosch wrote:

> I've been working on a design for a new index file format, and I'll
> include my current draft at the end of this message. It is not finished,
> and I've not written much code yet, but I'd like to prevent duplicated
> work and give others the opportunity to borrow from the ideas so far.

I'm glad you posted this as I intended to work on the index today.

> My main focus is to minimize the amount of data accessed in a random
> fashion, allow for multiple packs and virtually unlimited scaling.
> This is achieved through a fan-out table that grows with the number
> of items in the pack, keeping the fan-out table overhead under 2 bits
> per object while encoding a growing prefix of the object ID. This
> frees up bits for a pack number. The pack number is either used to
> find the correct pack, or alternatively for the right chunk of a
> very large pack file.

And how do you determine that pack number?

The index should be tied to the pack it is indexing and nothing else 
like the presence of other packs if possible.  When given a 20-byte SHA1 
you don't know what packnumber that corresponds to anyway.

> The linear search through packs is very inefficient
> with large numbers of packs. Having packs much larger
> than a GB is also problematic, due to this as repacking
> and otherwise modifying packs gets very expensive.

Repacking is not a frequent operation, and it can be done 
asynchronously.  So I don't consider that to be a big issue if it is 
expensive.  It is already extremely expensive compared to other GIT 
operations.  So it is better to have fewer and bigger packs to speed up 
runtime object searching than making repack less expensive with more 
smaller packs.

> Another issue is that binary search requires many
> semi-random accesses spread over the index. Finally,
> most of the information actually read consists of
> SHA1's that are never needed.

Of course the pack v4 design allow for bypassing all this altogether in 
most cases.  But it doesn't eliminate the need for an index in every 
cases.  So let's optimize the index first, especially since the pressing 
need now is to lift the 4G pack size limit. And pack v4 will come after 
that.

Just to say that the index doesn't need to be the ultimate thing as pack 
v4 will scale much better than any index format could ever do due to its 
direct object reference design.

However, a big detail that would greatly help pack v4 is to have the 
SHA1 table together in one block with no other fields inserted between 
entries.  Then the only difference between current packs and pack v4 
would be that the SHA1 table will be located in the pack itself instead 
of the index (pack v4 will carry the sorted SHA1 table already so the 
index won't have to store it).

> This proposed pack index format does not focus on reducing
> used disk space, but instead aims to reduce the number
> of blocks that needs to be read to perform lookups.
> This is done using three techniques:
>   1) scale the number of fan-out bins with the number
>      of objects in the index, keeping the expected
>      number of objects in each bin constant
>   2) take advantage of 1) by only storing a few bits
>      following the common prefix in the main lookup table
>      as a discriminant. Store the rest of the SHA1 and
>      the pack offest in a separate, parallel, object table.
>   3) Instead of repeating the variable-length common prefix
>      and the discriminant, use the space for the prefix
>      for a pack identifier and omit the discriminant altogether.

I think (2) conflicts with my goal of having the SHA1 table independent. 
It is really important for future compatibility with pack v4 that the 
SHA1 table remains a sorted list of contiguous 20-byte records.

I really like your adaptative fanout idea though.  So it could be 
possible to have something based on the largest common SHA1 prefix 
within a pack for example.  Or maybe it could be made multi level for an 
arbitrary portion of the largest common prefix.


Nicolas
