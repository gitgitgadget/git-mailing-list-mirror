Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F169192B6D
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453270; cv=none; b=UljxHAhpM3/u05GyxoFyR75ZqVv0IB2iFy+pi89s8pQU5cO6g6zI2jmVpydCdqB56hCy2ZF7pbR6ddjQAqf4rjG41JLRbM3SGqmb3ZJEh0XfFCXh52ptI3DQpGKAFAN14RIhTxpOyqtQ/XFpOSSoUF8HW5ICg1qq9CYcnsM8Q3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453270; c=relaxed/simple;
	bh=QDHxFk6B61QLOaBhQf04GpmTq84ETy545BL6MpebPB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2XRnVsONurAWt89KISJMrI9Hstpz2EnZtyZdf0HGYdk3KONYYpGLvwZwZ/CC8DEs/ohS260DN/SBYcqcE2+u4QthHafaSsOEG9gR6sXvM77WyfZNKRTne7HFgozH22OKLzai567kz3AfjY2TJhnRUndtXQABAQ8AFGoKY0aRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=rW+hePpn; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="rW+hePpn"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B841F56A;
	Fri, 23 Aug 2024 22:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453193;
	bh=QDHxFk6B61QLOaBhQf04GpmTq84ETy545BL6MpebPB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rW+hePpn8z0gAjLEFDq+GthGXrYAjvFdmLZTaChmK7+QfwYxx2bO94aAmYlKQKUPv
	 vq1IrqwQGxFfKMy4op3uUHiobspFOobkwAAbDdj71tR1jPDMDqnHDbwXyJGm/RToNL
	 hwzkLJ6h7Dp0gvIgV2XE5UgR6jYMSlXvFLh4U+Ls=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 10/10] cat-file: use writev(2) if available
Date: Fri, 23 Aug 2024 22:46:30 +0000
Message-ID: <20240823224630.1180772-11-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using writev here is 20-40% faster than three write syscalls in
succession for smaller (1-10k) objects in the delta base cache.
This advantage decreases as object sizes approach pipe size (64k
on Linux).

writev reduces wakeups and syscalls on the read side as well:
each write(2) syscall may trigger one or more corresponding
read(2) syscalls in the reader.  Attempting atomicity in the
writer via writev also reduces the likelyhood of non-blocking
readers failing with EAGAIN and having to call poll||select
before attempting to read again.

Unfortunately, this turns into a small (1-3%) slowdown for
gigantic objects of a megabyte or more even with after
increasing pipe size to 1MB via the F_SETPIPE_SZ fcntl(2) op.
This slowdown is acceptable to me since the vast majority of
objects are 64K or less for projects I've looked at.

Relying on stdio buffering and fflush(3) after each response was
considered for users without --buffer, but historically cat-file
defaults to being compatible with non-blocking stdout and able
to poll(2) after hitting EAGAIN on write(2).  Using stdio on
files with the O_NONBLOCK flag is (AFAIK) unspecified and likely
subject to portability problems and thus avoided.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Makefile           |  3 +++
 builtin/cat-file.c | 62 ++++++++++++++++++++++++++++++-------------
 config.mak.uname   |  5 ++++
 git-compat-util.h  | 10 +++++++
 wrapper.c          | 18 +++++++++++++
 wrapper.h          |  1 +
 write-or-die.c     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 write-or-die.h     |  2 ++
 8 files changed, 149 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 3eab701b10..c7a062de00 100644
--- a/Makefile
+++ b/Makefile
@@ -1844,6 +1844,9 @@ ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
 endif
+ifdef HAVE_WRITEV
+	COMPAT_CFLAGS += -DHAVE_WRITEV
+endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
 endif
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bf81054662..016b7d26a7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -280,7 +280,7 @@ struct expand_data {
 	off_t disk_size;
 	const char *rest;
 	struct object_id delta_base_oid;
-	void *content;
+	struct git_iovec iov[3];
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -378,17 +378,42 @@ static void batch_write(struct batch_options *opt, const void *data, size_t len)
 		write_or_die(1, data, len);
 }
 
