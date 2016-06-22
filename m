Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F9A20189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbcFVUWH (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:22:07 -0400
Received: from kitenet.net ([66.228.36.95]:57452 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbcFVUWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:22:05 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=MtcVNOoO;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466626899; bh=wKDSdYH+L8BZJYlNVLLJTPq00PbdoUqZJV22XxsfnrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MtcVNOoOWobzX++RCCUePIb+j5hIfv8HzYiZMOCqrgCrAt/duxDFNXKvejL88yQ75
	 oTtIenGuBWuSxVute565tyHG1nifsQqHO2f3/oLlLQ3Xk4ixuvrT55TnlpjozVQeyX
	 yOARKQ5Wyw0ztlKwV/I5in5DxvP03JgKtlwys85E=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v3 2/8] add smudgeToFile and cleanFromFile filter configs
Date:	Wed, 22 Jun 2016 16:21:27 -0400
Message-Id: <20160622202133.23565-3-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.8.gf959b2a
In-Reply-To: <20160622202133.23565-1-joeyh@joeyh.name>
References: <20160622202133.23565-1-joeyh@joeyh.name>
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This adds new smudgeToFile and cleanFromFile filter commands,
which are similar to smudge and clean but allow direct access to files on
disk.

This interface can be much more efficient when operating on large files,
because the whole file content does not need to be streamed through the
filter. It even allows for things like cleanFromFile commands that avoid
reading the whole content of the file, and for smudgeToFile commands that
populate a work tree file using an efficient Copy On Write operation.

The new filter commands will not be used for all filtering. They are
efficient to use when git add is adding a file, or when the work tree is
being updated, but not a good fit when git is internally filtering blob
objects in memory for eg, a diff.

So, a user who wants to use smudgeToFile should also provide a smudge
command to be used in cases where smudgeToFile is not used. And ditto
with cleanFromFile and clean. To avoid foot-shooting configurations, the
new commands are not used unless the old commands are also configured.

That also ensures that a filter driver configuration that includes these
new commands will work, although less efficiently, when used with an older
version of git that does not support them.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 Documentation/config.txt        |  18 ++++++-
 Documentation/gitattributes.txt |  37 ++++++++++++++
 convert.c                       | 108 ++++++++++++++++++++++++++++++++++------
 convert.h                       |  10 ++++
 4 files changed, 157 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e1b2e4..c300efe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1299,15 +1299,29 @@ format.useAutoBase::
 	format-patch by default.
 
 filter.<driver>.clean::
-	The command which is used to convert the content of a worktree
+	The command which is used as a filter to convert the content of a worktree
 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
 	details.
 
 filter.<driver>.smudge::
-	The command which is used to convert the content of a blob
+	The command which is used as a filter to convert the content of a blob
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
 
+filter.<driver>.cleanFromFile::
+	Similar to filter.<driver>.clean but the specified command
+	directly accesses a worktree file on disk, rather than
+	receiving the file content from standard input.
+	Only used when filter.<driver>.clean is also configured.
+	See linkgit:gitattributes[5] for details.
+
+filter.<driver>.smudgeToFile::
+	Similar to filter.<driver>.smudge but the specified command
+	writes the content of a blob directly to a worktree file,
+	rather than to standard output.
+	Only used when filter.<driver>.smudge is also configured.
+	See linkgit:gitattributes[5] for details.
+
 fsck.<msg-id>::
 	Allows overriding the message type (error, warn or ignore) of a
 	specific message ID such as `missingEmail`.
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 145dd10..5ae0783 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -380,6 +380,43 @@ not exist, or may have different contents. So, smudge and clean commands
 should not try to access the file on disk, but only act as filters on the
 content provided to them on standard input.
 
+There are two extra commands "cleanFromFile" and "smudgeToFile", which
+can optionally be set in a filter driver. These are similar to the "clean"
+and "smudge" commands, but avoid needing to pipe the contents of files
+through the filters, and instead read/write files in the filesystem.
+This can be more efficient when using filters with large files that are not
+directly stored in the repository.
+
+Both "cleanFromFile" and "smudgeToFile" are provided a path as an
+added parameter after the configured command line.
+
+The "cleanFromFile" command is provided the path to the file that
+it should clean. Like the "clean" command, it should output the cleaned
+version to standard output.
+
+The "smudgeToFile" command is provided a path to the file that it
+should write to. (This file will already exist, as an empty file that can
+be written to or replaced.) Like the "smudge" command, "smudgeToFile"
+is fed the blob object from its standard input.
+
+Some git operations that need to apply filters cannot use "cleanFromFile"
+and "smudgeToFile", since the files are not present to disk. So, to avoid
+inconsistent behavior, "cleanFromFile" will only be used if "clean" is
+also configured, and "smudgeToFile" will only be used if "smudge" is also
+configured.
+
+An example large file storage filter driver using cleanFromFile and
+smudgeToFile follows:
+
+------------------------
+[filter "bigfiles"]
+	clean = store-bigfile --from-stdin
+	cleanFromFile = store-bigfile --from-file
+	smudge = retrieve-bigfile --to-stdout
+	smudgeToFile = retrieve-bigfile --to-file
+	required
+------------------------
+
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/convert.c b/convert.c
index b1614bf..bf63ba0 100644
--- a/convert.c
+++ b/convert.c
@@ -360,7 +360,8 @@ struct filter_params {
 	unsigned long size;
 	int fd;
 	const char *cmd;
-	const char *path;
+	const char *path; /* Path within the git repository */
+	const char *fspath; /* Path to file on disk */
 };
 
 static int filter_buffer_or_fd(int in, int out, void *data)
@@ -389,6 +390,15 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
 	strbuf_release(&path);
 
+	/* append fspath to the command if it's set, separated with a space */
+	if (params->fspath) {
+		struct strbuf fspath = STRBUF_INIT;
+		sq_quote_buf(&fspath, params->fspath);
+		strbuf_addstr(&cmd, " ");
+		strbuf_addbuf(&cmd, &fspath);
+		strbuf_release(&fspath);
+	}
+
 	argv[0] = cmd.buf;
 
 	child_process.argv = argv;
@@ -427,7 +437,8 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	return (write_err || status);
 }
 
