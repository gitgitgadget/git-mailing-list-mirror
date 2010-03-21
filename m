From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/14] xdl_merge(): move file1 and file2 labels to xmparam
 structure
Date: Sat, 20 Mar 2010 19:35:18 -0500
Message-ID: <20100321003518.GE23681@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:34:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt97a-0007rf-Rf
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab0CUAeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 20:34:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53113 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab0CUAeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:34:19 -0400
Received: by gwaa18 with SMTP id a18so397421gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kbY+pg9HwdGxlYdwP0nbVT6q3B5+HXyB6OUtjiGM3u8=;
        b=mVgptDhojEkc3QThz1UYF/KALWrAh9EVoIX6L8a0Vip/hqSRBWYyXY3oqSmpLEQ6yU
         1Nab2yCH7RwXWPI6kmt86PnolQjbyStVNX2xv8llN8wBJlijHCfPGQ3e6F+fxAkx/3XE
         znMN63+uEgYqK//bFd6rfWJc4AHXO6HOx7dDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IdYlfdyGT/InFjLXs3w/CswMcFLOt1w8821dSXjnr0fpNJj1vE973xNjP9oBp7sJqD
         MuM0uiyFveQfFWLvYaT24acmTkr5BoPmIpMoAAzRnArRgR+gzg3/LlDscuxOxFttg0gG
         J89arlzxZ6SqrmwdNWXE2b2l/HX2Zo6O8/wZM=
Received: by 10.100.245.31 with SMTP id s31mr11822964anh.110.1269131658332;
        Sat, 20 Mar 2010 17:34:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm971257iwn.9.2010.03.20.17.34.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:34:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142772>

The labels for the three participants in a potential conflict are all
optional arguments for the xdiff merge routine; if they are NULL, then
xdl_merge() can cope by omitting the labels from its output.  Move
them to the xmparam structure to allow new callers to save some
keystrokes where they are not needed.

This also has the virtue of making the xdiff merge interface more
similar to merge_trees, which might make it easier to learn.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Applied saved resolution for conflict with commit 560119b (refactor merge
flags into xmparam_t, 2010-03-01).  Thanks for writing rerere!

Previous version is at
<http://thread.gmane.org/gmane.comp.version-control.git/142374/focus=142377>.

 builtin/merge-file.c |    5 +++--
 ll-merge.c           |    4 +++-
 xdiff/xdiff.h        |    5 +++--
 xdiff/xmerge.c       |   19 +++++++++++--------
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 69cc683..65eb790 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -77,8 +77,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 					argv[i]);
 	}
 
-	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xmp, &result);
+	xmp.file1 = names[0];
+	xmp.file2 = names[2];
+	ret = xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/ll-merge.c b/ll-merge.c
index 82c7742..184948d 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -83,7 +83,9 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size = marker_size;
-	return xdl_merge(orig, src1, name1, src2, name2, &xmp, result);
+	xmp.file1 = name1;
+	xmp.file2 = name2;
+	return xdl_merge(orig, src1, src2, &xmp, result);
 }
 
 static int ll_union_merge(const struct ll_merge_driver *drv_unused,
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 6eb5fff..711048e 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -118,12 +118,13 @@ typedef struct s_xmparam {
 	int favor;
 	int style;
 	const char *ancestor;	/* label for orig */
+	const char *file1;	/* label for mf1 */
+	const char *file2;	/* label for mf2 */
 } xmparam_t;
 
 #define DEFAULT_CONFLICT_MARKER_SIZE 7
 
-int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
-		mmfile_t *mf2, const char *name2,
+int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 		xmparam_t const *xmp, mmbuffer_t *result);
 
 #ifdef __cplusplus
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 9fc80ad..16dd9ac 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -407,12 +407,15 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
  *
  * returns < 0 on error, == 0 for no conflicts, else number of conflicts
  */
-static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
-		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
-		xmparam_t const *xmp, mmbuffer_t *result) {
+static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
+		xdfenv_t *xe2, xdchange_t *xscr2,
+		xmparam_t const *xmp, mmbuffer_t *result)
+{
 	xdmerge_t *changes, *c;
 	xpparam_t const *xpp = &xmp->xpp;
 	const char *const ancestor_name = xmp->ancestor;
+	const char *const name1 = xmp->file1;
+	const char *const name2 = xmp->file2;
 	int i0, i1, i2, chg0, chg1, chg2;
 	int level = xmp->level;
 	int style = xmp->style;
@@ -566,9 +569,9 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	return xdl_cleanup_merge(changes);
 }
 
-int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
-		mmfile_t *mf2, const char *name2,
-		xmparam_t const *xmp, mmbuffer_t *result) {
+int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
+		xmparam_t const *xmp, mmbuffer_t *result)
+{
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
 	int status;
@@ -603,8 +606,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		memcpy(result->ptr, mf1->ptr, mf1->size);
 		result->size = mf1->size;
 	} else {
-		status = xdl_do_merge(&xe1, xscr1, name1,
-				      &xe2, xscr2, name2,
+		status = xdl_do_merge(&xe1, xscr1,
+				      &xe2, xscr2,
 				      xmp, result);
 	}
 	xdl_free_script(xscr1);
-- 
1.7.0.2
