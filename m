From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] Guard memory overwriting in resolve_ref's static buffer
Date: Sun, 11 Dec 2011 16:22:12 +0700
Message-ID: <CACsJy8BRs2Xh5AgibyW=X41cSDVAzMDo3xXSjSpkm5wyKeYN=A@mail.gmail.com>
References: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
 <1323521631-24320-2-git-send-email-pclouds@gmail.com> <20111210211040.GB24817@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tony Wang <wwwjfy@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 10:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZfcW-0005LN-57
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 10:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab1LKJWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Dec 2011 04:22:48 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54675 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1LKJWo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2011 04:22:44 -0500
Received: by bkcjm19 with SMTP id jm19so444303bkc.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=D/CPmc97kYJJhG9wqr+Jc5t1M7MGtTmFaZl4bpm2Pzs=;
        b=TegyALz0IOSJiy0N2rKWFNO+Wp4YzdvRzxvpXkZ5vczKeuxP/UkBR7FmYY/vPEG1al
         SoSCM72o4k/jhuNS/mvmeXYTOsRwM/nuDAzsBXMEURgpkQTmXaxAyi3I/jOFdv4o8F26
         KMne9xmMsWx7IfvY6JHJQRRpy8jY2AQ9ROLNI=
Received: by 10.204.128.130 with SMTP id k2mr7272621bks.7.1323595363245; Sun,
 11 Dec 2011 01:22:43 -0800 (PST)
Received: by 10.204.129.205 with HTTP; Sun, 11 Dec 2011 01:22:12 -0800 (PST)
In-Reply-To: <20111210211040.GB24817@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186800>

2011/12/11 Jonathan Nieder <jrnieder@gmail.com>:
>> =C2=A0- Rely on mmap/mprotect to catch illegal access. We need valgr=
ind or
>> =C2=A0 =C2=A0some other memory tracking tool to reliably catch this =
in Michael's
>> =C2=A0 =C2=A0approach.
>
> I wonder if the lower-tech approach would be so bad in practice. =C2=A0=
On
> systems using glibc, if MALLOC_PERTURB_ is set, then the value will
> always be clobbered on free(). =C2=A0It would be possible to do the s=
ame
> explicitly in resolve_ref() for platforms without such a feature.

Clobbered value may be carried around for some time before the code
detects wrong value. It'd be hard to track back where the root cause
is.

>> =C2=A0- Because mprotect is used instead of munmap, we definitely le=
ak
>> =C2=A0 =C2=A0memory. Hopefully callers will not put resolve_ref() in=
 a
>> =C2=A0 =C2=A0loop that runs 1 million times.
>
> Have you measured the performance impact when GIT_DEBUG_MEMCHECK is n=
ot
> set? =C2=A0(I don't expect major problems, but sometimes code surpris=
es me.)

No. I wish we had a performance test suite. Which use cases should I te=
st?

> [...]
>> Also introduce a new target, "make memcheck", that runs tests with t=
his
>> flag on.
>
> Neat. =C2=A0Did it catch any bugs?

No, otherwise I would have sent more patches ;)

>> --- a/cache.h
>> +++ b/cache.h
>> @@ -865,7 +865,8 @@ extern int read_ref(const char *filename, unsign=
ed char *sha1);
>> =C2=A0 *
>> =C2=A0 * errno is sometimes set on errors, but not always.
>> =C2=A0 */
>> -extern const char *resolve_ref(const char *ref, unsigned char *sha1=
, int reading, int *flag);
>> +#define resolve_ref(ref, sha1, reading, flag) resolve_ref_real(ref,=
 sha1, reading, flag, __FUNCTION__, __LINE__)
>
> __FUNCTION__ is nonstandard, though it's probably supported pretty
> widely and we can do
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#ifndef __FUNCTION__
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#define __FUNCTION__ something-else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#endif
>
> in git-compat-util.h when we discover a platform that doesn't support
> it if needed. =C2=A0__func__ was introduced in C99. =C2=A0__LINE__ an=
d __FILE__
> should work everywhere.

Will change to __FILE__ then

>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -60,6 +60,28 @@ void *xmallocz(size_t size)
>> =C2=A0 =C2=A0 =C2=A0 return ret;
>> =C2=A0}
>>
>> +void *xmalloc_mmap(size_t size, const char *file, int line)
>> +{
>> + =C2=A0 =C2=A0 int *ret;
>> + =C2=A0 =C2=A0 size +=3D sizeof(int*) * 3;
>> + =C2=A0 =C2=A0 ret =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_ANONYMO=
US | MAP_PRIVATE, -1, 0);
>> + =C2=A0 =C2=A0 if (ret =3D=3D (int*)-1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno("unable to mma=
p %lu bytes anonymously",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (unsigned long)size);
>> +
>> + =C2=A0 =C2=A0 ret[0] =3D (int)file;
>> + =C2=A0 =C2=A0 ret[1] =3D line;
>> + =C2=A0 =C2=A0 ret[2] =3D size;
>> + =C2=A0 =C2=A0 return ret + 3;
>
> Would this work on 64-bit platforms?

No idea (I'm on 32-bit). I don't see any reasons why it would not
work. But that function may cause unaligned access, I think.

> How does one retrieve the line and file number? =C2=A0I guess one is
> expected to retrieve them from the core dump, but a few words of
> advice in Documentation/technical would be helpful.

from coredump.
--=20
Duy
