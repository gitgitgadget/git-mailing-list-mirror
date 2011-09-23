From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Bug: git log --numstat counts wrong
Date: Fri, 23 Sep 2011 14:30:40 +0800
Message-ID: <CALUzUxprUFGMR-WVEMOOvYiwkev1cfxHOyBmZq9bKJcHq5E2VA@mail.gmail.com>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
	<7vr53a2icn.fsf@alter.siamese.dyndns.org>
	<3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de>
	<7vobyd1vmo.fsf@alter.siamese.dyndns.org>
	<4E7B5F28.2020204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Pepper <pepper@inf.fu-berlin.de>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Sep 23 08:30:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6zHb-0005Y1-Ih
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 08:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab1IWGam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 02:30:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37156 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab1IWGam convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 02:30:42 -0400
Received: by fxe4 with SMTP id 4so3497591fxe.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 23:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NhF20paR+kRFZvcUfs5t1fjhuxTOaJ/F32I2ehZPRo8=;
        b=YDUFEIopAC3jrPAGeRyDffuxoAELyodAxqvKecBksecEBgSd7KvnvqHtR4dImhAXfX
         SnJ0vXw4IS6DfWI0+A+32Sx00tWtBRyibOsMCB2Z+ql7zFXtom9k8dRksGlk1K9FwR2b
         qrAuJMmUbWpoSD1JEGvACC+B1DJvR5nBOfIoM=
Received: by 10.223.20.18 with SMTP id d18mr4557582fab.102.1316759440607; Thu,
 22 Sep 2011 23:30:40 -0700 (PDT)
Received: by 10.223.79.65 with HTTP; Thu, 22 Sep 2011 23:30:40 -0700 (PDT)
In-Reply-To: <4E7B5F28.2020204@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181945>

On Fri, Sep 23, 2011 at 12:15 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> The patch below reverts a part of 27af01d5523 that's not explained in=
 its
> commit message and doesn't seem to contribute to the intended speedup=
=2E =A0It
> seems to restore the original diff output. =A0I don't know how it's a=
ctually
> doing that, though, as I haven't dug into the code at all.
>
> [snip]
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 5a33d1a..e419f4f 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -383,7 +383,7 @@ static int xdl_clean_mmatch(char const *dis, long=
 i, long s, long e) {
> =A0* might be potentially discarded if they happear in a run of disca=
rdable.
> =A0*/
> =A0static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1=
, xdfile_t *xdf2) {
> - =A0 =A0 =A0 long i, nm, nreff;
> + =A0 =A0 =A0 long i, nm, nreff, mlim;
> =A0 =A0 =A0 =A0xrecord_t **recs;
> =A0 =A0 =A0 =A0xdlclass_t *rcrec;
> =A0 =A0 =A0 =A0char *dis, *dis1, *dis2;
> @@ -396,16 +396,20 @@ static int xdl_cleanup_records(xdlclassifier_t =
*cf, xdfile_t *xdf1, xdfile_t *xd
> =A0 =A0 =A0 =A0dis1 =3D dis;
> =A0 =A0 =A0 =A0dis2 =3D dis1 + xdf1->nrec + 1;
>
> + =A0 =A0 =A0 if ((mlim =3D xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIM=
IT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mlim =3D XDL_MAX_EQLIMIT;
> =A0 =A0 =A0 =A0for (i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->ds=
tart]; i <=3D xdf1->dend; i++, recs++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rcrec =3D cf->rcrecs[(*recs)->ha];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nm =3D rcrec ? rcrec->len2 : 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dis1[i] =3D (nm =3D=3D 0) ? 0: 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dis1[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D=
 mlim) ? 2: 1;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if ((mlim =3D xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIM=
IT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mlim =3D XDL_MAX_EQLIMIT;
> =A0 =A0 =A0 =A0for (i =3D xdf2->dstart, recs =3D &xdf2->recs[xdf2->ds=
tart]; i <=3D xdf2->dend; i++, recs++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rcrec =3D cf->rcrecs[(*recs)->ha];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nm =3D rcrec ? rcrec->len1 : 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dis2[i] =3D (nm =3D=3D 0) ? 0: 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dis2[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D=
 mlim) ? 2: 1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (nreff =3D 0, i =3D xdf1->dstart, recs =3D &xdf1->=
recs[xdf1->dstart];
>
>
>

Thanks for the patch, Ren=E9.

Sorry for not explaining that part of the change.

My understanding of mlim is that it "caps" how deep the for loop at
around line 387 goes through a hash bucket/record chaing to find a
matching record from side A in side B (and vice-versa in a later
loop), probably to prevent running time from becoming too long.

But with 27af01d, this is no longer a concern. We can get an *exact*,
pre-computed count of matching records in the other side, so we don't
have go through the hash bucket. Thus mlim is no longer needed.

So re-introducing mlim doesn't seem right, even though it may fix this
"bug" (ie restore the old behaviour).

--=20
Cheers,
Ray Chuan
