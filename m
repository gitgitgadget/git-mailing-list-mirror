From: Jeff King <peff@peff.net>
Subject: [PATCH 66/67] use strbuf_complete to conditionally append slash
Date: Tue, 15 Sep 2015 12:16:19 -0400
Message-ID: <20150915161619.GN29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:16:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsuA-00037C-N9
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbIOQQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:16:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:59485 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752461AbbIOQQV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:16:21 -0400
Received: (qmail 14705 invoked by uid 102); 15 Sep 2015 16:16:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:16:21 -0500
Received: (qmail 8060 invoked by uid 107); 15 Sep 2015 16:16:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:16:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:16:19 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277971>

When working with paths in strbufs, we frequently want to
ensure that a directory contains a trailing slash before
appending to it. We can shorten this code (and make the
intent more obvious) by calling strbuf_complete.

Most of these cases are trivially identical conversions, but
there are two things to note:

  - in a few cases we did not check that the strbuf is
    non-empty (which would lead to an out-of-bounds memory
    access). These were generally not triggerable in
    practice, either from earlier assertions, or typically
    because we would have just fed the strbuf to opendir(),
    which would choke on an empty path.

  - in a few cases we indexed the buffer with "original_len"
    or similar, rather than the current sb->len, and it is
    not immediately obvious from the diff that they are the
    same. In all of these cases, I manually verified that
    the strbuf does not change between the assignment and
    the strbuf_complete call.

This does not convert cases which look like:

  if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
	  strbuf_addch(sb, '/');

as those are obviously semantically different. Some of these
cases arguably should be doing that, but that is out of
scope for this change, which aims purely for cleanup with no
behavior change (and at least it will make such sites easier
to find and examine in the future, as we can grep for
strbuf_complete).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clean.c | 6 ++----
 builtin/log.c   | 3 +--
 diff-no-index.c | 6 ++----
 dir.c           | 6 ++----
 imap-send.c     | 3 +--
 path.c          | 3 +--
 refs.c          | 3 +--
 url.c           | 3 +--
 8 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index df53def..d7acb94 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -159,8 +159,7 @@ static int is_git_repository(struct strbuf *path)
 	int gitfile_error;
 	size_t orig_path_len = path->len;
 	assert(orig_path_len != 0);
-	if (path->buf[orig_path_len - 1] != '/')
-		strbuf_addch(path, '/');
+	strbuf_complete(path, '/');
 	strbuf_addstr(path, ".git");
 	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
 		ret = 1;
@@ -206,8 +205,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		return res;
 	}
 
-	if (path->buf[original_len - 1] != '/')
-		strbuf_addch(path, '/');
+	strbuf_complete(path, '/');
 
 	len = path->len;
 	while ((e = readdir(dir)) != NULL) {
diff --git a/builtin/log.c b/builtin/log.c
index a491d3d..dda671d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -796,8 +796,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 		if (filename.len >=
 		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len)
 			return error(_("name of output directory is too long"));
-		if (filename.buf[filename.len - 1] != '/')
-			strbuf_addch(&filename, '/');
+		strbuf_complete(&filename, '/');
 	}
 
 	if (rev->numbered_files)
diff --git a/diff-no-index.c b/diff-no-index.c
index 0320605..8e0fd27 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -136,15 +136,13 @@ static int queue_diff(struct diff_options *o,
 
 		if (name1) {
 			strbuf_addstr(&buffer1, name1);
-			if (buffer1.len && buffer1.buf[buffer1.len - 1] != '/')
-				strbuf_addch(&buffer1, '/');
+			strbuf_complete(&buffer1, '/');
 			len1 = buffer1.len;
 		}
 
 		if (name2) {
 			strbuf_addstr(&buffer2, name2);
-			if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
-				strbuf_addch(&buffer2, '/');
+			strbuf_complete(&buffer2, '/');
 			len2 = buffer2.len;
 		}
 
diff --git a/dir.c b/dir.c
index 7b25634..79fdad8 100644
--- a/dir.c
+++ b/dir.c
@@ -1519,8 +1519,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 	}
 	strbuf_addstr(path, cdir->ucd->name);
 	/* treat_one_path() does this before it calls treat_directory() */
-	if (path->buf[path->len - 1] != '/')
-		strbuf_addch(path, '/');
+	strbuf_complete(path, '/');
 	if (cdir->ucd->check_only)
 		/*
 		 * check_only is set as a result of treat_directory() getting
@@ -2126,8 +2125,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 		else
 			return -1;
 	}
-	if (path->buf[original_len - 1] != '/')
-		strbuf_addch(path, '/');
+	strbuf_complete(path, '/');
 
 	len = path->len;
 	while ((e = readdir(dir)) != NULL) {
diff --git a/imap-send.c b/imap-send.c
index 01aa227..f5d2b06 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1412,8 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
 
 	strbuf_addstr(&path, server.host);
-	if (!path.len || path.buf[path.len - 1] != '/')
-		strbuf_addch(&path, '/');
+	strbuf_complete(&path, '/');
 	strbuf_addstr(&path, server.folder);
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
diff --git a/path.c b/path.c
index c597473..c105a9e 100644
--- a/path.c
+++ b/path.c
@@ -240,8 +240,7 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 	const char *git_dir;
 
 	strbuf_addstr(buf, path);
-	if (buf->len && buf->buf[buf->len - 1] != '/')
-		strbuf_addch(buf, '/');
+	strbuf_complete(buf, '/');
 	strbuf_addstr(buf, ".git");
 
 	git_dir = read_gitfile(buf->buf);
diff --git a/refs.c b/refs.c
index df6c41a..cebe7cf 100644
--- a/refs.c
+++ b/refs.c
@@ -2193,8 +2193,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 
 	if (!has_glob_specials(pattern)) {
 		/* Append implied '/' '*' if not present. */
-		if (real_pattern.buf[real_pattern.len - 1] != '/')
-			strbuf_addch(&real_pattern, '/');
+		strbuf_complete(&real_pattern, '/');
 		/* No need to check for '*', there is none. */
 		strbuf_addch(&real_pattern, '*');
 	}
diff --git a/url.c b/url.c
index 7ca2a69..2d89ad1 100644
--- a/url.c
+++ b/url.c
@@ -120,8 +120,7 @@ char *url_decode_parameter_value(const char **query)
 void end_url_with_slash(struct strbuf *buf, const char *url)
 {
 	strbuf_addstr(buf, url);
-	if (buf->len && buf->buf[buf->len - 1] != '/')
-		strbuf_addch(buf, '/');
+	strbuf_complete(buf, '/');
 }
 
 void str_end_url_with_slash(const char *url, char **dest) {
-- 
2.6.0.rc2.408.ga2926b9
