From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/14] xdl_merge(): add optional ancestor label to
 diff3-style output
Date: Sat, 20 Mar 2010 19:31:44 -0500
Message-ID: <20100321003144.GD23681@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:30:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt949-0006nQ-LG
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab0CUAas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:30:48 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:62826 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab0CUAar (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:30:47 -0400
Received: by yxe12 with SMTP id 12so1194972yxe.33
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Q5oLjU2+FOQs8HM62DpTfAHg7STVEMltWyvQx8ySvMg=;
        b=DBdvqE9bUVexhHIadvDmuZKhIR8zqvcoN/wnC+CZn+aaDbTLEofe4Cv1lrUmU/evO4
         oc58Q9B8YFei68Vaz3StT4o85MGzWP0LZBaJxBuz7jNa02n40qhjlKcP552FhTgBCKIk
         J8KxKUeB5dJwPgEy6/M/mrE6C1Gxrh1ssWtiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wrEtJ2B8f1oif4npPCF3UJu81dSHr7hNDbXrzzcx+nadUSQU9Zm2HdXC+8x3k+ycT1
         yjEAuh2w/NF67phOEdeKLasDN8iEhq6ceYSrtoa8MXgmc0HcPhJoNRv/eik+aPL8GnjH
         dHtdhubvVbPP6GfJta//pUCdYEnk+PuyCoCUw=
Received: by 10.101.164.32 with SMTP id r32mr11897340ano.178.1269131444608;
        Sat, 20 Mar 2010 17:30:44 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm970966iwn.13.2010.03.20.17.30.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:30:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142771>

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

If xmp->ancestor is NULL, the output format is unchanged.  Thus, this
change only provides unexposed plumbing for the new feature; it does
not affect the outward behavior of git.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Bert Wesarg <Bert.Wesarg@googlemail.com>
---
Small stylistic change:

	const char *const ancestor_name =3D xmp->ancestor;

as suggested in
<http://thread.gmane.org/gmane.comp.version-control.git/142374/focus=3D=
142393>.

 xdiff/xdiff.h  |    1 +
 xdiff/xmerge.c |   16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index a71763a..6eb5fff 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -117,6 +117,7 @@ typedef struct s_xmparam {
 	int level;
 	int favor;
 	int style;
+	const char *ancestor;	/* label for orig */
 } xmparam_t;
=20
 #define DEFAULT_CONFLICT_MARKER_SIZE 7
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 87cafa7..9fc80ad 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -145,11 +145,13 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int=
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
@@ -179,10 +181,15 @@ static int fill_conflict_hunk(xdfenv_t *xe1, cons=
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
@@ -217,6 +224,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const =
char *name1,
=20
 static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 				 xdfenv_t *xe2, const char *name2,
+				 const char *ancestor_name,
 				 int favor,
 				 xdmerge_t *m, char *dest, int style,
 				 int marker_size)
@@ -229,6 +237,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, con=
st char *name1,
=20
 		if (m->mode =3D=3D 0)
 			size =3D fill_conflict_hunk(xe1, name1, xe2, name2,
+						  ancestor_name,
 						  size, i, style, m, dest,
 						  marker_size);
 		else if (m->mode & 3) {
@@ -403,6 +412,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *=
xscr1, const char *name1,
 		xmparam_t const *xmp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
 	xpparam_t const *xpp =3D &xmp->xpp;
+	const char *const ancestor_name =3D xmp->ancestor;
 	int i0, i1, i2, chg0, chg1, chg2;
 	int level =3D xmp->level;
 	int style =3D xmp->style;
@@ -540,6 +550,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *=
xscr1, const char *name1,
 	if (result) {
 		int marker_size =3D xmp->marker_size;
 		int size =3D xdl_fill_merge_buffer(xe1, name1, xe2, name2,
+						 ancestor_name,
 						 favor, changes, NULL, style,
 						 marker_size);
 		result->ptr =3D xdl_malloc(size);
@@ -548,7 +559,8 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *=
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
1.7.0.2
