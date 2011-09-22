From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Bug: git log --numstat counts wrong
Date: Thu, 22 Sep 2011 18:15:36 +0200
Message-ID: <4E7B5F28.2020204@lsrfire.ath.cx>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de> <7vr53a2icn.fsf@alter.siamese.dyndns.org> <3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de> <7vobyd1vmo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 18:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6lwk-0003xY-GO
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 18:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab1IVQQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 12:16:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:43979 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab1IVQQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 12:16:02 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R6lwO-0003oE-Mt
	for git@vger.kernel.org; Thu, 22 Sep 2011 18:16:00 +0200
Received: from p579be4d8.dip.t-dialin.net ([87.155.228.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:16:00 +0200
Received: from rene.scharfe by p579be4d8.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:16:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p579be4d8.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <7vobyd1vmo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181898>

Am 21.09.2011 22:35, schrieb Junio C Hamano:
> Alexander Pepper <pepper@inf.fu-berlin.de> writes:
>=20
>> Am 21.09.2011 um 14:24 schrieb Junio C Hamano:
>>>> $ git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
>>>> [...]
>>>> 11      10      src/java/voldemort/server/storage/StorageService.j=
ava
>>>
>>> Didn't we update it this already? I seem to get 10/9 here not 11/10=
=2E
>>
>> Current 'maint' (cd2b8ae9), 'master' (4b5eac7f)...
>=20
> That's a tad old master you seem to have.
>=20
> Strangely, bisection points at 27af01d5523, which was supposed to be =
only
> about performance and never about correctness. There is something fis=
hy
> going on....

The patch below reverts a part of 27af01d5523 that's not explained in i=
ts
commit message and doesn't seem to contribute to the intended speedup. =
 It
seems to restore the original diff output.  I don't know how it's actua=
lly
doing that, though, as I haven't dug into the code at all.

Alexander, can you confirm that this patch restores the old behaviour o=
f
git diff and git show for your test cases?

Ray, are you able to write a commit message for this patch if it turns =
out
to be useful?

Ren=E9


diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 5a33d1a..e419f4f 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -383,7 +383,7 @@ static int xdl_clean_mmatch(char const *dis, long i=
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
@@ -396,16 +396,20 @@ static int xdl_cleanup_records(xdlclassifier_t *c=
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
