From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH v2] fix openssl headers conflicting with custom SHA1
 implementations
Date: Wed, 01 Oct 2008 14:05:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810011341040.3635@xanadu.home>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home>
 <20080930203928.GN21310@spearce.org>
 <alpine.LFD.2.00.0809301645340.3635@xanadu.home>
 <20080930205122.GO21310@spearce.org>
 <20081001034712.GE24513@coredump.intra.peff.net>
 <20081001155458.GF21310@spearce.org>
 <20081001160418.GA13917@coredump.intra.peff.net>
 <20081001161047.GG21310@spearce.org>
 <alpine.LFD.2.00.0810011222090.3635@xanadu.home>
 <20081001163952.GJ21310@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 20:07:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl66H-0006sG-6H
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 20:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbYJASFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 14:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbYJASFb
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 14:05:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41005 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbYJASF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 14:05:28 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8200C5VNKW7AJ0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Oct 2008 14:05:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081001163952.GJ21310@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97251>

On ARM I have the following compilation errors:

    CC fast-import.o
In file included from cache.h:8,
                 from builtin.h:6,
                 from fast-import.c:142:
arm/sha1.h:14: error: conflicting types for 'SHA_CTX'
/usr/include/openssl/sha.h:105: error: previous declaration of 'SHA_CTX' was here
arm/sha1.h:16: error: conflicting types for 'SHA1_Init'
/usr/include/openssl/sha.h:115: error: previous declaration of 'SHA1_Init' was here
arm/sha1.h:17: error: conflicting types for 'SHA1_Update'
/usr/include/openssl/sha.h:116: error: previous declaration of 'SHA1_Update' was here
arm/sha1.h:18: error: conflicting types for 'SHA1_Final'
/usr/include/openssl/sha.h:117: error: previous declaration of 'SHA1_Final' was here
make: *** [fast-import.o] Error 1

This is because openssl header files are always included in 
git-compat-util.h since commit 684ec6c63c whenever NO_OPENSSL is not 
set, which somehow brings in <openssl/sha1.h> clashing with the custom 
ARM version.  Compilation of git is probably broken on PPC too for the 
same reason.

Turns out that the only file requiring openssl/ssl.h and openssl/err.h 
is imap-send.c.  But only moving those problematic includes there 
doesn't solve the issue as it also includes cache.h which brings in the 
conflicting local SHA1 header file.

As suggested by Jeff King, the best solution is to rename our references
to SHA1 functions and structure to something git specific, and define those
according to the implementation used. 

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

On Wed, 1 Oct 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 1 Oct 2008, Shawn O. Pearce wrote:
> > > Jeff King <peff@peff.net> wrote:
> > > > On Wed, Oct 01, 2008 at 08:54:58AM -0700, Shawn O. Pearce wrote:
> > > > 
> > > > > I think its easy enough to just rename our SHA_CTX and SHA_*
> > > > > functions to something more git specific.  Since its mostly a 
global
> > > > 
> > > > I think that is the cleanest and simplest solution. As for merging pain,
> > > > I think Junio would generally do a mechanical change like this as the
> > > > first thing after a release. However, in this case, I think we might
> > > > want it sooner if the conflict is causing breakage.
> > > 
> > > Oh, yea, that's probably true.  But with ARM broken according to
> > > Nico I'd almost just want this fixed in the upcoming 1.6.1 release.
> > 
> > > Its simple enough to do.  We can even do something like this during
> > > the transition period until right before the 1.6.1 final:
> > 
> > Because it's easy to do then I'd do it sooner than later.
> 
> Nico, are you going to write a patch for this?

Here it is.  Tested with straight openssl, the mozilla version, and the 
ARM version.  Can't test the ppc version but this should look straight 
forward enough.

 arm/sha1.c               |   16 ++++++++--------
 arm/sha1.h               |   15 ++++++++++-----
 arm/sha1_arm.S           |    4 ++--
 builtin-unpack-objects.c |   10 +++++-----
 cache.h                  |    8 +++++++-
 csum-file.c              |    8 ++++----
 csum-file.h              |    2 +-
 diff.c                   |   12 ++++++------
 fast-import.c            |   18 +++++++++---------
 http-push.c              |   10 +++++-----
 http-walker.c            |   10 +++++-----
 index-pack.c             |    8 ++++----
 mozilla-sha1/sha1.c      |   18 +++++++++---------
 mozilla-sha1/sha1.h      |   13 +++++++++----
 pack-check.c             |   16 ++++++++--------
 pack-write.c             |   30 +++++++++++++++---------------
 patch-id.c               |   12 ++++++------
 ppc/sha1.c               |   18 +++++++++---------
 ppc/sha1.h               |   15 ++++++++++-----
 ppc/sha1ppc.S            |    4 ++--
 read-cache.c             |   28 ++++++++++++++--------------
 rerere.c                 |   10 +++++-----
 sha1_file.c              |   10 +++++-----
 test-sha1.c              |    8 ++++----
 24 files changed, 162 insertions(+), 141 deletions(-)

diff --git a/arm/sha1.c b/arm/sha1.c
index 9e3ae03..c61ad4a 100644
--- a/arm/sha1.c
+++ b/arm/sha1.c
@@ -8,9 +8,9 @@
 #include <string.h>
 #include "sha1.h"
 
-extern void sha_transform(uint32_t *hash, const unsigned char *data, uint32_t *W);
+extern void arm_sha_transform(uint32_t *hash, const unsigned char *data, uint32_t *W);
 
-void SHA1_Init(SHA_CTX *c)
+void arm_SHA1_Init(arm_SHA_CTX *c)
 {
 	c->len = 0;
 	c->hash[0] = 0x67452301;
@@ -20,7 +20,7 @@ void SHA1_Init(SHA_CTX *c)
 	c->hash[4] = 0xc3d2e1f0;
 }
 
