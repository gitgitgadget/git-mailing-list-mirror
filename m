X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Mon, 18 Dec 2006 22:47:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 06:47:46 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219051108.GA29405@thunk.org>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34789>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwYlJ-0004wO-Aj for gcvg-git@gmane.org; Tue, 19 Dec
 2006 07:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752874AbWLSGri (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 01:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbWLSGri
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 01:47:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58797 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752877AbWLSGrh
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 01:47:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBJ6lPID018622
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 18
 Dec 2006 22:47:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBJ6lOTr025363; Mon, 18 Dec
 2006 22:47:25 -0800
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Theodore Tso wrote:
> 
> Actually, depending on the size of the chunk, even on Linux
> malloc/read/free can be faster than the mmap/munmap

Yes.

In general, mmap/munmap is faster only if:
 - you access the same data multiple times within one page (ie a single 
   page-fault will actually result in more than one access)
OR
 - you can use it to avoid management overhead (ie you know your data is 
   going to accessed very sparsely, but you don't know the patterns, and 
   trying to keep track of it is painful as hell)

That said, under Linux, mmap is almost never really _slower_ either, which 
is why this issue never made any real difference. The overhead of doing 
page table manipulation is pretty much balanced out by the overhead of 
doing a memcpy.

But that "mmap is fast" is _not_ true on many other operating systems, 
which is why it might be worthwhile to try something like the appended on 
OS X, which uses pread() instead of mmap().

This is _not_ very much tested. It seems to work. Caveat emptor. It would 
be interesting to hear if many small "pread()" calls are faster than many 
mmap/munmap calls on OS X. I bet they are. Under Linux, there should be 
almost no difference.

		Linus
---
diff --git a/index-pack.c b/index-pack.c
index 6d6c92b..094f8b2 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -8,6 +8,7 @@
 #include "tree.h"
 #include <sys/time.h>
 #include <signal.h>
+#include <unistd.h>
 
 static const char index_pack_usage[] =
 "git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
@@ -279,27 +280,25 @@ static void *get_data_from_pack(struct object_entry *obj)
 {
 	unsigned long from = obj[0].offset + obj[0].hdr_size;
 	unsigned long len = obj[1].offset - from;
-	unsigned pg_offset = from % getpagesize();
-	unsigned char *map, *data;
+	unsigned char *src, *data;
 	z_stream stream;
 	int st;
 
-	map = mmap(NULL, len + pg_offset, PROT_READ, MAP_PRIVATE,
-		   mmap_fd, from - pg_offset);
-	if (map == MAP_FAILED)
-		die("cannot mmap pack file: %s", strerror(errno));
+	src = xmalloc(len);
+	if (pread(mmap_fd, src, len, from) != len)
+		die("cannot pread pack file: %s", strerror(errno));
 	data = xmalloc(obj->size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = data;
 	stream.avail_out = obj->size;
-	stream.next_in = map + pg_offset;
+	stream.next_in = src;
 	stream.avail_in = len;
 	inflateInit(&stream);
 	while ((st = inflate(&stream, Z_FINISH)) == Z_OK);
 	inflateEnd(&stream);
 	if (st != Z_STREAM_END || stream.total_out != obj->size)
 		die("serious inflate inconsistency");
-	munmap(map, len + pg_offset);
+	free(src);
 	return data;
 }