-static int apply_filter(const char *path, const char *src, size_t len, int fd,
+static int apply_filter(const char *path, const char *fspath,
+			const char *src, size_t len, int fd,
                         struct strbuf *dst, const char *cmd)
 {
 	/*
@@ -456,6 +467,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	params.fd = fd;
 	params.cmd = cmd;
 	params.path = path;
+	params.fspath = fspath;
 
 	fflush(NULL);
 	if (start_async(&async))
@@ -486,6 +498,8 @@ static struct convert_driver {
 	struct convert_driver *next;
 	const char *smudge;
 	const char *clean;
+	const char *smudge_to_file;
+	const char *clean_from_file;
 	int required;
 } *user_convert, **user_convert_tail;
 
@@ -512,8 +526,9 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	}
 
 	/*
-	 * filter.<name>.smudge and filter.<name>.clean specifies
-	 * the command line:
+	 * filter.<name>.smudge, filter.<name>.clean,
+	 * filter.<name>.smudgeToFile, filter.<name>.cleanFromFile
+	 * specifies the command line:
 	 *
 	 *	command-line
 	 *
@@ -526,6 +541,12 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	if (!strcmp("clean", key))
 		return git_config_string(&drv->clean, var, value);
 
+	if (!strcmp("smudgetofile", key))
+		return git_config_string(&drv->smudge_to_file, var, value);
+
+	if (!strcmp("cleanfromfile", key))
+		return git_config_string(&drv->clean_from_file, var, value);
+
 	if (!strcmp("required", key)) {
 		drv->required = git_config_bool(var, value);
 		return 0;
@@ -823,7 +844,35 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;
 
-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
+	return apply_filter(path, NULL, NULL, 0, -1, NULL, ca.drv->clean);
+}
+
+int can_clean_from_file(const char *path)
+{
+	struct conv_attrs ca;
+
+	convert_attrs(&ca, path);
+	if (!ca.drv)
+		return 0;
+
+	/* Only use the cleanFromFile filter when the clean filter is also
+	 * configured.
+	 */
+	return (ca.drv->clean_from_file && ca.drv->clean);
+}
+
+int can_smudge_to_file(const char *path)
+{
+	struct conv_attrs ca;
+
+	convert_attrs(&ca, path);
+	if (!ca.drv)
+		return 0;
+
+	/* Only use the smudgeToFile filter when the smudge filter is also
+	 * configured.
+	 */
+	return (ca.drv->smudge_to_file && ca.drv->smudge);
 }
 
 const char *get_convert_attr_ascii(const char *path)
@@ -866,7 +915,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		required = ca.drv->required;
 	}
 
