From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
 pack memory
Date: Wed, 7 Jan 2009 19:54:47 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit> <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
 <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain> <20090108030115.GF10790@spearce.org> <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain> <20090108031314.GG10790@spearce.org>
 <20090108031655.GH10790@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 05:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKm83-0002Jb-20
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 05:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbZAHECw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 23:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbZAHECv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 23:02:51 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37040 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752370AbZAHECu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 23:02:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0841RLn029389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 20:01:29 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n083slC9002851;
	Wed, 7 Jan 2009 19:54:47 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090108031655.GH10790@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.448 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104886>



On Wed, 7 Jan 2009, Shawn O. Pearce wrote:
>
> If we are running low on virtual memory we should release pack
> windows if zlib's inflateInit fails due to an out of memory error.
> It may be that we are running under a low ulimit and are getting
> tight on address space.  Shedding unused windows may get us
> sufficient working space to continue.

Let's do this (more complete) wrapping instead, ok?

This one _just_ wraps things, btw - it doesn't do the "retry on low memory 
error" part, at least not yet. I think that's an independent issue from 
the reporting.

Hmm? 

Tyler - does this make the corruption errors go away, and be replaced by 
hard failures with "out of memory" reporting?

This patch is potentially pretty noisy, on purpose. I didn't remove the 
reporting from places that already do so - some of them have stricter 
errors than this.

For example: Z_BUF_ERROR can be valid depending on circumstance, so the 
wrapper doesn't complain about it, but the caller may not accept it. 

		Linus

