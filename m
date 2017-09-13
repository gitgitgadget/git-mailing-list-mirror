Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C579720286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdIMRQG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:37052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751054AbdIMRQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:16:05 -0400
Received: (qmail 22823 invoked by uid 109); 13 Sep 2017 17:16:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 17:16:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16409 invoked by uid 111); 13 Sep 2017 17:16:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:16:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 13:16:03 -0400
Date:   Wed, 13 Sep 2017 13:16:03 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 3/7] avoid "write_in_full(fd, buf, len) != len" pattern
Message-ID: <20170913171603.3whuql7l5da3ynrn@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value of write_in_full() is either "-1", or the
requested number of bytes[1]. If we make a partial write
before seeing an error, we still return -1, not a partial
value. This goes back to f6aa66cb95 (write_in_full: really
write in full or return error on disk full., 2007-01-11).

So checking anything except "was the return value negative"
is pointless. And there are a couple of reasons not to do
so:

  1. It can do a funny signed/unsigned comparison. If your
     "len" is signed (e.g., a size_t) then the compiler will
     promote the "-1" to its unsigned variant.

     This works out for "!= len" (unless you really were
     trying to write the maximum size_t bytes), but is a
     bug if you check "< len" (an example of which was fixed
     recently in config.c).

     We should avoid promoting the mental model that you
     need to check the length at all, so that new sites are
     not tempted to copy us.

  2. Checking for a negative value is shorter to type,
     especially when the length is an expression.

  3. Linus says so. In d34cf19b89 (Clean up write_in_full()
     users, 2007-01-11), right after the write_in_full()
     semantics were changed, he wrote:

       I really wish every "write_in_full()" user would just
       check against "<0" now, but this fixes the nasty and
       stupid ones.

     Appeals to authority aside, this makes it clear that
     writing it this way does not have an intentional
     benefit. It's a historical curiosity that we never
     bothered to clean up (and which was undoubtedly
     cargo-culted into new sites).

So let's convert these obviously-correct cases (this
includes write_str_in_full(), which is just a wrapper for
write_in_full()).

[1] A careful reader may notice there is one way that
    write_in_full() can return a different value. If we ask
    write() to write N bytes and get a return value that is
    _larger_ than N, we could return a larger total. But
    besides the fact that this would imply a totally broken
    version of write(), it would already invoke undefined
    behavior. Our internal remaining counter is an unsigned
    size_t, which means that subtracting too many byte will
    wrap it around to a very large number. So we'll instantly
    begin reading off the end of the buffer, trying to write
    gigabytes (or petabytes) of data.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 2 +-
 builtin/rerere.c       | 2 +-
 builtin/unpack-file.c  | 2 +-
 config.c               | 4 ++--
 diff.c                 | 2 +-
 fast-import.c          | 2 +-
 http-backend.c         | 4 ++--
 ll-merge.c             | 2 +-
 read-cache.c           | 6 +++---
 refs.c                 | 2 +-
 refs/files-backend.c   | 8 ++++----
 rerere.c               | 2 +-
 shallow.c              | 6 +++---
 t/helper/test-delta.c  | 2 +-
 transport-helper.c     | 5 ++---
 wrapper.c              | 2 +-
 16 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 52c63ebfdc..dd06b3fb4f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -743,7 +743,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 		size_t n;
 		if (feed(feed_state, &buf, &n))
 			break;
-		if (write_in_full(proc.in, buf, n) != n)
+		if (write_in_full(proc.in, buf, n) < 0)
 			break;
 	}
 	close(proc.in);
diff --git a/builtin/rerere.c b/builtin/rerere.c
index ffb66e2907..0bc40298c2 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -18,7 +18,7 @@ static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
 {
 	int i;
 	for (i = 0; i < nbuf; i++)
-		if (write_in_full(1, ptr[i].ptr, ptr[i].size) != ptr[i].size)
+		if (write_in_full(1, ptr[i].ptr, ptr[i].size) < 0)
 			return -1;
 	return 0;
 }
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 281ca1db6c..32e0155577 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -15,7 +15,7 @@ static char *create_temp_file(struct object_id *oid)
 
 	xsnprintf(path, sizeof(path), ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
-	if (write_in_full(fd, buf, size) != size)
+	if (write_in_full(fd, buf, size) < 0)
 		die_errno("unable to write temp-file");
 	close(fd);
 	return path;
diff --git a/config.c b/config.c
index eee4ac0355..daf093db45 100644
--- a/config.c
+++ b/config.c
@@ -2611,7 +2611,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 						  copy_end - copy_begin) < 0)
 					goto write_err_out;
 				if (new_line &&
-				    write_str_in_full(fd, "\n") != 1)
+				    write_str_in_full(fd, "\n") < 0)
 					goto write_err_out;
 			}
 			copy_begin = store.offset[i];
