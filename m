From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/10] vcs-svn: eliminate repo_tree structure
Date: Fri, 10 Dec 2010 04:33:54 -0600
Message-ID: <20101210103354.GJ26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR0Iv-0007Un-Jy
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084Ab0LJKeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:34:15 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55336 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075Ab0LJKeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:34:13 -0500
Received: by gyb11 with SMTP id 11so1942827gyb.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/k1s/kFJ+lLsIWVdk1oSCr6H82UsFFIlsTBdZ6HCjak=;
        b=SALEZofeYJqGpbTpU5YSOridS/b6pGX0kyPRCcVq24YBEAsie6N/i7JVsGdvYVNfQS
         GimoEbRY1M25GDik3H4UWKSTZocb2UaVsxCr3qT4U6Urb4Nk7m4wXbjeAoMb+PsMFbAI
         V+/oAHU7SLMt8+T7OeXu8r2QMuRnKAQDOi7GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mf6MrYtvBXyBxZAI0fgAp6U4R8eBFe2Cs/rDU4DOnfWbuA/fwuWbSeRhH4U3lTp51W
         LIJrJ+ctLjxsJlnYjd4DX5dR5rPzDePwnbdWutQzc82X8iyGGcbHT02krZAU4wgMynlz
         NPc6TUjuNOm98kl93mfvfJF2kbUuLLoTeAShc=
Received: by 10.150.212.1 with SMTP id k1mr1130061ybg.257.1291977252698;
        Fri, 10 Dec 2010 02:34:12 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id y21sm1812794yhc.14.2010.12.10.02.34.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:34:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163405>

Rely on fast-import for information about previous revs.

This requires always setting up backward flow of information,
even for v2 dumps.  On the plus side, it simplifies the code
by quite a bit and opens the door to further simplifications.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Sorry for its rough state; just thought
it would be useful to get this out early so other tools can be built
on it.  No doubt it is terribly buggy and ugly.  Reports of both sorts
of problem would be greatly appreciated.

 cache.h               |    2 +
 fast-import.c         |   42 +++++--
 t/t9010-svn-fe.sh     |   55 +++++----
 vcs-svn/fast_export.c |  173 +++++++++++++++------------
 vcs-svn/fast_export.h |   25 +++--
 vcs-svn/repo_tree.c   |  310 +++----------------------------------------------
 vcs-svn/repo_tree.h   |    2 +-
 vcs-svn/svndump.c     |   73 +++++++-----
 8 files changed, 239 insertions(+), 443 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..33e69eb 100644
--- a/cache.h
+++ b/cache.h
@@ -678,6 +678,8 @@ static inline void hashclr(unsigned char *hash)
 #define EMPTY_TREE_SHA1_BIN \
 	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
 	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+#define EMPTY_BLOB_SHA1_HEX \
+	"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
diff --git a/fast-import.c b/fast-import.c
index 670f4f5..e62f34d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2862,12 +2862,20 @@ static struct object_entry *parse_treeish_dataref(const char **r)
 
 static void print_ls(int mode, unsigned char *sha1, char *path)
 {
-	enum object_type type;
 	struct strbuf line = STRBUF_INIT;
-	type = sha1_object_info(sha1, NULL);
+	const char *type;
+
+	/* See show_tree(). */
+	if (S_ISGITLINK(mode))
+		type = commit_type;
+	else if (S_ISDIR(mode))
+		type = tree_type;
+	else
+		type = blob_type;
+
 	/* mode SP type SP object_name TAB path LF */
-	strbuf_addf(&line, "%o %s %s\t%s\n",
-			mode, typename(type), sha1_to_hex(sha1), path);
+	strbuf_addf(&line, "%06o %s %s\t%s\n",
+			mode, type, sha1_to_hex(sha1), path);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
 }
@@ -2898,17 +2906,25 @@ static void parse_ls(struct branch *b)
 	if (*p)
 		die("Garbage after path: %s", command_buf.buf);
 	tree_content_get(root, uq.buf, &leaf);
-	if (!leaf.versions[1].mode)
-		die("Path %s not in branch", uq.buf);
+	if (!leaf.versions[1].mode) {
+		/*
+		 * NEEDSWORK.  Missing path?  Must be an empty directory!
+		 *
+		 * Should find a nicer way to report this --- e.g.
+		 *	die("Path %s not in branch", uq.buf);
+		 */
+		print_ls(S_IFDIR, (unsigned char *) EMPTY_TREE_SHA1_BIN, uq.buf);
+	} else {
+		/*
+		 * A directory in preparation would have a sha1 of zero
+		 * until it is saved.  Save, for simplicity.
+		 */
+		if (S_ISDIR(leaf.versions[1].mode))
+			store_tree(&leaf);
 
-	/*
-	 * A directory in preparation would have a sha1 of zero
-	 * until it is saved.  Save, for simplicity.
-	 */
-	if (S_ISDIR(leaf.versions[1].mode))
-		store_tree(&leaf);
+		print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, uq.buf);
+	}
 
