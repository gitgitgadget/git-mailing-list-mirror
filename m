From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH v2 1/2] convert: fix normalization of foreign idents
Date: Mon, 23 Aug 2010 09:05:23 +0200
Message-ID: <E1Ot4NP-0002xn-Nc@chiyo.mc.pp.se>
References: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 22:27:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot4lO-0006U7-67
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 22:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515Ab0IGU1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 16:27:19 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:50141 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab0IGU1R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 16:27:17 -0400
X-Greylist: delayed 1471 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2010 16:27:17 EDT
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 24693FB17;
	Tue,  7 Sep 2010 22:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1283889765; bh=cKaacVa2H3T47ve6o5N6d5mpiWlTLmaxAK0kXTgF4kA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=2LCG
	wB4n/FfIyRlyOosJmbtzStiBysM4zTvMjnNY3TUEb8stR2grMEXE5w/ZjcB3RSEqlNJ
	Wwqx6Sp6QKOjRqf9Pd6OsY8MWw5Mto8Ro9qIobtmcdxMrq1N2+vdzTtR56NISKS+xTC
	rBoUpbt+tVzzYRDQIG3l2veVBK63F1jd4=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <c111a07f43b1b3af08e5546aff2983044c1b1a6b@chiyo>)
	id 1Ot4NP-0002xn-Nc; Tue, 07 Sep 2010 22:02:43 +0200
In-Reply-To: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155739>

Since ident_to_worktree() does not touch $Id$ tags which contain
foreign expansions in the repository, make sure that ident_to_git()
does not either.  This fixes the problem that such files show
spurious modification upon checkout.

There is however one case where we want ident_to_git() to normalize
the tag to $Id$ despite the asymmetry:  When committing a modification
to a file which has a foreign ident, the foreign ident should be
replaced with a regular git ident.  Thus, add a new parameter to
convert_to_git() that indicates if we want the foreign idents
normalized after all.

Signed-off-by: Marcus Comstedt <marcus@mc.pp.se>
---
 builtin/apply.c |    2 +-
 builtin/blame.c |    2 +-
 cache.h         |    3 ++-
 combine-diff.c  |    2 +-
 convert.c       |   23 ++++++++++++++++++-----
 diff.c          |    2 +-
 sha1_file.c     |    3 ++-
 7 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..7abff80 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1932,7 +1932,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(path, buf->buf, buf->len, buf, 0, 0);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index 1015354..4f3b004 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2095,7 +2095,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(path, buf.buf, buf.len, &buf, 0, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index be02a42..23ae1f1 100644
--- a/cache.h
+++ b/cache.h
@@ -1055,7 +1055,8 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 /* convert.c */
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t len,
-                          struct strbuf *dst, enum safe_crlf checksafe);
+			  struct strbuf *dst, enum safe_crlf checksafe,
+			  int normalize_foreign_ident);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst);
 
diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..e81aa7d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -758,7 +758,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(elem->path, result, len, &buf, safe_crlf, 0)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/convert.c b/convert.c
index 01de9a8..6abab3f 100644
--- a/convert.c
+++ b/convert.c
@@ -520,9 +520,10 @@ static int count_ident(const char *cp, unsigned long size)
 }
 
 static int ident_to_git(const char *path, const char *src, size_t len,
-                        struct strbuf *buf, int ident)
+			struct strbuf *buf, int ident,
+			int normalize_foreign_ident)
 {
-	char *dst, *dollar;
+	char *dst, *dollar, *spc;
 
 	if (!ident || !count_ident(src, len))
 		return 0;
@@ -549,6 +550,16 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 				continue;
 			}
 
+			spc = memchr(src + 4, ' ', dollar - src - 4);
+			if (spc && spc < dollar-1 &&
+			    !normalize_foreign_ident) {
+				/* There are spaces in unexpected places.
+				 * This is probably an id from some other
+				 * versioning system. Keep it for now.
+				 */
+				continue;
+			}
+
 			memcpy(dst, "Id$", 3);
 			dst += 3;
 			len -= dollar + 1 - src;
@@ -706,7 +717,8 @@ static enum action determine_action(enum action text_attr, enum eol eol_attr)
 }
 
 int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, enum safe_crlf checksafe,
+		   int normalize_foreign_ident)
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
@@ -738,7 +750,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | ident_to_git(path, src, len, dst, ident);
+	return ret | ident_to_git(path, src, len, dst, ident,
+				  normalize_foreign_ident);
 }
 
 static int convert_to_working_tree_internal(const char *path, const char *src,
@@ -796,5 +809,5 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, 0);
+	return ret | convert_to_git(path, src, len, dst, 0, 0);
 }
diff --git a/diff.c b/diff.c
index 144f2aa..d481cb6 100644
--- a/diff.c
+++ b/diff.c
@@ -2372,7 +2372,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf, 0)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 0cd9435..37e8657 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2434,7 +2434,8 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-		                   write_object ? safe_crlf : 0)) {
+				   write_object ? safe_crlf : 0,
+				   write_object)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
-- 
1.7.2
