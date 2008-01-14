From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] safecrlf: Add flag to convert_to_git() to disable safecrlf check
Date: Tue, 15 Jan 2008 00:20:40 +0100
Message-ID: <12003528401309-git-send-email-prohaska@zib.de>
References: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de>
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: dpotapov@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 15 00:21:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEYcR-0007tL-C8
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 00:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYANXU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 18:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYANXU7
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 18:20:59 -0500
Received: from mailer.zib.de ([130.73.108.11]:52329 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbYANXU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 18:20:58 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0ENKfWM018043;
	Tue, 15 Jan 2008 00:20:41 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0ENKfsk023207;
	Tue, 15 Jan 2008 00:20:41 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70486>

This commit goes on top of
"[PATCH v3] safecrlf: Add mechanism to warn about irreversible crlf conversions"
I send it as a separate patch to make reviewing easier.
Eventually it should be squashed.

I looked briefly at the various places where convert_to_git() is
called.  I think that only the one code path through index_fd()
actually writes data to the repsitory.  Maybe someone else with
a better understanding of git's internals should confirm this.

    Steffen

---- snip ---

We want to verify if an autocrlf conversion is reversible only if
the converted data is actually written to the repository.  Only
in this case the file would be modified during the next checkout.
But convert_to_git() is used for some other purposes.

This commit adds a flag to convert_to_git() that controls if the
safecrlf check is enabled.  The check is only enabled if
index_fd() writes the object converted.  In all other cases the
check is disabled.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-apply.c |    2 +-
 builtin-blame.c |    2 +-
 cache.h         |    2 +-
 convert.c       |   10 +++++-----
 diff.c          |    2 +-
 sha1_file.c     |    2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index d57bb6e..9fb6fe3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1430,7 +1430,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf);
+		convert_to_git(path, buf->buf, buf->len, buf, 0);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin-blame.c b/builtin-blame.c
index 9b4c02e..c361ee1 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2073,7 +2073,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die("read error %s from stdin", strerror(errno));
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf);
+	convert_to_git(path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index 4e03e3d..43e7d0e 100644
--- a/cache.h
+++ b/cache.h
@@ -640,7 +640,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 /* convert.c */
 /* returns 1 if *dst was used */
-extern int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst);
+extern int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst, int checksafe);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 
 /* add */
diff --git a/convert.c b/convert.c
index c9678ee..5adef4f 100644
--- a/convert.c
+++ b/convert.c
@@ -81,7 +81,7 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 }
 
 static int crlf_to_git(const char *path, const char *src, size_t len,
-                       struct strbuf *buf, int action)
+                       struct strbuf *buf, int action, int checksafe)
 {
 	struct text_stat stats;
 	char *dst;
@@ -107,7 +107,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
-	if (safe_crlf && auto_crlf > 0 && action != CRLF_INPUT) {
+	if (safe_crlf && checksafe && auto_crlf > 0 && action != CRLF_INPUT) {
 		/* CRLFs would be added by checkout: check if we have "naked" LFs */
 		if (stats.lf != stats.crlf) {
 			if (safe_crlf == SAFE_CRLF_WARN)
@@ -144,7 +144,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		} while (--len);
 	}
 
-	if (safe_crlf && (action == CRLF_INPUT || auto_crlf <= 0)) {
+	if (safe_crlf && checksafe && (action == CRLF_INPUT || auto_crlf <= 0)) {
 		/* CRLFs would not be restored by checkout: check if we removed CRLFs */
 		if (buf->len != dst - buf->buf) {
 			if (safe_crlf == SAFE_CRLF_WARN)
@@ -553,7 +553,7 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
 
-int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst)
+int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst, int checksafe)
 {
 	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
@@ -575,7 +575,7 @@ int convert_to_git(const char *path, const char *src, size_t len, struct strbuf
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, crlf);
+	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/diff.c b/diff.c
index b18c140..b5ac4f9 100644
--- a/diff.c
+++ b/diff.c
@@ -1624,7 +1624,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		 * Convert from working tree format to canonical git format
 		 */
 		strbuf_init(&buf, 0);
-		if (convert_to_git(s->path, s->data, s->size, &buf)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf, 0)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 6583797..3b5413d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2342,7 +2342,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	if ((type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
 		struct strbuf nbuf;
 		strbuf_init(&nbuf, 0);
-		if (convert_to_git(path, buf, size, &nbuf)) {
+		if (convert_to_git(path, buf, size, &nbuf, write_object)) {
 			munmap(buf, size);
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
-- 
1.5.4.rc2.60.g46ee