-	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, uq.buf);
 	strbuf_release(&uq);
 	if (!b || root != &b->branch_tree)
 		release_tree_entry(root);
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 022e3e3..34bb9f6 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -53,8 +53,7 @@ test_expect_success 'empty dump' '
 test_expect_success 'v4 dumps not supported' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 4" >v4.dump &&
-	test_must_fail test-svn-fe v4.dump >stream &&
-	test_cmp empty stream
+	test_must_fail test-svn-fe v4.dump
 '
 
 test_expect_failure 'empty revision' '
@@ -301,8 +300,9 @@ test_expect_success 'action: add node without text' '
 	test_must_fail test-svn-fe textless.dump
 '
 
-test_expect_failure 'change file mode but keep old content' '
+test_expect_failure PIPE 'change file mode but keep old content' '
 	reinit_git &&
+	rm -f backflow &&
 	cat >expect <<-\EOF &&
 	OBJID
 	:120000 100644 OBJID OBJID T	greeting
@@ -364,8 +364,9 @@ test_expect_failure 'change file mode but keep old content' '
 
 	PROPS-END
 	EOF
-	test-svn-fe filemode.dump >stream &&
-	git fast-import <stream &&
+	mkfifo backflow &&
+	test-svn-fe filemode.dump 3<backflow |
+	git fast-import --cat-blob-fd=3 3>backflow &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
@@ -378,8 +379,9 @@ test_expect_failure 'change file mode but keep old content' '
 	test_cmp hello actual.target
 '
 
-test_expect_success 'change file mode and reiterate content' '
+test_expect_success PIPE 'change file mode and reiterate content' '
 	reinit_git &&
+	rm -f backflow &&
 	cat >expect <<-\EOF &&
 	OBJID
 	:120000 100644 OBJID OBJID T	greeting
@@ -390,7 +392,7 @@ test_expect_success 'change file mode and reiterate content' '
 	EOF
 	echo "link hello" >expect.blob &&
 	echo hello >hello &&
-	cat >filemode.dump <<-\EOF &&
+	cat >filemode2.dump <<-\EOF &&
 	SVN-fs-dump-format-version: 3
 
 	Revision-number: 1
@@ -445,8 +447,9 @@ test_expect_success 'change file mode and reiterate content' '
 	PROPS-END
 	link hello
 	EOF
-	test-svn-fe filemode.dump >stream &&
-	git fast-import <stream &&
+	mkfifo backflow &&
+	test-svn-fe filemode2.dump 3<backflow |
+	git fast-import --cat-blob-fd=3 3>backflow &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
@@ -522,12 +525,13 @@ test_expect_success PIPE 'deltas supported' '
 		cat delta
 	} >delta.dump &&
 	mkfifo backflow &&
-	test_must_fail test-svn-fe delta.dump 3<backflow |
+	test-svn-fe delta.dump 3<backflow |
 	git fast-import --cat-blob-fd=3 3>backflow
 '
 
-test_expect_success 'property deltas supported' '
+test_expect_success PIPE 'property deltas supported' '
 	reinit_git &&
+	rm -f backflow &&
 	cat >expect <<-\EOF &&
 	OBJID
 	:100755 100644 OBJID OBJID M	script.sh
@@ -582,8 +586,9 @@ test_expect_success 'property deltas supported' '
 		PROPS-END
 		EOF
 	} >propdelta.dump &&
