From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/4] make union merge an xdl merge favor
Date: Mon,  1 Mar 2010 22:46:25 +0100
Message-ID: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:46:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDRo-0000bo-3w
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab0CAVqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:46:35 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:46151 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab0CAVqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:46:34 -0500
Received: by bwz4 with SMTP id 4so2233909bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oAll/krtmBJtJCwXaKoEi6eaCH+Uxop20j6084ZBs54=;
        b=AWjhjTJsldwBB5I9FrBzM1LsEAaW4ZMJ5O0cFabk5hDAOGkJpm1BgrsDZnUlU/M6Em
         GZCEhtOgztP0mlabecwBM4/LzJS5EjttTR9EcGnJWkI92C7FLUEAKGgt7UbuOnosEeH5
         OY8nVvfwEvrzWIcwMQ/dMzv3Uwg4a/ewJ1Jl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ltX2kYJjNnoVy8JWuLIVzU6am1KYHpwQec9YmQvpgCYJ7d4eioNTEzFqcSDYaIUuAw
         BN3ORdmVvJng2qT52xFWv8P1/xG5lsnSAO7w+ciw120BBrQ3OwkwmIXqf92tXq/1py0Q
         dPy3GvkiXkKQz0NTyg2K9v9nuskJbzwrYtczc=
Received: by 10.204.29.10 with SMTP id o10mr3538271bkc.82.1267479991491;
        Mon, 01 Mar 2010 13:46:31 -0800 (PST)
Received: from localhost (drsd-4dbd936b.pool.mediaWays.net [77.189.147.107])
        by mx.google.com with ESMTPS id s17sm927393bkd.12.2010.03.01.13.46.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 13:46:31 -0800 (PST)
X-Mailer: git-send-email 1.7.0.584.g2da2b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141356>

The current union merge driver is implemented as an post process.  But the
xdl_merge code is quite capable to produce the result by itself.  Therefore
move it there.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 ll-merge.c     |   43 +++++--------------------------------------
 xdiff/xdiff.h  |    1 +
 xdiff/xmerge.c |   20 +++++++++++++-------
 3 files changed, 19 insertions(+), 45 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 4c7f11b..a4b2f4c 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -98,44 +98,11 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmfile_t *src2, const char *name2,
 			  int flag, int marker_size)
 {
-	char *src, *dst;
-	long size;
-	int status, saved_style;
-
-	/* We have to force the RCS "merge" style */
-	saved_style = git_xmerge_style;
-	git_xmerge_style = 0;
-	status = ll_xdl_merge(drv_unused, result, path_unused,
-			      orig, src1, NULL, src2, NULL,
-			      flag, marker_size);
-	git_xmerge_style = saved_style;
-	if (status <= 0)
-		return status;
-	size = result->size;
-	src = dst = result->ptr;
-	while (size) {
-		char ch;
-		if ((marker_size < size) &&
-		    (*src == '<' || *src == '=' || *src == '>')) {
-			int i;
-			ch = *src;
-			for (i = 0; i < marker_size; i++)
-				if (src[i] != ch)
-					goto not_a_marker;
-			if (src[marker_size] != '\n')
-				goto not_a_marker;
-			src += marker_size + 1;
-			size -= marker_size + 1;
-			continue;
-		}
-	not_a_marker:
-		do {
-			ch = *src++;
-			*dst++ = ch;
-			size--;
-		} while (ch != '\n' && size);
-	}
-	result->size = dst - result->ptr;
+	/* Use union favor */
+	flag = (flag & 1) | (XDL_MERGE_FAVOR_UNION << 1);
+	return ll_xdl_merge(drv_unused, result, path_unused,
+			    orig, src1, NULL, src2, NULL,
+			    flag, marker_size);
 	return 0;
 }
 
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 3f6229e..22614d5 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -61,6 +61,7 @@ extern "C" {
 /* merge favor modes */
 #define XDL_MERGE_FAVOR_OURS 1
 #define XDL_MERGE_FAVOR_THEIRS 2
+#define XDL_MERGE_FAVOR_UNION 3
 #define XDL_MERGE_FAVOR(flags) (((flags)>>4) & 3)
 #define XDL_MERGE_FLAGS(level, style, favor) ((level)|(style)|((favor)<<4))
 
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 8cbe45e..c901ecb 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -28,6 +28,7 @@ typedef struct s_xdmerge {
 	 * 0 = conflict,
 	 * 1 = no conflict, take first,
 	 * 2 = no conflict, take second.
+	 * 3 = no conflict, take both.
 	 */
 	int mode;
 	/*
@@ -230,14 +231,19 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 			size = fill_conflict_hunk(xe1, name1, xe2, name2,
 						  size, i, style, m, dest,
 						  marker_size);
-		else if (m->mode == 1)
-			size += xdl_recs_copy(xe1, i, m->i1 + m->chg1 - i, 0,
+		else if (m->mode & 3) {
+			/* Before conflicting part */
+			size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
 					      dest ? dest + size : NULL);
-		else if (m->mode == 2)
-			size += xdl_recs_copy(xe2, m->i2 - m->i1 + i,
-					      m->i1 + m->chg2 - i, 0,
-					      dest ? dest + size : NULL);
-		else
+			/* Postimage from side #1 */
+			if (m->mode & 1)
+				size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
+						      dest ? dest + size : NULL);
+			/* Postimage from side #2 */
+			if (m->mode & 2)
+				size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
+						      dest ? dest + size : NULL);
+		} else
 			continue;
 		i = m->i1 + m->chg1;
 	}
-- 
1.7.0.584.g2da2b
