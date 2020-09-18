Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E778C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365892311B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIRLjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:39:46 -0400
Received: from mail001-2.aei.ca ([206.123.6.133]:36794 "EHLO mail001.aei.ca"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgIRLjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:39:46 -0400
Received: (qmail 32126 invoked by uid 89); 18 Sep 2020 11:33:05 -0000
Received: by simscan 1.2.0 ppid: 32121, pid: 32123, t: 0.0064s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mta.aei.ca) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 18 Sep 2020 11:33:05 -0000
Received: (qmail 1916 invoked by uid 89); 18 Sep 2020 11:33:06 -0000
Received: by simscan 1.2.0 ppid: 1898, pid: 1906, t: 1.3308s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.97.8/m: spam: 3.3.1
Received: from dsl-216-221-52-235.mtl.contact.net (HELO dermoth.lan) (216.221.52.235)
  by mail.aei.ca with (AES256-SHA encrypted) SMTP; 18 Sep 2020 11:33:04 -0000
Received: from dermoth by dermoth.lan with local (Exim 4.92)
        (envelope-from <tguyot@gmail.com>)
        id 1kJEdT-0004cI-GP; Fri, 18 Sep 2020 07:33:03 -0400
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
To:     git@vger.kernel.org
Cc:     dermoth@aei.ca, Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: [PATCH 2/2] Allow passing pipes for input pipes to diff --no-index
Date:   Fri, 18 Sep 2020 07:32:56 -0400
Message-Id: <20200918113256.8699-3-tguyot@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918113256.8699-1-tguyot@gmail.com>
References: <20200918113256.8699-1-tguyot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A very handy way to pass data to applications is to use the <() process
substitution syntax in bash variants. It allow comparing files streamed
from a remote server or doing on-the-fly stream processing to alter the
diff. These are usually implemented as a symlink that points to a bogus
name (ex "pipe:[209326419]") but opens as a pipe.

Git normally tracks symlinks targets. This patch makes it detect such
pipes in --no-index mode and read the file normally like it would do for
stdin ("-"), so they can be compared directly.

Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
---
 diff-no-index.c          |  56 ++++++++++--
 t/t4053-diff-no-index.sh | 189 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+), 7 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 7814eabfe0..779c686d23 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -41,6 +41,33 @@ static int read_directory_contents(const char *path, struct string_list *list)
  */
 static const char file_from_standard_input[] = "-";
 
+/* Check that file is - (STDIN) or unnamed pipe - explicitly
+ * avoid on-disk named pipes which could block
+ */
+static int ispipe(const char *name)
+{
+	struct stat st;
+
+	if (name == file_from_standard_input)
+		return 1;  /* STDIN */
+
+	if (!lstat(name, &st)) {
+		if (S_ISLNK(st.st_mode)) {
+			/* symlink - read it and check it doesn't exists
+			 * as a file yet link to a pipe */
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_realpath(&sb, name, 0);
+			/* We're abusing strbuf_realpath here, it may append
+			 * pipe:[NNNNNNNNN] to an abs path */
+			if (!stat(sb.buf, &st))
+				return 0; /* link target exists , not pipe */
+			if (!stat(name, &st))
+				return S_ISFIFO(st.st_mode);
+		}
+	}
+	return 0;
+}
+
 static int get_mode(const char *path, int *mode)
 {
 	struct stat st;
@@ -51,7 +78,7 @@ static int get_mode(const char *path, int *mode)
 	else if (!strcasecmp(path, "nul"))
 		*mode = 0;
 #endif
-	else if (path == file_from_standard_input)
+	else if (ispipe(path))
 		*mode = create_ce_mode(0666);
 	else if (lstat(path, &st))
 		return error("Could not access '%s'", path);
@@ -60,13 +87,13 @@ static int get_mode(const char *path, int *mode)
 	return 0;
 }
 
-static int populate_from_stdin(struct diff_filespec *s)
+static int populate_from_fd(struct diff_filespec *s, int fd)
 {
 	struct strbuf buf = STRBUF_INIT;
 	size_t size = 0;
 
-	if (strbuf_read(&buf, 0, 0) < 0)
-		return error_errno("error while reading from stdin");
+	if (strbuf_read(&buf, fd, 0) < 0)
+		return error_errno(_("error while reading from fd %i"), fd);
 
 	s->should_munmap = 0;
 	s->data = strbuf_detach(&buf, &size);
@@ -76,6 +103,20 @@ static int populate_from_stdin(struct diff_filespec *s)
 	return 0;
 }
 
