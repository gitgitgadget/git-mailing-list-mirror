From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/16] xdl_merge(): move file1 and file2 labels to xmparam
 structure
Date: Wed, 17 Mar 2010 06:53:16 -0500
Message-ID: <20100317115316.GB25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 12:54:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrrpC-0007bx-Ju
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 12:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab0CQLwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 07:52:54 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:62201 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab0CQLwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 07:52:53 -0400
Received: by gxk9 with SMTP id 9so539519gxk.8
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FrLjzxSKLw22olh/n36+iO9V7S80OyfNZ16NHKJdRWk=;
        b=p4qQEFzMvYULrYQAPA2DN/WESiTfQYtJScv2HQAMVRDT54q3xGiAcxbUsyvhIfhW48
         ZO70dV5xjFhc4CZ9q10LNDkMb1fxRWSH5bFsy1QoU1wgf5eq8dFXIf7ZCyBN1vLKdC3k
         Mzt2/4AXJG9u2nOjMv4WNLbvZhRciDQRpIxFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Yove5QJk+LroIDhX4fyRcrQ+b0X2I2tbgn7zOydZHYqnbPqJvUxEXtUauqlntx8jvb
         7w/qMFdW+DX5kKf3hpsSivLzYBTSPR0V0CJOpasR5vqlTiuPhb5xf52Q4EwI1iKBLSMo
         BoOqBFE7VrPmBNifDYvDNDq4Iqr0cJBZUhXvU=
Received: by 10.150.128.41 with SMTP id a41mr5234590ybd.245.1268826771852;
        Wed, 17 Mar 2010 04:52:51 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6275154iwn.11.2010.03.17.04.52.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 04:52:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142377>

The labels for the three participants in a potential conflict are all
optional arguments for the xdiff merge routine; if they are NULL, then
xdl_merge() can cope by omitting the labels from its output.  Move
them to the xmparam structure to allow new callers to save some
keystrokes where they are not needed.

This also has the virtue of making the xdiff merge interface more
similar to merge_trees, which might make it easier to learn.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks to Junio for the idea.  I was worried for a moment that
this might be a step in the wrong direction: aren=E2=80=99t all existin=
g
xmparam_t members the sort of thing that would be the same over
multiple merges?  That is true but not really relevant.

This has interactions of the =E2=80=9Cnonconflicting changes on adjacen=
t lines=E2=80=9D
kind with commit 560119b (refactor merge flags into xmparam_t,
2010-03-01) in next.

 builtin/merge-file.c |    6 ++++--
 ll-merge.c           |    8 ++++----
 xdiff/xdiff.h        |    5 +++--
 xdiff/xmerge.c       |   13 +++++++------
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 1e70073..ade1e8b 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -72,8 +72,10 @@ int cmd_merge_file(int argc, const char **argv, cons=
t char *prefix)
 					argv[i]);
 	}
=20
-	ret =3D xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xmp, XDL_MERGE_FLAGS(level, style, favor), &result);
+	xmp.file1 =3D names[0];
+	xmp.file2 =3D names[2];
+	ret =3D xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp,
+			XDL_MERGE_FLAGS(level, style, favor), &result);
=20
 	for (i =3D 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/ll-merge.c b/ll-merge.c
index 4c7f11b..b8e8971 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -83,10 +83,10 @@ static int ll_xdl_merge(const struct ll_merge_drive=
r *drv_unused,
 		style =3D git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size =3D marker_size;
-	return xdl_merge(orig,
-			 src1, name1,
-			 src2, name2,
-			 &xmp, XDL_MERGE_FLAGS(XDL_MERGE_ZEALOUS, style, favor),
+	xmp.file1 =3D name1;
+	xmp.file2 =3D name2;
+	return xdl_merge(orig, src1, src2, &xmp,
+			 XDL_MERGE_FLAGS(XDL_MERGE_ZEALOUS, style, favor),
 			 result);
 }
=20
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index fd89b9a..82d7fc7 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -118,12 +118,13 @@ typedef struct s_xmparam {
 	xpparam_t xpp;
 	int marker_size;
 	const char *ancestor;	/* label for orig */
+	const char *file1;	/* label for mf1 */
+	const char *file2;	/* label for mf2 */
 } xmparam_t;
=20
 #define DEFAULT_CONFLICT_MARKER_SIZE 7
=20
-int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
-		mmfile_t *mf2, const char *name2,
+int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 		xmparam_t const *xmp, int flags, mmbuffer_t *result);
=20
 #ifdef __cplusplus
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 3a0ae14..241f7ba 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -401,12 +401,14 @@ static int xdl_simplify_non_conflicts(xdfenv_t *x=
e1, xdmerge_t *m,
  *
  * returns < 0 on error, =3D=3D 0 for no conflicts, else number of con=
flicts
  */
-static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *=
name1,
-		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
+static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
+		xdfenv_t *xe2, xdchange_t *xscr2,
 		int flags, xmparam_t const *xmp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
 	xpparam_t const *xpp =3D &xmp->xpp;
 	const char * const ancestor_name =3D xmp->ancestor;
+	const char * const name1 =3D xmp->file1;
+	const char * const name2 =3D xmp->file2;
 	int i0, i1, i2, chg0, chg1, chg2;
 	int level =3D flags & XDL_MERGE_LEVEL_MASK;
 	int style =3D flags & XDL_MERGE_STYLE_MASK;
@@ -560,8 +562,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *=
xscr1, const char *name1,
 	return xdl_cleanup_merge(changes);
 }
=20
-int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
-		mmfile_t *mf2, const char *name2,
+int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 		xmparam_t const *xmp, int flags, mmbuffer_t *result) {
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
@@ -597,8 +598,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const =
char *name1,
 		memcpy(result->ptr, mf1->ptr, mf1->size);
 		result->size =3D mf1->size;
 	} else {
-		status =3D xdl_do_merge(&xe1, xscr1, name1,
-				      &xe2, xscr2, name2,
+		status =3D xdl_do_merge(&xe1, xscr1,
+				      &xe2, xscr2,
 				      flags, xmp, result);
 	}
 	xdl_free_script(xscr1);
--=20
1.7.0
