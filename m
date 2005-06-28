From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Tue, 28 Jun 2005 12:28:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org> <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 21:41:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnLsS-0000R3-Sg
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 21:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVF1Tf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 15:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVF1TeV
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 15:34:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261189AbVF1T05 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 15:26:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SJQajA010973
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 12:26:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SJQUal021631;
	Tue, 28 Jun 2005 12:26:33 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Nicolas Pitre wrote:
> 
> Here's one improvement to the pack format, breaking it early so it won't 
> affect anyone at this point: compressed object header.  Instead of the 
> fixed 5 byte header, this patch convert it to a variable size granted 
> most object are small enough to save on the storage of the significant 
> size bytes which will be zero and packing the non-zero byte position 
> with the object type.

Ok, this is against an older version and doesn't have that "read_sha1" 
thing, but yes, something like this would work.

I'd prefer the encoding to be a bit different, though: make the size be
encoded in seven bits per byte, with the high bit meaning "more to come". 
We can use four bits from the "type" byte for the initial value, making 
lengths 0-15 be free.

	unsigned long size;
	unsigned char c;

	c = *pack++;
	type = 
	size = c & 15;
	type = (c >> 4) & 7;
	while (c & 0x80) {
		c = *pack++;
		size = (size << 7) + (pack & 0x7f);
	}

or something. That's even denser.

However, I also end up wanting to add a "global header" to the pack-file, 
that contains at least the number of objects packed. We may not know how 
big the pack-file will be, but we'll at least know how many objects it 
has before we start writing it.

		Linus