---
 builtin-apply.c          |    5 ++-
 builtin-pack-objects.c   |    6 ++--
 builtin-unpack-objects.c |    6 ++--
 cache.h                  |    4 +++
 http-push.c              |    8 +++---
 http-walker.c            |    8 +++---
 index-pack.c             |   12 ++++----
 sha1_file.c              |   24 +++++++++---------
 wrapper.c                |   60 ++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 99 insertions(+), 34 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 07244b0..ed02b6d 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1253,8 +1253,9 @@ static char *inflate_it(const void *data, unsigned long size,
 	stream.avail_in = size;
 	stream.next_out = out = xmalloc(inflated_size);
 	stream.avail_out = inflated_size;
-	inflateInit(&stream);
-	st = inflate(&stream, Z_FINISH);
+	git_inflate_init(&stream);
+	st = git_inflate(&stream, Z_FINISH);
+	git_inflate_end(&stream);
 	if ((st != Z_STREAM_END) || stream.total_out != inflated_size) {
 		free(out);
 		return NULL;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e851534..cb51916 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -195,16 +195,16 @@ static int check_pack_inflate(struct packed_git *p,
 	int st;
 
 	memset(&stream, 0, sizeof(stream));
-	inflateInit(&stream);
+	git_inflate_init(&stream);
 	do {
 		in = use_pack(p, w_curs, offset, &stream.avail_in);
 		stream.next_in = in;
 		stream.next_out = fakebuf;
 		stream.avail_out = sizeof(fakebuf);
-		st = inflate(&stream, Z_FINISH);
+		st = git_inflate(&stream, Z_FINISH);
 		offset += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
-	inflateEnd(&stream);
+	git_inflate_end(&stream);
 	return (st == Z_STREAM_END &&
 		stream.total_out == expect &&
 		stream.total_in == len) ? 0 : -1;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 47ed610..9a77323 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -99,10 +99,10 @@ static void *get_data(unsigned long size)
 	stream.avail_out = size;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
-	inflateInit(&stream);
+	git_inflate_init(&stream);
 
 	for (;;) {
-		int ret = inflate(&stream, 0);
+		int ret = git_inflate(&stream, 0);
 		use(len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
@@ -118,7 +118,7 @@ static void *get_data(unsigned long size)
 		stream.next_in = fill(1);
 		stream.avail_in = len;
 	}
-	inflateEnd(&stream);
+	git_inflate_end(&stream);
 	return buf;
 }
 
diff --git a/cache.h b/cache.h
index 231c06d..49e54fb 100644
--- a/cache.h
+++ b/cache.h
@@ -18,6 +18,10 @@
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
+void git_inflate_init(z_streamp strm);
+void git_inflate_end(z_streamp strm);
+int git_inflate(z_streamp strm, int flush);
+
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/http-push.c b/http-push.c
index 7c64609..809002b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -208,7 +208,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	do {
 		request->stream.next_out = expn;
 		request->stream.avail_out = sizeof(expn);
-		request->zret = inflate(&request->stream, Z_SYNC_FLUSH);
+		request->zret = git_inflate(&request->stream, Z_SYNC_FLUSH);
 		git_SHA1_Update(&request->c, expn,
 			    sizeof(expn) - request->stream.avail_out);
 	} while (request->stream.avail_in && request->zret == Z_OK);
@@ -268,7 +268,7 @@ static void start_fetch_loose(struct transfer_request *request)
 
 	memset(&request->stream, 0, sizeof(request->stream));
 
-	inflateInit(&request->stream);
+	git_inflate_init(&request->stream);
 
 	git_SHA1_Init(&request->c);
 
@@ -309,7 +309,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
 		memset(&request->stream, 0, sizeof(request->stream));
-		inflateInit(&request->stream);
+		git_inflate_init(&request->stream);
 		git_SHA1_Init(&request->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
@@ -741,7 +741,7 @@ static void finish_request(struct transfer_request *request)
 			if (request->http_code == 416)
 				fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
 
-			inflateEnd(&request->stream);
+			git_inflate_end(&request->stream);
 			git_SHA1_Final(request->real_sha1, &request->c);
 			if (request->zret != Z_STREAM_END) {
 				unlink(request->tmpfile);
diff --git a/http-walker.c b/http-walker.c
index 7271c7d..0dbad3c 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -82,7 +82,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	do {
 		obj_req->stream.next_out = expn;
 		obj_req->stream.avail_out = sizeof(expn);
-		obj_req->zret = inflate(&obj_req->stream, Z_SYNC_FLUSH);
+		obj_req->zret = git_inflate(&obj_req->stream, Z_SYNC_FLUSH);
 		git_SHA1_Update(&obj_req->c, expn,
 			    sizeof(expn) - obj_req->stream.avail_out);
 	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
@@ -142,7 +142,7 @@ static void start_object_request(struct walker *walker,
 
 	memset(&obj_req->stream, 0, sizeof(obj_req->stream));
 
-	inflateInit(&obj_req->stream);
+	git_inflate_init(&obj_req->stream);
 
 	git_SHA1_Init(&obj_req->c);
 
@@ -183,7 +183,7 @@ static void start_object_request(struct walker *walker,
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
 		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
-		inflateInit(&obj_req->stream);
+		git_inflate_init(&obj_req->stream);
 		git_SHA1_Init(&obj_req->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
@@ -243,7 +243,7 @@ static void finish_object_request(struct object_request *obj_req)
 		return;
 	}
 
-	inflateEnd(&obj_req->stream);
+	git_inflate_end(&obj_req->stream);
 	git_SHA1_Final(obj_req->real_sha1, &obj_req->c);
 	if (obj_req->zret != Z_STREAM_END) {
 		unlink(obj_req->tmpfile);
diff --git a/index-pack.c b/index-pack.c
index 60ed41a..c0a3d97 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -275,10 +275,10 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 	stream.avail_out = size;
 	stream.next_in = fill(1);
 	stream.avail_in = input_len;
-	inflateInit(&stream);
+	git_inflate_init(&stream);
 
 	for (;;) {
-		int ret = inflate(&stream, 0);
+		int ret = git_inflate(&stream, 0);
 		use(input_len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
@@ -287,7 +287,7 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
 		stream.next_in = fill(1);
 		stream.avail_in = input_len;
 	}
-	inflateEnd(&stream);
+	git_inflate_end(&stream);
 	return buf;
 }
 
@@ -382,9 +382,9 @@ static void *get_data_from_pack(struct object_entry *obj)
 	stream.avail_out = obj->size;
 	stream.next_in = src;
 	stream.avail_in = len;
-	inflateInit(&stream);
-	while ((st = inflate(&stream, Z_FINISH)) == Z_OK);
-	inflateEnd(&stream);
+	git_inflate_init(&stream);
+	while ((st = git_inflate(&stream, Z_FINISH)) == Z_OK);
+	git_inflate_end(&stream);
 	if (st != Z_STREAM_END || stream.total_out != obj->size)
 		die("serious inflate inconsistency");
 	free(src);
diff --git a/sha1_file.c b/sha1_file.c
index 52d1ead..8600b04 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1196,8 +1196,8 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	stream->avail_out = bufsiz;
 
 	if (legacy_loose_object(map)) {
-		inflateInit(stream);
-		return inflate(stream, 0);
+		git_inflate_init(stream);
+		return git_inflate(stream, 0);
 	}
 
 
@@ -1217,7 +1217,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	/* Set up the stream for the rest.. */
 	stream->next_in = map;
 	stream->avail_in = mapsize;
-	inflateInit(stream);
+	git_inflate_init(stream);
 
 	/* And generate the fake traditional header */
 	stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
@@ -1254,11 +1254,11 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 		stream->next_out = buf + bytes;
 		stream->avail_out = size - bytes;
 		while (status == Z_OK)
-			status = inflate(stream, Z_FINISH);
+			status = git_inflate(stream, Z_FINISH);
 	}
 	buf[size] = 0;
 	if (status == Z_STREAM_END && !stream->avail_in) {
-		inflateEnd(stream);
+		git_inflate_end(stream);
 		return buf;
 	}
 
@@ -1348,15 +1348,15 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	stream.next_out = delta_head;
 	stream.avail_out = sizeof(delta_head);
 
-	inflateInit(&stream);
+	git_inflate_init(&stream);
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
-		st = inflate(&stream, Z_FINISH);
+		st = git_inflate(&stream, Z_FINISH);
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
-	inflateEnd(&stream);
+	git_inflate_end(&stream);
 	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head)) {
 		error("delta data unpack-initial failed");
 		return 0;
@@ -1585,14 +1585,14 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	stream.next_out = buffer;
 	stream.avail_out = size;
 
-	inflateInit(&stream);
+	git_inflate_init(&stream);
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
-		st = inflate(&stream, Z_FINISH);
+		st = git_inflate(&stream, Z_FINISH);
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
-	inflateEnd(&stream);
+	git_inflate_end(&stream);
 	if ((st != Z_STREAM_END) || stream.total_out != size) {
 		free(buffer);
 		return NULL;
@@ -2017,7 +2017,7 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	else if (sizep)
 		*sizep = size;
-	inflateEnd(&stream);
+	git_inflate_end(&stream);
 	munmap(map, mapsize);
 	return status;
 }
diff --git a/wrapper.c b/wrapper.c
index 93562f0..29afa96 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -196,3 +196,63 @@ int xmkstemp(char *template)
 		die("Unable to create temporary file: %s", strerror(errno));
 	return fd;
 }
+
+/*
+ * zlib wrappers to make sure we don't silently miss errors
+ * at init time.
+ */
+void git_inflate_init(z_streamp strm)
+{
+	const char *err;
+
+	switch (inflateInit(strm)) {
+	case Z_OK:
+		return;
+
+	case Z_MEM_ERROR:
+		err = "out of memory";
+		break;
+	case Z_VERSION_ERROR:
+		err = "wrong version";
+		break;
+	default:
+		err = "error";
+	}
+	die("inflateInit: %s (%s)", err, strm->msg ? strm->msg : "no message");
+}
+
+void git_inflate_end(z_streamp strm)
+{
+	if (inflateEnd(strm) != Z_OK)
+		error("inflateEnd: %s", strm->msg ? strm->msg : "failed");
+}
+
+int git_inflate(z_streamp strm, int flush)
+{
+	int ret = inflate(strm, flush);
+	const char *err;
+
+	switch (ret) {
+	/* Out of memory is fatal. */
+	case Z_MEM_ERROR:
+		die("inflate: out of memory");
+
+	/* Data corruption errors: we may want to recover from them (fsck) */
+	case Z_NEED_DICT:
+		err = "needs dictionary"; break;
+	case Z_DATA_ERROR:
+		err = "data stream error"; break;
+	case Z_STREAM_ERROR:
+		err = "stream consistency error"; break;
+	default:
+		err = "unknown error"; break;
+
+	/* Z_BUF_ERROR: normal, needs a buffer output buffer */
+	case Z_BUF_ERROR:
+	case Z_OK:
+	case Z_STREAM_END:
+		return ret;
+	}
+	error("inflate: %s (%s)", err, strm->msg ? strm->msg : "no message");
+	return ret;
+}
