From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH v3 1/4] convert: generalize checksafe parameter
Date: Tue, 14 Sep 2010 00:00:49 +0200
Message-ID: <dc98d53e2cc922c4ba7f21043969f77463e72c58.1284820251.git.marcus@mc.pp.se>
References: <cover.1284820251.git.marcus@mc.pp.se>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 16:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owyi8-00005X-FW
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 16:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab0IROrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 10:47:45 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:46504 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab0IROr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 10:47:28 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 13CF1F8C2;
	Sat, 18 Sep 2010 16:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1284820668; bh=Z9RsyosLEDY0jwQyIvpSrk98zPqly2/61Gu/My+sNgA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=hqxu
	fWJZP6GvVFW7r1UgTlEK+XwC8kR31bMgt+NIKnaMAQ2caCWmfynCFP1++s7+iFs0UnJ
	afRQAtCiDXHOkKyWgy7KL+qsL5CzY00vtF7983UI1PLi2dP7IeBDxdM3C2C11gerLSs
	H1OHIdznEgyd7FyhIerLfLbKlKsW+Y9bs=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <dc98d53e2cc922c4ba7f21043969f77463e72c58@chiyo>)
	id 1OwyXy-0002NB-W3; Sat, 18 Sep 2010 16:37:47 +0200
In-Reply-To: <cover.1284820251.git.marcus@mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156459>

The convert_to_git() function used to have a checksafe parameter,
which could be used to prevent safe_crlf checks by passing 0
instead of the value of the global variable safe_crlf.

Since preventing checks is a wider concept than just disabling
safe_crlf, generalize the parameter so that it can be used for other
types of checks as well.

Signed-off-by: Marcus Comstedt <marcus@mc.pp.se>
---
 builtin/apply.c |    2 +-
 builtin/blame.c |    2 +-
 cache.h         |    7 ++++++-
 combine-diff.c  |    2 +-
 convert.c       |    7 ++++---
 diff.c          |    2 +-
 sha1_file.c     |    2 +-
 7 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..638e7be 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1932,7 +1932,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(path, buf->buf, buf->len, buf, CHECKS_DISALLOWED);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index 1015354..850e165 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2095,7 +2095,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(path, buf.buf, buf.len, &buf, CHECKS_DISALLOWED);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index 2ef2fa3..250abc1 100644
--- a/cache.h
+++ b/cache.h
@@ -581,6 +581,11 @@ enum eol {
 
 extern enum eol eol;
 
+enum allow_checks {
+	CHECKS_DISALLOWED = 0,
+	CHECKS_ALLOWED = 1,
+};
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
@@ -1059,7 +1064,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 /* convert.c */
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t len,
-                          struct strbuf *dst, enum safe_crlf checksafe);
+                          struct strbuf *dst, enum allow_checks checksallowed);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst);
 
diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..c7f132d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -758,7 +758,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(elem->path, result, len, &buf, CHECKS_ALLOWED)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/convert.c b/convert.c
index 01de9a8..8050c24 100644
--- a/convert.c
+++ b/convert.c
@@ -706,7 +706,7 @@ static enum action determine_action(enum action text_attr, enum eol eol_attr)
 }
 
 int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+                   struct strbuf *dst, enum allow_checks checksallowed)
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
@@ -733,7 +733,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		len = dst->len;
 	}
 	action = determine_action(action, eol_attr);
-	ret |= crlf_to_git(path, src, len, dst, action, checksafe);
+	ret |= crlf_to_git(path, src, len, dst, action,
+			   (checksallowed? safe_crlf : 0));
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -796,5 +797,5 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, 0);
+	return ret | convert_to_git(path, src, len, dst, CHECKS_DISALLOWED);
 }
diff --git a/diff.c b/diff.c
index 9a5c77c..ed74f6b 100644
--- a/diff.c
+++ b/diff.c
@@ -2375,7 +2375,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf, CHECKS_ALLOWED)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 0cd9435..13624a6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2434,7 +2434,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-		                   write_object ? safe_crlf : 0)) {
+		                   write_object ? CHECKS_ALLOWED : CHECKS_DISALLOWED)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
-- 
1.7.2
