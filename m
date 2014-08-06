From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2 2/2] convert: Stream from fd to required clean filter instead of mmap
Date: Wed,  6 Aug 2014 07:32:14 +0200
Message-ID: <1407303134-16635-3-git-send-email-prohaska@zib.de>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 07:32:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEtqI-0002Ud-0y
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 07:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbaHFFcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 01:32:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:40503 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbaHFFcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 01:32:41 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s765WWEn020451;
	Wed, 6 Aug 2014 07:32:32 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s765WNKu020135;
	Wed, 6 Aug 2014 07:32:32 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1407303134-16635-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53E1BDF0.001 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53E1BDF0.001 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53E1BDF0.001 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254846>

The data is streamed to the filter process anyway.  Better avoid mapping
the file if possible.  This is especially useful if a clean filter
reduces the size, for example if it computes a sha1 for binary data,
like git media.  The file size that the previous implementation could
handle was limited by the available address space; large files for
example could not be handled with (32-bit) msysgit.  The new
implementation can filter files of any size as long as the filter output
is small enough.

The new code path is only taken if the filter is required.  The filter
consumes data directly from the fd.  The original data is not available
to git, so it must fail if the filter fails.

The test that exercises required filters is modified to verify that the
data actually has been modified on its way from the file system to the
object store.

The expectation on the process size is tested using /usr/bin/time.  An
alternative would have been tcsh, which could be used to print memory
information as follows:

    tcsh -c 'set time=(0 "%M"); <cmd>'

Although the logic could perhaps be simplified with tcsh, I chose to use
'time' to avoid a dependency on tcsh.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 convert.c             | 60 ++++++++++++++++++++++++++++++++++++++++-----
 convert.h             |  5 ++++
 sha1_file.c           | 27 +++++++++++++++++++-
 t/t0021-conversion.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 148 insertions(+), 12 deletions(-)

diff --git a/convert.c b/convert.c
index cb5fbb4..463f6de 100644
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
@@ -325,6 +326,7 @@ static int filter_buffer(int in, int out, void *data)
 	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
 	const char *argv[] = { NULL, NULL };
+	int fd;
 
 	/* apply % substitution to cmd */
 	struct strbuf cmd = STRBUF_INIT;
@@ -355,7 +357,17 @@ static int filter_buffer(int in, int out, void *data)
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
+	if (params->src) {
+	    write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
+	} else {
+	    /* dup(), because copy_fd() closes the input fd. */
+	    fd = dup(params->fd);
+	    if (fd < 0)
+		write_err = error("failed to dup file descriptor.");
+	    else
+		write_err = copy_fd(fd, child_process.in);
+	}
+
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
@@ -371,7 +383,7 @@ static int filter_buffer(int in, int out, void *data)
 	return (write_err || status);
 }
 
-static int apply_filter(const char *path, const char *src, size_t len,
+static int apply_filter(const char *path, const char *src, size_t len, int fd,
                         struct strbuf *dst, const char *cmd)
 {
 	/*
@@ -392,11 +404,12 @@ static int apply_filter(const char *path, const char *src, size_t len,
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
 
@@ -747,6 +760,24 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 	}
 }
 
+int would_convert_to_git_filter_fd(const char *path)
+{
+	struct conv_attrs ca;
+
+	convert_attrs(&ca, path);
+	if (!ca.drv)
+	    return 0;
+
+	/* Apply a filter to an fd only if the filter is required to succeed.
+	 * We must die if the filter fails, because the original data before
+	 * filtering is not available.
+	 */
+	if (!ca.drv->required)
+	    return 0;
+
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
@@ -761,7 +792,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		required = ca.drv->required;
 	}
 
-	ret |= apply_filter(path, src, len, dst, filter);
+	ret |= apply_filter(path, src, len, -1, dst, filter);
 	if (!ret && required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
@@ -778,6 +809,23 @@ int convert_to_git(const char *path, const char *src, size_t len,
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
@@ -811,7 +859,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
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
index 00c07f2..eaf3220 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3074,6 +3074,29 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
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
@@ -3141,7 +3164,9 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
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
index f890c54..2cb2414 100755
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
@@ -190,6 +196,58 @@ test_expect_success 'required filter clean failure' '
 	test_must_fail git add test.fc
 '
 
+# Handle differences in /usr/bin/time.
+#
+#  - Linux: call with '-v'.
+#    output: <spaces><description>:<space><value-in-KBytes>
+#
+#  - Mac: call with '-l'.
+#    output: <spaces><value-in-Bytes><spaces><description>
+#    Strip three digits to get to KB (base 10 is good enough).
+#
+case $(uname -s) in
+Linux)
+	test_set_prereq HAVE_MAX_MEM_USAGE
+	max_mem_usage_KB () {
+	    /usr/bin/time -v "$@" 2>&1 |
+	    grep 'Maximum resident set size' |
+	    cut -d ':' -f 2
+	}
+	;;
+Darwin)
+	test_set_prereq HAVE_MAX_MEM_USAGE
+	max_mem_usage_KB () {
+		/usr/bin/time -l "$@" 2>&1 |
+		grep 'maximum resident set size' |
+		sed -e 's/  */ /' |
+		cut -d ' ' -f 2 |
+		sed -e 's/...$//'
+	}
+	;;
+esac
+
+max_mem_usage_is_lt_KB () {
+	limit=$1
+	shift
+	mem_usage=$(max_mem_usage_KB "$@")
+	if [ $mem_usage -lt $limit ]; then
+		true
+	else
+		printf 'Command used too much memory (expected limit %dKB, actual usage %dKB).\n' \
+			$limit $mem_usage
+		false
+	fi
+}
+
+test_expect_success HAVE_MAX_MEM_USAGE \
+'filtering large input to small output should use little memory' '
+	git config filter.devnull.clean "cat >/dev/null" &&
+	git config filter.devnull.required true &&
+	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
+	echo "30MB filter=devnull" >.gitattributes &&
+	max_mem_usage_is_lt_KB 15000 git add 30MB
+'
+
 test_expect_success EXPENSIVE 'filter large file' '
 	git config filter.largefile.smudge cat &&
 	git config filter.largefile.clean cat &&
-- 
2.1.0.rc1.6.gb569bd8
