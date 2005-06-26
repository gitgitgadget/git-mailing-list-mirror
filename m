From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sun, 26 Jun 2005 09:41:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org> <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>, Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 18:32:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dma3v-0003Nq-Bu
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 18:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVFZQji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 12:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVFZQji
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 12:39:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11970 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261371AbVFZQj0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 12:39:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5QGcxjA002156
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Jun 2005 09:39:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5QGcuVY010507;
	Sun, 26 Jun 2005 09:38:57 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Jun 2005, Linus Torvalds wrote:
> 
> yeah, it clearly needs some refining to be useful, but I think you can
> kind of see how it would work.

Ok, here's how it works.

 - Pick a starting commit (or a hundred)

 - Pick an ending commit (or a hundred)

 - generate the list of objects in between them

	git-rev-list --object end ^start > object-list

 - Pack that list of objects into an "object pack":

	git-pack-objects out < object-list

   (This actually generates two files: "out.idx" is the index file, 
   "out.pack" is the data file, but I'll make it concatenate the two at 
   some point)

 - move the pack-files over somewhere else

 - unpack them

	git-unpack-objects out

and you're done.

Now, the reason I use "pack" and "unpack" instead of just "tar" to
transport the objects is that this allows me to do a fairly efficient
packing. I wanted these pack-files to be independent (ie they do _not_
depend on any objects outside of the pack-file), but within the objects
described in the pack I cna do delta-compression.

Now, that doesn't much help for small updates (where the objects are just 
unrelated and have no deltas), but it helps increasingly for big ones. The 
biggest one obviously being the whole path from the start to the HEAD..

For example, the "du -sh .git/objects" for the git project itself is 17MB 
for me, and I can do:

	torvalds@ppc970:~/git> du -sh .git/objects 
	17M     .git/objects

	torvalds@ppc970:~/git> time git-rev-list --objects HEAD | git-pack-objects out
	Packing 3656 objects

	real    0m3.779s
	user    0m3.169s
	sys     0m0.602s

	torvalds@ppc970:~/git> ls -lh out.*
	-rw-rw-r--  1 torvalds torvalds  87K Jun 26 09:12 out.idx
	-rw-rw-r--  1 torvalds torvalds 2.0M Jun 26 09:12 out.pack

ie it packs down to a nice 2MB pack-file with a small index. Move that
over to somewhere else, and unpack it, and you'll get all the regular
objects (it doesn't move tags and refs over, you'll have to do that
outside of the packing).

Now, you can trade off some packing time to get a better pack:

	torvalds@ppc970:~/git> time git-rev-list --objects HEAD | git-pack-objects --window=100 out
	Packing 3656 objects
	
	real    0m11.953s
	user    0m11.294s
	sys     0m0.663s

	torvalds@ppc970:~/git> ls -lh out.*
	-rw-rw-r--  1 torvalds torvalds  87K Jun 26 09:14 out.idx
	-rw-rw-r--  1 torvalds torvalds 1.6M Jun 26 09:14 out.pack

and if you want to allow deep delta chains (the default delta depth
limiting is 10), you can get even better results:

	torvalds@ppc970:~/git> time git-rev-list --objects HEAD | git-pack-objects --window=100 --depth=100 out
	Packing 3656 objects
	
	real    0m12.374s
	user    0m11.704s
	sys     0m0.659s

	torvalds@ppc970:~/git> ls -lh out.*
	-rw-rw-r--  1 torvalds torvalds  87K Jun 26 09:16 out.idx
	-rw-rw-r--  1 torvalds torvalds 1.3M Jun 26 09:16 out.pack

but then unpacking will slightly heavier.

(Doing the same for the kernel is obviously much more expensive just
because the kernel is so much bigger. A big delta discovery window like
100 takes about fifteen minutes to pack on my machine, but gets the
current kernel archive down to 70MB or so. That's ok for a monthly "pack
all the objects" to keep size requirements down, but you clearly don't
want to do this all the time ;).

Now, perhaps the more interesting part is that I also designed the pack
format so that it should be a good "history" format, not just a way to
move objects from one place to the other. Ie if you worry about diskspace,
you can pack everything up to the now into one big pack, and then remove
the original objects.

Don't do that yet, btw - I haven't actually written the code to read stuff
out of packs if we don't find it in the object directory yet, but the
layout is such that it should be straightforward and pretty efficient (but
there a deep delta chain obviously _will_ cause a performance hit).

I actually like this approach better than having delta-objects in the
filesystem. Partly because the pack-file is self-contained, partly because
it also solves the fs blocking issue, yet is still efficient to look up
the results without having hardlinks etc to duplicate objects virtually.  
And when you do the packing by hand as an "archival" mechanism, it also
doesn't have any of the downsides that Chris' packing approach had.

Nico? Chris? Interested in giving it a look? It's kind of a combination of 
your things, generalized and then made to have fast lookup with the index.

Fast lookup doesn't matter for a normal unpack, of course, and if I just
always wanted to unpack all the objects (ie just an object transfer
mechanism) I'd have made the index be a toposort of the objects. But
because I wanted to be able to use it as an archival format, I needed it
to be "random-access" by object name. So the index is in fact a binary
tree (well, sorted array, so the lookup degenerates into a binary search)
with a top-level index splitting up the contents based on the first byte
(the same way the filesystem layout does).

		Linus
