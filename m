From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2 5/5] Use kwset in grep
Date: Sun, 28 Aug 2011 13:31:49 +0200
Message-ID: <CALx8hKTuZ5hG6fGUnTbRPLifF=N-SJcfmgYAKUVDO-jgzrKRaA@mail.gmail.com>
References: <20110820223032.12380.72469.stgit@localhost6.localdomain6>
	<20110820224218.GF2199@fredrik-Q430-Q530>
	<4E51F998.50801@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, dpotapov@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 28 13:31:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxdan-0000Zz-6n
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 13:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab1H1Lbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Aug 2011 07:31:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44630 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1H1Lbv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 07:31:51 -0400
Received: by fxh19 with SMTP id 19so3661968fxh.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=08sZ7ym9w+koQ+C3C0ZDVtTRSQAj9vZHzkzk462pBvI=;
        b=Y04xoBWKTVI4Bf4gh63b45kAwqatdbzDi94J2haC3HQTob/mWz0UHq4kCsPKfG9VIo
         7jUSefEmS9HHZ8CaDKYhN+O80a2wTi2jh2IlFCKYB33lO/YDSBS3CvY+yiJRHZnsvjNI
         SQ/aTRhV7I9Yfy0rnCj7PWiNchRkyi3nYnqZw=
Received: by 10.223.39.216 with SMTP id h24mr5146969fae.31.1314531110304; Sun,
 28 Aug 2011 04:31:50 -0700 (PDT)
Received: by 10.223.143.19 with HTTP; Sun, 28 Aug 2011 04:31:49 -0700 (PDT)
In-Reply-To: <4E51F998.50801@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180264>

On Mon, Aug 22, 2011 at 08:39, Paolo Bonzini <bonzini@gnu.org> wrote:
> On 08/21/2011 12:42 AM, Fredrik Kuivinen wrote:
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (opt->regflags& =A0REG_ICASE || p->=
ignore_case) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 static char trans[256]=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i< =A025=
6; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trans[=
i] =3D tolower(i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->kws =3D kwsalloc(tr=
ans);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->kws =3D kwsalloc(NU=
LL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Of course, this makes absolutely no sense for MB_CUR_MAX > 1. =A0It's=
 worth
> mentioning that grep instead uses a loop with mbrtowc/towlower/wcrtom=
b.
> =A0This in turn will remove the need for the complex kwset code. :)

Good catch. At least it is not a regression from the current behavior,
neither our own strcasestr in compat/ nor strcasestr in glibc can
handle MB_CUR_MAX > 1. My original idea was to make use of kwset also
for the case when more than one fixed string is given to git-grep, but
I didn't find a nice way to refactor the code to make that possible.

> The "mbtolower" code" dates to after the license change, but I wrote =
it and
> I give permission to use it under GPLv2. =A0See commits 70e23616 and =
30af8050
> in the GNU grep repository.
>
> Should still be good enough for most uses, so I'll give my
>
> Acked-by: Paolo Bonzini <bonzini@gnu.org>

Thanks.

- Fredrik