-	ret |= apply_filter(path, src, len, -1, dst, filter);
+	ret |= apply_filter(path, NULL, src, len, -1, dst, filter);
 	if (!ret && required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
@@ -891,14 +940,33 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	assert(ca.drv);
 	assert(ca.drv->clean);
 
-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
+	if (!apply_filter(path, NULL, NULL, 0, fd, dst, ca.drv->clean))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
-static int convert_to_working_tree_internal(const char *path, const char *src,
+void convert_to_git_filter_from_file(const char *path, struct strbuf *dst,
+				   enum safe_crlf checksafe)
+{
+	struct conv_attrs ca;
+	convert_attrs(&ca, path);
+
+	assert(ca.drv);
+	assert(ca.drv->clean);
+	assert(ca.drv->clean_from_file);
+
+	if (!apply_filter(path, path, "", 0, -1, dst, ca.drv->clean_from_file))
+		die("%s: cleanFromFile filter '%s' failed", path, ca.drv->name);
+
+	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
+}
+
+static int convert_to_working_tree_internal(const char *path,
+					    const char *destpath,
+					    const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing)
 {
@@ -909,7 +977,10 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 
 	convert_attrs(&ca, path);
 	if (ca.drv) {
-		filter = ca.drv->smudge;
+		if (destpath)
+			filter = ca.drv->smudge_to_file;
+		else
+			filter = ca.drv->smudge;
 		required = ca.drv->required;
 	}
 
@@ -920,7 +991,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	}
 	/*
 	 * CRLF conversion can be skipped if normalizing, unless there
-	 * is a smudge filter.  The filter might expect CRLFs.
+	 * is a filter.  The filter might expect CRLFs.
 	 */
 	if (filter || !normalizing) {
 		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
@@ -930,21 +1001,30 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
-	ret_filter = apply_filter(path, src, len, -1, dst, filter);
+	ret_filter = apply_filter(path, destpath, src, len, -1, dst, filter);
 	if (!ret_filter && required)
-		die("%s: smudge filter %s failed", path, ca.drv->name);
+		die("%s: %s filter %s failed", path, destpath ? "smudgeToFile" : "smudge", ca.drv->name);
 
 	return ret | ret_filter;
 }
 
 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0);
+	return convert_to_working_tree_internal(path, NULL, src, len, dst, 0);
+}
+
+int convert_to_working_tree_filter_to_file(const char *path, const char *destpath, const char *src, size_t len)
+{
+	struct strbuf output = STRBUF_INIT;
+	int ret = convert_to_working_tree_internal(path, destpath, src, len, &output, 0);
+	/* The smudgeToFile filter stdout is not used. */
+	strbuf_release(&output);
+	return ret;
 }
 
 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
+	int ret = convert_to_working_tree_internal(path, NULL, src, len, dst, 1);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/convert.h b/convert.h
index ccf436b..53e1474 100644
--- a/convert.h
+++ b/convert.h
@@ -41,6 +41,10 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
 			  struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
+extern int convert_to_working_tree_filter_to_file(const char *path,
+						  const char *destpath,
+						  const char *src,
+						  size_t len);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
 static inline int would_convert_to_git(const char *path)
@@ -52,6 +56,12 @@ extern void convert_to_git_filter_fd(const char *path, int fd,
 				     struct strbuf *dst,
 				     enum safe_crlf checksafe);
 extern int would_convert_to_git_filter_fd(const char *path);
+/* Precondition: can_clean_from_file(path) == true */
+extern void convert_to_git_filter_from_file(const char *path,
+					    struct strbuf *dst,
+					    enum safe_crlf checksafe);
+extern int can_clean_from_file(const char *path);
+extern int can_smudge_to_file(const char *path);
 
 /*****************************************************************
  *
-- 
2.9.0.8.g973eabb.dirty

