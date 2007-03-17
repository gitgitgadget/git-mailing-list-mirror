From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 18:11:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-392721763-1174093910=:3910"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 02:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSNSe-0003ta-Mp
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 02:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbXCQBLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 21:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753686AbXCQBLy
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 21:11:54 -0400
Received: from smtp.osdl.org ([65.172.181.24]:45805 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbXCQBLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 21:11:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2H1BpcD012994
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Fri, 16 Mar 2007 18:11:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2H1Boib026005
	for <git@vger.kernel.org>; Fri, 16 Mar 2007 17:11:51 -0800
In-Reply-To: <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
X-Spam-Status: No, hits=0.643 required=5 tests=AWL,OSDL_HIGH_ASCII_6,OSDL_HIGH_ASCII_9
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42414>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-392721763-1174093910=:3910
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Fri, 16 Mar 2007, Linus Torvalds wrote:
> 
> And yes, it's not hugely faster, but I seem to see *some* difference: this 
> is the real-time of ten runs of 
> 
> 	time git log drivers/usb/ > /dev/null

Damn. I think I know why it's happening, and I'm an idiot. I think it's 
actually an issue I wondered about a *loong* time ago, and then forgot all 
about. And later or Nico made it almost impossible to fix with his "pack 
offset" changes.

The thing that made me realize was one of the callchains into inflate() 
that I looked at:

   (gdb) where
   #0  inflate (strm=0x7fff10d83810, flush=4) at inflate.c:566
   #1  0x000000000044c165 in unpack_compressed_entry (p=0x6d52e0, w_curs=0x7fff10d838e0, curpos=94941911,
       size=<value optimized out>) at sha1_file.c:1348
   #2  0x000000000044c2b6 in unpack_entry (p=0x6d52e0, obj_offset=94941909, type=0x7fff10d85d8c, sizep=0x7fff10d83928)
       at sha1_file.c:1408
   #3  0x000000000044c32e in unpack_entry (p=0x6d52e0, obj_offset=94942707, type=0x7fff10d85d8c, sizep=0x7fff10d83988)
       at sha1_file.c:1373
   #4  0x000000000044c32e in unpack_entry (p=0x6d52e0, obj_offset=94943021, type=0x7fff10d85d8c, sizep=0x7fff10d839e8)
       at sha1_file.c:1373
   #5  0x000000000044c32e in unpack_entry (p=0x6d52e0, obj_offset=94943382, type=0x7fff10d85d8c, sizep=0x7fff10d83a48)
       at sha1_file.c:1373
   #6  0x000000000044c32e in unpack_entry (p=0x6d52e0, obj_offset=94943531, type=0x7fff10d85d8c, sizep=0x7fff10d83aa8)
       at sha1_file.c:1373
   #7  0x000000000044c32e in unpack_entry (p=0x6d52e0, obj_offset=94943622, type=0x7fff10d85d8c, sizep=0x7fff10d83b08)
       at sha1_file.c:1373
   #8  0x000000000044c32e in unpack_entry (p=0x6d52e0, obj_offset=94945357, type=0x7fff10d85d8c, sizep=0x7fff10d83b68)
       at sha1_file.c:1373
   #9  0x000000000044c32e in unpack_entry (p=0x6d52e0, obj_offset=94945447, type=0x7fff10d85d8c, sizep=0x7fff10d83bc8)
       at sha1_file.c:1373
   #10 0x000000000044c32e in unpack_entry (p=0x6d52e0, obj_offset=94945571, type=0x7fff10d85d8c, sizep=0x7fff10d85d80)
       at sha1_file.c:1373
   #11 0x000000000044c3f8 in read_packed_sha1 (sha1=<value optimized out>, type=0x7fff10d85d8c, size=0x7fff10d85d80)
       at sha1_file.c:1567
   #12 0x000000000044c741 in read_sha1_file (sha1=0x7fff10d85d60 "�Ab\217��236���031", type=0x7fff10d85d8c,
       size=0x7fff10d85d80) at sha1_file.c:1636
   ....

and notice the deep recursion in sha1_file.

The way we unpack delta chains is that we do

 - find a delta
 - we apply it to "recursively unpack the thing it's a delta to"

which sounds totally obvious and straightforward, right?

EXCEPT it's actually O(n**2) in the delta depth, because we never save the 
intermediate results, so when we have a delta depth of 10 (our default), 
and we decode a lot of these things, we basically will look up the base 
object 10 times, apply the first delta 9 times, apply the second delta 8 
times, etc etc.. 

I didn't worry about it, because it never actually hit as much of a
performance problem (and when you do a *single* tree operation you'd
never see it anyway: you apply the deltas you need, and nothing else),
but what it means is that we actually call inflate on the chain entries
55 times instead of just doing it 10 times. 

It's also somewhat limited by the delta depth that we enforce anyway (I 
say "somewhat", because we only limit the maximum depth, not the number of 
times an object can be used as a base, and if you use an object as a base 
a thousand times, it will literally be unpacked a thousand times too!

I also didn't worry about it, because I felt that if it became a problem, 
it would be easy to just add a cache of base objects (we probably do *not* 
want to keep the whole unpacked object info in memory all the time just 
because of memory pressure issues, so "cache of base objects" is better). 
However, the "pack file + offset" thing makes it harder to do, since we 
now don't even have the SHA1 of the base object before we unpack it.

But I guess we could just index this by a <packfile, offset> tuple.

Anyway, I bet that this is a much bigger issue than the pack format 
itself (and is largely independent).

		Linus
---1463790079-392721763-1174093910=:3910--
