From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sun, 26 Jun 2005 12:19:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506261206170.19755@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org> <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org> <7vzmtdq7wy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>, Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 21:11:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmcWi-0001Pk-Mz
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 21:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVFZTR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 15:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVFZTR0
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 15:17:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261573AbVFZTRU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 15:17:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5QJH2jA011616
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Jun 2005 12:17:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5QJH1LU016343;
	Sun, 26 Jun 2005 12:17:02 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmtdq7wy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 26 Jun 2005, Junio C Hamano wrote:
> 
> My preference is to do things in this order:
> 
>  (0) concatenate pack and idx files;

Actually, I was originally planning to do that, but now that I have 
thought about what read_sha1_file() would actually do, I think it's more 
efficient to leave the index as a separate file.

In particular, what you'd normally do is that if you can't look up the
file in the regular object directory, you start going through the pack
files. You can do it by having GIT_ALTERNATE_OBJECT_DIRECTORIES point to a
pack file, but I actually would prefer the notion of just adding a

	.git/objects/pack

subdirectory, and having object lookup just automatically open and map all 
index files in that subdirectory.

And the thing is, you really just want to map the index files, the data
files can be so big that you can't afford to map them (ie a really big
project might have several pack-files a gig each or something like that).

And the most efficient way to map just the index file is to keep it 
separate, because then the "stat()" will just get the information 
directly, and you then just mmap that. 

The alternative is to first read the index of the index (to figure out how
big the index is), and then map the rest. But that just seems a lot
messier than just mapping the index file directly.

And when creating these things, we do need to create the data file (which 
can be big enough that it doesn't fit in memory) first, so we have to have 
a separate file for it, we can't just stream it out to stdout.

Now, when _sending_ the pack-files, linearizing them is easy: you just 
send the index first, and the data file immediately afterwards. The index 
tells how big it is, so there's no need to even add any markers: you can 
do something like 'git-send-script' with something simple like

	git-rev-list ... | git-pack-file tmp-pack &&
	cat tmp-pack.idx tmp-pack.data | ssh other git-receive-script

So let's just keep the index/data files separate.

		Linus
