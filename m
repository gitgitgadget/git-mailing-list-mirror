From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH v3 2/4] convert: fix normalization of foreign idents
Date: Mon, 23 Aug 2010 09:05:23 +0200
Message-ID: <b56d7f50198f63a810b304ae77043f58a240f743.1284820251.git.marcus@mc.pp.se>
References: <cover.1284820251.git.marcus@mc.pp.se>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 16:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owyhj-0008C7-LZ
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 16:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab0IROrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 10:47:46 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:55341 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab0IROr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 10:47:28 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 2F616F8C4;
	Sat, 18 Sep 2010 16:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1284820668; bh=gGSOYx5fFHCYfKFx1NhdHOdvOv28tlxEu/LNY2JZ8xo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=KDcF
	K3ZJs0YNnv+gM0SqfWipDaR0HcjmAi5vxn4wc/6f3pi/8fdF3yM/K2yC+84A0fQ6YZ2
	rUYQh4TNL9Nvz5323loTIQn3ueuBzYMW9SOeDfRCVbZ3iVt9eDBbPJ1kAXLVFPZtsEQ
	OIWrXbgYaQYcsEwcV0SMPo9g/BQ/rM1gk=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <b56d7f50198f63a810b304ae77043f58a240f743@chiyo>)
	id 1OwyXz-0002NE-DN; Sat, 18 Sep 2010 16:37:47 +0200
In-Reply-To: <cover.1284820251.git.marcus@mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156457>

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
 cache.h         |    8 +++++++-
 combine-diff.c  |    2 +-
 convert.c       |   23 ++++++++++++++++++-----
 diff.c          |    2 +-
 sha1_file.c     |    3 ++-
 7 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 638e7be..fe8d638 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1932,7 +1932,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf, CHECKS_DISALLOWED);
+	        convert_to_git(path, buf->buf, buf->len, buf, CHECKS_DISALLOWED, NORMALIZE_FOR_COMPARE);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index 850e165..8d8cbf3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2095,7 +2095,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, CHECKS_DISALLOWED);
+	convert_to_git(path, buf.buf, buf.len, &buf, CHECKS_DISALLOWED, NORMALIZE_FOR_COMPARE);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index 250abc1..3010e20 100644
--- a/cache.h
+++ b/cache.h
@@ -586,6 +586,11 @@ enum allow_checks {
 	CHECKS_ALLOWED = 1,
 };
 
+enum normalize_mode {
+        NORMALIZE_FOR_COMPARE = 0,
+	NORMALIZE_FOR_COMMIT = 1,
+};
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
@@ -1064,7 +1069,8 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 /* convert.c */
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t len,
-                          struct strbuf *dst, enum allow_checks checksallowed);
+                          struct strbuf *dst, enum allow_checks checksallowed,
+			  enum normalize_mode mode);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst);
 
diff --git a/combine-diff.c b/combine-diff.c
index c7f132d..e36bf61 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -758,7 +758,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(elem->path, result, len, &buf, CHECKS_ALLOWED)) {
+				if (convert_to_git(elem->path, result, len, &buf, CHECKS_ALLOWED, NORMALIZE_FOR_COMPARE)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/convert.c b/convert.c
index 8050c24..4eb28d8 100644
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
-                   struct strbuf *dst, enum allow_checks checksallowed)
+                   struct strbuf *dst, enum allow_checks checksallowed,
+		   enum normalize_mode mode)
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
@@ -739,7 +751,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | ident_to_git(path, src, len, dst, ident);
+	return ret | ident_to_git(path, src, len, dst, ident,
+				  mode == NORMALIZE_FOR_COMMIT);
 }
 
 static int convert_to_working_tree_internal(const char *path, const char *src,
@@ -797,5 +810,5 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, CHECKS_DISALLOWED);
+	return ret | convert_to_git(path, src, len, dst, CHECKS_DISALLOWED, NORMALIZE_FOR_COMPARE);
 }
diff --git a/diff.c b/diff.c
index ed74f6b..eebe3dd 100644
--- a/diff.c
+++ b/diff.c
@@ -2375,7 +2375,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, CHECKS_ALLOWED)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf, CHECKS_ALLOWED, NORMALIZE_FOR_COMPARE)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 13624a6..cbebb75 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2434,7 +2434,8 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-		                   write_object ? CHECKS_ALLOWED : CHECKS_DISALLOWED)) {
+		                   write_object ? CHECKS_ALLOWED : CHECKS_DISALLOWED,
+				   write_object ? NORMALIZE_FOR_COMMIT : NORMALIZE_FOR_COMPARE)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
-- 
1.7.2
