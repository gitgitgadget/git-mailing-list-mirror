From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [cgit PATCH] Close file descriptor on error in readfile()
Date: Sat, 7 Nov 2009 18:15:34 +0100
Message-ID: <8c5c35580911070915j7a0100f5sc666b3294bca3941@mail.gmail.com>
References: <4AF4D4EC.1040806@pixeltards.com> <4AF566C9.5090106@pixeltards.com>
	 <8c5c35580911070659h35c44421q713ddba97318e2b8@mail.gmail.com>
	 <m2ocneb9cc.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rys Sommefeldt <rys@pixeltards.com>, git@vger.kernel.org,
	steven@uplinklabs.net
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Nov 07 18:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6ouc-0007Rj-NE
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 18:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbZKGRPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 12:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbZKGRP3
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 12:15:29 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47924 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbZKGRP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 12:15:29 -0500
Received: by yxe17 with SMTP id 17so1663091yxe.33
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 09:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xEdlDLO6XRQAks5StE3DxXK4uPT9XHsDBrsLJ4PgwJg=;
        b=o6zCGXUvEhRrCG4VBg3tBQpQIQIwtllfWB0c8/J6HjolbouLor+8zMxQNL4Iw0bpDi
         w/mvIRPeBMkL/6rQGQSMljZ14ONrUto2Tum2qwm2Ld6IniT0bDVslx+SJxSGdPxJKPkP
         uytqSwxJgdNUxNiCfDJo++YWVZMVPraNpxEDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ri8qVFMClpzVbGTIkpRnV/cS0wZdBmg07rkA29uO7WEnqEA1ONOCk2v786sClWuV4L
         qYfmxjITbUmheXSkNGXK1XCTwBypF1GapIfOMQJFYlrTD4bZZ/LdcODNTKYYWNk735K+
         kBbyVlLUo9t3JcY+JhBZMWyHt4oLF0ttRQchw=
Received: by 10.150.33.5 with SMTP id g5mr10140048ybg.132.1257614134429; Sat, 
	07 Nov 2009 09:15:34 -0800 (PST)
In-Reply-To: <m2ocneb9cc.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132372>

On Sat, Nov 7, 2009 at 17:14, Andreas Schwab <schwab@linux-m68k.org> wr=
ote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> diff --git a/shared.c b/shared.c
>> index d7b2d5a..a27ab30 100644
>> --- a/shared.c
>> +++ b/shared.c
>> @@ -406,12 +406,17 @@ int readfile(const char *path, char **buf, siz=
e_t *size)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D open(path, O_RDONLY);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd =3D=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return errno=
;
>> - =C2=A0 =C2=A0 =C2=A0 if (fstat(fd, &st))
>> + =C2=A0 =C2=A0 =C2=A0 if (fstat(fd, &st)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return errno=
;
>
> The close call can clobber errno.
>
>> - =C2=A0 =C2=A0 =C2=A0 if (!S_ISREG(st.st_mode))
>> + =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 if (!S_ISREG(st.st_mode)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return EISDI=
R;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 *buf =3D xmalloc(st.st_size + 1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D read_in_full(fd, *buf, st.st_s=
ize);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*buf)[*size] =3D '\0';
>> + =C2=A0 =C2=A0 =C2=A0 close(fd);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (*size =3D=3D st.st_size ? 0 : er=
rno);
>
> Likewise.

Thanks for noticing. I've applied the following patch on top of the bad=
 one:

=46rom 21f67e7d82986135922aece6b4ebf410a98705bc Mon Sep 17 00:00:00 200=
1
=46rom: Lars Hjemli <hjemli@gmail.com>
Date: Sat, 7 Nov 2009 18:08:30 +0100
Subject: [PATCH] shared.c: return original errno

Noticed-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 shared.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/shared.c b/shared.c
index a27ab30..9362d21 100644
--- a/shared.c
+++ b/shared.c
@@ -400,15 +400,16 @@ int cgit_close_filter(struct cgit_filter *filter)
  */
 int readfile(const char *path, char **buf, size_t *size)
 {
-       int fd;
+       int fd, e;
        struct stat st;

        fd =3D open(path, O_RDONLY);
        if (fd =3D=3D -1)
                return errno;
        if (fstat(fd, &st)) {
+               e =3D errno;
                close(fd);
-               return errno;
+               return e;
        }
        if (!S_ISREG(st.st_mode)) {
                close(fd);
@@ -416,7 +417,8 @@ int readfile(const char *path, char **buf, size_t *=
size)
        }
        *buf =3D xmalloc(st.st_size + 1);
        *size =3D read_in_full(fd, *buf, st.st_size);
+       e =3D errno;
        (*buf)[*size] =3D '\0';
        close(fd);
-       return (*size =3D=3D st.st_size ? 0 : errno);
+       return (*size =3D=3D st.st_size ? 0 : e);
 }

--=20
larsh