-	test-svn-fe propdelta.dump >stream &&
-	git fast-import <stream &&
+	mkfifo backflow &&
+	test-svn-fe propdelta.dump 3<backflow |
+	git fast-import --cat-blob-fd=3 3>backflow &&
 	{
 		git rev-list HEAD |
 		git diff-tree --stdin |
@@ -592,8 +597,9 @@ test_expect_success 'property deltas supported' '
 	test_cmp expect actual
 '
 
-test_expect_success 'properties on /' '
+test_expect_success PIPE 'properties on /' '
 	reinit_git &&
+	rm -f backflow &&
 	cat <<-\EOF >expect &&
 	OBJID
 	OBJID
@@ -637,8 +643,9 @@ test_expect_success 'properties on /' '
 
 	PROPS-END
 	EOF
-	test-svn-fe changeroot.dump >stream &&
-	git fast-import <stream &&
+	mkfifo backflow &&
+	test-svn-fe changeroot.dump 3<backflow |
+	git fast-import --cat-blob-fd=3 3>backflow &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --always --stdin |
@@ -647,8 +654,9 @@ test_expect_success 'properties on /' '
 	test_cmp expect actual
 '
 
-test_expect_success 'deltas for typechange' '
+test_expect_success PIPE 'deltas for typechange' '
 	reinit_git &&
+	rm -f backflow &&
 	cat >expect <<-\EOF &&
 	OBJID
 	:120000 100644 OBJID OBJID T	test-file
@@ -723,8 +731,9 @@ test_expect_success 'deltas for typechange' '
 	PROPS-END
 	link testing 321
 	EOF
-	test-svn-fe deleteprop.dump >stream &&
-	git fast-import <stream &&
+	mkfifo backflow &&
+	test-svn-fe deleteprop.dump 3<backflow |
+	git fast-import --cat-blob-fd=3 3>backflow &&
 	{
 		git rev-list HEAD |
 		git diff-tree --root --stdin |
@@ -841,15 +850,17 @@ test_expect_success PIPE 'deltas need not consume the whole preimage' '
 	test_cmp expect.3 actual.3
 '
 
-test_expect_success 't9135/svn.dump' '
+test_expect_success PIPE 't9135/svn.dump' '
+	rm -f backflow &&
 	svnadmin create simple-svn &&
 	svnadmin load simple-svn <"$TEST_DIRECTORY/t9135/svn.dump" &&
 	svn_cmd export "file://$PWD/simple-svn" simple-svnco &&
 	git init simple-git &&
-	test-svn-fe "$TEST_DIRECTORY/t9135/svn.dump" >simple.fe &&
+	mkfifo backflow &&
+	test-svn-fe "$TEST_DIRECTORY/t9135/svn.dump" 3<backflow |
 	(
 		cd simple-git &&
-		git fast-import <../simple.fe
+		git fast-import --cat-blob-fd=3 3>../backflow
 	) &&
 	(
 		cd simple-svnco &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 6a4a689..96f6023 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -37,17 +37,17 @@ void fast_export_delete(uint32_t depth, uint32_t *path)
 	putchar('\n');
 }
 
-void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
-			uint32_t mark)
+void fast_export_modify(uint32_t depth, const uint32_t *path, uint32_t mode,
+			const char *dataref)
 {
 	/* Mode must be 100644, 100755, 120000, or 160000. */
-	printf("M %06"PRIo32" :%"PRIu32" ", mode, mark);
+	printf("M %06"PRIo32" %s ", mode, dataref);
 	pool_print_seq(depth, path, '/', stdout);
 	putchar('\n');
 }
 
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
-void fast_export_commit(uint32_t revision, uint32_t author, char *log,
+void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url,
 			unsigned long timestamp)
 {
@@ -74,10 +74,20 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 			printf("from refs/heads/master^0\n");
 		first_commit_done = 1;
 	}
-	repo_diff(revision - 1, revision);
-	fputc('\n', stdout);
+}
 
-	printf("progress Imported commit %"PRIu32".\n\n", revision);
+void fast_export_end_commit(uint32_t revision)
+{
+	printf("\nprogress Imported commit %"PRIu32".\n\n", revision);
+}
+
+static struct strbuf response_line = STRBUF_INIT;
+static const char *get_response_line(void)
+{
+	strbuf_reset(&response_line);
+	if (fd_read_line(&response_line, REPORT_FILENO))
+		return NULL;
+	return response_line.buf;
 }
 
 static void ls_from_rev(uint32_t rev, const uint32_t *path)
@@ -89,6 +99,56 @@ static void ls_from_rev(uint32_t rev, const uint32_t *path)
 	fflush(stdout);
 }
 
+static void parse_ls_response(const char *response, uint32_t *mode,
+					struct strbuf *dataref)
+{
+	const char *tab;
+	const char *response_end;
+
+	if (!response)
+		die("cannot read ls response");
+	response_end = response + strlen(response);
+
+	/* Mode. */
+	if (response_end - response < strlen("100644") ||
+	    response[strlen("100644")] != ' ')
+		die("invalid ls response: missing mode: %s", response);
+	*mode = 0;
+	for (; *response != ' '; response++) {
+		*mode *= 8;
+		*mode += (*response - '0');
+	}
+
+	/* ' blob ' or ' tree ' */
+	if (response_end - response < strlen(" blob "))
+		die("invalid ls response: missing type: %s", response);
+	response += strlen(" blob ");
+
+	/* Dataref. */
+	tab = memchr(response, '\t', response_end - response);
+	if (!tab)
+		die("invalid ls response: missing tab: %s", response);
+	strbuf_add(dataref, response, tab - response);
+}
+
+void fast_export_ls_rev(uint32_t rev, const uint32_t *path,
+				uint32_t *mode, struct strbuf *dataref)
+{
+	ls_from_rev(rev, path);
+	parse_ls_response(get_response_line(), mode, dataref);
+}
+
+/* Read directory entry from the active commit. */
+void fast_export_ls(const uint32_t *path,
+				uint32_t *mode, struct strbuf *dataref)
+{
+	printf("ls \"");
+	pool_print_seq(REPO_MAX_PATH_DEPTH, path, '/', stdout);
+	printf("\"\n");
+	fflush(stdout);
+	parse_ls_response(get_response_line(), mode, dataref);
+}
+
 static int ends_with(const char *s, size_t len, const char *suffix)
 {
 	const size_t suffixlen = strlen(suffix);
@@ -97,27 +157,15 @@ static int ends_with(const char *s, size_t len, const char *suffix)
 	return !memcmp(s + len - suffixlen, suffix, suffixlen);
 }
 
