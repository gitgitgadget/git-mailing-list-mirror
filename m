From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "failed to read delta base object at..."
Date: Mon, 25 Aug 2008 16:59:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org> <20080825213104.GI2213@fieldses.org> <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org> <20080825221321.GL2213@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 02:01:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXlzt-0000Nn-6M
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 02:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbYHYX7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 19:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbYHYX7i
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 19:59:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48210 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350AbYHYX7h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 19:59:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7PNxR5n029561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Aug 2008 16:59:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7PNxQrK011441;
	Mon, 25 Aug 2008 16:59:26 -0700
In-Reply-To: <20080825221321.GL2213@fieldses.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.427 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93695>



On Mon, 25 Aug 2008, J. Bruce Fields wrote:
> 
> OK!  It's in:
> 
> 	http://www.citi.umich.edu/u/bfields/bad-pack/
> 
> I assume the .idx file isn't interesting, but it's there anyway in case.

It makes things slightly easier.

But yes, the file is corrupt. The most obvious corruption is simply the 
comparison that git-fsck does with the SHA1 that the pack-file itself 
contains: all pack-files have at the end the SHA1 of the contents of the 
pack-file, and git fsck says:

	error: .git/objects/pack/pack-f7261d96cf1161b1b0a1593f673a67d0f2469e9b.pack SHA1 checksum mismatch

so it's definitely not a valid pack-file, and perhaps more importantly, 
since git calculates the SHA1 as it writes the file out, the data really 
doesn't match what git wrote, and it got corrupted at some point in 
between the generation of the data and the reading back.

(It _could_ still be some git corruption where git itself corrupted it 
after it had done the SHA1 writing, but I doubt it).

As to the exact error: zlib reports "invalid distance too far back" as the 
error message when unpacking, which doesn't really tell me much. It's just 
a common data error. But since I actually _have_ that corrupt object in my 
pack too, I can actually look at what it should be.

It's object 784716eb7fc5735a3e6b6209223508984013819f (it's a blob encoding 
for arch/arm/mach-pxa/sleep.S from earlier this year), and in my pack-file 
it's at byte offset 48094431-48098049.

So I can actually extract just those bytes from my pack, and compare them 
against the bytes in your corrupt pack. It's interesting, because the 
differences aren't all that big, but they aren't a single word either.

Here's a "diff -u" of "od -t x1" output:

	--- good-object.hex     2008-08-25 16:33:41.000000000 -0700
	+++ bad-object.hex      2008-08-25 16:33:50.000000000 -0700
	@@ -113,16 +113,16 @@
	 0003400 e1 b1 dc ef 45 fa b1 ec 0f a0 2c 72 1b 25 55 f7
	 0003420 5a d6 f7 5c 72 dd 8b b2 44 dd 25 e6 c6 33 09 98
	 0003440 03 9b d1 49 8e 30 e6 7a df 76 76 bb cc c9 fb 44
	-0003460 a0 14 8d 7d cd 12 75 81 2b c4 d9 71 27 62 ae b5
	-0003500 87 a9 4f 76 c5 90 82 04 2b 15 53 47 ad 97 d1 02
	-0003520 98 14 df 45 7c 5f 93 b1 08 fd b6 bf e1 62 1b 00
	-0003540 b5 f6 ee 6c 70 30 78 73 74 38 3c 7f f3 e3 e5 90
	-0003560 39 7e 2e df e5 e1 c5 c1 29 62 02 fd 61 36 61 7d
	-0003600 c0 83 a0 4f 17 04 02 c6 ec 59 2e c1 7d 20 41 b1
	-0003620 fd 51 56 d0 b1 74 b9 76 81 4c 47 63 f0 10 76 15
	-0003640 db a7 0b b8 d1 6a f8 59 73 8c c4 e5 c9 ab 8b cb
	-0003660 37 32 5d 4a 91 c3 c1 c9 77 33 b4 2c b7 61 a0 37
	-0003700 47 f7 9b 3d b6 a5 99 5a cf 49 ef e0 3f 54 08 f4
	+0003460 a0 14 8d 7d 22 00 00 00 6b 57 fe ff 55 57 fe ff
	+0003500 aa 57 fe ff b0 00 0e 00 d9 66 22 00 00 00 00 e0
	+0003520 19 9f fe ff ff ff d1 43 fe ff d1 43 fe ff 00 c0
	+0003540 bf fe f0 33 69 bf b2 33 69 bf 00 00 00 10 01 fe
	+0003560 bf fe 66 01 00 00 01 1f 37 17 2e 59 fe ff 00 00
	+0003600 00 00 c2 41 fe ff 00 00 01 1f 37 17 44 42 fe ff
	+0003620 00 01 fe ff 01 1f 37 07 d4 42 fe ff 02 01 a8 44
	+0003640 00 f8 bf fe 6b 57 fe ff 55 57 fe ff 97 57 fe ff
	+0003660 00 f8 bf fe 04 00 fe ff ab 45 fe ff 02 00 fe ff
	+0003700 ae 41 49 50 aa 40 fe ff cf 49 ef e0 3f 54 08 f4
	 0003720 1e 2b 6f 59 e5 47 06 f4 80 a7 76 3a 38 a7 88 0a
	 0003740 30 72 a2 0a ed e1 b0 d5 6d 6f 9e ca 96 c7 28 d0
	 0003760 2c 19 b6 db 51 97 a9 f6 c3 31 8a 50 22 87 7a 97

and the difference literally seems to be just a block of less than 160 
bytes. But it's certainly not a single-bit error, and it's also not a disk 
block or anything like that.

Looking at the first line that differs, they are:

	-0003460 a0 14 8d 7d cd 12 75 81 2b c4 d9 71 27 62 ae b5
	+0003460 a0 14 8d 7d 22 00 00 00 6b 57 fe ff 55 57 fe ff

so the differences start at offset 03464. The last line is:

	-0003700 47 f7 9b 3d b6 a5 99 5a cf 49 ef e0 3f 54 08 f4
	+0003700 ae 41 49 50 aa 40 fe ff cf 49 ef e0 3f 54 08 f4

so they re-join at 03708 (octal offsets because of 'od' behavior).  But in 
between there seems to be nothing in common.

So the corrupt data looks like

	                    22 00 00 00 6b 57 fe ff 55 57 fe ff
        0003500 aa 57 fe ff b0 00 0e 00 d9 66 22 00 00 00 00 e0
        0003520 19 9f fe ff ff ff d1 43 fe ff d1 43 fe ff 00 c0
        0003540 bf fe f0 33 69 bf b2 33 69 bf 00 00 00 10 01 fe
        0003560 bf fe 66 01 00 00 01 1f 37 17 2e 59 fe ff 00 00
        0003600 00 00 c2 41 fe ff 00 00 01 1f 37 17 44 42 fe ff
        0003620 00 01 fe ff 01 1f 37 07 d4 42 fe ff 02 01 a8 44
        0003640 00 f8 bf fe 6b 57 fe ff 55 57 fe ff 97 57 fe ff
        0003660 00 f8 bf fe 04 00 fe ff ab 45 fe ff 02 00 fe ff
        0003700 ae 41 49 50 aa 40 fe ff 

and I don't see what the patern is, except that there's a lot of "fe ff" 
in there. 148 bytes, no obvious source. It definitely does _not_ look like 
compressed input (it's too regular to be something zlib spits out), nor is 
it text. Nor is it valid x86 assembly, so it's not some code-segment data 
either.

And as far as I can tell, that's the _only_ corruption in the whole file, 
but I didn't really double-check.

Does anybody see a pattern?

			Linus
