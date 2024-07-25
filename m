Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9B14A82
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721948854; cv=none; b=dyvg/eSKaktxOyXwdcRqED8xp8E5xwmkyvX2Qdt0Wr8thW5ANQ9Rxqf7jDdzA4lU1nI3R/wyoKzw9rJzxbOfB62XBkKzZIKQ5vtRQvnF40zgrPYVtJkvK+ZGLA1MKTJfmgxHCWHIBnm3V9SimBa080nUebuWyEdZ3egITTeLBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721948854; c=relaxed/simple;
	bh=laRpcQGwwnfdDZnc7rwwABvyeErjlwCKOfFtFeUMFXs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FufiIpLI8qtCFCDoJcL8Z7XXPYxJc5P8CkWngTNpmHu3clvioPNpLxBjOF8OeUanimciSWJD2/o+dQNS41wm2IJr3XEPxitqyo37+Ls3/sH8S/RiZQN9v931kz7pobTT+uTAnmht1y4YPtRus4qkWNUUgDJIO14Wxz3Wz773fZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vW3Q0ha6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vW3Q0ha6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 061BB287B6;
	Thu, 25 Jul 2024 19:07:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=l
	aRpcQGwwnfdDZnc7rwwABvyeErjlwCKOfFtFeUMFXs=; b=vW3Q0ha6uG52uO4kd
	+XohG0+fGJS15JXQD/95MSZooCty3TwAnPp6XjrdL2apTyImELdvZdhG4Sc+kOqv
	I0hhzuoqH70tqryrIrl4FM2T0Ij9yw1dvwmHmMUee8Ey34JFEHlpDifZ3+h9m2y4
	BbRJscaZwUtDB/B5hpV9nOVq9Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFC1F287B5;
	Thu, 25 Jul 2024 19:07:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 548B9287B4;
	Thu, 25 Jul 2024 19:07:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] csum-file: introduce discard_hashfile()
Date: Thu, 25 Jul 2024 16:07:28 -0700
Message-ID: <xmqqle1p1367.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AA61E57A-4ADA-11EF-9963-34EEED2EC81B-77302942!pb-smtp1.pobox.com

The hashfile API is used to write out a "hashfile", which has a
final checksum (typically SHA-1) at the end.  An in-core hashfile
structure has up to two file descriptors and a few buffers that can
only be freed by calling a helper function that is private to the
csum-file implementation.

The usual flow of a user of the API is to first open a file
descriptor for writing, obtain a hashfile associated with that write
file descriptor by calling either hashfd() or hashfd_check(), call
hashwrite() number of times to write data to the file, and then call
finalize_hashfile(), which appends th checksum to the end of the
file, closes file descriptors and releases associated buffers.

But what if a caller finds some error after calling hashfd() to
start the process and/or hashwrite() to send some data to the file,
and wants to abort the operation?  The underlying file descriptor is
often managed by the tempfile API, so aborting will clean the file
out of the filesystem, but the resources associated with the in-core
hashfile structure is lost.

Introduce discard_hashfile() API function to allow them to release
the resources held by a hashfile structure the callers want to
dispose of, and use that in read-cache.c:do_write_index(), which is
a central place that writes the index file.

Mark t2107 as leak-free, as this leak in "update-index --cacheinfo"
test that deliberately makes it fail is now plugged.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 csum-file.c                   |  9 ++++
 csum-file.h                   |  1 +
 read-cache.c                  | 99 +++++++++++++++++++++++++++--------
 t/t2107-update-index-basic.sh |  1 +
 4 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 8abbf01325..2131ee6b12 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -102,6 +102,15 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	return fd;
 }
 
