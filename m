From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] sha1_file: don't convert off_t to size_t too early to avoid potential die()
Date: Sun, 21 Sep 2014 12:03:26 +0200
Message-ID: <1411293806-3087-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 12:04:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVdzw-00014Y-E2
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 12:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbaIUKDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 06:03:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:46345 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbaIUKDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 06:03:52 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s8LA3nJ8018554;
	Sun, 21 Sep 2014 12:03:49 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s8LA3mPf010312;
	Sun, 21 Sep 2014 12:03:49 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.263.gab8d730
X-Miltered: at mailer.zib.de with ID 541EA285.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 541EA285.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 541EA285.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257349>

xsize_t() checks if an off_t argument can be safely converted to
a size_t return value.  If the check is executed too early, it could
fail for large files on 32-bit architectures even if the size_t code
path is not taken.  Other paths might be able to handle the large file.
Specifically, index_stream_convert_blob() is able to handle a large file
if a filter is configured that returns a small result.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---

This patch should be applied on top of sp/stream-clean-filter.

index_stream() might internally also be able to handle large files to
some extent.  But it uses size_t for its third argument, and we must
already die() when calling it.  It might be a good idea to convert its
interface to use off_t and push the size checks further down the stack.
In general, it might be good idea to carefully consider whether to use
off_t or size_t when passing file-related sizes around.  To me it looks
like a separate issue for a separate patch series (I have no specific
plans to prepare one).

 sha1_file.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5b0e67a..6f18c22 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3180,17 +3180,22 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
-	size_t size = xsize_t(st->st_size);
 
+	/*
+	 * Call xsize_t() only when needed to avoid potentially unnecessary
+	 * die() for large files.
+	 */
 	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(path))
 		ret = index_stream_convert_blob(sha1, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
-	else if (size <= big_file_threshold || type != OBJ_BLOB ||
+	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
 		 (path && would_convert_to_git(path)))
-		ret = index_core(sha1, fd, size, type, path, flags);
+		ret = index_core(sha1, fd, xsize_t(st->st_size), type, path,
+				 flags);
 	else
-		ret = index_stream(sha1, fd, size, type, path, flags);
+		ret = index_stream(sha1, fd, xsize_t(st->st_size), type, path,
+				   flags);
 	close(fd);
 	return ret;
 }
-- 
2.1.0.139.g351b19f