+static int populate_from_pipe(struct diff_filespec *s, const char *name)
+{
+	int ret;
+	FILE *f;
+
+	f = fopen(name, "r");
+	if (!f)
+		return error_errno(_("cannot open %s"), name);
+
+	ret = populate_from_fd(s, fileno(f));
+	fclose(f);
+	return ret;
+}
+
 static struct diff_filespec *noindex_filespec(const char *name, int mode)
 {
 	struct diff_filespec *s;
@@ -85,7 +126,9 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
 	s = alloc_filespec(name);
 	fill_filespec(s, &null_oid, 0, mode);
 	if (name == file_from_standard_input)
-		populate_from_stdin(s);
+		populate_from_fd(s, 0);
+	else if (ispipe(name))
+		populate_from_pipe(s, name);
 	return s;
 }
 
@@ -218,8 +261,7 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 {
 	unsigned int isdir0, isdir1;
 
-	if (path[0] == file_from_standard_input ||
-	    path[1] == file_from_standard_input)
+	if (ispipe(path[0]) || ispipe(path[1]))
 		return;
 	isdir0 = is_directory(path[0]);
 	isdir1 = is_directory(path[1]);
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 0168946b63..e49f773515 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -144,4 +144,193 @@ test_expect_success 'diff --no-index allows external diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index can diff piped subshells' '
+	echo 1 >non/git/c &&
+	test_expect_code 0 git diff --no-index non/git/b <(cat non/git/c) &&
+	test_expect_code 0 git diff --no-index <(cat non/git/b) non/git/c &&
+	test_expect_code 0 git diff --no-index <(cat non/git/b) <(cat non/git/c) &&
+	test_expect_code 0 cat non/git/b | git diff --no-index - non/git/c &&
+	test_expect_code 0 cat non/git/c | git diff --no-index non/git/b - &&
+	test_expect_code 0 cat non/git/b | git diff --no-index - <(cat non/git/c) &&
+	test_expect_code 0 cat non/git/c | git diff --no-index <(cat non/git/b) -
+'
+
+test_expect_success 'diff --no-index finds diff in piped subshells' '
+	(
+		set -- <(cat /dev/null) <(cat /dev/null)
+		cat <<-EOF >expect
+			diff --git a$1 b$2
+			--- a$1
+			+++ b$2
+			@@ -1 +1 @@
+			-1
+			+2
+		EOF
+	) &&
+	test_expect_code 1 \
+		git diff --no-index <(cat non/git/b) <(sed s/1/2/ non/git/c) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --no-index with stat and numstat' '
+	(
+		set -- <(cat /dev/null) <(cat /dev/null)
+		min=$((${#1} < ${#2} ? ${#1} : ${#2}))
+		for ((i=0; i<min; i++)); do [ "${1:i:1}" = "${2:i:1}" ] || break; done
+		base=${1:0:i-1}
+		cat <<-EOF >expect1
+			 $base{${1#$base} => ${2#$base}} | 2 +-
+			 1 file changed, 1 insertion(+), 1 deletion(-)
+		EOF
+		cat <<-EOF >expect2
+			1	1	$base{${1#$base} => ${2#$base}}
+		EOF
+	) &&
+	test_expect_code 1 \
+		git diff --no-index --stat <(cat non/git/a) <(sed s/1/2/ non/git/b) >actual &&
+	test_cmp expect1 actual &&
+	test_expect_code 1 \
+		git diff --no-index --numstat <(cat non/git/a) <(sed s/1/2/ non/git/b) >actual &&
+	test_cmp expect2 actual
+'
+
+test_expect_success PIPE 'diff --no-index on filesystem pipes' '
+	(
+		cd non/git &&
+		mkdir f g &&
+		mkfifo f/1 g/1 &&
+		test_expect_code 128 git diff --no-index f g &&
+		test_expect_code 128 git diff --no-index ../../a f &&
+		test_expect_code 128 git diff --no-index g ../../a &&
+		test_expect_code 128 git diff --no-index f/1 g/1 &&
+		test_expect_code 128 git diff --no-index f/1 ../../a/1 &&
+		test_expect_code 128 git diff --no-index ../../a/1 g/1
+	)
+'
+
+test_expect_success PIPE 'diff --no-index reads symlinks to named pipes as symlinks' '
+	(
+		cd non/git &&
+		mkdir h i &&
+		ln -s ../f/1 h/1 &&
+		ln -s ../g/1 i/1 &&
+		test_expect_code 1 git diff --no-index h i >actual &&
+		cat <<-EOF >expect &&
+			diff --git a/h/1 b/i/1
+			index d0b5850..d8b9c34 120000
+			--- a/h/1
+			+++ b/i/1
+			@@ -1 +1 @@
+			-../f/1
+			\ No newline at end of file
+			+../g/1
+			\ No newline at end of file
+		EOF
+		test_cmp expect actual &&
+		test_expect_code 1 git diff --no-index ../../a h >actual &&
+		cat <<-EOF >expect &&
+			diff --git a/../../a/1 b/../../a/1
+			deleted file mode 100644
+			index d00491f..0000000
+			--- a/../../a/1
+			+++ /dev/null
+			@@ -1 +0,0 @@
+			-1
+			diff --git a/h/1 b/h/1
+			new file mode 120000
+			index 0000000..d0b5850
+			--- /dev/null
+			+++ b/h/1
+			@@ -0,0 +1 @@
+			+../f/1
+			\ No newline at end of file
+			diff --git a/../../a/2 b/../../a/2
+			deleted file mode 100644
+			index 0cfbf08..0000000
+			--- a/../../a/2
+			+++ /dev/null
+			@@ -1 +0,0 @@
+			-2
+		EOF
+		test_cmp expect actual &&
+		test_expect_code 1 git diff --no-index i ../../a >actual &&
+		cat <<-EOF >expect &&
+			diff --git a/i/1 b/i/1
+			deleted file mode 120000
+			index d8b9c34..0000000
+			--- a/i/1
+			+++ /dev/null
+			@@ -1 +0,0 @@
+			-../g/1
+			\ No newline at end of file
+			diff --git a/../../a/1 b/../../a/1
+			new file mode 100644
+			index 0000000..d00491f
+			--- /dev/null
+			+++ b/../../a/1
+			@@ -0,0 +1 @@
+			+1
+			diff --git a/../../a/2 b/../../a/2
+			new file mode 100644
+			index 0000000..0cfbf08
+			--- /dev/null
+			+++ b/../../a/2
+			@@ -0,0 +1 @@
+			+2
+		EOF
+		test_cmp expect actual &&
+		test_expect_code 1 git diff --no-index h/1 i/1 >actual &&
+		cat <<-EOF >expect &&
+			diff --git a/h/1 b/i/1
+			index d0b5850..d8b9c34 120000
+			--- a/h/1
+			+++ b/i/1
+			@@ -1 +1 @@
+			-../f/1
+			\ No newline at end of file
+			+../g/1
+			\ No newline at end of file
+		EOF
+		test_cmp expect actual &&
+		test_expect_code 1 git diff --no-index h/1 ../../a/1 >actual &&
+		cat <<-EOF >expect &&
+			diff --git a/h/1 b/h/1
+			deleted file mode 120000
+			index d0b5850..0000000
+			--- a/h/1
+			+++ /dev/null
+			@@ -1 +0,0 @@
+			-../f/1
+			\ No newline at end of file
+			diff --git a/../../a/1 b/../../a/1
+			new file mode 100644
+			index 0000000..d00491f
+			--- /dev/null
+			+++ b/../../a/1
+			@@ -0,0 +1 @@
+			+1
+		EOF
+		test_cmp expect actual &&
+		test_expect_code 1 git diff --no-index ../../a/1 i/1 >actual &&
+		cat <<-EOF >expect &&
+			diff --git a/../../a/1 b/../../a/1
+			deleted file mode 100644
+			index d00491f..0000000
+			--- a/../../a/1
+			+++ /dev/null
+			@@ -1 +0,0 @@
+			-1
+			diff --git a/i/1 b/i/1
+			new file mode 120000
+			index 0000000..d8b9c34
+			--- /dev/null
+			+++ b/i/1
+			@@ -0,0 +1 @@
+			+../g/1
+			\ No newline at end of file
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.20.1

