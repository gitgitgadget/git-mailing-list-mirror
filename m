From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problematic git pack
Date: Wed, 30 Aug 2006 11:11:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608301012060.27779@g5.osdl.org>
References: <44F1D826.2010701@arces.unibo.it> <7v1wr1yjjz.fsf@assigned-by-dhcp.cox.net>
 <44F4006C.1040908@arces.unibo.it> <7vmz9nn90t.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0608291007170.27779@g5.osdl.org> <7vodu2iryg.fsf@assigned-by-dhcp.cox.net>
 <44F5615F.7010809@arces.unibo.it> <7v7j0qihwl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergio Callegari <scallegari@arces.unibo.it>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 30 20:11:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIUXQ-0005E6-9E
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 20:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWH3SLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 14:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWH3SLb
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 14:11:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3716 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751279AbWH3SLa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Aug 2006 14:11:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7UIBKnW011309
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 30 Aug 2006 11:11:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7UIBJPL002272;
	Wed, 30 Aug 2006 11:11:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j0qihwl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.425 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26229>


[ git list cc'd, just because maybe somebody was interested in seeing what 
  looks very much like the resolution of this issue..

  For people who haven't followed (the private) email exhanges with Sergio 
  about his git corruption, what was going on is that we initially were 
  able to re-generate all but one object (and the objects that were 
  dependent on it through deltas - there were three deltas against it, but 
  two of the deltas happened to delete the corruption and thus only one 
  of the dependent objects actually ended up having the wrong data, in 
  addition to the primary corrupted object, of course)..

  Junio pinpointed what the filesystem name of that primary object was, 
  and Sergio actually had the original object in his working tree, so 
  Junio could then generate a new pack with the one corrupted object 
  fixed, which obviously meant that all the deltas now worked too.

  This is my (probably final) analysis of the resulting differences.. ]

On Wed, 30 Aug 2006, Junio C Hamano wrote:
> 
> Ok, I was going to attach the resurrected pack that should
> contain everything your corrupt pack had, but it is a bit too
> large, so I'll place it here [*1*].  Drop me a note when you
> retrieved it, so that I can remove it.

VERY interesting.

The pack you generated looks very different from the original corrupt 
pack, but when I compare it to one that I generated _from_ that corrupted 
original by forcing a full repack, they are actually very very similar.

[ Side note: the explanation for the difference between my repacked 
  version and the original corrupt pack in turn seems to be fairly 
  straightforward: the older objects in the original pack were created 
  with an older version of git that defaulted to maximum zlib compression, 
  while the newer parts of the pack were done with the current default of 
  "default compression".

  So when Junio re-created the packfile from scratch with a modern git 
  version, it would now re-compress everything with the modern compression 
  value, and thus the byte-stream of Junio's pack would look very 
  different from Sergio's original one for the older objects. So what I 
  did was to repack the _corrupt_ data with a modern git, to be able to 
  compare the two sanely. ]

In fact, doing a hexdump with 'od', and diffing the results, here's the 
differences:

	--- od.unfixed  2006-08-30 10:11:36.000000000 -0700
	+++ od.fixed    2006-08-30 09:33:02.000000000 -0700
	@@ -3358,7 +3358,7 @@
	 0150720 2c0c bc8b 2f07 3733 767d 35bb 6bb6 4b28
	 0150740 0e3c 0ddc 955b eb2d 57e0 754b b1ec b9f7
	 0150760 8ac8 87bf 9d44 fd11 a041 c4ea cd1d 26de
	-0151000 94ea 9cf3 7dcd b596 13a3 61bb 48db e69e
	+0151000 96ea 9cf3 7dcd b596 13a3 61bb 48db e69e
	 0151020 21e9 1288 6294 8dd4 8b3c 6cc6 e4e7 518f
	 0151040 6166 3e2d d635 b631 9ec6 0613 aee3 caab
	 0151060 d4fd 3ab3 6e18 c43a 8dee 15b9 bc6d 0748
	@@ -8455,7 +8455,7 @@
	 0410140 9f30 2514 f447 0c0d 477e 27c7 a0e1 c9ec
	 0410160 c0b1 f352 76dd 4ff6 24b1 03c2 0ed2 363a
	 0410200 034f 637c 8e11 0c86 e2db 2625 75c4 508b
	-0410220 6fdb bf01 af2d b23b fbb7 0128 49bd 2bd8
	+0410220 6fdb bf01 54b6 b23d fbb7 0128 49bd 2bd8
	 0410240 a76b bca3 7df2 a4c8 e8b9 9081 1d01 a778
	 0410260 9cad 564d 6f1b 4518 7605 e563 c501 0995
	 0410300 231a 0151 5255 f6ce ccee ec07 8a22 25eb
	@@ -394626,7 +394626,7 @@
	 30054020 4951 6272 665e 7a6e 6272 517e b1ad d1e4
	 30054040 a55c 9a40 fd62 a2a9 c925 99f9 79b5 d5aa
	 30054060 5c0a 4010 03b4 d6a1 a064 b323 f74a c6cd
	-30054100 df78 a219 27c7 f205 0200 8970 3307 ae17
	-30054120 5e11 8f8c e015 00f8 5d51 9152 0d07 79b2
	-30054140 45dd
	+30054100 df78 a219 27c7 f205 0200 8970 3307 4599
	+30054120 3854 bacb 704e 7312 11e1 60e3 c14b 0a90
	+30054140 e22b
	 30054142

