From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] binary patch.
Date: Fri, 05 May 2006 03:15:53 -0700
Message-ID: <7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
	<7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 12:16:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbxLv-0000ST-QC
	for gcvg-git@gmane.org; Fri, 05 May 2006 12:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWEEKPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 06:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWEEKPz
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 06:15:55 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39905 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751122AbWEEKPy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 06:15:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505101554.NKTO9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 06:15:54 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19607>

Junio C Hamano <junkio@cox.net> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> This is nice.
>>
>> However I'd deflate the delta data before encoding it with base85.
>
> Yeah, things still to be done are deflating both delta and
> optionally perhaps use just deflate without delta for "new file"
> codepath.
>
> And testsuite.

-- >8 --
[PATCH] binary diff: further updates.

This updates the user interface and generated diff data format.

 * "diff --binary" is used to signal that we want an e-mailable
   binary patch.  It implies --full-index and -p.

 * "apply --allow-binary-replacement" acquired a short synonym
   "apply --binary".

 * After the "GIT binary patch\n" header line there is a token
   to record which binary patch mechanism was used, so that we
   can extend it later.  Currently there are two mechanisms
   defined: "literal" and "delta".  The former records the
   deflated postimage and the latter records the deflated delta
   from the preimage to postimage.

   For purely implementation convenience, I added the deflated
   length after these "literal/delta" tokens (otherwise the
   decoding side needs to guess and reallocate the buffer while
   inflating).  Improvement patches are very welcomed.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Have done only very minimum testing, and unlike somebody else ;-)
   my code is not always perfect, so this will still stay out of
   "next" for a while.

 apply.c |  130 +++++++++++++++++++++++++++++++++++++++++++++----------------
 cache.h |    1 
 diff.c  |  135 +++++++++++++++++++++++++++++++++------------------------------
 diff.h  |    1 
 4 files changed, 169 insertions(+), 98 deletions(-)

