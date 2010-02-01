From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3] fast-import: Stream very large blobs directly to pack
Date: Mon, 1 Feb 2010 09:27:35 -0800
Message-ID: <20100201172735.GC9394@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 18:27:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc03v-00036P-P7
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 18:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab0BAR1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 12:27:41 -0500
Received: from mail-qy0-f198.google.com ([209.85.221.198]:51001 "EHLO
	mail-qy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab0BAR1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 12:27:40 -0500
X-Greylist: delayed 5154 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2010 12:27:40 EST
Received: by qyk36 with SMTP id 36so2132887qyk.15
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 09:27:39 -0800 (PST)
Received: by 10.224.95.202 with SMTP id e10mr2183841qan.171.1265045259108;
        Mon, 01 Feb 2010 09:27:39 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm3903694qyk.9.2010.02.01.09.27.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 09:27:37 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138629>

If a blob is larger than the configured big-file-threshold, instead
of reading it into a single buffer obtained from malloc, stream it
onto the end of the current pack file.  Streaming the larger objects
into the pack avoids the 4+ GiB memory footprint that occurs when
fast-import is processing 2+ GiB blobs.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Changed --big-file-threshold option to be in bytes.
 Squashed the documentation patch from earlier today.

 Documentation/config.txt          |   14 +++
 Documentation/git-fast-import.txt |    6 ++
 fast-import.c                     |  179 +++++++++++++++++++++++++++++++++----
 t/t5705-clone-2gb.sh              |    2 +-
 t/t9300-fast-import.sh            |   46 ++++++++++
 5 files changed, 227 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f7728ec..b16a20b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -409,6 +409,20 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.bigFileThreshold::
+	Files larger than this size are stored deflated, without
+	attempting delta compression.  Storing large files without
+	delta compression avoids excessive memory usage, at the
+	slight expense of increased disk usage.
++
+Default is 512 MiB on all platforms.  This should be reasonable
+for most projects as source code and other text files can still
+be delta compressed, but larger binary media files won't be.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
++
+Currently only linkgit:git-fast-import[1] honors this setting.
+
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index e6d364f..79c5f69 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -50,6 +50,12 @@ OPTIONS
 	importers may wish to lower this, such as to ensure the
 	resulting packfiles fit on CDs.
 
+--big-file-threshold=<n>::
+	Maximum size of a blob that fast-import will attempt to
+	create a delta for, expressed in bytes.  The default is 512m
+	(512 MiB).  Some importers may wish to lower this on systems
+	with constrained memory.
+
 --depth=<n>::
 	Maximum delta depth, for blob and tree deltification.
 	Default is 10.
diff --git a/fast-import.c b/fast-import.c
index 60d0aa2..2105310 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -280,6 +280,7 @@ struct recent_command
 /* Configured limits on output */
 static unsigned long max_depth = 10;
 static off_t max_packsize = (1LL << 32) - 1;
+static uintmax_t big_file_threshold = 512 * 1024 * 1024;
 static int force_update;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
@@ -1003,7 +1004,7 @@ static void cycle_packfile(void)
 
 static size_t encode_header(
 	enum object_type type,
-	size_t size,
+	uintmax_t size,
 	unsigned char *hdr)
 {
 	int n = 1;
@@ -1159,6 +1160,118 @@ static int store_object(
 	return 0;
 }
 
+static void truncate_pack(off_t to)
+{
+	if (ftruncate(pack_data->pack_fd, to)
+	 || lseek(pack_data->pack_fd, to, SEEK_SET) != to)
+		die_errno("cannot truncate pack to skip duplicate");
+	pack_size = to;
+}
+
+static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
+{
+	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
+	unsigned char *in_buf = xmalloc(in_sz);
+	unsigned char *out_buf = xmalloc(out_sz);
+	struct object_entry *e;
+	unsigned char sha1[20];
+	unsigned long hdrlen;
+	off_t offset;
+	git_SHA_CTX c;
+	z_stream s;
+	int status = Z_OK;
+
+	/* Determine if we should auto-checkpoint. */
+	if ((pack_size + 60 + len) > max_packsize
+		|| (pack_size + 60 + len) < pack_size)
+		cycle_packfile();
+
+	offset = pack_size;
+
+	hdrlen = snprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
+	if (out_sz <= hdrlen)
+		die("impossibly large object header");
+
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, out_buf, hdrlen);
+
+	memset(&s, 0, sizeof(s));
+	deflateInit(&s, pack_compression_level);
+
+	hdrlen = encode_header(OBJ_BLOB, len, out_buf);
+	if (out_sz <= hdrlen)
+		die("impossibly large object header");
+
+	s.next_out = out_buf + hdrlen;
+	s.avail_out = out_sz - hdrlen;
+
+	while (status != Z_STREAM_END) {
+		if (0 < len && !s.avail_in) {
+			size_t cnt = in_sz < len ? in_sz : (size_t)len;
+			size_t n = fread(in_buf, 1, cnt, stdin);
+			if (!n && feof(stdin))
+				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
+
+			git_SHA1_Update(&c, in_buf, n);
+			s.next_in = in_buf;
+			s.avail_in = n;
+			len -= n;
+		}
+
+		status = deflate(&s, len ? 0 : Z_FINISH);
+
+		if (!s.avail_out || status == Z_STREAM_END) {
+			size_t n = s.next_out - out_buf;
+			write_or_die(pack_data->pack_fd, out_buf, n);
+			pack_size += n;
+			s.next_out = out_buf;
+			s.avail_out = out_sz;
+		}
+
+		switch (status) {
+		case Z_OK:
+		case Z_BUF_ERROR:
+		case Z_STREAM_END:
+			continue;
+		default:
+			die("unexpected deflate failure: %d", status);
+		}
+	}
+	deflateEnd(&s);
+	git_SHA1_Final(sha1, &c);
+
+	if (sha1out)
+		hashcpy(sha1out, sha1);
+
+	e = insert_object(sha1);
+
+	if (mark)
+		insert_mark(mark, e);
+
+	if (e->offset) {
+		duplicate_count_by_type[OBJ_BLOB]++;
+		truncate_pack(offset);
+
+	} else if (find_sha1_pack(sha1, packed_git)) {
+		e->type = OBJ_BLOB;
+		e->pack_id = MAX_PACK_ID;
+		e->offset = 1; /* just not zero! */
+		duplicate_count_by_type[OBJ_BLOB]++;
+		truncate_pack(offset);
+
+	} else {
+		e->depth = 0;
+		e->type = OBJ_BLOB;
+		e->pack_id = pack_id;
+		e->offset = offset;
+		object_count++;
+		object_count_by_type[OBJ_BLOB]++;
+	}
+
+	free(in_buf);
+	free(out_buf);
+}
+
 /* All calls must be guarded by find_object() or find_mark() to
  * ensure the 'struct object_entry' passed was written by this
  * process instance.  We unpack the entry by the offset, avoiding
@@ -1704,7 +1817,7 @@ static void parse_mark(void)
 		next_mark = 0;
 }
 
-static void parse_data(struct strbuf *sb)
+static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 {
 	strbuf_reset(sb);
 
@@ -1728,9 +1841,15 @@ static void parse_data(struct strbuf *sb)
 		free(term);
 	}
 	else {
-		size_t n = 0, length;
+		uintmax_t len = strtoumax(command_buf.buf + 5, NULL, 10);
+		size_t n = 0, length = (size_t)len;
 
-		length = strtoul(command_buf.buf + 5, NULL, 10);
+		if (limit && limit < len) {
+			*len_res = len;
+			return 0;
+		}
+		if (length < len)
+			die("data is too large to use in this context");
 
 		while (n < length) {
 			size_t s = strbuf_fread(sb, length - n, stdin);
@@ -1742,6 +1861,7 @@ static void parse_data(struct strbuf *sb)
 	}
 
 	skip_optional_lf();
+	return 1;
 }
 
 static int validate_raw_date(const char *src, char *result, int maxlen)
@@ -1806,14 +1926,32 @@ static char *parse_ident(const char *buf)
 	return ident;
 }
 
-static void parse_new_blob(void)
+static void parse_and_store_blob(
+	struct last_object *last,
+	unsigned char *sha1out,
+	uintmax_t mark)
 {
 	static struct strbuf buf = STRBUF_INIT;
+	uintmax_t len;
 
+	if (parse_data(&buf, big_file_threshold, &len))
+		store_object(OBJ_BLOB, &buf, last, sha1out, mark);
+	else {
+		if (last) {
+			strbuf_release(&last->data);
+			last->offset = 0;
+			last->depth = 0;
+		}
+		stream_blob(len, sha1out, mark);
+		skip_optional_lf();
+	}
+}
+
+static void parse_new_blob(void)
+{
 	read_next_command();
 	parse_mark();
-	parse_data(&buf);
-	store_object(OBJ_BLOB, &buf, &last_blob, NULL, next_mark);
+	parse_and_store_blob(&last_blob, NULL, next_mark);
 }
 
 static void unload_one_branch(void)
@@ -1924,15 +2062,12 @@ static void file_change_m(struct branch *b)
 		 * another repository.
 		 */
 	} else if (inline_data) {
-		static struct strbuf buf = STRBUF_INIT;
-
 		if (p != uq.buf) {
 			strbuf_addstr(&uq, p);
 			p = uq.buf;
 		}
 		read_next_command();
-		parse_data(&buf);
-		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0);
+		parse_and_store_blob(&last_blob, sha1, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
@@ -2058,15 +2193,12 @@ static void note_change_n(struct branch *b)
 		die("Invalid ref name or SHA1 expression: %s", p);
 
 	if (inline_data) {
-		static struct strbuf buf = STRBUF_INIT;
-
 		if (p != uq.buf) {
 			strbuf_addstr(&uq, p);
 			p = uq.buf;
 		}
 		read_next_command();
-		parse_data(&buf);
-		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0);
+		parse_and_store_blob(&last_blob, sha1, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
 			die("Not a blob (actually a %s): %s",
@@ -2232,7 +2364,7 @@ static void parse_new_commit(void)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
-	parse_data(&msg);
+	parse_data(&msg, 0, NULL);
 	read_next_command();
 	parse_from(b);
 	merge_list = parse_merge(&merge_count);
@@ -2353,7 +2485,7 @@ static void parse_new_tag(void)
 		tagger = NULL;
 
 	/* tag payload/message */
-	parse_data(&msg);
+	parse_data(&msg, 0, NULL);
 
 	/* build the tag object */
 	strbuf_reset(&new_data);
@@ -2473,11 +2605,15 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		pack_compression_seen = 1;
 		return 0;
 	}
+	if (!strcmp(k, "core.bigfilethreshold")) {
+		long n = git_config_int(k, v);
+		big_file_threshold = 0 < n ? n : 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
 static const char fast_import_usage[] =
-"git fast-import [--date-format=f] [--max-pack-size=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
+"git fast-import [--date-format=f] [--max-pack-size=n] [--big-file-threshold=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
 
 int main(int argc, const char **argv)
 {
@@ -2518,7 +2654,12 @@ int main(int argc, const char **argv)
 		}
 		else if (!prefixcmp(a, "--max-pack-size="))
 			max_packsize = strtoumax(a + 16, NULL, 0) * 1024 * 1024;
-		else if (!prefixcmp(a, "--depth=")) {
+		else if (!prefixcmp(a, "--big-file-threshold=")) {
+			unsigned long v;
+			if (!git_parse_ulong(a + 21, &v))
+				usage(fast_import_usage);
+			big_file_threshold = v;
+		} else if (!prefixcmp(a, "--depth=")) {
 			max_depth = strtoul(a + 8, NULL, 0);
 			if (max_depth > MAX_DEPTH)
 				die("--depth cannot exceed %u", MAX_DEPTH);
diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index 9f52154..adfaae8 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -31,7 +31,7 @@ test_expect_success 'setup' '
 	 echo "data 5" &&
 	 echo ">2gb" &&
 	 cat commit) |
-	git fast-import &&
+	git fast-import --big-file-threshold=2 &&
 	test ! -f exit-status
 
 '
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index b49815d..513db86 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1254,4 +1254,50 @@ test_expect_success \
 	'Q: verify note for third commit' \
 	'git cat-file blob refs/notes/foobar:$commit3 >actual && test_cmp expect actual'
 
+##
+## R: very large blobs
+##
+blobsize=$((2*1024*1024 + 53))
+test-genrandom bar $blobsize >expect
+cat >input <<INPUT_END
+commit refs/heads/big-file
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+R - big file
+COMMIT
+
+M 644 inline big1
+data $blobsize
+INPUT_END
+cat expect >>input
+cat >>input <<INPUT_END
+M 644 inline big2
+data $blobsize
+INPUT_END
+cat expect >>input
+echo >>input
+
+test_expect_success \
+	'R: blob bigger than threshold' \
+	'test_create_repo R &&
+	 git --git-dir=R/.git fast-import --big-file-threshold=1 <input'
+test_expect_success \
+	'R: verify created pack' \
+	': >verify &&
+	 for p in R/.git/objects/pack/*.pack;
+	 do
+	   git verify-pack -v $p >>verify || exit;
+	 done'
+test_expect_success \
+	'R: verify written objects' \
+	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
+	 test_cmp expect actual &&
+	 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
+	 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
+	 test $a = $b'
+test_expect_success \
+	'R: blob appears only once' \
+	'n=$(grep $a verify | wc -l) &&
+	 test 1 = $n'
+
 test_done
-- 
1.7.0.rc0.170.g7207c

-- 
Shawn.