-void SHA1_Update(SHA_CTX *c, const void *p, unsigned long n)
+void arm_SHA1_Update(arm_SHA_CTX *c, const void *p, unsigned long n)
 {
 	uint32_t workspace[80];
 	unsigned int partial;
@@ -32,12 +32,12 @@ void SHA1_Update(SHA_CTX *c, const void *p, unsigned long n)
 		if (partial) {
 			done = 64 - partial;
 			memcpy(c->buffer + partial, p, done);
-			sha_transform(c->hash, c->buffer, workspace);
+			arm_sha_transform(c->hash, c->buffer, workspace);
 			partial = 0;
 		} else
 			done = 0;
 		while (n >= done + 64) {
-			sha_transform(c->hash, p + done, workspace);
+			arm_sha_transform(c->hash, p + done, workspace);
 			done += 64;
 		}
 	} else
@@ -46,7 +46,7 @@ void SHA1_Update(SHA_CTX *c, const void *p, unsigned long n)
 		memcpy(c->buffer + partial, p + done, n - done);
 }
 
-void SHA1_Final(unsigned char *hash, SHA_CTX *c)
+void arm_SHA1_Final(unsigned char *hash, arm_SHA_CTX *c)
 {
 	uint64_t bitlen;
 	uint32_t bitlen_hi, bitlen_lo;
@@ -57,7 +57,7 @@ void SHA1_Final(unsigned char *hash, SHA_CTX *c)
 	bitlen = c->len << 3;
 	offset = c->len & 0x3f;
 	padlen = ((offset < 56) ? 56 : (64 + 56)) - offset;
-	SHA1_Update(c, padding, padlen);
+	arm_SHA1_Update(c, padding, padlen);
 
 	bitlen_hi = bitlen >> 32;
 	bitlen_lo = bitlen & 0xffffffff;
@@ -69,7 +69,7 @@ void SHA1_Final(unsigned char *hash, SHA_CTX *c)
 	bits[5] = bitlen_lo >> 16;
 	bits[6] = bitlen_lo >> 8;
 	bits[7] = bitlen_lo;
-	SHA1_Update(c, bits, 8);
+	arm_SHA1_Update(c, bits, 8);
 
 	for (i = 0; i < 5; i++) {
 		uint32_t v = c->hash[i];
diff --git a/arm/sha1.h b/arm/sha1.h
index 3952646..b61b618 100644
--- a/arm/sha1.h
+++ b/arm/sha1.h
@@ -7,12 +7,17 @@
 
 #include <stdint.h>
 
-typedef struct sha_context {
+typedef struct {
 	uint64_t len;
 	uint32_t hash[5];
 	unsigned char buffer[64];
-} SHA_CTX;
+} arm_SHA_CTX;
 
-void SHA1_Init(SHA_CTX *c);
-void SHA1_Update(SHA_CTX *c, const void *p, unsigned long n);
-void SHA1_Final(unsigned char *hash, SHA_CTX *c);
+void arm_SHA1_Init(arm_SHA_CTX *c);
+void arm_SHA1_Update(arm_SHA_CTX *c, const void *p, unsigned long n);
+void arm_SHA1_Final(unsigned char *hash, arm_SHA_CTX *c);
+
+#define git_SHA_CTX	arm_SHA_CTX
+#define git_SHA1_Init	arm_SHA1_Init
+#define git_SHA1_Update	arm_SHA1_Update
+#define git_SHA1_Final	arm_SHA1_Final
diff --git a/arm/sha1_arm.S b/arm/sha1_arm.S
index 8c1cb99..41e9263 100644
--- a/arm/sha1_arm.S
+++ b/arm/sha1_arm.S
@@ -10,7 +10,7 @@
  */
 
 	.text
-	.globl	sha_transform
+	.globl	arm_sha_transform
 
 /*
  * void sha_transform(uint32_t *hash, const unsigned char *data, uint32_t *W);
@@ -18,7 +18,7 @@
  * note: the "data" pointer may be unaligned.
  */
 
-sha_transform:
+arm_sha_transform:
 
 	stmfd	sp!, {r4 - r8, lr}
 
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 40b20f2..d2796b6 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -19,7 +19,7 @@ static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]
 static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
-static SHA_CTX ctx;
+static git_SHA_CTX ctx;
 
 /*
  * When running under --strict mode, objects whose reachability are
@@ -59,7 +59,7 @@ static void *fill(int min)
 	if (min > sizeof(buffer))
 		die("cannot fill %d bytes", min);
 	if (offset) {
-		SHA1_Update(&ctx, buffer, offset);
+		git_SHA1_Update(&ctx, buffer, offset);
 		memmove(buffer, buffer + offset, len);
 		offset = 0;
 	}
@@ -539,10 +539,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 		/* We don't take any non-flag arguments now.. Maybe some day */
 		usage(unpack_usage);
 	}
-	SHA1_Init(&ctx);
+	git_SHA1_Init(&ctx);
 	unpack_all();
-	SHA1_Update(&ctx, buffer, offset);
-	SHA1_Final(sha1, &ctx);
+	git_SHA1_Update(&ctx, buffer, offset);
+	git_SHA1_Final(sha1, &ctx);
 	if (strict)
 		write_rest();
 	if (hashcmp(fill(20), sha1))
diff --git a/cache.h b/cache.h
index f4b8ddf..9ff1b2f 100644
--- a/cache.h
+++ b/cache.h
@@ -6,8 +6,14 @@
 #include "hash.h"
 
 #include SHA1_HEADER
