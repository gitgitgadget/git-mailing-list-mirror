From: Geert Bosch <bosch@adacore.com>
Subject: Re: [RFC] Packing large repositories
Date: Sat, 31 Mar 2007 13:04:39 +0200
Message-ID: <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com> <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org> <20070330062324.GU13247@spearce.org> <alpine.LFD.0.83.0703300851270.3041@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 13:04:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXbO4-0005vB-FP
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 13:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbXCaLEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 07:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbXCaLEp
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 07:04:45 -0400
Received: from nile.gnat.com ([205.232.38.5]:60447 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881AbXCaLEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 07:04:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id C4EA648CC2B;
	Sat, 31 Mar 2007 07:04:43 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 27790-01-5; Sat, 31 Mar 2007 07:04:43 -0400 (EDT)
Received: from [205.232.38.91] (vpn202.gnat.com [205.232.38.91])
	by nile.gnat.com (Postfix) with ESMTP id 4D1C148CBCF;
	Sat, 31 Mar 2007 07:04:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.83.0703300851270.3041@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43545>


On Mar 30, 2007, at 15:01, Nicolas Pitre wrote:

> Remains only to determine what this new index format should look like.
> I think that the SHA1 table and the offset table should be separate.
> For one it will require less mmap space to binary search through
> the SHA1 table, and it will make things much easier if pack v4 stores
> the SHA1 table itself.

I've been working on a design for a new index file format, and I'll
include my current draft at the end of this message. It is not finished,
and I've not written much code yet, but I'd like to prevent duplicated
work and give others the opportunity to borrow from the ideas so far.

My main focus is to minimize the amount of data accessed in a random
fashion, allow for multiple packs and virtually unlimited scaling.
This is achieved through a fan-out table that grows with the number
of items in the pack, keeping the fan-out table overhead under 2 bits
per object while encoding a growing prefix of the object ID. This
frees up bits for a pack number. The pack number is either used to
find the correct pack, or alternatively for the right chunk of a
very large pack file.

   -Geert

---
The primary purpose of the pack index is to quickly
find the location of a given SHA1 in any of the pack
files. It is also used for quick lookup of and expansion
of a unique prefix of a SHA1 object name.

Original Pack Index

The original pack index uses a separate index file
per pack file, with the same name as the pack file
but a .idx extension instead of .pack. After an
initial 256 entry fan-out table gives an approximate
range of the object, binary lookup is used to find
the exact object entry in the table of objects sorted
by SHA1. Each entry is 24 bytes: the 20 bytes of the
SHA1 and 4 bytes for the offset.

A problem with that approach is that doesn't scale well
for repositories with large numbers of objects and
pack files. In the following I'll assume a repository
with 1K packs containing about 1M objects of 1K bytes
each for a total repository size of 1TB. Such a scenario
could occur in a situation where many loosely connected
projects are combined in one large repository.

Performance with Large Repository

Now consider the working set needed to complete a job
involving the lookup of 1K random objects in the
repository described above. File access are counted
in 4K blocks.  The index for each pack is about 24M bytes,
and the total space for all indices is 24G bytes.

Each lookup in a pack file reads the entire fan-out table,
so the 1K * 4K = 4M of pack fan out tables is read.
A successful object lookup searches through about half
of the table entries, so each pack file will be used
approximately 500 times. Each of the 256 fan-out bins
has about 4K objects (totalling 96K bytes)
and will be accessed twice.

Of the expected 12 binary lookups, the first one will
be repeated twice, while the second level has a 50%
chance of hitting the same location, the third level
25% and so on. So, on average 11 unique lookups will
be done per object access for each pack. Since a total
of 22 random reads will be done in each 96K bin,
most if not all of the file blocks in the pack indices
needs to be read. As access is random, there is no
meaningful caching possible for the 24G working set
of indices.

The result is 500*11=5500 random disk reads accessing
each object, for a total of 5500K I/Os in the the 24G
of pack indices.

Multiple Pack Index

The linear search through packs is very inefficient
with large numbers of packs. Having packs much larger
than a GB is also problematic, due to this as repacking
and otherwise modifying packs gets very expensive.

Another issue is that binary search requires many
semi-random accesses spread over the index. Finally,
most of the information actually read consists of
SHA1's that are never needed.

This proposed pack index format does not focus on reducing
used disk space, but instead aims to reduce the number
of blocks that needs to be read to perform lookups.
This is done using three techniques:
   1) scale the number of fan-out bins with the number
      of objects in the index, keeping the expected
      number of objects in each bin constant
   2) take advantage of 1) by only storing a few bits
      following the common prefix in the main lookup table
      as a discriminant. Store the rest of the SHA1 and
      the pack offest in a separate, parallel, object table.
   3) Instead of repeating the variable-length common prefix
      and the discriminant, use the space for the prefix
      for a pack identifier and omit the discriminant altogether.

