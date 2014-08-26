From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v6 6/6] convert: stream from fd to required clean filter to reduce used address space
Date: Tue, 26 Aug 2014 17:23:25 +0200
Message-ID: <1409066605-4851-7-git-send-email-prohaska@zib.de>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:24:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMIbX-0001KG-ND
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 17:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758522AbaHZPYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 11:24:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:35555 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932326AbaHZPYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 11:24:10 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNec2011320;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNcNf011272;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1409066605-4851-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53FCA67C.006 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FCA67C.006 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FCA67C.006 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255913>

The data is streamed to the filter process anyway.  Better avoid mapping
the file if possible.  This is especially useful if a clean filter
reduces the size, for example if it computes a sha1 for binary data,
like git media.  The file size that the previous implementation could
handle was limited by the available address space; large files for
example could not be handled with (32-bit) msysgit.  The new
implementation can filter files of any size as long as the filter output
is small enough.

The new code path is only taken if the filter is required.  The filter
consumes data directly from the fd.  If it fails, the original data is
not immediately available.  The condition can easily be handled as
a fatal error, which is expected for a required filter anyway.

If the filter was not required, the condition would need to be handled
in a different way, like seeking to 0 and reading the data.  But this
would require more restructuring of the code and is probably not worth
it.  The obvious approach of falling back to reading all data would not
help achieving the main purpose of this patch, which is to handle large
files with limited address space.  If reading all data is an option, we
can simply take the old code path right away and mmap the entire file.

The environment variable GIT_MMAP_LIMIT, which has been introduced in
a previous commit is used to test that the expected code path is taken.
A related test that exercises required filters is modified to verify
that the data actually has been modified on its way from the file system
to the object store.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 convert.c             | 55 +++++++++++++++++++++++++++++++++++++++++++++------
 convert.h             |  5 +++++
 sha1_file.c           | 27 ++++++++++++++++++++++++-
 t/t0021-conversion.sh | 24 +++++++++++++++++-----
 4 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/convert.c b/convert.c
index cb5fbb4..677d339 100644
--- a/convert.c
+++ b/convert.c
@@ -312,11 +312,12 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 struct filter_params {
 	const char *src;
 	unsigned long size;
+	int fd;
 	const char *cmd;
 	const char *path;
 };
 
-static int filter_buffer(int in, int out, void *data)
+static int filter_buffer_or_fd(int in, int out, void *data)
 {
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
@@ -355,7 +356,12 @@ static int filter_buffer(int in, int out, void *data)
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
+	if (params->src) {
+		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
+	} else {
+		write_err = copy_fd(params->fd, child_process.in);
+	}
+
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
@@ -371,7 +377,7 @@ static int filter_buffer(int in, int out, void *data)
 	return (write_err || status);
 }
 
