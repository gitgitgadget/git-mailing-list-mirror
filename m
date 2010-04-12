From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] index-pack: smarter memory usage when appending objects
Date: Mon, 12 Apr 2010 16:50:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004121639170.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 00:15:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Ruz-0002Ps-EY
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 00:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab0DLWPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 18:15:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52226 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab0DLWPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 18:15:35 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0S00IL878BTVM0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Apr 2010 16:50:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144771>

In the same spirit as commit 9892bebafe, let's avoid allocating the full
buffer for the deflated data in write_compressed() in order to write it.
Let's deflate and write the data in chunks instead to reduce memory
usage.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4308abb..c1e0394 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -669,25 +669,25 @@ static void parse_pack_objects(unsigned char *sha1)
 static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 {
 	z_stream stream;
-	unsigned long maxsize;
-	void *out;
+	int status;
+	unsigned char outbuf[4096];
 
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
-	maxsize = deflateBound(&stream, size);
-	out = xmalloc(maxsize);
-
-	/* Compress it */
 	stream.next_in = in;
 	stream.avail_in = size;
-	stream.next_out = out;
-	stream.avail_out = maxsize;
-	while (deflate(&stream, Z_FINISH) == Z_OK);
-	deflateEnd(&stream);
 
+	do {
+		stream.next_out = outbuf;
+		stream.avail_out = sizeof(outbuf);
+		status = deflate(&stream, Z_FINISH);
+		sha1write(f, outbuf, sizeof(outbuf) - stream.avail_out);
+	} while (status == Z_OK); 
+
+	if (status != Z_STREAM_END)
+		die("unable to deflate appended object (%d)", status);
 	size = stream.total_out;
-	sha1write(f, out, size);
-	free(out);
+	deflateEnd(&stream);
 	return size;
 }
 