+void discard_hashfile(struct hashfile *f)
+{
+	if (0 <= f->check_fd)
+		close(f->check_fd);
+	if (0 <= f->fd)
+		close(f->fd);
+	free_hashfile(f);
+}
+
 void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 {
 	while (count) {
diff --git a/csum-file.h b/csum-file.h
index 566e05cbd2..36c7c5585f 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -47,6 +47,7 @@ struct hashfile *hashfd(int fd, const char *name);
 struct hashfile *hashfd_check(const char *name);
 struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
+void discard_hashfile(struct hashfile *);
 void hashwrite(struct hashfile *, const void *, unsigned int);
 void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
diff --git a/read-cache.c b/read-cache.c
index 48bf24f87c..d96a2cb8cf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2963,7 +2963,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	if (err) {
 		free(ieot);
-		return err;
+		goto discard_hashfile_and_return;
 	}
 
 	offset = hashfile_total(f);
@@ -2992,8 +2992,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		free(ieot);
-		if (err)
-			return -1;
+		/*
+		 * NEEDSWORK: write_index_ext_header() never returns a failure,
+		 * and this part may want to be simplified.
+		 */
+		if (err) {
+			err = -1;
+			goto discard_hashfile_and_return;
+		}
 	}
 
 	if (write_extensions & WRITE_SPLIT_INDEX_EXTENSION &&
@@ -3008,8 +3014,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 					       sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
-		if (err)
-			return -1;
+		/*
+		 * NEEDSWORK: write_link_extension() never returns a failure,
+		 * and this part may want to be simplified.
+		 */
+		if (err) {
+			err = -1;
+			goto discard_hashfile_and_return;
+		}
 	}
 	if (write_extensions & WRITE_CACHE_TREE_EXTENSION &&
 	    !drop_cache_tree && istate->cache_tree) {
@@ -3019,8 +3031,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_TREE, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
-		if (err)
-			return -1;
+		/*
+		 * NEEDSWORK: write_index_ext_header() never returns a failure,
+		 * and this part may want to be simplified.
+		 */
+		if (err) {
+			err = -1;
+			goto discard_hashfile_and_return;
+		}
 	}
 	if (write_extensions & WRITE_RESOLVE_UNDO_EXTENSION &&
 	    istate->resolve_undo) {
@@ -3031,8 +3049,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
-		if (err)
-			return -1;
+		/*
+		 * NEEDSWORK: write_index_ext_header() never returns a failure,
+		 * and this part may want to be simplified.
+		 */
+		if (err) {
+			err = -1;
+			goto discard_hashfile_and_return;
+		}
 	}
 	if (write_extensions & WRITE_UNTRACKED_CACHE_EXTENSION &&
 	    istate->untracked) {
@@ -3043,8 +3067,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
-		if (err)
-			return -1;
+		/*
+		 * NEEDSWORK: write_index_ext_header() never returns a failure,
+		 * and this part may want to be simplified.
+		 */
+		if (err) {
+			err = -1;
+			goto discard_hashfile_and_return;
+		}
 	}
 	if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
 	    istate->fsmonitor_last_update) {
@@ -3054,12 +3084,25 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_FSMONITOR, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
-		if (err)
-			return -1;
+		/*
+		 * NEEDSWORK: write_index_ext_header() never returns a failure,
+		 * and this part may want to be simplified.
+		 */
+		if (err) {
+			err = -1;
+			goto discard_hashfile_and_return;
+		}
 	}
 	if (istate->sparse_index) {
-		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0)
-			return -1;
+		err = write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0);
+		/*
+		 * NEEDSWORK: write_index_ext_header() never returns a failure,
+		 * and this part may want to be simplified.
+		 */
+		if (err) {
+			err = -1;
+			goto discard_hashfile_and_return;
+		}
 	}
 
 	/*
@@ -3075,8 +3118,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		err = write_index_ext_header(f, NULL, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
-		if (err)
-			return -1;
+		/*
+		 * NEEDSWORK: write_index_ext_header() never returns a failure,
+		 * and this part may want to be simplified.
+		 */
+		if (err) {
+			err = -1;
+			goto discard_hashfile_and_return;
+		}
 	}
 
 	csum_fsync_flag = 0;
@@ -3085,13 +3134,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
 			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
+	f = NULL;
 
 	if (close_tempfile_gently(tempfile)) {
-		error(_("could not close '%s'"), get_tempfile_path(tempfile));
-		return -1;
+		err = error(_("could not close '%s'"), get_tempfile_path(tempfile));
+		goto discard_hashfile_and_return;
+	}
+	if (stat(get_tempfile_path(tempfile), &st)) {
+		err = error_errno(_("could not stat '%s'"), get_tempfile_path(tempfile));
+		goto discard_hashfile_and_return;
 	}
-	if (stat(get_tempfile_path(tempfile), &st))
-		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
@@ -3106,6 +3158,11 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			   istate->cache_nr);
 
 	return 0;
+
+discard_hashfile_and_return:
+	if (f)
+		discard_hashfile(f);
+	return err;
 }
 
 void set_alternate_index_output(const char *name)
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index cc72ead79f..f0eab13f96 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -5,6 +5,7 @@ test_description='basic update-index tests
 Tests for command-line parsing and basic operation.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'update-index --nonsense fails' '
-- 
2.46.0-rc2-67-g99767055c1