-static int apply_filter(const char *path, const char *src, size_t len,
+static int apply_filter(const char *path, const char *src, size_t len, int fd,
                         struct strbuf *dst, const char *cmd)
 {
 	/*
@@ -392,11 +398,12 @@ static int apply_filter(const char *path, const char *src, size_t len,
 		return 1;
 
 	memset(&async, 0, sizeof(async));
-	async.proc = filter_buffer;
+	async.proc = filter_buffer_or_fd;
 	async.data = &params;
 	async.out = -1;
 	params.src = src;
 	params.size = len;
+	params.fd = fd;
 	params.cmd = cmd;
 	params.path = path;
 
@@ -747,6 +754,25 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 	}
 }
 
+int would_convert_to_git_filter_fd(const char *path)
+{
+	struct conv_attrs ca;
+
+	convert_attrs(&ca, path);
+	if (!ca.drv)
+		return 0;
+
+	/*
+	 * Apply a filter to an fd only if the filter is required to succeed.
+	 * We must die if the filter fails, because the original data before
+	 * filtering is not available.
+	 */
+	if (!ca.drv->required)
+		return 0;
+
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
@@ -761,7 +787,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		required = ca.drv->required;
 	}
 
-	ret |= apply_filter(path, src, len, dst, filter);
+	ret |= apply_filter(path, src, len, -1, dst, filter);
 	if (!ret && required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
@@ -778,6 +804,23 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
 
+void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
+			      enum safe_crlf checksafe)
+{
+	struct conv_attrs ca;
+	convert_attrs(&ca, path);
+
+	assert(ca.drv);
+	assert(ca.drv->clean);
+
+	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
+		die("%s: clean filter '%s' failed", path, ca.drv->name);
+
+	ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
+	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
+}
+
 static int convert_to_working_tree_internal(const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing)
@@ -811,7 +854,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
-	ret_filter = apply_filter(path, src, len, dst, filter);
+	ret_filter = apply_filter(path, src, len, -1, dst, filter);
 	if (!ret_filter && required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);
 
diff --git a/convert.h b/convert.h
index c638b33..d9d853c 100644
--- a/convert.h
+++ b/convert.h
@@ -44,6 +44,11 @@ static inline int would_convert_to_git(const char *path)
 {
 	return convert_to_git(path, NULL, 0, NULL, 0);
 }
+/* Precondition: would_convert_to_git_filter_fd(path) == true */
+extern void convert_to_git_filter_fd(const char *path, int fd,
+				     struct strbuf *dst,
+				     enum safe_crlf checksafe);
+extern int would_convert_to_git_filter_fd(const char *path);
 
 /*****************************************************************
  *
diff --git a/sha1_file.c b/sha1_file.c
index d9b5157..423ec64 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3090,6 +3090,29 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	return ret;
 }
 
+static int index_stream_convert_blob(unsigned char *sha1, int fd,
+				     const char *path, unsigned flags)
+{
+	int ret;
+	const int write_object = flags & HASH_WRITE_OBJECT;
+	struct strbuf sbuf = STRBUF_INIT;
+
+	assert(path);
+	assert(would_convert_to_git_filter_fd(path));
+
+	convert_to_git_filter_fd(path, fd, &sbuf,
+				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
+
+	if (write_object)
+		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
+				      sha1);
+	else
+		ret = hash_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
+				     sha1);
+	strbuf_release(&sbuf);
+	return ret;
+}
+
 static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
 		      const char *path, unsigned flags)
 {
@@ -3157,7 +3180,9 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	int ret;
 	size_t size = xsize_t(st->st_size);
 
-	if (!S_ISREG(st->st_mode))
+	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(path))
+		ret = index_stream_convert_blob(sha1, fd, path, flags);
+	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
 	else if (size <= big_file_threshold || type != OBJ_BLOB ||
 		 (path && would_convert_to_git(path)))
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index f890c54..82ebbff 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -153,17 +153,23 @@ test_expect_success 'filter shell-escaped filenames' '
 	:
 '
 
-test_expect_success 'required filter success' '
-	git config filter.required.smudge cat &&
-	git config filter.required.clean cat &&
+test_expect_success 'required filter should filter data' '
+	git config filter.required.smudge ./rot13.sh &&
+	git config filter.required.clean ./rot13.sh &&
 	git config filter.required.required true &&
 
 	echo "*.r filter=required" >.gitattributes &&
 
-	echo test >test.r &&
+	cat test.o >test.r &&
 	git add test.r &&
+
 	rm -f test.r &&
-	git checkout -- test.r
+	git checkout -- test.r &&
+	cmp test.o test.r &&
+
+	./rot13.sh <test.o >expected &&
+	git cat-file blob :test.r >actual &&
+	cmp expected actual
 '
 
 test_expect_success 'required filter smudge failure' '
@@ -189,6 +195,14 @@ test_expect_success 'required filter clean failure' '
 	echo test >test.fc &&
 	test_must_fail git add test.fc
 '
+test_expect_success \
+'filtering large input to small output should use little memory' '
+	git config filter.devnull.clean "cat >/dev/null" &&
+	git config filter.devnull.required true &&
+	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
+	echo "30MB filter=devnull" >.gitattributes &&
+	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
+'
 
 test_expect_success EXPENSIVE 'filter large file' '
 	git config filter.largefile.smudge cat &&
-- 
2.1.0.8.gf3a29c8
