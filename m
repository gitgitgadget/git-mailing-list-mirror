From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Wrap inflateInit to retry allocation after releasing pack
	memory
Date: Wed, 7 Jan 2009 19:16:55 -0800
Message-ID: <20090108031655.GH10790@spearce.org>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit> <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain> <20090108030115.GF10790@spearce.org> <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain> <20090108031314.GG10790@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 04:18:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKlPZ-0001s5-L9
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 04:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbZAHDQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 22:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZAHDQ5
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 22:16:57 -0500
Received: from george.spearce.org ([209.20.77.23]:50875 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZAHDQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 22:16:56 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id F00BF38210; Thu,  8 Jan 2009 03:16:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090108031314.GG10790@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104884>

If we are running low on virtual memory we should release pack
windows if zlib's inflateInit fails due to an out of memory error.
It may be that we are running under a low ulimit and are getting
tight on address space.  Shedding unused windows may get us
sufficient working space to continue.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  "Shawn O. Pearce" <spearce@spearce.org> wrote:
  > Linus Torvalds <torvalds@linux-foundation.org> wrote:
  > > The Z_STREAM_ERROR probably comes from inflate() itself - and could very 
  > > easily be due to a allocation error in inflateInit leaving the stream data 
  > > incomplete.
  > > 
  > > Let me try wrapping that dang thing and send a patch. 
  > 
  > Yup.  I'm actually doing the same thing...

 builtin-apply.c          |    2 +-
 builtin-pack-objects.c   |    2 +-
 builtin-unpack-objects.c |    2 +-
 cache.h                  |    1 +
 http-push.c              |    4 ++--
 http-walker.c            |    4 ++--
 index-pack.c             |    4 ++--
 sha1_file.c              |    8 ++++----
 wrapper.c                |   20 ++++++++++++++++++++
 9 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index af25ee9..cb2663e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1258,7 +1258,7 @@ static char *inflate_it(const void *data, unsigned long size,
 	stream.avail_in = size;
 	stream.next_out = out = xmalloc(inflated_size);
 	stream.avail_out = inflated_size;
-	inflateInit(&stream);
+	xinflateInit(&stream);
 	st = inflate(&stream, Z_FINISH);
 	if ((st != Z_STREAM_END) || stream.total_out != inflated_size) {
 		free(out);
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e851534..09576c6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -195,7 +195,7 @@ static int check_pack_inflate(struct packed_git *p,
 	int st;
 
 	memset(&stream, 0, sizeof(stream));
-	inflateInit(&stream);
+	xinflateInit(&stream);
 	do {
 		in = use_pack(p, w_curs, offset, &stream.avail_in);
 		stream.next_in = in;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 47ed610..cb9edac 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -99,7 +99,7 @@ static void *get_data(unsigned long size)
 	stream.avail_out = size;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
-	inflateInit(&stream);
+	xinflateInit(&stream);
 
 	for (;;) {
 		int ret = inflate(&stream, 0);
diff --git a/cache.h b/cache.h
index 231c06d..7d5c38d 100644
--- a/cache.h
+++ b/cache.h
@@ -17,6 +17,7 @@
 #if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
+extern void xinflateInit(z_stream *stream);
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
diff --git a/http-push.c b/http-push.c
index a4b7d08..906ca48 100644
--- a/http-push.c
+++ b/http-push.c
@@ -269,7 +269,7 @@ static void start_fetch_loose(struct transfer_request *request)
 
 	memset(&request->stream, 0, sizeof(request->stream));
 
-	inflateInit(&request->stream);
+	xinflateInit(&request->stream);
 
 	git_SHA1_Init(&request->c);
 
@@ -310,7 +310,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
 		memset(&request->stream, 0, sizeof(request->stream));
-		inflateInit(&request->stream);
+		xinflateInit(&request->stream);
 		git_SHA1_Init(&request->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
diff --git a/http-walker.c b/http-walker.c
index 7271c7d..6aa8486 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -142,7 +142,7 @@ static void start_object_request(struct walker *walker,
 
 	memset(&obj_req->stream, 0, sizeof(obj_req->stream));
 
-	inflateInit(&obj_req->stream);
+	xinflateInit(&obj_req->stream);
 
 	git_SHA1_Init(&obj_req->c);
 
@@ -183,7 +183,7 @@ static void start_object_request(struct walker *walker,
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
 		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
-		inflateInit(&obj_req->stream);
+		xinflateInit(&obj_req->stream);
 		git_SHA1_Init(&obj_req->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
diff --git a/index-pack.c b/index-pack.c
index 2931511..c6bfc12 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -275,7 +275,7 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 	stream.avail_out = size;
 	stream.next_in = fill(1);
 	stream.avail_in = input_len;
-	inflateInit(&stream);
+	xinflateInit(&stream);
 
 	for (;;) {
 		int ret = inflate(&stream, 0);
@@ -382,7 +382,7 @@ static void *get_data_from_pack(struct object_entry *obj)
 	stream.avail_out = obj->size;
 	stream.next_in = src;
 	stream.avail_in = len;
-	inflateInit(&stream);
+	xinflateInit(&stream);
 	while ((st = inflate(&stream, Z_FINISH)) == Z_OK);
 	inflateEnd(&stream);
 	if (st != Z_STREAM_END || stream.total_out != obj->size)
diff --git a/sha1_file.c b/sha1_file.c
index 52d1ead..9aabae2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1196,7 +1196,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	stream->avail_out = bufsiz;
 
 	if (legacy_loose_object(map)) {
-		inflateInit(stream);
+		xinflateInit(stream);
 		return inflate(stream, 0);
 	}
 
@@ -1217,7 +1217,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	/* Set up the stream for the rest.. */
 	stream->next_in = map;
 	stream->avail_in = mapsize;
-	inflateInit(stream);
+	xinflateInit(stream);
 
 	/* And generate the fake traditional header */
 	stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
@@ -1348,7 +1348,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	stream.next_out = delta_head;
 	stream.avail_out = sizeof(delta_head);
 
-	inflateInit(&stream);
+	xinflateInit(&stream);
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
@@ -1585,7 +1585,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	stream.next_out = buffer;
 	stream.avail_out = size;
 
-	inflateInit(&stream);
+	xinflateInit(&stream);
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
diff --git a/wrapper.c b/wrapper.c
index 93562f0..f255eef 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -196,3 +196,23 @@ int xmkstemp(char *template)
 		die("Unable to create temporary file: %s", strerror(errno));
 	return fd;
 }
+
+void xinflateInit(z_stream *stream)
+{
+	switch (inflateInit(stream)) {
+	case Z_OK:
+		return;
+
+	case Z_MEM_ERROR:
+		release_pack_memory(128 * 1024, -1);
+		if (inflateInit(stream) == Z_OK)
+			return;
+		die("Out of memory? inflateInit failed");
+
+	case Z_VERSION_ERROR:
+		die("Wrong zlib version? inflateInit failed");
+
+	default:
+		die("Unknown inflateInit failure");
+	}
+}
-- 
1.6.1.141.gfe98e
