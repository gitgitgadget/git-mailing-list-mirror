From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/10] xdl_merge(): add optional ancestor label to
 diff3-style output
Date: Mon, 15 Mar 2010 02:49:09 -0500
Message-ID: <20100315074909.GA8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 08:49:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr535-00067S-Nc
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 08:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935644Ab0COHtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 03:49:11 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:51065 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933904Ab0COHtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 03:49:09 -0400
Received: by gxk27 with SMTP id 27so387913gxk.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+0JGeE8dVnryzpRdzGIkmg1kUdeNDqJDFxAnifPReBE=;
        b=d6g7jaIfOID+/IhgYwqEUZRdUknd9AtDAppNpd514vILH731nbL3viIDm5SINiuDDE
         I7+0Nrkk+6wsRJ0XSz0EitdQ3wyljKKGfS1A8Xng/25fha9P+VVAnjKvxYNg1sKHCLJp
         WojoHW5P73w4y78VxYfivk4NBpCScsWckkMa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PrH0Bmg8PIDX9gZqGNyL3fYGlXekGXt/swk2CHOzd9ngmM41uo0BBu/Mc5zicc6xFD
         cBXWYwRQGsHmSC07bpSduuMqrVvodlSZGgW2zwBK/85qjFkjQBD7jrCDRs3kQPk+l5N6
         +ALQ1vVdTWg9l2Z3VhiD4WtX+XMT6DS+6NEL0=
Received: by 10.150.46.30 with SMTP id t30mr2902910ybt.286.1268639348509;
        Mon, 15 Mar 2010 00:49:08 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4032245iwn.0.2010.03.15.00.49.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 00:49:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142177>

The =E2=80=98git checkout --conflict=3Ddiff3=E2=80=99 command can be us=
ed to
present conflicts hunks including text from the common ancestor:

	<<<<<<< ours
	ourside
	|||||||
	original
	=3D=3D=3D=3D=3D=3D=3D
	theirside
	>>>>>>> theirs

The added information is helpful for resolving merges by hand, and
merge tools can usually grok it because it is very similar to the
output from diff3 -m.

A subtle change can help more tools to understand the output.  =E2=80=98=
diff3=E2=80=99
includes the name of the merge base on the ||||||| line of the output,
and some tools misparse the conflict hunks without it.  Add a new
xmp->ancestor parameter to xdl_merge() for use with conflict style
XDL_MERGE_DIFF3 as a label on the ||||||| line for any conflict hunks.

If xmp->ancestor is NULL, the output format is unchanged.  =E2=80=98git
checkout=E2=80=99 and other users within git all use NULL for this para=
meter,
so this change only provides unexposed plumbing for a fix: it does not
affect the outward behavior of git in any way.

Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 xdiff/xdiff.h  |    1 +
 xdiff/xmerge.c |   16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 3f6229e..abaf960 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -117,6 +117,7 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_=
t const *xpp,
 typedef struct s_xmparam {
 	xpparam_t xpp;
 	int marker_size;
+	const char *ancestor;
 } xmparam_t;
=20
 #define DEFAULT_CONFLICT_MARKER_SIZE 7
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 8cbe45e..3a0ae14 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -144,11 +144,13 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int=
 count, int add_nl, char *dest)
=20
 static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      xdfenv_t *xe2, const char *name2,
+			      const char *name3,
 			      int size, int i, int style,
 			      xdmerge_t *m, char *dest, int marker_size)
 {
 	int marker1_size =3D (name1 ? strlen(name1) + 1 : 0);
 	int marker2_size =3D (name2 ? strlen(name2) + 1 : 0);
+	int marker3_size =3D (name3 ? strlen(name3) + 1 : 0);
 	int j;
=20
 	if (marker_size <=3D 0)
@@ -178,10 +180,15 @@ static int fill_conflict_hunk(xdfenv_t *xe1, cons=
t char *name1,
 	if (style =3D=3D XDL_MERGE_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
-			size +=3D marker_size + 1;
+			size +=3D marker_size + 1 + marker3_size;
 		} else {
 			for (j =3D 0; j < marker_size; j++)
 				dest[size++] =3D '|';
+			if (marker3_size) {
+				dest[size] =3D ' ';
+				memcpy(dest + size + 1, name3, marker3_size - 1);
+				size +=3D marker3_size;
+			}
 			dest[size++] =3D '\n';
 		}
 		size +=3D xdl_orig_copy(xe1, m->i0, m->chg0, 1,
@@ -216,6 +223,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const =
char *name1,
=20
 static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 				 xdfenv_t *xe2, const char *name2,
+				 const char *ancestor_name,
 				 int favor,
 				 xdmerge_t *m, char *dest, int style,
 				 int marker_size)
@@ -228,6 +236,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, con=
st char *name1,
=20
 		if (m->mode =3D=3D 0)
 			size =3D fill_conflict_hunk(xe1, name1, xe2, name2,
+						  ancestor_name,
 						  size, i, style, m, dest,
 						  marker_size);
 		else if (m->mode =3D=3D 1)
@@ -397,6 +406,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *=
xscr1, const char *name1,
 		int flags, xmparam_t const *xmp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
 	xpparam_t const *xpp =3D &xmp->xpp;
+	const char * const ancestor_name =3D xmp->ancestor;
 	int i0, i1, i2, chg0, chg1, chg2;
 	int level =3D flags & XDL_MERGE_LEVEL_MASK;
 	int style =3D flags & XDL_MERGE_STYLE_MASK;
@@ -534,6 +544,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *=
xscr1, const char *name1,
 	if (result) {
 		int marker_size =3D xmp->marker_size;
 		int size =3D xdl_fill_merge_buffer(xe1, name1, xe2, name2,
+						 ancestor_name,
 						 favor, changes, NULL, style,
 						 marker_size);
 		result->ptr =3D xdl_malloc(size);
@@ -542,7 +553,8 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *=
xscr1, const char *name1,
 			return -1;
 		}
 		result->size =3D size;
-		xdl_fill_merge_buffer(xe1, name1, xe2, name2, favor, changes,
+		xdl_fill_merge_buffer(xe1, name1, xe2, name2,
+				      ancestor_name, favor, changes,
 				      result->ptr, style, marker_size);
 	}
 	return xdl_cleanup_merge(changes);
--=20
1.7.0