-#include <zlib.h>
+#ifndef git_SHA_CTX
+#define git_SHA_CTX	SHA_CTX
+#define git_SHA1_Init	SHA1_Init
+#define git_SHA1_Update	SHA1_Update
+#define git_SHA1_Final	SHA1_Final
+#endif
 
+#include <zlib.h>
 #if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
diff --git a/csum-file.c b/csum-file.c
index bb70c75..717d29f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -36,11 +36,11 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 	unsigned offset = f->offset;
 
 	if (offset) {
-		SHA1_Update(&f->ctx, f->buffer, offset);
+		git_SHA1_Update(&f->ctx, f->buffer, offset);
 		sha1flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
-	SHA1_Final(f->buffer, &f->ctx);
+	git_SHA1_Final(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
 	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
@@ -82,7 +82,7 @@ int sha1write(struct sha1file *f, void *buf, unsigned int count)
 		buf = (char *) buf + nr;
 		left -= nr;
 		if (!left) {
-			SHA1_Update(&f->ctx, data, offset);
+			git_SHA1_Update(&f->ctx, data, offset);
 			sha1flush(f, data, offset);
 			offset = 0;
 		}
@@ -105,7 +105,7 @@ struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp
 	f->tp = tp;
 	f->name = name;
 	f->do_crc = 0;
-	SHA1_Init(&f->ctx);
+	git_SHA1_Init(&f->ctx);
 	return f;
 }
 
diff --git a/csum-file.h b/csum-file.h
index 72c9487..9e13342 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -7,7 +7,7 @@ struct progress;
 struct sha1file {
 	int fd;
 	unsigned int offset;
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	off_t total;
 	struct progress *tp;
 	const char *name;
diff --git a/diff.c b/diff.c
index b001d7b..e023348 100644
--- a/diff.c
+++ b/diff.c
@@ -3089,7 +3089,7 @@ static void diff_summary(FILE *file, struct diff_filepair *p)
 }
 
 struct patch_id_t {
-	SHA_CTX *ctx;
+	git_SHA_CTX *ctx;
 	int patchlen;
 };
 
@@ -3117,7 +3117,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 
 	new_len = remove_space(line, len);
 
-	SHA1_Update(data->ctx, line, new_len);
+	git_SHA1_Update(data->ctx, line, new_len);
 	data->patchlen += new_len;
 }
 
@@ -3126,11 +3126,11 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	struct patch_id_t data;
 	char buffer[PATH_MAX * 4 + 20];
 
-	SHA1_Init(&ctx);
+	git_SHA1_Init(&ctx);
 	memset(&data, 0, sizeof(struct patch_id_t));
 	data.ctx = &ctx;
 
@@ -3192,7 +3192,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 					len2, p->two->path,
 					len1, p->one->path,
 					len2, p->two->path);
-		SHA1_Update(&ctx, buffer, len1);
+		git_SHA1_Update(&ctx, buffer, len1);
 
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = 3;
@@ -3201,7 +3201,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 			      &xpp, &xecfg, &ecb);
 	}
 
-	SHA1_Final(sha1, &ctx);
+	git_SHA1_Final(sha1, &ctx);
 	return 0;
 }
 
diff --git a/fast-import.c b/fast-import.c
index ab6689a..3c035a5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -845,7 +845,7 @@ static int oecmp (const void *a_, const void *b_)
 static char *create_index(void)
 {
 	static char tmpfile[PATH_MAX];
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	struct sha1file *f;
 	struct object_entry **idx, **c, **last, *e;
 	struct object_entry_pool *o;
@@ -882,17 +882,17 @@ static char *create_index(void)
 	idx_fd = xmkstemp(tmpfile);
 	f = sha1fd(idx_fd, tmpfile);
 	sha1write(f, array, 256 * sizeof(int));
-	SHA1_Init(&ctx);
+	git_SHA1_Init(&ctx);
 	for (c = idx; c != last; c++) {
 		uint32_t offset = htonl((*c)->offset);
 		sha1write(f, &offset, 4);
 		sha1write(f, (*c)->sha1, sizeof((*c)->sha1));
-		SHA1_Update(&ctx, (*c)->sha1, 20);
+		git_SHA1_Update(&ctx, (*c)->sha1, 20);
 	}
 	sha1write(f, pack_data->sha1, sizeof(pack_data->sha1));
 	sha1close(f, NULL, CSUM_FSYNC);
 	free(idx);
-	SHA1_Final(pack_data->sha1, &ctx);
+	git_SHA1_Final(pack_data->sha1, &ctx);
 	return tmpfile;
 }
 
@@ -1033,15 +1033,15 @@ static int store_object(
 	unsigned char hdr[96];
 	unsigned char sha1[20];
 	unsigned long hdrlen, deltalen;
-	SHA_CTX c;
+	git_SHA_CTX c;
 	z_stream s;
 
 	hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
-	SHA1_Init(&c);
-	SHA1_Update(&c, hdr, hdrlen);
-	SHA1_Update(&c, dat->buf, dat->len);
-	SHA1_Final(sha1, &c);
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, hdr, hdrlen);
+	git_SHA1_Update(&c, dat->buf, dat->len);
+	git_SHA1_Final(sha1, &c);
 	if (sha1out)
 		hashcpy(sha1out, sha1);
 
diff --git a/http-push.c b/http-push.c
index c9dd9a1..42f4d78 100644
--- a/http-push.c
+++ b/http-push.c
@@ -126,7 +126,7 @@ struct transfer_request
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
 	unsigned char real_sha1[20];
-	SHA_CTX c;
+	git_SHA_CTX c;
 	z_stream stream;
 	int zret;
 	int rename;
