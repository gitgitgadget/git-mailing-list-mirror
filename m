From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
Date: Sat, 20 Feb 2010 23:27:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 05:37:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj3Q3-0008VZ-Vx
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 05:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063Ab0BUE1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 23:27:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20812 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468Ab0BUE1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 23:27:32 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY6008J7CDVRD60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 20 Feb 2010 23:27:32 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140594>

There is no real advantage to malloc the whole output buffer and
deflate the data in a single pass when writing loose objects. That is
like only 1% faster while using more memory, especially with large
files where memory usage is far more. It is best to deflate and write
the data out in small chunks reusing the same memory instead.

For example, using 'git add' on a few large files averaging 40 MB ...

Before:
21.45user 1.10system 0:22.57elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+828040outputs (0major+142640minor)pagefaults 0swaps

After:
21.50user 1.25system 0:22.76elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+828040outputs (0major+104408minor)pagefaults 0swaps

While the runtime stayed relatively the same, the number of minor page
faults went down significantly.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

I think this is worth doing independently of the paranoid mode being 
discussed.

diff --git a/sha1_file.c b/sha1_file.c
index 657825e..9196b57 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2281,8 +2281,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 			      void *buf, unsigned long len, time_t mtime)
 {
 	int fd, ret;
-	size_t size;
-	unsigned char *compressed;
+	unsigned char compressed[4096];
 	z_stream stream;
 	char *filename;
 	static char tmpfile[PATH_MAX];
@@ -2301,12 +2300,8 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
-	size = 8 + deflateBound(&stream, len+hdrlen);
-	compressed = xmalloc(size);
-
-	/* Compress it */
 	stream.next_out = compressed;
-	stream.avail_out = size;
+	stream.avail_out = sizeof(compressed);
 
 	/* First header.. */
 	stream.next_in = (unsigned char *)hdr;
@@ -2317,20 +2312,21 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	/* Then the data itself.. */
 	stream.next_in = buf;
 	stream.avail_in = len;
-	ret = deflate(&stream, Z_FINISH);
+	do {
+		ret = deflate(&stream, Z_FINISH);
+		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
+			die("unable to write sha1 file");
+		stream.next_out = compressed;
+		stream.avail_out = sizeof(compressed);
+	} while (ret == Z_OK);
+
 	if (ret != Z_STREAM_END)
 		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
-
 	ret = deflateEnd(&stream);
 	if (ret != Z_OK)
 		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
 
-	size = stream.total_out;
-
-	if (write_buffer(fd, compressed, size) < 0)
-		die("unable to write sha1 file");
 	close_sha1_file(fd);
-	free(compressed);
 
 	if (mtime) {
 		struct utimbuf utb;
