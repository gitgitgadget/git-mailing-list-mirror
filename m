Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195B41FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 20:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbcFPUdu (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 16:33:50 -0400
Received: from kitenet.net ([66.228.36.95]:45004 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbcFPUdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 16:33:49 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=lpEqAo/o;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466109184; bh=7o+4g7XCrGBtG7uavuAaX0We2qWIjb00TzCuY+MHKkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpEqAo/oWhmc3G/iahNhd+5FC0Kau4/GMvRrvKDXRNq6z4zaMjFUv5ZDL8FsB7H87
	 CIUVMwhaIZ3jbO7Ih9Y5b8R5wWnvSHOhKYtZ+v7nv+2Y9K50Ew+GEC9rs61CZqk8SG
	 GdKlXD2fbnoFHDeO7V+48ybn2ZmxbLS/KCfZl7WA=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH 2/4] add smudge-to-file and clean-from-file filter configuration
Date:	Thu, 16 Jun 2016 16:32:57 -0400
Message-Id: <20160616203259.5886-3-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.4.g2856e74.dirty
In-Reply-To: <20160616203259.5886-1-joeyh@joeyh.name>
References: <20160616203259.5886-1-joeyh@joeyh.name>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This adds new smudge-to-file and clean-from-file filter commands,
which are similar to smudge and clean but allow direct access to files on
disk.

In smudge-to-file and clean-from-file, "%p" is expanded to the path to the
file that should be cleaned from, or smudged to.

This interface can be much more efficient when operating on large files,
because the whole file content does not need to be streamed through the
filter. It even allows for things like clean-from-file commands that avoid
reading the whole content of the file, and for smudge-to-file commands that
populate a work tree file using an efficient Copy On Write operation.

The new filter commands will not be used for all filtering. They are
efficient to use when git add is adding a file, or when the work tree is
being updated, but not a good fit when git is internally filtering blob
objects in memory for eg, a diff.

So, a user who wants to use smudge-to-file should also provide a smudge
command to be used in cases where smudge-to-file is not used. And ditto
with clean-from-file and clean. To avoid foot-shooting configurations, the
new commands are not used unless the old commands are also configured.

That also ensures that a filter driver configuration that includes these
new commands will work, although less efficiently, when used with an older
version of git that does not support them.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 Documentation/config.txt        |  27 +++++++---
 Documentation/gitattributes.txt |  37 ++++++++++++++
 convert.c                       | 107 ++++++++++++++++++++++++++++++++++------
 convert.h                       |  10 ++++
 4 files changed, 160 insertions(+), 21 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e1b2e4..bbb9296 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1299,14 +1299,29 @@ format.useAutoBase::
 	format-patch by default.
 
 filter.<driver>.clean::
-	The command which is used to convert the content of a worktree
-	file to a blob upon checkin.  See linkgit:gitattributes[5] for
-	details.
+	The command which is used on checkin to convert the content of
+	a worktree file (provided on stdin) to a blob (written to stdout).
+	See linkgit:gitattributes[5] for details.
 
 filter.<driver>.smudge::
-	The command which is used to convert the content of a blob
-	object to a worktree file upon checkout.  See
-	linkgit:gitattributes[5] for details.
+	The command which is used on checkout to convert the content of a
+	blob object (provided on stdin) to a worktree file (written to
+	stdout).
+	See linkgit:gitattributes[5] for details.
+
+filter.<driver>.clean-from-file::
+	Optional command which is used on checkin to convert the content
+	of a worktree file, which can be read from disk, to a blob
+	(written to stdout).
+	Only used when filter.<driver>.clean is also configured.
+	See linkgit:gitattributes[5] for details.
+
+filter.<driver>.smudge-to-file::
+	Optional command which is used to convert the content of a blob
+	object (provided on stdin) to a worktree file, writing directly
+	to the file.
+	Only used when filter.<driver>.clean is also configured.
+	See linkgit:gitattributes[5] for details.
 
 fsck.<msg-id>::
 	Allows overriding the message type (error, warn or ignore) of a
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e077cc9..32621e7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -378,6 +378,43 @@ Note that the "%f" is the name of a file in the git repository; the
 corresponding file on disk may not exist, or may have unrelated contents to
 what git is filtering.
 
+There are two extra commands "clean-from-file" and "smudge-to-file", which
+can optionally be set in a filter driver. These are similar to the "clean"
+and "smudge" commands, but avoid needing to pipe the contents of files
+through the filters, and instead reading/writing files in the filesystem.
+This can be more efficient when using filters with large files that are not
+directly stored in the repository.
+
+Sequence "%p" on the "clean-from-file" and "smudge-to-file" command line
+is replaced with the path to a file that the filter can access.
+
+In the "clean-from-file" command, "%p" is the path to the file that
+it should clean. Like the "clean" command, it should output the cleaned
+version to standard output.
+
+In the "smudge-from-file" command, "%p" is the path to the file that it
+should write to. (This file will already exist, as an empty file that can
+be written to or replaced.) Like the "smudge" command, "smudge-from-file"
+is fed the blob object from its standard input.
+
+Some git operations that need to apply filters cannot use "clean-from-file"
+and "smudge-to-file", since the files are not present to disk. So, to avoid
+inconsistent behavior, "clean-from-file" will only be used if "clean" is
+also configured, and "smudge-to-file" will only be used if "smudge" is also
+configured.
+
+An example large file storage filter driver using "*-from-file" follows:
+
+------------------------
+[filter "bigfiles"]
+	clean = store-bigfile --from-stdin
+	clean-from-file = store-bigfile %p
+	smudge = retrieve-bigfile --to-stdout
+	smudge-to-file = retrieve-bigfile %p
+	required
+
+------------------------
+
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/convert.c b/convert.c
index b1614bf..bfb7578 100644
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
@@ -376,16 +377,22 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	/* apply % substitution to cmd */
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
+	struct strbuf fspath = STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[] = {
 		{ "f", NULL, },
+		{ (params->fspath ? "p" : NULL), NULL, },
 		{ NULL, NULL, },
 	};
 
 	/* quote the path to preserve spaces, etc. */
 	sq_quote_buf(&path, params->path);
 	dict[0].value = path.buf;
+	if (params->fspath) {
+		sq_quote_buf(&fspath, params->fspath);
+		dict[1].value = fspath.buf;
+	}
 
-	/* expand all %f with the quoted path */
+	/* expand all %f and %p with the quoted path and fspath */
 	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
 	strbuf_release(&path);
 
@@ -427,7 +434,8 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	return (write_err || status);
 }
 
