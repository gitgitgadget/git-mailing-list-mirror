From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC v2 3/4] Pass eol conv mode as an argument instead of using global auto_crlf
Date: Sat,  8 May 2010 23:46:20 +0200
Message-ID: <de1db7b41b76dae815988590dbb707e2fa101440.1273352819.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Cc: mat <matthieu.stigler@gmail.com>, hasen j <hasan.aljudy@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 23:46:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OArr8-0005e1-8k
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 23:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab0EHVqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 17:46:38 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:40289 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab0EHVqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 17:46:35 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so578783ewy.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JZNJfaE+qPWhK2Op0EghUBztXYd5lNCh9xv0Ay5M+WE=;
        b=XtEVrvLArMLNPfeN0JuPheYJhJqFVjUkhAyfqgNp1VKhTmRKTuvHr8zShsscdRi0q2
         7QI1sFFwZ+hE0fSn91j4ZzI7YGTQa0xvz9hsJOP0WpaxqHbBfugn1b0jblsa3+w6ggrx
         2UW43FJVHFjAkFG78QCYV2CYjo9weKRbdvjfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Op+lE+peIqt26dDx/VwKVZCDK7Fq6lLvamIkunsG6jLJNljEfEHOK3VYX0Y/0gq7kY
         HJ0JNzU8djGGj2CvTueIt4K3Ejy1/ktzY8N+GrfuymO8Wy+Gl7CzE73VdBL6mVicAP+W
         JNx3EpObf2yq34dlQxGMfqQ3m9XOTy1weB/t0=
Received: by 10.213.61.12 with SMTP id r12mr498656ebh.80.1273355194533;
        Sat, 08 May 2010 14:46:34 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm1782464ewy.6.2010.05.08.14.46.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 14:46:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
In-Reply-To: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146676>

This patch has no semantic changes, but makes the next commit easier to
review.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 convert.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index 4f8fcb7..2eef2f6 100644
--- a/convert.c
+++ b/convert.c
@@ -90,12 +90,13 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 }
 
 static void check_safe_crlf(const char *path, int action,
-                            struct text_stat *stats, enum safe_crlf checksafe)
+			    struct text_stat *stats, enum safe_crlf checksafe,
+			    int eol_conversion)
 {
 	if (!checksafe)
 		return;
 
-	if (action == CRLF_INPUT || auto_crlf <= 0) {
+	if (action == CRLF_INPUT || eol_conversion <= 0) {
 		/*
 		 * CRLFs would not be restored by checkout:
 		 * check if we'd remove CRLFs
@@ -106,7 +107,7 @@ static void check_safe_crlf(const char *path, int action,
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("CRLF would be replaced by LF in %s.", path);
 		}
-	} else if (auto_crlf > 0) {
+	} else if (eol_conversion > 0) {
 		/*
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
@@ -121,12 +122,13 @@ static void check_safe_crlf(const char *path, int action,
 }
 
 static int crlf_to_git(const char *path, const char *src, size_t len,
-                       struct strbuf *buf, int action, enum safe_crlf checksafe)
+		       struct strbuf *buf, int action, enum safe_crlf checksafe,
+		       int eol_conversion)
 {
 	struct text_stat stats;
 	char *dst;
 
-	if ((action == CRLF_BINARY) || !auto_crlf || !len)
+	if ((action == CRLF_BINARY) || !eol_conversion || !len)
 		return 0;
 
 	gather_stats(src, len, &stats);
@@ -147,7 +149,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
-	check_safe_crlf(path, action, &stats, checksafe);
+	check_safe_crlf(path, action, &stats, checksafe, eol_conversion);
 
 	/* Optimization: No CR? Nothing to convert, regardless. */
 	if (!stats.cr)
@@ -180,13 +182,13 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 }
 
 static int crlf_to_worktree(const char *path, const char *src, size_t len,
-                            struct strbuf *buf, int action)
+			    struct strbuf *buf, int action, int eol_conversion)
 {
 	char *to_free = NULL;
 	struct text_stat stats;
 
 	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
-	    auto_crlf <= 0)
+	    eol_conversion <= 0)
 		return 0;
 
 	if (!len)
@@ -591,7 +593,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe);
+	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe, auto_crlf);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -621,7 +623,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_worktree(path, src, len, dst, crlf);
+	ret |= crlf_to_worktree(path, src, len, dst, crlf, auto_crlf);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
-- 
1.7.1.3.gb95c9
