From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 30/32] resolve_symlink(): take a strbuf parameter
Date: Sat,  6 Sep 2014 09:50:44 +0200
Message-ID: <1409989846-22401-31-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnf-0000Um-R4
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbaIFHwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:44 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42594 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbaIFHwl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:41 -0400
X-AuditID: 12074413-f79ed6d000002501-0e-540abd48697c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.53.09473.84DBA045; Sat,  6 Sep 2014 03:52:40 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHT006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:39 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqOuxlyvEYNUUG4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujMenZzAVPJGquPRvDnsD4wORLkZODgkBE4n9R/cxQthiEhfurWfr
	YuTiEBK4zCjR17uYBcI5xiSx6tAZVpAqNgFdiUU9zUwgCRGBNkaJXRc3gyWYBVIkOp53g40S
	FnCRuD3vA1A3BweLgKrEt19FIGFeAVeJNe2bmCC2yUls2P0frJwTKD69qRPMFgJqbT/ZzzSB
	kXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJBAE97BuOuk3CFGAQ5G
	JR7eAgeuECHWxLLiytxDjJIcTEqivHnLgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeDsmA+V4
	UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8zXuAGgWLUtNTK9Iyc0oQ
	0kwcnCDDuaREilPzUlKLEktLMuJBsRFfDIwOkBQP0N5GkHbe4oLEXKAoROspRl2OdZ3f+pmE
	WPLy81KlxHmZQIoEQIoySvPgVsDSyitGcaCPhXknglTxAFMS3KRXQEuYgJaYp3OCLClJREhJ
	NTAmuO6wXvNoZmRiJr/o5SOiq6reTz9el/CIj/dgUmTIc4e0moy82dtu5L17JHF1rqFDk3zi
	bMZLfXu2Lf3jOq1URqjuo/+kieoqQgf+3c9cFNv35oVH/MQH038JPVHeUFrmnLN8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256561>

Change resolve_symlink() to take a strbuf rather than a string as
parameter.  This simplifies the code and removes an arbitrary pathname
length restriction.  It also means that lock_file's filename field no
longer needs to be initialized to a large size.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 53 +++++++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 9413f7a..d78b6bf 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -119,53 +119,40 @@ static char *last_path_elm(char *p)
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
 
 /* Make sure errno contains a meaningful value on error */
@@ -185,16 +172,14 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
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
2.1.0
