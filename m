From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 24/25] resolve_symlink(): take a strbuf parameter
Date: Mon, 14 Apr 2014 15:54:54 +0200
Message-ID: <1397483695-10888-25-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:56:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMg-0000xt-4n
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbaDNNzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:54 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59726 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755255AbaDNNzt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:49 -0400
X-AuditID: 12074413-f79076d000002d17-ac-534be8e41c8e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.40.11543.4E8EB435; Mon, 14 Apr 2014 09:55:48 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09O010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:46 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqPvkhXewwfIb4hZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGcsu/CVteCjVMWr2a+ZGhjfiXQx
	cnJICJhIfG3+wA5hi0lcuLeerYuRi0NI4DKjxMS7O5hBEkICJ5kkNrzmA7HZBHQlFvU0M4HY
	IgJqEhPbDrGANDALtDNJHNrRC5YQFnCRONSymA3EZhFQlZjx9y3QBg4OXgFXicsLeCGWyUmc
	PDaZFSTMCRRe+CELYpWLxN0vU1gnMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpeb
	WaKXmlK6iRESiMI7GHedlDvEKMDBqMTD2zHHO1iINbGsuDL3EKMkB5OSKG/GDaAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEV7XrUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKY
	rAwHh5IEb81zoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UFzEFwMjAyTFA7Q3
	CaSdt7ggMRcoCtF6ilFRSpy3BCQhAJLIKM2DGwtLL68YxYG+FOZNA6niAaYmuO5XQIOZgAaz
	tIMNLklESEk1MLqa/9z4pOeUCLf6518mc8tPyT78+UJDSvl9dN+U0DCzy8XfZ38+e1ZoaS7X
	uyVCd1pXXOv7vLg2sODUg/YbAYU6H8KdRDVOWHaLfPd/uVzh7+sZGYolez/vulaX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246232>

Change resolve_symlink() to take a strbuf rather than a string as
parameter.  This simplifies the code and removes an arbitrary pathname
length restriction.  It also means that lock_file's filename field no
longer needs to be initialized to a large size.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 53 +++++++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 59ed758..65f56ef 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -124,53 +124,40 @@ static char *last_path_elm(char *p)
 #define MAXDEPTH 5
 
 /*
- * p = path that may be a symlink
- * s = full size of p
+ * path contains a path that might be a symlink.
  *
- * If p is a symlink, attempt to overwrite p with a path to the real
- * file or directory (which may or may not exist), following a chain of
- * symlinks if necessary.  Otherwise, leave p unmodified.
+ * If path is a symlink, attempt to overwrite it with a path to the
+ * real file or directory (which may or may not exist), following a
+ * chain of symlinks if necessary.  Otherwise, leave path unmodified.
  *
- * This is a best-effort routine.  If an error occurs, p will either be
- * left unmodified or will name a different symlink in a symlink chain
- * that started with p's initial contents.
- *
- * Always returns p.
+ * This is a best-effort routine.  If an error occurs, path will
+ * either be left unmodified or will name a different symlink in a
+ * symlink chain that started with the original path.
  */
-
-static char *resolve_symlink(char *p, size_t s)
+static void resolve_symlink(struct strbuf *path)
 {
 	int depth = MAXDEPTH;
 	static struct strbuf link = STRBUF_INIT;
 
 	while (depth--) {
-		if (strbuf_readlink(&link, p, strlen(p)) < 0)
+		if (strbuf_readlink(&link, path->buf, path->len) < 0)
 			break;
 
-		if (is_absolute_path(link.buf)) {
+		if (is_absolute_path(link.buf))
 			/* absolute path simply replaces p */
-			if (link.len < s)
-				strcpy(p, link.buf);
-			else {
-				warning("%s: symlink too long", p);
-				break;
-			}
-		} else {
+			strbuf_reset(path);
+		else {
 			/*
 			 * link is a relative path, so replace the
 			 * last element of p with it.
 			 */
-			char *r = (char *)last_path_elm(p);
-			if (r - p + link.len < s)
-				strcpy(r, link.buf);
-			else {
-				warning("%s: symlink too long", p);
-				break;
-			}
+			char *r = last_path_elm(path->buf);
+			strbuf_setlen(path, r - path->buf);
 		}
+
+		strbuf_addbuf(path, &link);
 	}
 	strbuf_reset(&link);
-	return p;
 }
 
 static int lock_file(struct lock_file *lk, const char *path, int flags)
@@ -189,16 +176,14 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		lk->active = 0;
 		lk->owner = 0;
 		lk->on_list = 1;
-		strbuf_init(&lk->filename, PATH_MAX);
+		strbuf_init(&lk->filename, 0);
 		lk->next = lock_file_list;
 		lock_file_list = lk;
 	}
 
 	strbuf_addstr(&lk->filename, path);
-	if (!(flags & LOCK_NODEREF)) {
-		resolve_symlink(lk->filename.buf, lk->filename.alloc);
-		strbuf_setlen(&lk->filename, strlen(lk->filename.buf));
-	}
+	if (!(flags & LOCK_NODEREF))
+		resolve_symlink(&lk->filename);
 	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
-- 
1.9.1
