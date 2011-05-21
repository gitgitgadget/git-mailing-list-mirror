From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] Add streaming filter API
Date: Fri, 20 May 2011 23:58:45 -0700
Message-ID: <1305961127-26540-3-git-send-email-gitster@pobox.com>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg9Y-0006gF-Sv
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab1EUG7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:59:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab1EUG7H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:59:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D3145DEE
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4Yum
	duC7w9YWzFzU997OT23DiXA=; b=c2443YFm+9R9xkdoRKa7gv3KclcMma5Jbe4k
	OHnZWIrN8GcOC/NyEV7YmWWJeIoVEg9ZTJkjImFAMeMPSjXGeylvdqzWgPIvXZDU
	itwPtXkODVWvgqT42339M34xZ08rN+7IdK/3hzLZx/rgdQVjBRpEU8gmQPcQMGBw
	eLd9PZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=T5a2op
	WH6XTD+4FDRkaKvgJxesv3TG7VK+Z8GnWYbn838wDND9dv5efmyxy3T4YNIDUbFo
	VHAcrddpzNu6YUroQnRVjB3/tz+4lVvQ/Czng2zDejygARSNBNLAJXQaCiElX57e
	0cggBbEB8HCP1iDEZCQ6rQlxYjOiKN3iGPDs4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A3985DED
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0EB3C5DEC for
 <git@vger.kernel.org>; Sat, 21 May 2011 03:01:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305961127-26540-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1D2E504A-8378-11E0-9DC1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174109>

This introduces an API to plug custom filters to an input stream.

The caller gets get_stream_filter("path") to obtain an appropriate
filter for the path, and then uses it when opening an input stream
via open_istream().  After that, the caller can read from the stream
with read_istream(), and close it with close_istream(), just like an
unfiltered stream.

This only adds a "null" filter that is a pass-thru filter, but later
changes can add LF-to-CRLF and other filters, and the callers of the
streaming API do not have to change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c   |   84 +++++++++++++++++++++++++++++++++++++++++++++----
 convert.h   |   23 +++++++++++++-
 entry.c     |   16 ++++++---
 streaming.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 streaming.h |    2 +-
 5 files changed, 209 insertions(+), 16 deletions(-)

diff --git a/convert.c b/convert.c
index 264af1d..1ec91a3 100644
--- a/convert.c
+++ b/convert.c
@@ -814,12 +814,69 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 	return ret | convert_to_git(path, src, len, dst, 0);
 }
 
+/*****************************************************************
+ *
+ * Streaming converison support
+ *
+ *****************************************************************/
+
+typedef int (*filter_fn)(struct stream_filter *,
+			 const char *input, size_t *isize_p,
+			 char *output, size_t *osize_p);
+typedef void (*free_fn)(struct stream_filter *);
+
+struct stream_filter_vtbl {
+	filter_fn filter;
+	free_fn free;
+};
+
+struct stream_filter {
+	struct stream_filter_vtbl *vtbl;
+};
+
+static int null_filter_fn(struct stream_filter *filter,
+			  const char *input, size_t *isize_p,
+			  char *output, size_t *osize_p)
+{
+	size_t count = *isize_p;
+	if (*osize_p < count)
+		count = *osize_p;
+	if (count) {
+		memmove(output, input, count);
+		*isize_p -= count;
+		*osize_p -= count;
+	}
+	return 0;
+}
+
+static void null_free_fn(struct stream_filter *filter)
+{
+	; /* nothing -- null instances are shared */
+}
+
+static struct stream_filter_vtbl null_vtbl = {
+	null_filter_fn,
+	null_free_fn,
+};
+
+static struct stream_filter null_filter_singleton = {
+	&null_vtbl,
+};
+
+int is_null_stream_filter(struct stream_filter *filter)
+{
+	return filter == &null_filter_singleton;
+}
+
 /*
- * You would be crazy to set CRLF, smuge/clean or ident to
- * a large binary blob you would want us not to slurp into
- * the memory!
+ * Return an appropriately constructed filter for the path, or NULL if
+ * the contents cannot be filtered without reading the whole thing
+ * in-core.
+ *
+ * Note that you would be crazy to set CRLF, smuge/clean or ident to a
+ * large binary blob you would want us not to slurp into the memory!
  */