-static int parse_ls_response_line(const char *line, struct strbuf *objnam)
-{
-	const char *end = line + strlen(line);
-	const char *name, *tab;
-
-	if (end - line < strlen("100644 blob "))
-		return error("ls response too short: %s", line);
-	name = line + strlen("100644 blob ");
-	tab = memchr(name, '\t', end - name);
-	if (!tab)
-		return error("ls response does not contain tab: %s", line);
-	strbuf_add(objnam, name, tab - name);
-	return 0;
-}
-
 static int parse_cat_response_line(const char *header, off_t *len)
 {
-	size_t headerlen = strlen(header);
+	size_t headerlen;
 	const char *type;
 	const char *end;
 
+	if (!header)
+		return error("missing cat-blob response");
+	headerlen = strlen(header);
 	if (ends_with(header, headerlen, " missing"))
 		return error("cat-blob reports missing blob: %s", header);
 	type = memmem(header, headerlen, " blob ", strlen(" blob "));
@@ -131,49 +179,22 @@ static int parse_cat_response_line(const char *header, off_t *len)
 	return 0;
 }
 
-static struct strbuf response_line = STRBUF_INIT;
-static const char *get_response_line(void)
+static off_t cat_dataref(const char *dataref)
 {
-	strbuf_reset(&response_line);
-	if (fd_read_line(&response_line, REPORT_FILENO))
-		return NULL;
-	return response_line.buf;
-}
-
-static off_t cat_mark(uint32_t mark)
-{
-	const char *response;
 	off_t length = length;
-
-	printf("cat-blob :%"PRIu32"\n", mark);
-	fflush(stdout);
-	response = get_response_line();
-	if (parse_cat_response_line(response, &length))
-		die("invalid cat-blob response: %s", response);
-	return length;
-}
-
-static off_t cat_from_rev(uint32_t rev, const uint32_t *path)
-{
 	const char *response;
-	off_t length = length;
-	struct strbuf blob_name = STRBUF_INIT;
-
-	ls_from_rev(rev, path);
-	response = get_response_line();
-	if (parse_ls_response_line(response, &blob_name))
-		die("invalid ls response: %s", response);
 
-	printf("cat-blob %s\n", blob_name.buf);
+	if (!dataref)
+		die("BUG: null data reference");
+	printf("cat-blob %s\n", dataref);
 	fflush(stdout);
 	response = get_response_line();
 	if (parse_cat_response_line(response, &length))
-		die("invalid cat-blob response: %s", response);
-	strbuf_release(&blob_name);
+		die("invalid cat-blob response");
 	return length;
 }
 
-static long delta_apply(uint32_t mark, off_t len, struct line_buffer *input,
+static long delta_apply(off_t len, struct line_buffer *input,
 			off_t preimage_len, uint32_t old_mode)
 {
 	long ret;
@@ -203,52 +224,50 @@ static long delta_apply(uint32_t mark, off_t len, struct line_buffer *input,
 	return ret;
 }
 
-static void record_postimage(uint32_t mark, uint32_t mode,
-				long postimage_len)
+static void record_postimage(uint32_t mode, long postimage_len)
 {
 	if (mode == REPO_MODE_LNK) {
 		buffer_skip_bytes(&postimage, strlen("link "));
 		postimage_len -= strlen("link ");
 	}
-	printf("blob\nmark :%"PRIu32"\ndata %ld\n", mark, postimage_len);
+	printf("data %ld\n", postimage_len);
 	buffer_copy_bytes(&postimage, postimage_len);
 	fputc('\n', stdout);
 }
 
-void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_buffer *input)
+void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
 		buffer_skip_bytes(input, 5);
 		len -= 5;
 	}
-	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
+	printf("data %"PRIu32"\n", len);
 	buffer_copy_bytes(input, len);
 	fputc('\n', stdout);
 }
 
-void fast_export_blob_delta(uint32_t mode, uint32_t mark,
-				uint32_t old_mode, uint32_t old_mark,
-				uint32_t len, struct line_buffer *input)
+void fast_export_empty_blob(void)
 {
-	long postimage_len;
-	if (len > maximum_signed_value_of_type(off_t))
-		die("enormous delta");
-	postimage_len = delta_apply(mark, (off_t) len, input,
-						old_mark ? cat_mark(old_mark) : -1,
-						old_mode);
-	record_postimage(mark, mode, postimage_len);
+	printf("blob\ndata 0\n\n");
 }
 