@@ -2842,7 +2842,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 		if (remove)
 			continue;
 		length = strlen(output);
-		if (write_in_full(out_fd, output, length) != length) {
+		if (write_in_full(out_fd, output, length) < 0) {
 			ret = write_error(get_lock_file_path(lock));
 			goto out;
 		}
diff --git a/diff.c b/diff.c
index 3d3e553a98..3914830ff1 100644
--- a/diff.c
+++ b/diff.c
@@ -3738,7 +3738,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		blob = buf.buf;
 		size = buf.len;
 	}
-	if (write_in_full(fd, blob, size) != size)
+	if (write_in_full(fd, blob, size) < 0)
 		die_errno("unable to write temp-file");
 	close_tempfile(&temp->tempfile);
 	temp->name = get_tempfile_path(&temp->tempfile);
diff --git a/fast-import.c b/fast-import.c
index 49516d60e6..35bf671f12 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2952,7 +2952,7 @@ static void parse_reset_branch(const char *arg)
 
 static void cat_blob_write(const char *buf, unsigned long size)
 {
-	if (write_in_full(cat_blob_fd, buf, size) != size)
+	if (write_in_full(cat_blob_fd, buf, size) < 0)
 		die_errno("Write to frontend failed");
 }
 
diff --git a/http-backend.c b/http-backend.c
index 8076b1d5e5..e51c7805c8 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -358,7 +358,7 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
 				die("zlib error inflating request, result %d", ret);
 
 			n = stream.total_out - cnt;
-			if (write_in_full(out, out_buf, n) != n)
+			if (write_in_full(out, out_buf, n) < 0)
 				die("%s aborted reading request", prog_name);
 			cnt += n;
 
@@ -379,7 +379,7 @@ static void copy_request(const char *prog_name, int out)
 	ssize_t n = read_request(0, &buf);
 	if (n < 0)
 		die_errno("error reading request body");
-	if (write_in_full(out, buf, n) != n)
+	if (write_in_full(out, buf, n) < 0)
 		die("%s aborted reading request", prog_name);
 	close(out);
 	free(buf);
diff --git a/ll-merge.c b/ll-merge.c
index 9fb855a900..a6ad2ec12d 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -154,7 +154,7 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
 
 	xsnprintf(path, len, ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
-	if (write_in_full(fd, src->ptr, src->size) != src->size)
+	if (write_in_full(fd, src->ptr, src->size) < 0)
 		die_errno("unable to write temp-file");
 	close(fd);
 }
diff --git a/read-cache.c b/read-cache.c
index 40da87ea71..357cea7a15 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1922,7 +1922,7 @@ static int ce_write_flush(git_SHA_CTX *context, int fd)
 	unsigned int buffered = write_buffer_len;
 	if (buffered) {
 		git_SHA1_Update(context, write_buffer, buffered);
-		if (write_in_full(fd, write_buffer, buffered) != buffered)
+		if (write_in_full(fd, write_buffer, buffered) < 0)
 			return -1;
 		write_buffer_len = 0;
 	}
@@ -1971,7 +1971,7 @@ static int ce_flush(git_SHA_CTX *context, int fd, unsigned char *sha1)
 
 	/* Flush first if not enough space for SHA1 signature */
 	if (left + 20 > WRITE_BUFFER_SIZE) {
-		if (write_in_full(fd, write_buffer, left) != left)
+		if (write_in_full(fd, write_buffer, left) < 0)
 			return -1;
 		left = 0;
 	}
@@ -1980,7 +1980,7 @@ static int ce_flush(git_SHA_CTX *context, int fd, unsigned char *sha1)
 	git_SHA1_Final(write_buffer + left, context);
 	hashcpy(sha1, write_buffer + left);
 	left += 20;
-	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
+	return (write_in_full(fd, write_buffer, left) < 0) ? -1 : 0;
 }
 
 static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