-int can_bypass_conversion(const char *path)
+struct stream_filter *get_stream_filter(const char *path, const unsigned char *sha1)
 {
 	struct conv_attrs ca;
 	enum crlf_action crlf_action;
@@ -828,11 +885,24 @@ int can_bypass_conversion(const char *path)
 
 	if (ca.ident ||
 	    (ca.drv && (ca.drv->smudge || ca.drv->clean)))
-		return 0;
+		return NULL;
 
 	crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
 	if ((crlf_action == CRLF_BINARY) || (crlf_action == CRLF_INPUT) ||
 	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE))
-		return 1;
-	return 0;
+		return &null_filter_singleton;
+
+	return NULL;
+}
+
+void free_stream_filter(struct stream_filter *filter)
+{
+	filter->vtbl->free(filter);
+}
+
+int stream_filter(struct stream_filter *filter,
+		  const char *input, size_t *isize_p,
+		  char *output, size_t *osize_p)
+{
+	return filter->vtbl->filter(filter, input, isize_p, output, osize_p);
 }
diff --git a/convert.h b/convert.h
index d61c111..c9906f9 100644
--- a/convert.h
+++ b/convert.h
@@ -37,5 +37,26 @@ extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
-extern int can_bypass_conversion(const char *path);
+
+/*****************************************************************
+ *
+ * Streaming converison support
+ *
+ *****************************************************************/
+
+struct stream_filter; /* opaque */
+
+extern struct stream_filter *get_stream_filter(const char *path, const unsigned char *);
+extern void free_stream_filter(struct stream_filter *);
+extern int is_null_stream_filter(struct stream_filter *);
+
+/*
+ * Use as much input up to *isize_p and fill output up to *osize_p;
+ * update isize_p and osize_p to indicate how much buffer space was
+ * consumed and filled. Return 0 on success, non-zero on error.
+ */
+extern int stream_filter(struct stream_filter *,
+			 const char *input, size_t *isize_p,
+			 char *output, size_t *osize_p);
+
 #endif /* CONVERT_H */
