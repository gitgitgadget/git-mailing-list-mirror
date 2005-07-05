From: Linus Torvalds <torvalds@osdl.org>
Subject: zlib experts, please..
Date: Tue, 5 Jul 2005 16:57:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507051644100.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 06 01:58:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpxIx-0001z7-5r
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 01:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVGEX6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 19:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVGEX6J
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 19:58:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261973AbVGEX6B (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 19:58:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j65NvwjA004941
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Tue, 5 Jul 2005 16:57:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j65Nvts9032767
	for <git@vger.kernel.org>; Tue, 5 Jul 2005 16:57:57 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I just hit an interesting pack failure because of how git (mis-)uses zlib, 
and I'm wondering what to do about it.

In particular, the "git-unpack-objects" code gets a data stream, and only
knows the _unpacked_ size of each object, because writing packed size is
extremely inconvenient in many ways (let me count the ways.. At pack time,
we want to fill in the size field before we've even packed things, and at
unpack time, we really don't care about the packed size, but we _do_ care
about the unpacked size in order to be able to allocate the right sized
allocation for the result).

However, it turns out that there's a silly special case: a zero-sized 
"blob" object will ne encoded as a single byte "0x30" followed by the 
"packed representation of empty".

Now, you'd expect the packed representation of empty to be empty, but 
that's not apparently what zlib does. It actually seems to pack zero bytes 
as 8 bytes of "78 9c 03 00 00 00 00 01". Which is fine, I don't care, with 
git this will literally happen for only one single object, so it's not 
like I care about the expansion.

But what I care about is that when git-unpack-objects sees that it wants a 
zero-byte object, and asks zlib to unpack it, zlib will not actually use 
the bytes it wrote - it will just say "oh, you wanted zero bytes, here's 
zero bytes". Which means that the stream handling gets upset.

Now, I can easily fix this by just teaching the packing code that it 
should pack the zero-byte object as zero bytes, and not let zlib mess it 
up. In fact, I've done exactly that. However, now I worry that there's 
some other case where zlib uncompression doesn't eat everything that zlib 
compression generated. I've not found it, and I think a zero sized case is 
special (it's kind of like a "break" event), but this is yet another cry 
for zlib expertise in case somebody knows...

		Linus