You can ignore the last hunk, that's just the SHA1 of the pack itself, and 
that will obviously differ in all 20 bytes, so that difference is not 
interesting. 

So the _real_ difference is literally just the one byte at offset 0151000 
(decimal 53760) which in the fixed pack is 0x96, and in the corrupt pack 
it is 0x94. That's a single-bit difference (bit #1 has been cleared).

The other difference is at 0410224 (decimal 135316), where the sequence 
"af2d b23b" should have been "54b6 b23d", and that's just final zlib CRC 
of that one object (the corrupted object is fairly large: it's 127905 
bytes uncompressed, and I think it was ~100kB compressed too, because most 
of it is the data for the image inside of it).

The way I know that: doing "git-show-index" (and sorting by object offset) 
on the index gives you:

	...
	13830 2849bd2bd8a76bbca37df2a4c8e8b990811d01a7
	135320 42abdeecbf1b49c8354ca9639bd19c378be6d7d4
	...

which means that the one-bit error was in the middle of that (known 
corrupt) object 2849bd2bd8, and the four-byte difference is exactly the 
four last bytes of that same object - which is obviously where you'd 
expect to find the crc32 for the compressed data.

[ NOTE! The only reason the crc32 has changed is exactly the fact that I 
  forced a full repack of the corrupt pack. In the _original_ pack the 
  object 2849bd2bd8a76bbca37df2a4c8e8b990811d01a7 was at:

	...
	13369 2849bd2bd8a76bbca37df2a4c8e8b990811d01a7
	134859 42abdeecbf1b49c8354ca9639bd19c378be6d7d4
	...

  and thus the crc32 in the original is the four bytes at 134855, and 
  indeed in the original corrupt pack we see:

	...
	0407260 d236 3a03 4f63 7c8e 110c 86e2 db26 2575
	0407300 c450 8b6f dbbf 0154 b6b2 3dfb b701 2849
				 ^^ ^^^^ ^^
	0407320 bd2b d8a7 6bbc a37d f2a4 c8e8 b990 811d
	...

  so note how that contains the _original_ CRC, because in the original 
  corrupt pack, the CRC was the one that had been computed with the 
  original (uncorrupted) zlib data, but obviously didn't actually _match_ 
  the actual corrupted data itself - which is why we got a zlib error on 
  unpacking it ]

So I think this is pretty damn conclusive. Sergio had a single-bit error 
in a pack-file, and that error got propagated because "git repack" didn't 
notice, and because he used unison to synchronize between two different 
machines, and that obviously happily transferred the corruption.

Now, that makes me feel happy on one level, because it's almost certainly 
a hardware problem - subtle memory corruption, or disk corruption that 
happened when either reading or writing the image. Sergio may not be that 
happy about it, of course.

It _could_ be something else (hey, it could be the kernel or git itself 
that has a wild pointer and corrupted a single bit), but I'd say that the 
hardware is the primary suspect.

Now, what to take away from this:

 - git _did_ find the error, but it would have been easier for everybody 
   if it had noticed it a bit earlier. Ergo:

 - we should make the repacking verify the object even when it just 
   blindly copies it, so that we do _not_ end up in the situation that a 
   pack-file has a "valid" SHA1, even though the contents are actually 
   corrupt.

   This should be easy enough, since zlib already has the crc (actually, 
   we should probably do a full unpack of that object, even if it's 
   expensive: if it's a delta, we'd need that to verify that the SHA1 of 
   the base object is valid).

 - git pack-files are extremely dense (we knew that already, and mostly 
   consider it to be a really good thing), and a single-bit error can be 
   absolutely devastating. For important data, always keep a copy on 
   another machine (that's obviously true regardless of whether you use 
   git or not ;), and _always_ create the copy with git itself, or at 
   least verify it with "git-fsck-objects --full" before you overwrite the 
   previous version.

   The point being, if you have even a single-bit error (and for all we 
   know, it could have been introduced by the transfer itself, and then 
   been re-introduced in the original place when transferring the data 
   back), you absolutely do _not_ want to transfer that to your backup 
   location too.

Finally, this also points out that the corrupted packs _can_ be fixed, but 
I think Sergio was a bit lucky (to offset all the bad luck). Sergio still 
had access to the original file that had had its object corrupted. And it 
took a fair amount of work, and some git hacking by somebody who really 
understood git (Junio).

Maybe we'll end up having some of that effort being useful and checked in, 
and we'll eventually have more infrastructure for fixing these things, but 
I suspect that in most cases, even a _single_ bit of corruption will 
generally result in so much havoc that nobody should depend on that. It's 
a lot better to have backups.

			Linus