@@ -209,7 +209,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 		request->stream.next_out = expn;
 		request->stream.avail_out = sizeof(expn);
 		request->zret = inflate(&request->stream, Z_SYNC_FLUSH);
-		SHA1_Update(&request->c, expn,
+		git_SHA1_Update(&request->c, expn,
 			    sizeof(expn) - request->stream.avail_out);
 	} while (request->stream.avail_in && request->zret == Z_OK);
 	data_received++;
@@ -270,7 +270,7 @@ static void start_fetch_loose(struct transfer_request *request)
 
 	inflateInit(&request->stream);
 
-	SHA1_Init(&request->c);
+	git_SHA1_Init(&request->c);
 
 	url = xmalloc(strlen(remote->url) + 50);
 	request->url = xmalloc(strlen(remote->url) + 50);
@@ -310,7 +310,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	if (prev_read == -1) {
 		memset(&request->stream, 0, sizeof(request->stream));
 		inflateInit(&request->stream);
-		SHA1_Init(&request->c);
+		git_SHA1_Init(&request->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
 			lseek(request->local_fileno, 0, SEEK_SET);
@@ -742,7 +742,7 @@ static void finish_request(struct transfer_request *request)
 				fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
 
 			inflateEnd(&request->stream);
-			SHA1_Final(request->real_sha1, &request->c);
+			git_SHA1_Final(request->real_sha1, &request->c);
 			if (request->zret != Z_STREAM_END) {
 				unlink(request->tmpfile);
 			} else if (hashcmp(request->obj->sha1, request->real_sha1)) {
diff --git a/http-walker.c b/http-walker.c
index 9dc6b27..7271c7d 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -36,7 +36,7 @@ struct object_request
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
 	unsigned char real_sha1[20];
-	SHA_CTX c;
+	git_SHA_CTX c;
 	z_stream stream;
 	int zret;
 	int rename;
@@ -83,7 +83,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 		obj_req->stream.next_out = expn;
 		obj_req->stream.avail_out = sizeof(expn);
 		obj_req->zret = inflate(&obj_req->stream, Z_SYNC_FLUSH);
-		SHA1_Update(&obj_req->c, expn,
+		git_SHA1_Update(&obj_req->c, expn,
 			    sizeof(expn) - obj_req->stream.avail_out);
 	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
 	data_received++;
@@ -144,7 +144,7 @@ static void start_object_request(struct walker *walker,
 
 	inflateInit(&obj_req->stream);
 
-	SHA1_Init(&obj_req->c);
+	git_SHA1_Init(&obj_req->c);
 
 	url = xmalloc(strlen(obj_req->repo->base) + 51);
 	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 51);
@@ -184,7 +184,7 @@ static void start_object_request(struct walker *walker,
 	if (prev_read == -1) {
 		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
 		inflateInit(&obj_req->stream);
-		SHA1_Init(&obj_req->c);
+		git_SHA1_Init(&obj_req->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
 			lseek(obj_req->local, 0, SEEK_SET);
@@ -244,7 +244,7 @@ static void finish_object_request(struct object_request *obj_req)
 	}
 
 	inflateEnd(&obj_req->stream);
-	SHA1_Final(obj_req->real_sha1, &obj_req->c);
+	git_SHA1_Final(obj_req->real_sha1, &obj_req->c);
 	if (obj_req->zret != Z_STREAM_END) {
 		unlink(obj_req->tmpfile);
 		return;
diff --git a/index-pack.c b/index-pack.c
index 530d820..2e4c088 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -67,7 +67,7 @@ static struct progress *progress;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
-static SHA_CTX input_ctx;
+static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
 
@@ -119,7 +119,7 @@ static void flush(void)
 	if (input_offset) {
 		if (output_fd >= 0)
 			write_or_die(output_fd, input_buffer, input_offset);
-		SHA1_Update(&input_ctx, input_buffer, input_offset);
+		git_SHA1_Update(&input_ctx, input_buffer, input_offset);
 		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
 	}
@@ -188,7 +188,7 @@ static char *open_pack_file(char *pack_name)
 		output_fd = -1;
 		pack_fd = input_fd;
 	}
-	SHA1_Init(&input_ctx);
+	git_SHA1_Init(&input_ctx);
 	return pack_name;
 }
 
@@ -588,7 +588,7 @@ static void parse_pack_objects(unsigned char *sha1)
 
 	/* Check pack integrity */
 	flush();
-	SHA1_Final(sha1, &input_ctx);
+	git_SHA1_Final(sha1, &input_ctx);
 	if (hashcmp(fill(20), sha1))
 		die("pack is corrupted (SHA1 mismatch)");
 	use(20);
diff --git a/mozilla-sha1/sha1.c b/mozilla-sha1/sha1.c
index 3f06b83..95a4ebf 100644
--- a/mozilla-sha1/sha1.c
+++ b/mozilla-sha1/sha1.c
@@ -35,9 +35,9 @@
 
 #include "sha1.h"
 
-static void shaHashBlock(SHA_CTX *ctx);
+static void shaHashBlock(moz_SHA_CTX *ctx);
 
-void SHA1_Init(SHA_CTX *ctx) {
+void moz_SHA1_Init(moz_SHA_CTX *ctx) {
   int i;
 
   ctx->lenW = 0;
@@ -56,7 +56,7 @@ void SHA1_Init(SHA_CTX *ctx) {
 }
 
 
-void SHA1_Update(SHA_CTX *ctx, const void *_dataIn, int len) {
+void moz_SHA1_Update(moz_SHA_CTX *ctx, const void *_dataIn, int len) {
   const unsigned char *dataIn = _dataIn;
   int i;
 
@@ -75,7 +75,7 @@ void SHA1_Update(SHA_CTX *ctx, const void *_dataIn, int len) {
 }
 
 
-void SHA1_Final(unsigned char hashout[20], SHA_CTX *ctx) {
+void moz_SHA1_Final(unsigned char hashout[20], moz_SHA_CTX *ctx) {
   unsigned char pad0x80 = 0x80;
   unsigned char pad0x00 = 0x00;
   unsigned char padlen[8];
@@ -91,10 +91,10 @@ void SHA1_Final(unsigned char hashout[20], SHA_CTX *ctx) {
   padlen[5] = (unsigned char)((ctx->sizeLo >> 16) & 255);
   padlen[6] = (unsigned char)((ctx->sizeLo >> 8) & 255);
   padlen[7] = (unsigned char)((ctx->sizeLo >> 0) & 255);
-  SHA1_Update(ctx, &pad0x80, 1);
+  moz_SHA1_Update(ctx, &pad0x80, 1);
   while (ctx->lenW != 56)
-    SHA1_Update(ctx, &pad0x00, 1);
-  SHA1_Update(ctx, padlen, 8);
+    moz_SHA1_Update(ctx, &pad0x00, 1);
+  moz_SHA1_Update(ctx, padlen, 8);
 
   /* Output hash
    */
@@ -106,13 +106,13 @@ void SHA1_Final(unsigned char hashout[20], SHA_CTX *ctx) {
   /*
    *  Re-initialize the context (also zeroizes contents)
    */
-  SHA1_Init(ctx);
+  moz_SHA1_Init(ctx);
 }
 
 
 #define SHA_ROT(X,n) (((X) << (n)) | ((X) >> (32-(n))))
 
-static void shaHashBlock(SHA_CTX *ctx) {
+static void shaHashBlock(moz_SHA_CTX *ctx) {
   int t;
   unsigned int A,B,C,D,E,TEMP;
 
diff --git a/mozilla-sha1/sha1.h b/mozilla-sha1/sha1.h
index 16f2d3d..aa48a46 100644
--- a/mozilla-sha1/sha1.h
+++ b/mozilla-sha1/sha1.h
@@ -38,8 +38,13 @@ typedef struct {
   unsigned int W[80];
   int lenW;
   unsigned int sizeHi,sizeLo;
-} SHA_CTX;
+} moz_SHA_CTX;
 
-void SHA1_Init(SHA_CTX *ctx);
-void SHA1_Update(SHA_CTX *ctx, const void *dataIn, int len);
-void SHA1_Final(unsigned char hashout[20], SHA_CTX *ctx);
+void moz_SHA1_Init(moz_SHA_CTX *ctx);
+void moz_SHA1_Update(moz_SHA_CTX *ctx, const void *dataIn, int len);
+void moz_SHA1_Final(unsigned char hashout[20], moz_SHA_CTX *ctx);
+
+#define git_SHA_CTX	moz_SHA_CTX
+#define git_SHA1_Init	moz_SHA1_Init
+#define git_SHA1_Update	moz_SHA1_Update
+#define git_SHA1_Final	moz_SHA1_Final
diff --git a/pack-check.c b/pack-check.c
index f596bf2..90c33b1 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -47,7 +47,7 @@ static int verify_packfile(struct packed_git *p,
 {
 	off_t index_size = p->index_size;
 	const unsigned char *index_base = p->index_data;
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	unsigned char sha1[20], *pack_sig;
 	off_t offset = 0, pack_sig_ofs = p->pack_size - 20;
 	uint32_t nr_objects, i;
@@ -60,16 +60,16 @@ static int verify_packfile(struct packed_git *p,
 	 * immediately.
 	 */
 
-	SHA1_Init(&ctx);
+	git_SHA1_Init(&ctx);
 	while (offset < pack_sig_ofs) {
 		unsigned int remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
-		SHA1_Update(&ctx, in, remaining);
+		git_SHA1_Update(&ctx, in, remaining);
 	}
-	SHA1_Final(sha1, &ctx);
+	git_SHA1_Final(sha1, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (hashcmp(sha1, pack_sig))
 		err = error("%s SHA1 checksum mismatch",
@@ -135,7 +135,7 @@ int verify_pack(struct packed_git *p)
 {
 	off_t index_size;
 	const unsigned char *index_base;
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	unsigned char sha1[20];
 	int err = 0;
 	struct pack_window *w_curs = NULL;
@@ -146,9 +146,9 @@ int verify_pack(struct packed_git *p)
 	index_base = p->index_data;
 
 	/* Verify SHA1 sum of the index file */
-	SHA1_Init(&ctx);
-	SHA1_Update(&ctx, index_base, (unsigned int)(index_size - 20));
-	SHA1_Final(sha1, &ctx);
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, index_base, (unsigned int)(index_size - 20));
+	git_SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, index_base + index_size - 20))
 		err = error("Packfile index for %s SHA1 mismatch",
 			    p->pack_name);
diff --git a/pack-write.c b/pack-write.c
index 3621f1d..b426006 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -25,7 +25,7 @@ char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
 	off_t last_obj_offset = 0;
 	uint32_t array[256];
 	int i, fd;
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	uint32_t index_version;
 
 	if (nr_objects) {
@@ -86,7 +86,7 @@ char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
 	sha1write(f, array, 256 * 4);
 
 	/* compute the SHA1 hash of sorted object names. */
-	SHA1_Init(&ctx);
+	git_SHA1_Init(&ctx);
 
 	/*
 	 * Write the actual SHA1 entries..
@@ -99,7 +99,7 @@ char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
 			sha1write(f, &offset, 4);
 		}
 		sha1write(f, obj->sha1, 20);
-		SHA1_Update(&ctx, obj->sha1, 20);
+		git_SHA1_Update(&ctx, obj->sha1, 20);
 	}
 
 	if (index_version >= 2) {
@@ -140,7 +140,7 @@ char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
 
 	sha1write(f, sha1, 20);
 	sha1close(f, NULL, CSUM_FSYNC);
-	SHA1_Final(sha1, &ctx);
+	git_SHA1_Final(sha1, &ctx);
 	return index_name;
 }
 
@@ -168,12 +168,12 @@ void fixup_pack_header_footer(int pack_fd,
 			 off_t partial_pack_offset)
 {
 	int aligned_sz, buf_sz = 8 * 1024;
-	SHA_CTX old_sha1_ctx, new_sha1_ctx;
+	git_SHA_CTX old_sha1_ctx, new_sha1_ctx;
 	struct pack_header hdr;
 	char *buf;
 
-	SHA1_Init(&old_sha1_ctx);
-	SHA1_Init(&new_sha1_ctx);
+	git_SHA1_Init(&old_sha1_ctx);
+	git_SHA1_Init(&new_sha1_ctx);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die("Failed seeking to start of %s: %s", pack_name, strerror(errno));
@@ -181,9 +181,9 @@ void fixup_pack_header_footer(int pack_fd,
 		die("Unable to reread header of %s: %s", pack_name, strerror(errno));
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die("Failed seeking to start of %s: %s", pack_name, strerror(errno));
-	SHA1_Update(&old_sha1_ctx, &hdr, sizeof(hdr));
+	git_SHA1_Update(&old_sha1_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
-	SHA1_Update(&new_sha1_ctx, &hdr, sizeof(hdr));
+	git_SHA1_Update(&new_sha1_ctx, &hdr, sizeof(hdr));
 	write_or_die(pack_fd, &hdr, sizeof(hdr));
 	partial_pack_offset -= sizeof(hdr);
 
@@ -198,7 +198,7 @@ void fixup_pack_header_footer(int pack_fd,
 			break;
 		if (n < 0)
 			die("Failed to checksum %s: %s", pack_name, strerror(errno));
-		SHA1_Update(&new_sha1_ctx, buf, n);
+		git_SHA1_Update(&new_sha1_ctx, buf, n);
 
 		aligned_sz -= n;
 		if (!aligned_sz)
@@ -207,11 +207,11 @@ void fixup_pack_header_footer(int pack_fd,
 		if (!partial_pack_sha1)
 			continue;
 
-		SHA1_Update(&old_sha1_ctx, buf, n);
+		git_SHA1_Update(&old_sha1_ctx, buf, n);
 		partial_pack_offset -= n;
 		if (partial_pack_offset == 0) {
 			unsigned char sha1[20];
-			SHA1_Final(sha1, &old_sha1_ctx);
+			git_SHA1_Final(sha1, &old_sha1_ctx);
 			if (hashcmp(sha1, partial_pack_sha1) != 0)
 				die("Unexpected checksum for %s "
 				    "(disk corruption?)", pack_name);
@@ -220,7 +220,7 @@ void fixup_pack_header_footer(int pack_fd,
 			 * pack, which also means making partial_pack_offset
 			 * big enough not to matter anymore.
 			 */
-			SHA1_Init(&old_sha1_ctx);
+			git_SHA1_Init(&old_sha1_ctx);
 			partial_pack_offset = ~partial_pack_offset;
 			partial_pack_offset -= MSB(partial_pack_offset, 1);
 		}
@@ -228,8 +228,8 @@ void fixup_pack_header_footer(int pack_fd,
 	free(buf);
 
 	if (partial_pack_sha1)
-		SHA1_Final(partial_pack_sha1, &old_sha1_ctx);
-	SHA1_Final(new_pack_sha1, &new_sha1_ctx);
+		git_SHA1_Final(partial_pack_sha1, &old_sha1_ctx);
+	git_SHA1_Final(new_pack_sha1, &new_sha1_ctx);
 	write_or_die(pack_fd, new_pack_sha1, 20);
 	fsync_or_die(pack_fd, pack_name);
 }
diff --git a/patch-id.c b/patch-id.c
index 9349bc5..871f1d2 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-static void flush_current_id(int patchlen, unsigned char *id, SHA_CTX *c)
+static void flush_current_id(int patchlen, unsigned char *id, git_SHA_CTX *c)
 {
 	unsigned char result[20];
 	char name[50];
@@ -8,10 +8,10 @@ static void flush_current_id(int patchlen, unsigned char *id, SHA_CTX *c)
 	if (!patchlen)
 		return;
 
-	SHA1_Final(result, c);
+	git_SHA1_Final(result, c);
 	memcpy(name, sha1_to_hex(id), 41);
 	printf("%s %s\n", sha1_to_hex(result), name);
-	SHA1_Init(c);
+	git_SHA1_Init(c);
 }
 
 static int remove_space(char *line)
@@ -31,10 +31,10 @@ static void generate_id_list(void)
 {
 	static unsigned char sha1[20];
 	static char line[1000];
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	int patchlen = 0;
 
-	SHA1_Init(&ctx);
+	git_SHA1_Init(&ctx);
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		unsigned char n[20];
 		char *p = line;
@@ -67,7 +67,7 @@ static void generate_id_list(void)
 		/* Compute the sha without whitespace */
 		len = remove_space(line);
 		patchlen += len;
-		SHA1_Update(&ctx, line, len);
+		git_SHA1_Update(&ctx, line, len);
 	}
 	flush_current_id(patchlen, sha1, &ctx);
 }
diff --git a/ppc/sha1.c b/ppc/sha1.c
index 738e36c..ec6a192 100644
--- a/ppc/sha1.c
+++ b/ppc/sha1.c
@@ -10,10 +10,10 @@
 #include <string.h>
 #include "sha1.h"
 
-extern void sha1_core(uint32_t *hash, const unsigned char *p,
-		      unsigned int nblocks);
+extern void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
+			  unsigned int nblocks);
 
-int SHA1_Init(SHA_CTX *c)
+int ppc_SHA1_Init(ppc_SHA_CTX *c)
 {
 	c->hash[0] = 0x67452301;
 	c->hash[1] = 0xEFCDAB89;
@@ -25,7 +25,7 @@ int SHA1_Init(SHA_CTX *c)
 	return 0;
 }
 
-int SHA1_Update(SHA_CTX *c, const void *ptr, unsigned long n)
+int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *ptr, unsigned long n)
 {
 	unsigned long nb;
 	const unsigned char *p = ptr;
@@ -38,12 +38,12 @@ int SHA1_Update(SHA_CTX *c, const void *ptr, unsigned long n)
 				nb = n;
 			memcpy(&c->buf.b[c->cnt], p, nb);
 			if ((c->cnt += nb) == 64) {
-				sha1_core(c->hash, c->buf.b, 1);
+				ppc_sha1_core(c->hash, c->buf.b, 1);
 				c->cnt = 0;
 			}
 		} else {
 			nb = n >> 6;
-			sha1_core(c->hash, p, nb);
+			ppc_sha1_core(c->hash, p, nb);
 			nb <<= 6;
 		}
 		n -= nb;
@@ -52,7 +52,7 @@ int SHA1_Update(SHA_CTX *c, const void *ptr, unsigned long n)
 	return 0;
 }
 
-int SHA1_Final(unsigned char *hash, SHA_CTX *c)
+int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c)
 {
 	unsigned int cnt = c->cnt;
 
@@ -60,13 +60,13 @@ int SHA1_Final(unsigned char *hash, SHA_CTX *c)
 	if (cnt > 56) {
 		if (cnt < 64)
 			memset(&c->buf.b[cnt], 0, 64 - cnt);
-		sha1_core(c->hash, c->buf.b, 1);
+		ppc_sha1_core(c->hash, c->buf.b, 1);
 		cnt = 0;
 	}
 	if (cnt < 56)
 		memset(&c->buf.b[cnt], 0, 56 - cnt);
 	c->buf.l[7] = c->len;
-	sha1_core(c->hash, c->buf.b, 1);
+	ppc_sha1_core(c->hash, c->buf.b, 1);
 	memcpy(hash, c->hash, 20);
 	return 0;
 }
diff --git a/ppc/sha1.h b/ppc/sha1.h
index c3c51aa..c405f73 100644
--- a/ppc/sha1.h
+++ b/ppc/sha1.h
@@ -5,7 +5,7 @@
  */
 #include <stdint.h>
 
-typedef struct sha_context {
+typedef struct {
 	uint32_t hash[5];
 	uint32_t cnt;
 	uint64_t len;
@@ -13,8 +13,13 @@ typedef struct sha_context {
 		unsigned char b[64];
 		uint64_t l[8];
 	} buf;
-} SHA_CTX;
+} ppc_SHA_CTX;
 
-int SHA1_Init(SHA_CTX *c);
-int SHA1_Update(SHA_CTX *c, const void *p, unsigned long n);
-int SHA1_Final(unsigned char *hash, SHA_CTX *c);
+int ppc_SHA1_Init(ppc_SHA_CTX *c);
+int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *p, unsigned long n);
+int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c);
+
+#define git_SHA_CTX	ppc_SHA_CTX
+#define git_SHA1_Init	ppc_SHA1_Init
+#define git_SHA1_Update	ppc_SHA1_Update
+#define git_SHA1_Final	ppc_SHA1_Final
diff --git a/ppc/sha1ppc.S b/ppc/sha1ppc.S
index f132696..1711eef 100644
--- a/ppc/sha1ppc.S
+++ b/ppc/sha1ppc.S
@@ -162,8 +162,8 @@ add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30
 	STEPUP4(fn, (t)+12, (s)+12,);	\
 	STEPUP4(fn, (t)+16, (s)+16, loadk)
 
-	.globl	sha1_core
-sha1_core:
+	.globl	ppc_sha1_core
+ppc_sha1_core:
 	stwu	%r1,-80(%r1)
 	stmw	%r13,4(%r1)
 
diff --git a/read-cache.c b/read-cache.c
index c5a8659..d7900f3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1091,16 +1091,16 @@ struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
 
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
-	SHA_CTX c;
+	git_SHA_CTX c;
 	unsigned char sha1[20];
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	if (hdr->hdr_version != htonl(2))
 		return error("bad index version");
-	SHA1_Init(&c);
-	SHA1_Update(&c, hdr, size - 20);
-	SHA1_Final(sha1, &c);
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, hdr, size - 20);
+	git_SHA1_Final(sha1, &c);
 	if (hashcmp(sha1, (unsigned char *)hdr + size - 20))
 		return error("bad index file sha1 signature");
 	return 0;
@@ -1297,11 +1297,11 @@ int unmerged_index(const struct index_state *istate)
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
 
-static int ce_write_flush(SHA_CTX *context, int fd)
+static int ce_write_flush(git_SHA_CTX *context, int fd)
 {
 	unsigned int buffered = write_buffer_len;
 	if (buffered) {
-		SHA1_Update(context, write_buffer, buffered);
+		git_SHA1_Update(context, write_buffer, buffered);
 		if (write_in_full(fd, write_buffer, buffered) != buffered)
 			return -1;
 		write_buffer_len = 0;
@@ -1309,7 +1309,7 @@ static int ce_write_flush(SHA_CTX *context, int fd)
 	return 0;
 }
 
-static int ce_write(SHA_CTX *context, int fd, void *data, unsigned int len)
+static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
 {
 	while (len) {
 		unsigned int buffered = write_buffer_len;
@@ -1331,7 +1331,7 @@ static int ce_write(SHA_CTX *context, int fd, void *data, unsigned int len)
 	return 0;
 }
 
-static int write_index_ext_header(SHA_CTX *context, int fd,
+static int write_index_ext_header(git_SHA_CTX *context, int fd,
 				  unsigned int ext, unsigned int sz)
 {
 	ext = htonl(ext);
@@ -1340,13 +1340,13 @@ static int write_index_ext_header(SHA_CTX *context, int fd,
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
 
-static int ce_flush(SHA_CTX *context, int fd)
+static int ce_flush(git_SHA_CTX *context, int fd)
 {
 	unsigned int left = write_buffer_len;
 
 	if (left) {
 		write_buffer_len = 0;
-		SHA1_Update(context, write_buffer, left);
+		git_SHA1_Update(context, write_buffer, left);
 	}
 
 	/* Flush first if not enough space for SHA1 signature */
@@ -1357,7 +1357,7 @@ static int ce_flush(SHA_CTX *context, int fd)
 	}
 
 	/* Append the SHA1 signature at the end */
-	SHA1_Final(write_buffer + left, context);
+	git_SHA1_Final(write_buffer + left, context);
 	left += 20;
 	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
 }
@@ -1411,7 +1411,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 	}
 }
 
-static int ce_write_entry(SHA_CTX *c, int fd, struct cache_entry *ce)
+static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 {
 	int size = ondisk_ce_size(ce);
 	struct ondisk_cache_entry *ondisk = xcalloc(1, size);
@@ -1435,7 +1435,7 @@ static int ce_write_entry(SHA_CTX *c, int fd, struct cache_entry *ce)
 
 int write_index(const struct index_state *istate, int newfd)
 {
-	SHA_CTX c;
+	git_SHA_CTX c;
 	struct cache_header hdr;
 	int i, err, removed;
 	struct cache_entry **cache = istate->cache;
@@ -1449,7 +1449,7 @@ int write_index(const struct index_state *istate, int newfd)
 	hdr.hdr_version = htonl(2);
 	hdr.hdr_entries = htonl(entries - removed);
 
-	SHA1_Init(&c);
+	git_SHA1_Init(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
diff --git a/rerere.c b/rerere.c
index 8447cae..121f911 100644
--- a/rerere.c
+++ b/rerere.c
@@ -73,7 +73,7 @@ static int write_rr(struct string_list *rr, int out_fd)
 static int handle_file(const char *path,
 	 unsigned char *sha1, const char *output)
 {
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	char buf[1024];
 	int hunk_no = 0;
 	enum {
@@ -95,7 +95,7 @@ static int handle_file(const char *path,
 	}
 
 	if (sha1)
-		SHA1_Init(&ctx);
+		git_SHA1_Init(&ctx);
 
 	strbuf_init(&one, 0);
 	strbuf_init(&two,  0);
@@ -127,9 +127,9 @@ static int handle_file(const char *path,
 				fputs(">>>>>>>\n", out);
 			}
 			if (sha1) {
-				SHA1_Update(&ctx, one.buf ? one.buf : "",
+				git_SHA1_Update(&ctx, one.buf ? one.buf : "",
 					    one.len + 1);
-				SHA1_Update(&ctx, two.buf ? two.buf : "",
+				git_SHA1_Update(&ctx, two.buf ? two.buf : "",
 					    two.len + 1);
 			}
 			strbuf_reset(&one);
@@ -154,7 +154,7 @@ static int handle_file(const char *path,
 	if (out)
 		fclose(out);
 	if (sha1)
-		SHA1_Final(sha1, &ctx);
+		git_SHA1_Final(sha1, &ctx);
 	if (hunk != RR_CONTEXT) {
 		if (output)
 			unlink(output);
diff --git a/sha1_file.c b/sha1_file.c
index 70ff904..7515987 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2132,16 +2132,16 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
                                     const char *type, unsigned char *sha1,
                                     char *hdr, int *hdrlen)
 {
-	SHA_CTX c;
+	git_SHA_CTX c;
 
 	/* Generate the header */
 	*hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
 
 	/* Sha1.. */
-	SHA1_Init(&c);
-	SHA1_Update(&c, hdr, *hdrlen);
-	SHA1_Update(&c, buf, len);
-	SHA1_Final(sha1, &c);
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, hdr, *hdrlen);
+	git_SHA1_Update(&c, buf, len);
+	git_SHA1_Final(sha1, &c);
 }
 
 /*
diff --git a/test-sha1.c b/test-sha1.c
index 78d7e98..9b98d07 100644
--- a/test-sha1.c
+++ b/test-sha1.c
@@ -2,7 +2,7 @@
 
 int main(int ac, char **av)
 {
-	SHA_CTX ctx;
+	git_SHA_CTX ctx;
 	unsigned char sha1[20];
 	unsigned bufsz = 8192;
 	char *buffer;
@@ -20,7 +20,7 @@ int main(int ac, char **av)
 			die("OOPS");
 	}
 
-	SHA1_Init(&ctx);
+	git_SHA1_Init(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -39,9 +39,9 @@ int main(int ac, char **av)
 		}
 		if (this_sz == 0)
 			break;
-		SHA1_Update(&ctx, buffer, this_sz);
+		git_SHA1_Update(&ctx, buffer, this_sz);
 	}
-	SHA1_Final(sha1, &ctx);
+	git_SHA1_Final(sha1, &ctx);
 	puts(sha1_to_hex(sha1));
 	exit(0);
 }