-static int apply_filter(const char *path, const char *src, size_t len, int fd,
+static int apply_filter(const char *path, const char *fspath,
+			const char *src, size_t len, int fd,
                         struct strbuf *dst, const char *cmd)
 {
 	/*
@@ -456,6 +464,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	params.fd = fd;
 	params.cmd = cmd;
 	params.path = path;
+	params.fspath = fspath;
 
 	fflush(NULL);
 	if (start_async(&async))
@@ -486,6 +495,8 @@ static struct convert_driver {
 	struct convert_driver *next;
 	const char *smudge;
 	const char *clean;
+	const char *smudge_to_file;
+	const char *clean_from_file;
 	int required;
 } *user_convert, **user_convert_tail;
 
@@ -512,8 +523,9 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	}
 
 	/*
-	 * filter.<name>.smudge and filter.<name>.clean specifies
-	 * the command line:
+	 * filter.<name>.smudge, filter.<name>.clean,
+	 * filter.<name>.smudge-to-file, filter.<name>.clean-from-file
+	 * specifies the command line:
 	 *
 	 *	command-line
 	 *
@@ -526,6 +538,12 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	if (!strcmp("clean", key))
 		return git_config_string(&drv->clean, var, value);
 
+	if (!strcmp("smudge-to-file", key))
+		return git_config_string(&drv->smudge_to_file, var, value);
+
+	if (!strcmp("clean-from-file", key))
+		return git_config_string(&drv->clean_from_file, var, value);
+
 	if (!strcmp("required", key)) {
 		drv->required = git_config_bool(var, value);
 		return 0;
@@ -823,7 +841,35 @@ int would_convert_to_git_filter_fd(const char *path)
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
+	/* Only use the clean-from-file filter when the clean filter is also
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
+	/* Only use the smudge-to-file filter when the smudge filter is also
+	 * configured.
+	 */
+	return (ca.drv->smudge_to_file && ca.drv->smudge);
 }
 
 const char *get_convert_attr_ascii(const char *path)
@@ -866,7 +912,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		required = ca.drv->required;
 	}
 
-	ret |= apply_filter(path, src, len, -1, dst, filter);
+	ret |= apply_filter(path, NULL, src, len, -1, dst, filter);
 	if (!ret && required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
@@ -891,14 +937,33 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
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
+		die("%s: clean-from-file filter '%s' failed", path, ca.drv->name);
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
@@ -909,7 +974,10 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 
 	convert_attrs(&ca, path);
 	if (ca.drv) {
-		filter = ca.drv->smudge;
+		if (destpath)
+			filter = ca.drv->smudge_to_file;
+		else
+			filter = ca.drv->smudge;
 		required = ca.drv->required;
 	}
 
@@ -920,7 +988,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	}
 	/*
 	 * CRLF conversion can be skipped if normalizing, unless there
-	 * is a smudge filter.  The filter might expect CRLFs.
+	 * is a filter.  The filter might expect CRLFs.
 	 */
 	if (filter || !normalizing) {
 		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
@@ -930,21 +998,30 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
-	ret_filter = apply_filter(path, src, len, -1, dst, filter);
+	ret_filter = apply_filter(path, destpath, src, len, -1, dst, filter);
 	if (!ret_filter && required)
-		die("%s: smudge filter %s failed", path, ca.drv->name);
+		die("%s: %s filter %s failed", path, destpath ? "smudge-to-file" : "smudge", ca.drv->name);
 
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
+	/* The smudge-to-file filter stdout is not used. */
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
2.9.0.4.g2856e74.dirty