-void fast_export_blob_delta_rev(uint32_t mode, uint32_t mark, uint32_t old_mode,
-				uint32_t old_rev, const uint32_t *old_path,
+void fast_export_delta(const uint32_t *path, uint32_t mode, uint32_t old_mode,
+				const char *dataref,
 				uint32_t len, struct line_buffer *input)
 {
+	off_t preimage_len;
 	long postimage_len;
 	if (len > maximum_signed_value_of_type(off_t))
 		die("enormous delta");
-	postimage_len = delta_apply(mark, (off_t) len, input,
-					cat_from_rev(old_rev, old_path),
-					old_mode);
-	record_postimage(mark, mode, postimage_len);
+	preimage_len = cat_dataref(dataref);
+
+	/*
+	 * NEEDSWORK: Will deadlock with very long paths.
+	 */
+	fast_export_modify(REPO_MAX_PATH_DEPTH, path, mode, "inline");
+
+	postimage_len = delta_apply((off_t) len, input,
+						preimage_len, old_mode);
+	record_postimage(mode, postimage_len);
 }
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 487d3d4..8415d2c 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -3,18 +3,23 @@
 
 #include "line_buffer.h"
 
+/* Output routines */
 void fast_export_delete(uint32_t depth, uint32_t *path);
-void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
-			uint32_t mark);
-void fast_export_commit(uint32_t revision, uint32_t author, char *log,
+void fast_export_modify(uint32_t depth, const uint32_t *path, uint32_t mode,
+			const char *dataref);
+void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url, unsigned long timestamp);
-void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
-		      struct line_buffer *input);
-void fast_export_blob_delta(uint32_t mode, uint32_t mark,
-			uint32_t old_mode, uint32_t old_mark,
-			uint32_t len, struct line_buffer *input);
-void fast_export_blob_delta_rev(uint32_t mode, uint32_t mark, uint32_t old_mode,
-			uint32_t old_rev, const uint32_t *old_path,
+void fast_export_end_commit(uint32_t revision);
+void fast_export_empty_blob(void);
+void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
+void fast_export_delta(const uint32_t *path, uint32_t mode, uint32_t old_mode,
+			const char *dataref,
 			uint32_t len, struct line_buffer *input);
 
+/* Input routines */
+void fast_export_ls_rev(uint32_t rev, const uint32_t *path,
+			uint32_t *mode_out, struct strbuf *dataref_out);
+void fast_export_ls(const uint32_t *path,
+			uint32_t *mode_out, struct strbuf *dataref_out);
+
 #endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 4d98185..1283089 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -4,321 +4,49 @@
  */
 
 #include "git-compat-util.h"
-
-#include "string_pool.h"
+#include "strbuf.h"
 #include "repo_tree.h"
-#include "obj_pool.h"
 #include "fast_export.h"
 
-#include "trp.h"
-
-struct repo_dirent {
-	uint32_t name_offset;
-	struct trp_node children;
-	uint32_t mode;
-	uint32_t content_offset;
-};
-
-struct repo_dir {
-	struct trp_root entries;
-};
-
-struct repo_commit {
-	uint32_t root_dir_offset;
-};
-
-/* Memory pools for commit, dir and dirent */
-obj_pool_gen(commit, struct repo_commit, 4096)
-obj_pool_gen(dir, struct repo_dir, 4096)
-obj_pool_gen(dent, struct repo_dirent, 4096)
-
-static uint32_t active_commit;
-static uint32_t mark;
-
-static int repo_dirent_name_cmp(const void *a, const void *b);
-
-/* Treap for directory entries */
-trp_gen(static, dent_, struct repo_dirent, children, dent, repo_dirent_name_cmp);
-
-uint32_t next_blob_mark(void)
-{
-	return mark++;
-}
-
-static struct repo_dir *repo_commit_root_dir(struct repo_commit *commit)
-{
-	return dir_pointer(commit->root_dir_offset);
-}
-
-static struct repo_dirent *repo_first_dirent(struct repo_dir *dir)
-{
-	return dent_first(&dir->entries);
-}
-
-static int repo_dirent_name_cmp(const void *a, const void *b)
-{
-	const struct repo_dirent *dent1 = a, *dent2 = b;
-	uint32_t a_offset = dent1->name_offset;
-	uint32_t b_offset = dent2->name_offset;
-	return (a_offset > b_offset) - (a_offset < b_offset);
-}
-
-static int repo_dirent_is_dir(struct repo_dirent *dent)
-{
-	return dent != NULL && dent->mode == REPO_MODE_DIR;
-}
-
-static struct repo_dir *repo_dir_from_dirent(struct repo_dirent *dent)
-{
-	if (!repo_dirent_is_dir(dent))
-		return NULL;
-	return dir_pointer(dent->content_offset);
-}
-
-static struct repo_dir *repo_clone_dir(struct repo_dir *orig_dir)
-{
-	uint32_t orig_o, new_o;
-	orig_o = dir_offset(orig_dir);
-	if (orig_o >= dir_pool.committed)
-		return orig_dir;
-	new_o = dir_alloc(1);
-	orig_dir = dir_pointer(orig_o);
-	*dir_pointer(new_o) = *orig_dir;
-	return dir_pointer(new_o);
-}
-
-static struct repo_dirent *repo_read_dirent(uint32_t revision, uint32_t *path)
+static struct strbuf dataref_buf = STRBUF_INIT;
+const char *repo_read_path(uint32_t *path)
 {
-	uint32_t name = 0;
-	struct repo_dirent *key = dent_pointer(dent_alloc(1));
-	struct repo_dir *dir = NULL;
-	struct repo_dirent *dent = NULL;
-	dir = repo_commit_root_dir(commit_pointer(revision));
-	while (~(name = *path++)) {
-		key->name_offset = name;
-		dent = dent_search(&dir->entries, key);
-		if (dent == NULL || !repo_dirent_is_dir(dent))
-			break;
-		dir = repo_dir_from_dirent(dent);
-	}
-	dent_free(1);
-	return dent;
-}
+	uint32_t unused;
 
-static void repo_write_dirent(uint32_t *path, uint32_t mode,
-			      uint32_t content_offset, uint32_t del)
-{
-	uint32_t name, revision, dir_o = ~0, parent_dir_o = ~0;
-	struct repo_dir *dir;
-	struct repo_dirent *key;
-	struct repo_dirent *dent = NULL;
-	revision = active_commit;
-	dir = repo_commit_root_dir(commit_pointer(revision));
-	dir = repo_clone_dir(dir);
-	commit_pointer(revision)->root_dir_offset = dir_offset(dir);
-	while (~(name = *path++)) {
-		parent_dir_o = dir_offset(dir);
-
-		key = dent_pointer(dent_alloc(1));
-		key->name_offset = name;
-
-		dent = dent_search(&dir->entries, key);
-		if (dent == NULL)
-			dent = key;
-		else
-			dent_free(1);
-
-		if (dent == key) {
-			dent->mode = REPO_MODE_DIR;
-			dent->content_offset = 0;
-			dent_insert(&dir->entries, dent);
-		}
-
-		if (dent_offset(dent) < dent_pool.committed) {
-			dir_o = repo_dirent_is_dir(dent) ?
-					dent->content_offset : ~0;
-			dent_remove(&dir->entries, dent);
-			dent = dent_pointer(dent_alloc(1));
-			dent->name_offset = name;
-			dent->mode = REPO_MODE_DIR;
-			dent->content_offset = dir_o;
-			dent_insert(&dir->entries, dent);
-		}
-
-		dir = repo_dir_from_dirent(dent);
-		dir = repo_clone_dir(dir);
-		dent->content_offset = dir_offset(dir);
-	}
-	if (dent == NULL)
-		return;
-	dent->mode = mode;
-	dent->content_offset = content_offset;
-	if (del && ~parent_dir_o)
-		dent_remove(&dir_pointer(parent_dir_o)->entries, dent);
-}
-
-uint32_t repo_read_path(uint32_t *path)
-{
-	uint32_t content_offset = 0;
-	struct repo_dirent *dent = repo_read_dirent(active_commit, path);
-	if (dent != NULL)
-		content_offset = dent->content_offset;
-	return content_offset;
+	strbuf_reset(&dataref_buf);
+	fast_export_ls(path, &unused, &dataref_buf);
+	return dataref_buf.buf;
 }
 
 uint32_t repo_read_mode(const uint32_t *path)
 {
-	struct repo_dirent *dent = repo_read_dirent(active_commit, path);
-	if (dent == NULL)
-		die("invalid dump: path to be modified is missing");
-	return dent->mode;
+	uint32_t result;
+	struct strbuf unused = STRBUF_INIT;
+
+	fast_export_ls(path, &result, &unused);
+	strbuf_release(&unused);
+	return result;
 }
 
 void repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
 {
-	uint32_t mode = 0, content_offset = 0;
-	struct repo_dirent *src_dent;
-	src_dent = repo_read_dirent(revision, src);
-	if (src_dent != NULL) {
-		mode = src_dent->mode;
-		content_offset = src_dent->content_offset;
-		repo_write_dirent(dst, mode, content_offset, 0);
-	}
-}
+	uint32_t mode;
+	struct strbuf data = STRBUF_INIT;
 
-void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
-{
-	repo_write_dirent(path, mode, blob_mark, 0);
+	fast_export_ls_rev(revision, src, &mode, &data);
+	fast_export_modify(REPO_MAX_PATH_DEPTH, dst, mode, data.buf);
+	strbuf_release(&data);
 }
 
 void repo_delete(uint32_t *path)
 {
-	repo_write_dirent(path, 0, 0, 1);
-}
-
-static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo_dir *dir);
-
-static void repo_git_add(uint32_t depth, uint32_t *path, struct repo_dirent *dent)
-{
-	if (repo_dirent_is_dir(dent))
-		repo_git_add_r(depth, path, repo_dir_from_dirent(dent));
-	else
-		fast_export_modify(depth, path,
-				   dent->mode, dent->content_offset);
-}
-
-static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo_dir *dir)
-{
-	struct repo_dirent *de = repo_first_dirent(dir);
-	while (de) {
-		path[depth] = de->name_offset;
-		repo_git_add(depth + 1, path, de);
-		de = dent_next(&dir->entries, de);
-	}
-}
-
-static void repo_diff_r(uint32_t depth, uint32_t *path, struct repo_dir *dir1,
-			struct repo_dir *dir2)
-{
-	struct repo_dirent *de1, *de2;
-	de1 = repo_first_dirent(dir1);
-	de2 = repo_first_dirent(dir2);
-
-	while (de1 && de2) {
-		if (de1->name_offset < de2->name_offset) {
-			path[depth] = de1->name_offset;
-			fast_export_delete(depth + 1, path);
-			de1 = dent_next(&dir1->entries, de1);
-			continue;
-		}
-		if (de1->name_offset > de2->name_offset) {
-			path[depth] = de2->name_offset;
-			repo_git_add(depth + 1, path, de2);
-			de2 = dent_next(&dir2->entries, de2);
-			continue;
-		}
-		path[depth] = de1->name_offset;
-
-		if (de1->mode == de2->mode &&
-		    de1->content_offset == de2->content_offset) {
-			; /* No change. */
-		} else if (repo_dirent_is_dir(de1) && repo_dirent_is_dir(de2)) {
-			repo_diff_r(depth + 1, path,
-				    repo_dir_from_dirent(de1),
-				    repo_dir_from_dirent(de2));
-		} else if (!repo_dirent_is_dir(de1) && !repo_dirent_is_dir(de2)) {
-			repo_git_add(depth + 1, path, de2);
-		} else {
-			fast_export_delete(depth + 1, path);
-			repo_git_add(depth + 1, path, de2);
-		}
-		de1 = dent_next(&dir1->entries, de1);
-		de2 = dent_next(&dir2->entries, de2);
-	}
-	while (de1) {
-		path[depth] = de1->name_offset;
-		fast_export_delete(depth + 1, path);
-		de1 = dent_next(&dir1->entries, de1);
-	}
-	while (de2) {
-		path[depth] = de2->name_offset;
-		repo_git_add(depth + 1, path, de2);
-		de2 = dent_next(&dir2->entries, de2);
-	}
-}
-
-static uint32_t path_stack[REPO_MAX_PATH_DEPTH];
-
-void repo_diff(uint32_t r1, uint32_t r2)
-{
-	repo_diff_r(0,
-		    path_stack,
-		    repo_commit_root_dir(commit_pointer(r1)),
-		    repo_commit_root_dir(commit_pointer(r2)));
-}
-
-void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
-		 uint32_t url, unsigned long timestamp)
-{
-	fast_export_commit(revision, author, log, uuid, url, timestamp);
-	dent_commit();
-	dir_commit();
-	active_commit = commit_alloc(1);
-	commit_pointer(active_commit)->root_dir_offset =
-		commit_pointer(active_commit - 1)->root_dir_offset;
-}
-
-static void mark_init(void)
-{
-	uint32_t i;
-	mark = 1024 * 1024 * 1024;
-	for (i = 0; i < dent_pool.size; i++)
-		if (!repo_dirent_is_dir(dent_pointer(i)) &&
-		    dent_pointer(i)->content_offset > mark)
-			mark = dent_pointer(i)->content_offset;
-	mark++;
+	fast_export_delete(REPO_MAX_PATH_DEPTH, path);
 }
 
 void repo_init(void)
 {
-	mark_init();
-	if (commit_pool.size == 0) {
-		/* Create empty tree for commit 0. */
-		commit_alloc(1);
-		commit_pointer(0)->root_dir_offset = dir_alloc(1);
-		dir_pointer(0)->entries.trp_root = ~0;
-		dir_commit();
-	}
-	/* Preallocate next commit, ready for changes. */
-	active_commit = commit_alloc(1);
-	commit_pointer(active_commit)->root_dir_offset =
-		commit_pointer(active_commit - 1)->root_dir_offset;
 }
 
 void repo_reset(void)
 {
-	pool_reset();
-	commit_reset();
-	dir_reset();
-	dent_reset();
 }
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 0499a19..559f99f 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -14,7 +14,7 @@
 uint32_t next_blob_mark(void);
 void repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