For a repository with N objects and highest PACK_NR P,
the total space used for the index is bounded by
24 * (N + P) bytes, if N is at least 512 and N >= 512 * P.

Limits:
    - Maximum number of packs: 2^27
    - Maximum number of objects: 2^40
    - Maximum repository size: 2^48 bytes

<PACK_INDEX>
    :   <IDX_PACK_LIST>
        <IDX_FANOUT_BITS>
        <IDX_FANOUT_TABLE>
        <IDX_LOOKUP_TABLE>
        <IDX_OBJECT_TABLE>
        <IDX_CHECKSUM>
    ;

<IDX_PACK_LIST>
    :   <IDX_PACK_LIST_ENTRIES>
        <ZERO_32> <IDX_PACK_LIST_CHECKSUM>
    ;
<IDX_PACK_LIST_ENTRIES>
    # List of packs sorted by ascending PACK_ID
    :  ( <IDX_PACK_NR> <PACK_ID> ) *
    ;

<PACK_ID>
    # 20-byte binary representation of the 40 hex-digit
    # value PACK_ID_HEX, such that pack-${PACK_ID_HEX}.pack
    # is the name of the pack file
    ;

<IDX_PACK_NR>
    # 32-bit unsigned integer in network order, with the same
    # value as the preceding <IDX_PACK_NR> (or zero for the
    # first entry), increased by the size of the pack file in
    # bytes, divided by 2^32 and rounded up.
    ;

<ZERO_32>
    # 32-bit zero
    ;

<IDX_PACK_LIST_CHECKSUM>
    # 20-byte SHA1 of <IDX_PACK_LIST_ENTRIES>
    ;

<IDX_FANOUT_BITS>
    # 1 byte with the smallest value N between 8 and 35,
    # such that 2^(N - 8) greater than or equal to the
    # largest IDX_PACK_NR in the IDX_PACK_LIST, and such that
    # 2^(N+5) is greater than or equal to the total number
    # of objects in all packs.
    ;

<IDX_FANOUT_TABLE>
    # Table of 2^${IDX_FANOUT_BITS} entries
    :   ( <IDX_PARTIAL_COUNT> ) *
    ;

<IDX_PARTIAL_COUNT>
    # 40 bit, network byte order, binary integer of the count of
    # objects in the pack file with the high IDX_FANOUT_BITS bits of
    # the object ID less than or equal to the index of the count,
    # starting from zero.
    ;

<IDX_LOOKUP_TABLE>
    # One 8-bit key per object indexed by the pack
    :   ( <IDX_LOOKUP_KEY> ) *
    ;

<IDX_LOOKUP_KEY>
    # Bits IDX_FANOUT_BITS through IDX_FANOUT_BITS + 7 of the
    # object ID.
    ;

<IDX_OBJECT_ENTRY>
    # The total width of each entry is 22 bytes
    :   ( <IDX_PACK_REF> <IDX_OBJECT_ID> <IDX_OFFSET> ) *
    ;

<IDX_PACK_REF>
    # A IDX_FANOUT_BITS - 8 bit wide integer value, equal to
    # PACK_NR of pack preceding the one containing the object
    # (or zero, if object is in first pack) increased with the
    # pack offset divided by 2^32.
    ;

<IDX_OBJECT_ID>
    # Bits IDX_FANOUT_BITS + 8 .. 159 of the object ID
    ;

<IDX_OFFSET>
    # 32-bits offset in network byte order
    ;
