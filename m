From: Geert Bosch <bosch@adacore.com>
Subject: Re: [RFC] super indexes to span multiple packfiles
Date: Tue, 29 May 2007 13:54:30 -0400
Message-ID: <E393F294-9159-4824-8874-69FB836F4B59@adacore.com>
References: <20070529071622.GA8905@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 29 19:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht5u6-00076w-4K
	for gcvg-git@gmane.org; Tue, 29 May 2007 19:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbXE2Ryc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 13:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbXE2Ryc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 13:54:32 -0400
Received: from nile.gnat.com ([205.232.38.5]:61085 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbXE2Ryc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 13:54:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 547F448CE8A;
	Tue, 29 May 2007 13:54:31 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 16876-01-3; Tue, 29 May 2007 13:54:31 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 20C8048CDBF;
	Tue, 29 May 2007 13:54:27 -0400 (EDT)
In-Reply-To: <20070529071622.GA8905@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48704>

[resent, my email client doesn't like Shawn's name :( ]
On May 29, 2007, at 03:16, Shawn O. Pearce wrote:

> In the single packfile case (everything repacked into one) this
> is not faster; its actually slightly slower.  With a handful of
> smaller recent packfiles (such as immediately after a git-fetch)
> it breaks even with the stock code.  I haven't tested it yet with
> a high number of packfiles (e.g. 20).  I suspect it won't gain us
> a lot up there either...
>
> So in short this shouldn't be applied, because its not any faster,
> and is sometimes slower.  But I'm tossing it out here for discussion.
> I'm also not documenting the new super-index command line program,
> because I don't think this should be applied.  ;-)

A super-index should have a fan-out factor dependent on the number
of entries in the index. So an index with 2^20 entries would have
2^16 fan-outs. So there will be about 2^4 entries per fanout slot.
Each slot only contains the next byte of the key, so in this case
bit 16 through 23 (numbering bits starting at zero).

The format would look like:
   * Header
   * Fan-out table (approx 2 bits/object)
   * Next key-byte table (1 byte/object)
   * Object info (offset into packfile(s) and/or rest of object name)

So, after a single lookup to get to about the right entry, only
an expected 16 single-byte comparisons are necessary to find the
entry that is needed or return a "entry doesn't exist".

Below I repeat a previous suggestion for a new pack file index.
I'm happy to implement this, although it seems that there are
so many pending index/pack file format changes that this may
be premature. If the pack file itself will have the full SHA-1,
the

(snipped from <http://article.gmane.org/gmane.comp.version- 
control.git/43545>)

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