diff --git a/refs.c b/refs.c
index b0106b8162..30201cf0cb 100644
--- a/refs.c
+++ b/refs.c
@@ -627,7 +627,7 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 		}
 	}
 
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_addf(err, "could not write to '%s'", filename);
 		rollback_lock_file(&lock);
 		goto done;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fccbc24ac4..f8b91fff3f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1628,8 +1628,8 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 		return -1;
 	}
 	fd = get_lock_file_fd(lock->lk);
-	if (write_in_full(fd, oid_to_hex(oid), GIT_SHA1_HEXSZ) != GIT_SHA1_HEXSZ ||
-	    write_in_full(fd, &term, 1) != 1 ||
+	if (write_in_full(fd, oid_to_hex(oid), GIT_SHA1_HEXSZ) < 0 ||
+	    write_in_full(fd, &term, 1) < 0 ||
 	    close_ref(lock) < 0) {
 		strbuf_addf(err,
 			    "couldn't write '%s'", get_lock_file_path(lock->lk));
@@ -2853,8 +2853,8 @@ static int files_reflog_expire(struct ref_store *ref_store,
 					strerror(errno));
 		} else if (update &&
 			   (write_in_full(get_lock_file_fd(lock->lk),
-				oid_to_hex(&cb.last_kept_oid), GIT_SHA1_HEXSZ) != GIT_SHA1_HEXSZ ||
-			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") != 1 ||
+				oid_to_hex(&cb.last_kept_oid), GIT_SHA1_HEXSZ) < 0 ||
+			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") < 0 ||
 			    close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
 					get_lock_file_path(lock->lk));
diff --git a/rerere.c b/rerere.c
index d77235645e..1ce440f4bb 100644
--- a/rerere.c
+++ b/rerere.c
@@ -258,7 +258,7 @@ static int write_rr(struct string_list *rr, int out_fd)
 				    rerere_id_hex(id),
 				    rr->items[i].string, 0);
 
-		if (write_in_full(out_fd, buf.buf, buf.len) != buf.len)
+		if (write_in_full(out_fd, buf.buf, buf.len) < 0)
 			die("unable to write rerere record");
 
 		strbuf_release(&buf);
diff --git a/shallow.c b/shallow.c
index f5591e56da..57b494ab58 100644
--- a/shallow.c
+++ b/shallow.c
@@ -296,7 +296,7 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
 	if (write_shallow_commits(&sb, 0, extra)) {
 		fd = xmks_tempfile(&temporary_shallow, git_path("shallow_XXXXXX"));
 
-		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
+		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
 				  get_tempfile_path(&temporary_shallow));
 		close_tempfile(&temporary_shallow);
@@ -321,7 +321,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update();
 	if (write_shallow_commits(&sb, 0, extra)) {
-		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
+		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
 				  get_lock_file_path(shallow_lock));
 		*alternate_shallow_file = get_lock_file_path(shallow_lock);
@@ -368,7 +368,7 @@ void prune_shallow(int show_only)
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update();
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
-		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
+		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
 				  get_lock_file_path(&shallow_lock));
 		commit_lock_file(&shallow_lock);
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 59937dc1be..591730adc4 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -69,7 +69,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
-	if (fd < 0 || write_in_full(fd, out_buf, out_size) != out_size) {
+	if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
 		perror(argv[4]);
 		return 1;
 	}
diff --git a/transport-helper.c b/transport-helper.c
index f50b34df2d..b66cb7d8e2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -44,8 +44,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 {
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", buffer->buf);
-	if (write_in_full(helper->helper->in, buffer->buf, buffer->len)
-		!= buffer->len)
+	if (write_in_full(helper->helper->in, buffer->buf, buffer->len) < 0)
 		die_errno("Full write to remote helper failed");
 }
 
@@ -74,7 +73,7 @@ static void write_constant(int fd, const char *str)
 {
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", str);
-	if (write_in_full(fd, str, strlen(str)) != strlen(str))
+	if (write_in_full(fd, str, strlen(str)) < 0)
 		die_errno("Full write to remote helper failed");
 }
 
diff --git a/wrapper.c b/wrapper.c
index 36630e5d18..61aba0b5c1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -652,7 +652,7 @@ int xsnprintf(char *dst, size_t max, const char *fmt, ...)
 void write_file_buf(const char *path, const char *buf, size_t len)
 {
 	int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
-	if (write_in_full(fd, buf, len) != len)
+	if (write_in_full(fd, buf, len) < 0)
 		die_errno(_("could not write to %s"), path);
 	if (close(fd))
 		die_errno(_("could not close %s"), path);
-- 
2.14.1.874.ge7b2e05270

