From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] Revert removal of multi-match discard heuristic in 27af01
Date: Sun, 25 Sep 2011 21:39:08 +0800
Message-ID: <1316957948-1908-1-git-send-email-rctay89@gmail.com>
References: <4E7B5F28.2020204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 25 15:39:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7ovQ-0000fR-2p
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 15:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab1IYNjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 09:39:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60303 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab1IYNjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 09:39:15 -0400
Received: by gyg10 with SMTP id 10so3552755gyg.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q/z2TO7ZxYnqc40Gz89Fnhm5cgnO61YXhQftmPs0rwU=;
        b=h9TybMF0jqfbI/QcP6i/+AQNZlkSZ0hmYqoU1BkQKYUgPYXBwGcxH3zxWoakSAUZ/P
         t8M5urAc9MF8SJHepRw+M3yj9L8rxE/et/GmfWLx959csLjHWmaylgpQLFzkgyz/382G
         rq5wpPYw873qv5Uu4tyWl/QJQzUeZdacOVcok=
Received: by 10.68.22.195 with SMTP id g3mr3712814pbf.108.1316957954104;
        Sun, 25 Sep 2011 06:39:14 -0700 (PDT)
Received: from localhost ([137.132.17.19])
        by mx.google.com with ESMTPS id p9sm21432131pbq.12.2011.09.25.06.39.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Sep 2011 06:39:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <4E7B5F28.2020204@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182071>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

27af01d (xdiff/xprepare: improve O(n*m) performance in
xdl_cleanup_records(), 2011-08-17) was supposed to be a performance
boost only. However, it unexpectedly changed the behaviour of diff.

Revert a part of 27af01d that removes logic that mark lines as
"multi-match" (ie. dis[i] =3D=3D 2). This was preventing the multi-matc=
h
discard heuristic (performed in xdl_cleanup_records() and
xdl_clean_mmatch()) from executing.

Reported-by: Alexander Pepper <pepper@inf.fu-berlin.de>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

---

Junio, this replaces the patch the one in the
'rs/diff-cleanup-records-fix' topic in 'pu'. The only difference is in
the patch message.

Ren=C3=A9, will need your SOB on this. Thanks for working to produce th=
e
patch. Please disregard my earlier message [1], further reading has
shown my previous understanding to be wrong.

[1] <CALUzUxprUFGMR-WVEMOOvYiwkev1cfxHOyBmZq9bKJcHq5E2VA@mail.gmail.com=
>
---
 xdiff/xprepare.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 05a8f01..4c447ca 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -398,7 +398,7 @@ static int xdl_clean_mmatch(char const *dis, long i=
, long s, long e) {
  * might be potentially discarded if they happear in a run of discarda=
ble.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xd=
file_t *xdf2) {
-	long i, nm, nreff;
+	long i, nm, nreff, mlim;
 	xrecord_t **recs;
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
@@ -411,16 +411,20 @@ static int xdl_cleanup_records(xdlclassifier_t *c=
f, xdfile_t *xdf1, xdfile_t *xd
 	dis1 =3D dis;
 	dis2 =3D dis1 + xdf1->nrec + 1;
=20
+	if ((mlim =3D xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
+		mlim =3D XDL_MAX_EQLIMIT;
 	for (i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->dstart]; i <=3D x=
df1->dend; i++, recs++) {
 		rcrec =3D cf->rcrecs[(*recs)->ha];
 		nm =3D rcrec ? rcrec->len2 : 0;
-		dis1[i] =3D (nm =3D=3D 0) ? 0: 1;
+		dis1[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D mlim) ? 2: 1;
 	}
=20
+	if ((mlim =3D xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
+		mlim =3D XDL_MAX_EQLIMIT;
 	for (i =3D xdf2->dstart, recs =3D &xdf2->recs[xdf2->dstart]; i <=3D x=
df2->dend; i++, recs++) {
 		rcrec =3D cf->rcrecs[(*recs)->ha];
 		nm =3D rcrec ? rcrec->len1 : 0;
-		dis2[i] =3D (nm =3D=3D 0) ? 0: 1;
+		dis2[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D mlim) ? 2: 1;
 	}
=20
 	for (nreff =3D 0, i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->dsta=
rt];
--=20
1.7.7.rc3.432.g6bcf0
