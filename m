From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Mon, 26 Feb 2007 23:55:58 -0500
Message-ID: <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com>
References: <200702261540.27080.ttelford.groups@gmail.com> <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home> <20070227003118.GH1639@spearce.org> <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 05:56:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLuNl-0007IL-2N
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 05:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbXB0E4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 23:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbXB0E4F
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 23:56:05 -0500
Received: from nile.gnat.com ([205.232.38.5]:53454 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbXB0E4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 23:56:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 2AE3F48CC1C;
	Mon, 26 Feb 2007 23:56:01 -0500 (EST)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 10315-01-10; Mon, 26 Feb 2007 23:56:00 -0500 (EST)
Received: from [172.16.1.4] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 0AB8248CC7C;
	Mon, 26 Feb 2007 23:55:59 -0500 (EST)
In-Reply-To: <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40693>


On Feb 26, 2007, at 23:32, Nicolas Pitre wrote:

>> One thought I had here was to expand the fan-out table from 1<<8
>> entries to 1<<16 entries, then store only the low 18 bytes of
>> the SHA-1.  We would have another 2 bytes worth of space to store
>> the offset, pushing our total offset up to 48 bits.
>
> That would penalize small packs a lot.  the index would always start
> from 256KB in size.  With a pack of 100 objects (our current treshold
> for keeping a pack) that means a 258KB index file.  Currently the  
> index
> file for a 100-object pack is 3.4KB.

Why can't we do it with the current 1<<8 entry fan-out?
This would allow increases of pack file size up to 1 TB.
For larger repositories, we just need to use multiple
pack files. A couple hundred 1 TB pack files doesn't seem
to be a big issue.

Say a couple years from now, we can write data to stable storage
(disks/flash/holograms or whatever) at 1 GB/sec, then it would still
take 16 minutes to write a 1 TB file. At that point we'd need a
bigger overhaul than just larger offsets in the pack file.

BTW, here are a few issues with the current pack file format:
   - The final SHA1 consists of the count of objects in the file
     and all compressed data. Why? This is horrible for streaming
     applications where you only know the count of objects at the
     end, then you need to access *all* data to compute the SHA-1.
     Much better to just use compute a SHA1 over the SHA1's of each
     object. That way at least the data streamed can be streamed to
     disk. Buffering one SHA1 per object is probably going to be OK.

   - The object count is implicit in the SHA1 of all objects and the
     objects we find in the file. Why do we need it in the first place?
     Better to recompute it when necessary. This makes true streaming
     possible.

   -Geert