-static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
+static void batch_writev(struct batch_options *opt, struct expand_data *data,
+			const struct strbuf *hdr, size_t size)
+{
+	data->iov[0].iov_base = hdr->buf;
+	data->iov[0].iov_len = hdr->len;
+	data->iov[1].iov_len = size;
+
+	/*
+	 * Copying a (8|16)-byte iovec for a single byte is gross, but my
+	 * attempt to stuff output_delim into the trailing NUL byte of
+	 * iov[1].iov_base (and restoring it after writev(2) for the
+	 * OI_DBCACHED case) to drop iovcnt from 3->2 wasn't faster.
+	 */
+	data->iov[2].iov_base = &opt->output_delim;
+	data->iov[2].iov_len = 1;
+
+	if (opt->buffer_output)
+		fwritev_or_die(stdout, data->iov, 3);
+	else
+		writev_or_die(1, data->iov, 3);
+
+	/* writev_or_die may move iov[1].iov_base, so it's invalid */
+	data->iov[1].iov_base = NULL;
+}
+
+static void print_object_or_die(struct batch_options *opt,
+				struct expand_data *data, struct strbuf *hdr)
 {
 	const struct object_id *oid = &data->oid;
 
 	assert(data->info.typep);
 
-	if (data->content) {
-		void *content = data->content;
+	if (data->iov[1].iov_base) {
+		void *content = data->iov[1].iov_base;
 		unsigned long size = data->size;
 
-		data->content = NULL;
 		if (use_mailmap && (data->type == OBJ_COMMIT ||
 					data->type == OBJ_TAG)) {
 			size_t s = size;
@@ -399,10 +424,10 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			}
 
 			content = replace_idents_using_mailmap(content, &s);
+			data->iov[1].iov_base = content;
 			size = cast_size_t_to_ulong(s);
 		}
-
-		batch_write(opt, content, size);
+		batch_writev(opt, data, hdr, size);
 		switch (data->info.whence) {
 		case OI_CACHED:
 			/*
@@ -419,8 +444,6 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		}
 	} else {
 		assert(data->type == OBJ_BLOB);
-		if (opt->buffer_output)
-			fflush(stdout);
 		if (opt->transform_mode) {
 			char *contents;
 			unsigned long size;
@@ -447,10 +470,15 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 					    oid_to_hex(oid), data->rest);
 			} else
 				BUG("invalid transform_mode: %c", opt->transform_mode);
-			batch_write(opt, contents, size);
+			data->iov[1].iov_base = contents;
+			batch_writev(opt, data, hdr, size);
 			free(contents);
 		} else {
+			batch_write(opt, hdr->buf, hdr->len);
+			if (opt->buffer_output)
+				fflush(stdout);
 			stream_blob(oid);
+			batch_write(opt, &opt->output_delim, 1);
 		}
 	}
 }
@@ -519,12 +547,10 @@ static void batch_object_write(const char *obj_name,
 		strbuf_addch(scratch, opt->output_delim);
 	}
 
-	batch_write(opt, scratch->buf, scratch->len);
-
-	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
-		print_object_or_die(opt, data);
-		batch_write(opt, &opt->output_delim, 1);
-	}
+	if (opt->batch_mode == BATCH_MODE_CONTENTS)
+		print_object_or_die(opt, data, scratch);
+	else
+		batch_write(opt, scratch->buf, scratch->len);
 }
 
 static void batch_one_object(const char *obj_name,
@@ -666,7 +692,7 @@ static void parse_cmd_contents(struct batch_options *opt,
 			     struct expand_data *data)
 {
 	opt->batch_mode = BATCH_MODE_CONTENTS;
-	data->info.contentp = &data->content;
+	data->info.contentp = &data->iov[1].iov_base;
 	batch_one_object(line, output, opt, data);
 }
 
@@ -823,7 +849,7 @@ static int batch_objects(struct batch_options *opt)
 		data.info.typep = &data.type;
 		if (!opt->transform_mode) {
 			data.info.sizep = &data.size;
-			data.info.contentp = &data.content;
+			data.info.contentp = &data.iov[1].iov_base;
 			data.info.content_limit = big_file_threshold;
 			data.info.direct_cache = 1;
 		}
diff --git a/config.mak.uname b/config.mak.uname
index 85d63821ec..8ce8776657 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -69,6 +69,7 @@ ifeq ($(uname_S),Linux)
 		BASIC_CFLAGS += -std=c99
         endif
 	LINK_FUZZ_PROGRAMS = YesPlease
+	HAVE_WRITEV = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
@@ -77,6 +78,7 @@ ifeq ($(uname_S),GNU/kFreeBSD)
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	HAVE_WRITEV = YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
@@ -292,6 +294,7 @@ ifeq ($(uname_S),FreeBSD)
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	FILENO_IS_A_MACRO = UnfortunatelyYes
+	HAVE_WRITEV = YesPlease
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -307,6 +310,7 @@ ifeq ($(uname_S),OpenBSD)
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	FILENO_IS_A_MACRO = UnfortunatelyYes
+	HAVE_WRITEV = YesPlease
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
@@ -329,6 +333,7 @@ ifeq ($(uname_S),NetBSD)
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	CSPRNG_METHOD = arc4random
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
+	HAVE_WRITEV = YesPlease
 endif
 ifeq ($(uname_S),AIX)
 	DEFAULT_PAGER = more
diff --git a/git-compat-util.h b/git-compat-util.h
index ca7678a379..afde8abc99 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -388,6 +388,16 @@ static inline int git_setitimer(int which UNUSED,
 #define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
 #endif
 
+#ifdef HAVE_WRITEV
+#include <sys/uio.h>
+#define git_iovec iovec
+#else /* !HAVE_WRITEV */
+struct git_iovec {
+	void *iov_base;
+	size_t iov_len;
+};
+#endif /* !HAVE_WRITEV */
+
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
 #else
diff --git a/wrapper.c b/wrapper.c
index f87d90bf57..066c772145 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -262,6 +262,24 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	}
 }
 
+#ifdef HAVE_WRITEV
+ssize_t xwritev(int fd, const struct iovec *iov, int iovcnt)
+{
+	while (1) {
+		ssize_t nr = writev(fd, iov, iovcnt);
+
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			if (handle_nonblock(fd, POLLOUT, errno))
+				continue;
+		}
+
+		return nr;
+	}
+}
+#endif /* !HAVE_WRITEV */
+
 /*
  * xpread() is the same as pread(), but it automatically restarts pread()
  * operations with a recoverable error (EAGAIN and EINTR). xpread() DOES
diff --git a/wrapper.h b/wrapper.h
index 1b2b047ea0..3d33c63d4f 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -16,6 +16,7 @@ void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_
 int xopen(const char *path, int flags, ...);
 ssize_t xread(int fd, void *buf, size_t len);
 ssize_t xwrite(int fd, const void *buf, size_t len);
+ssize_t xwritev(int fd, const struct git_iovec *, int iovcnt);
 ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 int xdup(int fd);
 FILE *xfopen(const char *path, const char *mode);
diff --git a/write-or-die.c b/write-or-die.c
index 01a9a51fa2..227b051165 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -107,3 +107,69 @@ void fflush_or_die(FILE *f)
 	if (fflush(f))
 		die_errno("fflush error");
 }
+
+void fwritev_or_die(FILE *fp, const struct git_iovec *iov, int iovcnt)
+{
+	int i;
+
+	for (i = 0; i < iovcnt; i++) {
+		size_t n = iov[i].iov_len;
+
+		if (fwrite(iov[i].iov_base, 1, n, fp) != n)
+			die_errno("unable to write to FD=%d", fileno(fp));
+	}
+}
+
+/*
+ * note: we don't care about atomicity from writev(2) right now.
+ * The goal is to avoid allocations+copies in the writer and
+ * reduce wakeups+syscalls in the reader.
+ * n.b. @iov is not const since we modify it to avoid allocating
+ * on partial write.
+ */
+#ifdef HAVE_WRITEV
+void writev_or_die(int fd, struct git_iovec *iov, int iovcnt)
+{
+	int i;
+
+	while (iovcnt > 0) {
+		ssize_t n = xwritev(fd, iov, iovcnt);
+
+		/* EINVAL happens when sum of iov_len exceeds SSIZE_MAX */
+		if (n < 0 && errno == EINVAL)
+			n = xwrite(fd, iov[0].iov_base, iov[0].iov_len);
+		if (n < 0) {
+			check_pipe(errno);
+			die_errno("writev error");
+		} else if (!n) {
+			errno = ENOSPC;
+			die_errno("writev_error");
+		}
+		/* skip fully written iovs, retry from the first partial iov */
+		for (i = 0; i < iovcnt; i++) {
+			if (n >= iov[i].iov_len) {
+				n -= iov[i].iov_len;
+			} else {
+				iov[i].iov_len -= n;
+				iov[i].iov_base = (char *)iov[i].iov_base + n;
+				break;
+			}
+		}
+		iovcnt -= i;
+		iov += i;
+	}
+}
+#else /* !HAVE_WRITEV */
+
+/*
+ * n.b. don't use stdio fwrite here even if it's faster, @fd may be
+ * non-blocking and stdio isn't equipped for EAGAIN
+ */
+void writev_or_die(int fd, struct git_iovec *iov, int iovcnt)
+{
+	int i;
+
+	for (i = 0; i < iovcnt; i++)
+		write_or_die(fd, iov[i].iov_base, iov[i].iov_len);
+}
+#endif /* !HAVE_WRITEV */
diff --git a/write-or-die.h b/write-or-die.h
index 65a5c42a47..20abec211c 100644
--- a/write-or-die.h
+++ b/write-or-die.h
@@ -7,6 +7,8 @@ void fprintf_or_die(FILE *, const char *fmt, ...);
 void fwrite_or_die(FILE *f, const void *buf, size_t count);
 void fflush_or_die(FILE *f);
 void write_or_die(int fd, const void *buf, size_t count);
+void writev_or_die(int fd, struct git_iovec *, int iovcnt);
+void fwritev_or_die(FILE *, const struct git_iovec *, int iovcnt);
 
 /*
  * These values are used to help identify parts of a repository to fsync.
