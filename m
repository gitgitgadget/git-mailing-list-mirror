From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 11:04:41 -0500
Message-ID: <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
References: <200702261540.27080.ttelford.groups@gmail.com> <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home> <20070227003118.GH1639@spearce.org> <alpine.LRH.0.82.0702262306100.29426@xanadu.home> <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com> <alpine.LRH.0.82.0702270002100.29426@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 17:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4p7-00078b-BH
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 17:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbXB0QEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 11:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933071AbXB0QEo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 11:04:44 -0500
Received: from nile.gnat.com ([205.232.38.5]:41470 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933070AbXB0QEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 11:04:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 5FEDA48D1C4;
	Tue, 27 Feb 2007 11:04:42 -0500 (EST)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 00508-01-8; Tue, 27 Feb 2007 11:04:42 -0500 (EST)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 086BB48D1C0;
	Tue, 27 Feb 2007 11:04:42 -0500 (EST)
In-Reply-To: <alpine.LRH.0.82.0702270002100.29426@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40756>


On Feb 27, 2007, at 00:11, Nicolas Pitre wrote:

>> BTW, here are a few issues with the current pack file format:
>>  - The final SHA1 consists of the count of objects in the file
>>    and all compressed data. Why? This is horrible for streaming
>>    applications where you only know the count of objects at the
>>    end, then you need to access *all* data to compute the SHA-1.
>>    Much better to just use compute a SHA1 over the SHA1's of each
>>    object. That way at least the data streamed can be streamed to
>>    disk. Buffering one SHA1 per object is probably going to be OK.
>
> We always know the number of objects before actually constructing or
> streaming a pack.  Finding best delta matches require that we sort the
> object list by type, but for good locality we need to re-sort that  
> list
> by recency.  So we always know the number of objects before  
> starting to
> write since we need to have the list of objects in memory anyway.

When I import a large code-base (such as a *.tar.gz), I don't know
beforehand how many objects I'm going to create. Ideally, I'd like
to stream them directly into a new pack without ever having to write
the expanded source to the filesystem.

> Also the receiving end of a streamed pack wants to know the number of
> objects first if only to provide the user with some progress report.
>
>>  - The object count is implicit in the SHA1 of all objects and the
>>    objects we find in the file. Why do we need it in the first place?
>>    Better to recompute it when necessary. This makes true streaming
>>    possible.
>
> Sorry, I don't follow you here.

The object-count at the beginning of the pack is a little strange for
local on-disk pack files, as it is data that can easily be derived.
The *index* would seem to be the proper place for this.

Also, it is not possible to write a dummy 0 in the count and then  
fill in
the correct count at the end, because the final SHA1 at the end of  
the pack
file is a checksum over the count followed by all the pack data.
So for creating a large pack from a stream of data, you have to do  
the following:
   1. write out a temporary pack file to disk without correct count
   2. fix-up the count
   3. read the entire temporary pack file to compute the final SHA-1
   4. fix-up the SHA1 at the end of the file
   5. construct and write out the index

There are a few ways to fixing this:
   - Have a count of 0xffffffff mean: look in the index for the count.
     Pulling/pushing would still use regular counted pack files.
   - Have the pack file checksum be the SHA1 of (the count followed
     by the SHA1 of the compressed data of each object). This would  
allow 3.
     to be done without reading back all data.

   -Geert
