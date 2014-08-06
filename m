From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2 1/2] convert: Refactor would_convert_to_git() to single arg 'path'
Date: Wed,  6 Aug 2014 07:32:13 +0200
Message-ID: <1407303134-16635-2-git-send-email-prohaska@zib.de>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 07:32:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEtqH-0002Ud-FN
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 07:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbaHFFcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 01:32:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:40511 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbaHFFcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 01:32:41 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s765WWfG020450;
	Wed, 6 Aug 2014 07:32:32 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s765WNKt020135;
	Wed, 6 Aug 2014 07:32:32 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1407303134-16635-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53E1BDF0.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53E1BDF0.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53E1BDF0.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254847>

It is only the path that matters in the decision whether to filter or
not.  Clarify this by making path the single argument of
would_convert_to_git().

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 convert.h   | 5 ++---
 sha1_file.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/convert.h b/convert.h
index 0c2143c..c638b33 100644
--- a/convert.h
+++ b/convert.h
@@ -40,10 +40,9 @@ extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
-static inline int would_convert_to_git(const char *path, const char *src,
-				       size_t len, enum safe_crlf checksafe)
+static inline int would_convert_to_git(const char *path)
 {
-	return convert_to_git(path, src, len, NULL, checksafe);
+	return convert_to_git(path, NULL, 0, NULL, 0);
 }
 
 /*****************************************************************
diff --git a/sha1_file.c b/sha1_file.c
index 3f70b1d..00c07f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3144,7 +3144,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
 	else if (size <= big_file_threshold || type != OBJ_BLOB ||
-		 (path && would_convert_to_git(path, NULL, 0, 0)))
+		 (path && would_convert_to_git(path)))
 		ret = index_core(sha1, fd, size, type, path, flags);
 	else
 		ret = index_stream(sha1, fd, size, type, path, flags);
-- 
2.1.0.rc1.6.gb569bd8
