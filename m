X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] index-pack usage of mmap() is unacceptably slower on many OSes
 other than Linux
Date: Tue, 19 Dec 2006 10:53:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612191027270.18171@xanadu.home>
References: <86y7p57y05.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181906450.18171@xanadu.home>
 <20061219051108.GA29405@thunk.org>
 <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
 <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 19 Dec 2006 15:53:18 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34832>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwhHF-0001E9-Uo for gcvg-git@gmane.org; Tue, 19 Dec
 2006 16:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753064AbWLSPxK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 10:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbWLSPxK
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 10:53:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51196 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753051AbWLSPxJ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 10:53:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAJ00FV62SKQGQ0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Tue,
 19 Dec 2006 10:53:08 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

It was reported by Randal L. Schwartz <merlyn@stonehenge.com> that 
indexing the Linux repository ~150MB pack takes about an hour on OS x 
while it's a minute on Linux.  It seems that the OS X mmap() 
implementation is more than 2 orders of magnitude slower than the Linux 
one.

Linus proposed a patch replacing mmap() with pread() bringing index-pack 
performance on OS X in line with the Linux one.  The performances on 
Linux also improved by a small margin.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

OK looks like this has been sorted out while I was away.  Good!

On Tue, 19 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > in a very unscientific test, without your patch local cloning of the 
> > LilyPond repo takes 1m33s (user), and with your patch (pread() instead of 
> > mmap()) it takes 1m13s (user). The real times are somewhat bogus, but 
> > still in favour of pread(), but only by 8 seconds instead of 20.
> >
> > This is on Linux 2.4.32.
> 
> Interesting.  Anybody have numbers from 2.6?

My 37 seconds of yesterday dropped to 32.

This is Linus's patch plus a few cosmetic changes.

diff --git a/index-pack.c b/index-pack.c
index 6d6c92b..e08a687 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -1,3 +1,8 @@
+#define _XOPEN_SOURCE 500
+#include <unistd.h>
+#include <sys/time.h>
+#include <signal.h>
+
 #include "cache.h"
 #include "delta.h"
 #include "pack.h"
@@ -6,8 +11,6 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
-#include <sys/time.h>
-#include <signal.h>
 
 static const char index_pack_usage[] =
 "git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
@@ -87,7 +90,7 @@ static unsigned display_progress(unsigned n, unsigned total, unsigned last_pc)
 static unsigned char input_buffer[4096];
 static unsigned long input_offset, input_len, consumed_bytes;
 static SHA_CTX input_ctx;
-static int input_fd, output_fd, mmap_fd;
+static int input_fd, output_fd, pack_fd;
 
 /* Discard current buffer used content. */
 static void flush(void)
@@ -148,14 +151,14 @@ static const char *open_pack_file(const char *pack_name)
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
 			die("unable to create %s: %s\n", pack_name, strerror(errno));
-		mmap_fd = output_fd;
+		pack_fd = output_fd;
 	} else {
 		input_fd = open(pack_name, O_RDONLY);
 		if (input_fd < 0)
 			die("cannot open packfile '%s': %s",
 			    pack_name, strerror(errno));
 		output_fd = -1;
-		mmap_fd = input_fd;
+		pack_fd = input_fd;
 	}
 	SHA1_Init(&input_ctx);
 	return pack_name;
@@ -279,27 +282,25 @@ static void *get_data_from_pack(struct object_entry *obj)
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
+	if (pread(pack_fd, src, len, from) != len)
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