-uint32_t repo_read_path(uint32_t *path);
+const char *repo_read_path(uint32_t *path);
 uint32_t repo_read_mode(const uint32_t *path);
 void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 31c6056..68a8435 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -20,9 +20,11 @@
 #define NODEACT_CHANGE 1
 #define NODEACT_UNKNOWN 0
 
-#define DUMP_CTX 0
-#define REV_CTX  1
-#define NODE_CTX 2
+/* States: */
+#define DUMP_CTX 0	/* dump metadata */
+#define REV_CTX  1	/* revision metadata */
+#define NODE_CTX 2	/* node metadata */
+#define INTERNODE_CTX 3	/* between nodes */
 
 #define LENGTH_UNKNOWN (~0)
 #define DATE_RFC2822_LEN 31
@@ -198,13 +200,12 @@ static void read_props(void)
 
 static void handle_node(void)
 {
-	uint32_t mark = 0, old_mode, old_mark;
+	uint32_t old_mode;
+	const char *old_data;
 	const uint32_t type = node_ctx.type;
 	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
 	const int have_text = node_ctx.textLength != LENGTH_UNKNOWN;
 
-	if (have_text)
-		mark = next_blob_mark();
 	if (node_ctx.action == NODEACT_DELETE) {
 		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
@@ -224,18 +225,15 @@ static void handle_node(void)
 		die("invalid dump: directories cannot have text attached");
 
 	/*
-	 * Find old content (old_mark) and decide on the new content (mark)
-	 * and mode (node_ctx.type).
+	 * Find old content (old_data) and decide on the new mode.
 	 */
 	if (node_ctx.action == NODEACT_CHANGE && !~*node_ctx.dst) {
 		if (type != REPO_MODE_DIR)
 			die("invalid dump: root of tree is not a regular file");
-		old_mark = 0;
+		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_mark = repo_read_path(node_ctx.dst);
-		if (!have_text)
-			mark = old_mark;
+		old_data = repo_read_path(node_ctx.dst);
 		mode = repo_read_mode(node_ctx.dst);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
@@ -243,9 +241,12 @@ static void handle_node(void)
 			die("invalid dump: cannot modify a file into a directory");
 		node_ctx.type = mode;
 	} else if (node_ctx.action == NODEACT_ADD) {
-		if (!have_text && type != REPO_MODE_DIR)
+		if (type == REPO_MODE_DIR)
+			old_data = NULL;
+		else if (have_text)
+			old_data = EMPTY_BLOB_SHA1_HEX;
+		else
 			die("invalid dump: adds node without text");
-		old_mark = 0;
 	} else {
 		die("invalid dump: Node-path block lacks Node-action");
 	}
@@ -264,28 +265,35 @@ static void handle_node(void)
 	/*
 	 * Save the result.
 	 */
-	repo_add(node_ctx.dst, node_ctx.type, mark);
-	if (!have_text)
+	if (type == REPO_MODE_DIR)	/* directories are not tracked. */
 		return;
+	if (!have_text) {
+		fast_export_modify(REPO_MAX_PATH_DEPTH, node_ctx.dst, node_ctx.type,
+					old_data);
+		return;
+	}
 	if (!node_ctx.text_delta) {
-		fast_export_blob(node_ctx.type, mark, node_ctx.textLength, &input);
+		fast_export_modify(REPO_MAX_PATH_DEPTH, node_ctx.dst, node_ctx.type,
+					"inline");
+		fast_export_data(node_ctx.type, node_ctx.textLength, &input);
 		return;
 	}
-	if (node_ctx.srcRev) {
-		fast_export_blob_delta_rev(node_ctx.type, mark, old_mode,
-					node_ctx.srcRev, node_ctx.src,
+	fast_export_delta(node_ctx.dst, node_ctx.type, old_mode, old_data,
 					node_ctx.textLength, &input);
+}
+
+static void begin_revision(void)
+{
+	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
-	}
-	fast_export_blob_delta(node_ctx.type, mark, old_mode, old_mark,
-				node_ctx.textLength, &input);
+	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
+		dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
 }
 
-static void handle_revision(void)
+static void end_revision(void)
 {
 	if (rev_ctx.revision)
-		repo_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
-			dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
+		fast_export_end_commit(rev_ctx.revision);
 }
 
 void svndump_read(const char *url)
@@ -315,13 +323,17 @@ void svndump_read(const char *url)
 		} else if (key == keys.revision_number) {
 			if (active_ctx == NODE_CTX)
 				handle_node();
+			if (active_ctx == REV_CTX)
+				begin_revision();
 			if (active_ctx != DUMP_CTX)
-				handle_revision();
+				end_revision();
 			active_ctx = REV_CTX;
 			reset_rev_ctx(atoi(val));
 		} else if (key == keys.node_path) {
 			if (active_ctx == NODE_CTX)
 				handle_node();
+			if (active_ctx == REV_CTX)
+				begin_revision();
 			active_ctx = NODE_CTX;
 			reset_node_ctx(val);
 		} else if (key == keys.node_kind) {
@@ -363,7 +375,7 @@ void svndump_read(const char *url)
 				read_props();
 			} else if (active_ctx == NODE_CTX) {
 				handle_node();
-				active_ctx = REV_CTX;
+				active_ctx = INTERNODE_CTX;
 			} else {
 				fprintf(stderr, "Unexpected content length header: %"PRIu32"\n", len);
 				buffer_skip_bytes(&input, len);
@@ -372,8 +384,10 @@ void svndump_read(const char *url)
 	}
 	if (active_ctx == NODE_CTX)
 		handle_node();
+	if (active_ctx == REV_CTX)
+		begin_revision();
 	if (active_ctx != DUMP_CTX)
-		handle_revision();
+		end_revision();
 }
 
 int svndump_init(const char *filename)
@@ -385,6 +399,7 @@ int svndump_init(const char *filename)
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	init_keys();
+	fast_export_empty_blob();
 	return 0;
 }
 
-- 
1.7.2.4