diff --git a/entry.c b/entry.c
index e2dc16c..852fea1 100644
--- a/entry.c
+++ b/entry.c
@@ -116,6 +116,7 @@ static int fstat_output(int fd, const struct checkout *state, struct stat *st)
 }
 
 static int streaming_write_entry(struct cache_entry *ce, char *path,
+				 struct stream_filter *filter,
 				 const struct checkout *state, int to_tempfile,
 				 int *fstat_done, struct stat *statbuf)
 {
@@ -126,7 +127,7 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 	ssize_t kept = 0;
 	int fd = -1;
 
-	st = open_istream(ce->sha1, &type, &sz);
+	st = open_istream(ce->sha1, &type, &sz, filter);
 	if (!st)
 		return -1;
 	if (type != OBJ_BLOB)
@@ -186,11 +187,14 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	size_t wrote, newsize = 0;
 	struct stat st;
 
-	if ((ce_mode_s_ifmt == S_IFREG) &&
-	    can_bypass_conversion(path) &&
-	    !streaming_write_entry(ce, path, state, to_tempfile,
-				   &fstat_done, &st))
-		goto finish;
+	if (ce_mode_s_ifmt == S_IFREG) {
+		struct stream_filter *filter = get_stream_filter(path, ce->sha1);
+		if (filter &&
+		    !streaming_write_entry(ce, path, filter,
+					   state, to_tempfile,
+					   &fstat_done, &st))
+			goto finish;
+	}
 
 	switch (ce_mode_s_ifmt) {
 	case S_IFREG:
diff --git a/streaming.c b/streaming.c
index 0602926..565f000 100644
--- a/streaming.c
+++ b/streaming.c
@@ -41,6 +41,9 @@ struct stream_vtbl {
 static open_method_decl(incore);
 static open_method_decl(loose);
 static open_method_decl(pack_non_delta);
+static struct git_istream *attach_stream_filter(struct git_istream *st,
+						struct stream_filter *filter);
+
 
 static open_istream_fn open_istream_tbl[] = {
 	open_istream_incore,
@@ -48,6 +51,17 @@ static open_istream_fn open_istream_tbl[] = {
 	open_istream_pack_non_delta,
 };
 
+#define FILTER_BUFFER (1024*16)
+
+struct filtered_istream {
+	struct git_istream *upstream;
+	struct stream_filter *filter;
+	char ibuf[FILTER_BUFFER];
+	char obuf[FILTER_BUFFER];
+	int i_end, i_ptr;
+	int o_end, o_ptr;
+};
+
 struct git_istream {
 	const struct stream_vtbl *vtbl;
 	unsigned long size; /* inflated size of full object */
@@ -72,6 +86,8 @@ struct git_istream {
 			struct packed_git *pack;
 			off_t pos;
 		} in_pack;
+
+		struct filtered_istream filtered;
 	} u;
 };
 
@@ -112,7 +128,8 @@ static enum input_source istream_source(const unsigned char *sha1,
 
 struct git_istream *open_istream(const unsigned char *sha1,
 				 enum object_type *type,
-				 unsigned long *size)
+				 unsigned long *size,
+				 struct stream_filter *filter)
 {
 	struct git_istream *st;
 	struct object_info oi;
@@ -129,6 +146,14 @@ struct git_istream *open_istream(const unsigned char *sha1,
 			return NULL;
 		}
 	}
+	if (st && filter) {
+		/* Add "&& !is_null_stream_filter(filter)" for performance */
+		struct git_istream *nst = attach_stream_filter(st, filter);
+		if (!nst)
+			close_istream(st);
+		st = nst;
+	}
+
 	*size = st->size;
 	return st;
 }
@@ -149,6 +174,79 @@ static void close_deflated_stream(struct git_istream *st)
 
 /*****************************************************************
  *
+ * Filtered stream
+ *
+ *****************************************************************/
+
+static close_method_decl(filtered)
+{
+	free_stream_filter(st->u.filtered.filter);
+	return close_istream(st->u.filtered.upstream);
+}
+
+static read_method_decl(filtered)
+{
+	struct filtered_istream *fs = &(st->u.filtered);
+	size_t filled = 0;
+
+	while (sz) {
+		/* do we already have filtered output? */
+		if (fs->o_ptr < fs->o_end) {
+			size_t to_move = fs->o_end - fs->o_ptr;
+			if (sz < to_move)
+				to_move = sz;
+			memcpy(buf + filled, fs->obuf + fs->o_ptr, to_move);
+			fs->o_ptr += to_move;
+			sz -= to_move;
+			filled += to_move;
+			continue;
+		}
+		fs->o_end = fs->o_ptr = 0;
+
+		/* do we have anything to feed the filter with? */
+		if (fs->i_ptr < fs->i_end) {
+			size_t to_feed = fs->i_end - fs->i_ptr;
+			size_t to_receive = FILTER_BUFFER;
+			if (stream_filter(fs->filter,
+					  fs->ibuf + fs->i_ptr, &to_feed,
+					  fs->obuf, &to_receive))
+				return -1;
+			fs->i_ptr = fs->i_end - to_feed;
+			fs->o_end = FILTER_BUFFER - to_receive;
+			continue;
+		}
+		fs->i_end = fs->i_ptr = 0;
+
+		/* refill the input from the upstream */
+		fs->i_end = read_istream(fs->upstream, fs->ibuf, FILTER_BUFFER);
+		if (fs->i_end <= 0)
+			break;
+	}
+	return filled;
+}
+
+static struct stream_vtbl filtered_vtbl = {
+	close_istream_filtered,
+	read_istream_filtered,
+};
+
+static struct git_istream *attach_stream_filter(struct git_istream *st,
+						struct stream_filter *filter)
+{
+	struct git_istream *ifs = xmalloc(sizeof(*ifs));
+	struct filtered_istream *fs = &(ifs->u.filtered);
+
+	ifs->vtbl = &filtered_vtbl;
+	fs->upstream = st;
+	fs->filter = filter;
+	fs->i_end = fs->i_ptr = 0;
+	fs->o_end = fs->o_ptr = 0;
+	ifs->size = -1; /* unknown */
+	return ifs;
+}
+
+/*****************************************************************
+ *
  * Loose object stream
  *
  *****************************************************************/
diff --git a/streaming.h b/streaming.h
index 18cbe68..589e857 100644
--- a/streaming.h
+++ b/streaming.h
@@ -8,7 +8,7 @@
 /* opaque */
 struct git_istream;
 
-extern struct git_istream *open_istream(const unsigned char *, enum object_type *, unsigned long *);
+extern struct git_istream *open_istream(const unsigned char *, enum object_type *, unsigned long *, struct stream_filter *);
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, char *, size_t);
 
-- 
1.7.5.2.369.g8fc017
