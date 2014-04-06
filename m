From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/25] resolve_symlink(): take a strbuf parameter
Date: Mon,  7 Apr 2014 01:34:06 +0200
Message-ID: <1396827247-28465-25-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc7-00074B-RS
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbaDFXgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:21 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46573 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754570AbaDFXf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:28 -0400
X-AuditID: 1207440c-f79656d000003eba-5b-5341e4c03a79
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E5.41.16058.0C4E1435; Sun,  6 Apr 2014 19:35:28 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbXB011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:26 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqHvgiWOwwcpFMhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PW4wnMBd+lKj4cvsvYwPhRpIuRk0NCwERiwrJP
	7BC2mMSFe+vZQGwhgcuMEjMme3QxcgHZx5kkXi97yAqSYBPQlVjU08wEYosIqElMbDvEAlLE
	LHCDUeLdvsMsIAlhAReJtl29YEUsAqoSi24+YOxi5ODgFXCVePLNDmKZnMTJY5PBZnIChddN
	nssCsdgFaMw9tgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihAQe
	zw7Gb+tkDjEKcDAq8fCuOOQYLMSaWFZcmXuIUZKDSUmU98FjoBBfUn5KZUZicUZ8UWlOavEh
	RgkOZiUR3gM3gHK8KYmVValF+TApaQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4OJQnePpCh
	gkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDIiC8GxgZIigdo73SQdt7igsRcoChE
	6ylGRSlx3pmPgBICIImM0jy4sbB08opRHOhLYd5lIO08wFQE1/0KaDAT0OCGMDuQwSWJCCmp
	Bsb2c7Y9tps+nXOYuSk07c8DA5kJhcfE31ouKLBa8L/Y7J16PfOSOZYhPJrPbyjfCRXsXb3q
	Sscr2U9yCZUbPs9cGpatraqnseRMur9P9f7q6fFyvWyvHZZtnLbC+mTGzhTxmYK/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245816>

Change resolve_symlink() to take a strbuf rather than a string as
parameter.  This simplifies the code and removes an arbitrary pathname
length restriction.  It also means that lock_file's filename field no
longer needs to be initialized to a large size.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 53 +++++++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index c4e32a9..8e7bcda 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -133,53 +133,40 @@ static char *last_path_elm(char *p)
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
 
 /* We append ".lock" to the filename to derive the lockfile name: */
@@ -200,16 +187,14 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		lk->fd = -1;
 		lk->owner = 0;
 		lk->flags |= LOCK_FLAGS_ON_LIST;
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
 	strbuf_addstr(&lk->filename, ".lock");
 	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
-- 
1.9.1