diff --git a/apply.c b/apply.c
index e37c4eb..1b93aab 100644
--- a/apply.c
+++ b/apply.c
@@ -114,6 +114,9 @@ struct patch {
 	char *new_name, *old_name, *def_name;
 	unsigned int old_mode, new_mode;
 	int is_rename, is_copy, is_new, is_delete, is_binary;
+#define BINARY_DELTA_DEFLATED 1
+#define BINARY_LITERAL_DEFLATED 2
+	unsigned long deflate_origlen;
 	int lines_added, lines_deleted;
 	int score;
 	struct fragment *fragments;
@@ -969,9 +972,11 @@ static inline int metadata_changes(struc
 
 static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 {
-	/* We have read "GIT binary patch\n"; what follows is a
-	 * sequence of 'length-byte' followed by base-85 encoded
-	 * delta data.
+	/* We have read "GIT binary patch\n"; what follows is a line
+	 * that says the patch method (currently, either "deflated
+	 * literal" or "deflated delta") and the length of data before
+	 * deflating; a sequence of 'length-byte' followed by base-85
+	 * encoded data follows.
 	 *
 	 * Each 5-byte sequence of base-85 encodes up to 4 bytes,
 	 * and we would limit the patch line to 66 characters,
@@ -982,11 +987,27 @@ static int parse_binary(char *buffer, un
 	 */
 	int llen, used;
 	struct fragment *fragment;
-	char *delta = NULL;
+	char *data = NULL;
 
-	patch->is_binary = 1;
 	patch->fragments = fragment = xcalloc(1, sizeof(*fragment));
-	used = 0;
+
+	/* Grab the type of patch */
+	llen = linelen(buffer, size);
+	used = llen;
+	linenr++;
+
+	if (!strncmp(buffer, "delta ", 6)) {
+		patch->is_binary = BINARY_DELTA_DEFLATED;
+		patch->deflate_origlen = strtoul(buffer + 6, NULL, 10);
+	}
+	else if (!strncmp(buffer, "literal ", 8)) {
+		patch->is_binary = BINARY_LITERAL_DEFLATED;
+		patch->deflate_origlen = strtoul(buffer + 8, NULL, 10);
+	}
+	else
+		return error("unrecognized binary patch at line %d: %.*s",
+			     linenr-1, llen-1, buffer);
+	buffer += llen;
 	while (1) {
 		int byte_length, max_byte_length, newsize;
 		llen = linelen(buffer, size);
@@ -1015,8 +1036,8 @@ static int parse_binary(char *buffer, un
 		    byte_length <= max_byte_length - 4)
 			goto corrupt;
 		newsize = fragment->size + byte_length;
-		delta = xrealloc(delta, newsize);
-		if (decode_85(delta + fragment->size,
+		data = xrealloc(data, newsize);
+		if (decode_85(data + fragment->size,
 			      buffer + 1,
 			      byte_length))
 			goto corrupt;
@@ -1024,7 +1045,7 @@ static int parse_binary(char *buffer, un
 		buffer += llen;
 		size -= llen;
 	}
-	fragment->patch = delta;
+	fragment->patch = data;
 	return used;
  corrupt:
 	return error("corrupt binary patch at line %d: %.*s",
@@ -1425,6 +1446,61 @@ #endif
 	return offset;
 }
 
+static char *inflate_it(const void *data, unsigned long size,
+			unsigned long inflated_size)
+{
+	z_stream stream;
+	void *out;
+	int st;
+
+	memset(&stream, 0, sizeof(stream));
+
+	stream.next_in = (unsigned char *)data;
+	stream.avail_in = size;
+	stream.next_out = out = xmalloc(inflated_size);
+	stream.avail_out = inflated_size;
+	inflateInit(&stream);
+	st = inflate(&stream, Z_FINISH);
+	if ((st != Z_STREAM_END) || stream.total_out != inflated_size) {
+		free(out);
+		return NULL;
+	}
+	return out;
+}
+
+static int apply_binary_fragment(struct buffer_desc *desc, struct patch *patch)
+{
+	unsigned long dst_size;
+	struct fragment *fragment = patch->fragments;
+	void *data;
+	void *result;
+
+	data = inflate_it(fragment->patch, fragment->size,
+			  patch->deflate_origlen);
+	if (!data)
+		return error("corrupt patch data");
+	switch (patch->is_binary) {
+	case BINARY_DELTA_DEFLATED:
+		result = patch_delta(desc->buffer, desc->size,
+				     data,
+				     patch->deflate_origlen,
+				     &dst_size);
+		free(desc->buffer);
+		desc->buffer = result;
+		free(data);
+		break;
+	case BINARY_LITERAL_DEFLATED:
+		free(desc->buffer);
+		desc->buffer = data;
+		dst_size = patch->deflate_origlen;
+		break;
+	}
+	if (!desc->buffer)
+		return -1;
+	desc->size = desc->alloc = dst_size;
+	return 0;
+}
+
 static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 {
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
@@ -1466,18 +1542,20 @@ static int apply_binary(struct buffer_de
 				     "'%s' but it is not empty", name);
 	}
 
-	if (desc->buffer) {
+	get_sha1_hex(patch->new_sha1_prefix, sha1);
+	if (!memcmp(sha1, null_sha1, 20)) {
 		free(desc->buffer);
 		desc->alloc = desc->size = 0;
-	}
-	get_sha1_hex(patch->new_sha1_prefix, sha1);
-	if (!memcmp(sha1, null_sha1, 20))
+		desc->buffer = NULL;
 		return 0; /* deletion patch */
+	}
 
 	if (has_sha1_file(sha1)) {
+		/* We already have the postimage */
 		char type[10];
 		unsigned long size;
 
+		free(desc->buffer);
 		desc->buffer = read_sha1_file(sha1, type, &size);
 		if (!desc->buffer)
 			return error("the necessary postimage %s for "
@@ -1486,28 +1564,13 @@ static int apply_binary(struct buffer_de
 		desc->alloc = desc->size = size;
 	}
 	else {
-		char type[10];
-		unsigned long src_size, dst_size;
-		void *src;
-
-		get_sha1_hex(patch->old_sha1_prefix, sha1);
-		src = read_sha1_file(sha1, type, &src_size);
-		if (!src)
-			return error("the necessary preimage %s for "
-				     "'%s' cannot be read",
-				     patch->old_sha1_prefix, name);
-
-		/* patch->fragment->patch has the delta data and
-		 * we should apply it to the preimage.
+		/* We have verified desc matches the preimage;
+		 * apply the patch data to it, which is stored
+		 * in the patch->fragments->{patch,size}.
 		 */
-		desc->buffer = patch_delta(src, src_size,
-					   (void*) patch->fragments->patch,
-					   patch->fragments->size,
-					   &dst_size);
-		if (!desc->buffer)
+		if (apply_binary_fragment(desc, patch))
 			return error("binary patch does not apply to '%s'",
 				     name);
-		desc->size = desc->alloc = dst_size;
 
 		/* verify that the result matches */
 		write_sha1_file_prepare(desc->buffer, desc->size, blob_type,
@@ -2102,7 +2165,8 @@ int main(int argc, char **argv)
 			diffstat = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--allow-binary-replacement")) {
+		if (!strcmp(arg, "--allow-binary-replacement") ||
+		    !strcmp(arg, "--binary")) {
 			allow_binary_replacement = 1;
 			continue;
 		}
diff --git a/cache.h b/cache.h
index 2f32f3d..4b7a439 100644
--- a/cache.h
+++ b/cache.h
@@ -365,5 +365,6 @@ extern void setup_pager(void);
 
 /* base85 */
 int decode_85(char *dst, char *line, int linelen);
+void encode_85(char *buf, unsigned char *data, int bytes);
 
 #endif /* CACHE_H */
diff --git a/diff.c b/diff.c
index b14d897..94bd94a 100644
--- a/diff.c
+++ b/diff.c
@@ -392,78 +392,75 @@ static void show_stats(struct diffstat_t
 			total_files, adds, dels);
 }
 
-static void *encode_delta_size(void *data, unsigned long size)
+static unsigned char *deflate_it(char *data,
+				 unsigned long size,
+				 unsigned long *result_size)
 {
-	unsigned char *cp = data;
-	*cp++ = size;
-	size >>= 7;
-	while (size) {
-		cp[-1] |= 0x80;
-		*cp++ = size;
-		size >>= 7;
-	}
-	return cp;
-}
-
-static void *safe_diff_delta(const unsigned char *src, unsigned long src_size,
-			     const unsigned char *dst, unsigned long dst_size,
-			     unsigned long *delta_size)
-{
-	unsigned long bufsize;
-	unsigned char *data;
-	unsigned char *cp;
-
-	if (src_size && dst_size)
-		return diff_delta(src, src_size, dst, dst_size, delta_size, 0);
-
-	/* diff-delta does not like to do delta with empty, so
-	 * we do that by hand here.  Sigh...
-	 */
-
-	if (!src_size)
-		/* literal copy can be done only 127-byte at a time.
-		 */
-		bufsize = dst_size + (dst_size / 127) + 40;
-	else
-		bufsize = 40;
-	data = xmalloc(bufsize);
-	cp = encode_delta_size(data, src_size);
-	cp = encode_delta_size(cp, dst_size);
-
-	if (dst_size) {
-		/* copy out literally */
-		while (dst_size) {
-			int sz = (127 < dst_size) ? 127 : dst_size;
-			*cp++ = sz;
-			dst_size -= sz;
-			while (sz) {
-				*cp++ = *dst++;
-				sz--;
-			}
-		}
-	}
-	*delta_size = (cp - data);
-	return data;
+	int bound;
+	unsigned char *deflated;
+	z_stream stream;
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	bound = deflateBound(&stream, size);
+	deflated = xmalloc(bound);
+	stream.next_out = deflated;
+	stream.avail_out = bound;
+
+	stream.next_in = (unsigned char *)data;
+	stream.avail_in = size;
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		; /* nothing */
+	deflateEnd(&stream);
+	*result_size = stream.total_out;
+	return deflated;
 }
 
 static void emit_binary_diff(mmfile_t *one, mmfile_t *two)
 {
-	void *delta, *cp;
+	void *cp;
+	void *delta;
+	void *deflated;
+	void *data;
+	unsigned long orig_size;
 	unsigned long delta_size;
+	unsigned long deflate_size;
+	unsigned long data_size;
 
 	printf("GIT binary patch\n");
-	delta = safe_diff_delta(one->ptr, one->size,
-				two->ptr, two->size,
-				&delta_size);
-	if (!delta)
-		die("unable to generate binary diff");
-
-	/* emit delta encoded in base85 */
-	cp = delta;
-	while (delta_size) {
-		int bytes = (52 < delta_size) ? 52 : delta_size;
+	/* We could do deflated delta, or we could do just deflated two,
+	 * whichever is smaller.
+	 */
+	delta = NULL;
+	deflated = deflate_it(two->ptr, two->size, &deflate_size);
+	if (one->size && two->size) {
+		delta = diff_delta(one->ptr, one->size,
+				   two->ptr, two->size,
+				   &delta_size, deflate_size);
+		orig_size = delta_size;
+		if (delta)
+			delta = deflate_it(delta, delta_size, &delta_size);
+	}
+
+	if (delta && delta_size < deflate_size) {
+		printf("delta %lu\n", orig_size);
+		free(deflated);
+		data = delta;
+		data_size = delta_size;
+	}
+	else {
+		printf("literal %lu\n", two->size);
+		free(delta);
+		data = deflated;
+		data_size = deflate_size;
+	}
+
+	/* emit data encoded in base85 */
+	cp = data;
+	while (data_size) {
+		int bytes = (52 < data_size) ? 52 : data_size;
 		char line[70];
-		delta_size -= bytes;
+		data_size -= bytes;
 		if (bytes <= 26)
 			line[0] = bytes + 'A' - 1;
 		else
@@ -473,7 +470,7 @@ static void emit_binary_diff(mmfile_t *o
 		puts(line);
 	}
 	printf("\n");
-	free(delta);
+	free(data);
 }
 
 #define FIRST_FEW_BYTES 8000
@@ -538,7 +535,11 @@ static void builtin_diff(const char *nam
 		die("unable to read files to diff");
 
 	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2)) {
-		if (o->full_index)
+		/* Quite common confusing case */
+		if (mf1.size == mf2.size &&
+		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
+			goto free_ab_and_return;
+		if (o->binary)
 			emit_binary_diff(&mf1, &mf2);
 		else
 			printf("Binary files %s and %s differ\n",
@@ -1239,6 +1240,10 @@ int diff_opt_parse(struct diff_options *
 		options->rename_limit = strtoul(arg+2, NULL, 10);
 	else if (!strcmp(arg, "--full-index"))
 		options->full_index = 1;
+	else if (!strcmp(arg, "--binary")) {
+		options->output_format = DIFF_FORMAT_PATCH;
+		options->full_index = options->binary = 1;
+	}
 	else if (!strcmp(arg, "--name-only"))
 		options->output_format = DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
diff --git a/diff.h b/diff.h
index b3b2c4d..d052608 100644
--- a/diff.h
+++ b/diff.h
@@ -28,6 +28,7 @@ struct diff_options {
 		 with_raw:1,
 		 with_stat:1,
 		 tree_in_recursive:1,
+		 binary:1,
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1;
-- 
1.3.1.g25a9
