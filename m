From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] tag: support --sort=<spec>
Date: Wed, 26 Feb 2014 18:03:40 +0700
Message-ID: <CACsJy8CW9p-PDJC9zXBwXrxOk9GhBFk1nVtG1Xn76g3FN+KgaA@mail.gmail.com>
References: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
 <1393330935-22229-1-git-send-email-pclouds@gmail.com> <20140226090511.GA32537@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:04:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcHj-0004nu-VF
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaBZLEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 06:04:12 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52806 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbaBZLEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 06:04:10 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so380865qcv.33
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=P/bcVw3AUQq629d+8wvJupNj1JkO/fojcvNMufvXNTA=;
        b=04dmqXJpaf5rZ3AumNuuaDhtPwkC/qf2ljtuCrd3ZklDnORDeuzaEFp7VhzwTiOIJk
         O7+W3p+32QHjK/mi7FGB3syEWU/Xm15FQ37Op+5UQc5BCSYHXvKMLbrpe5VKjBAGtgjn
         RrANo0af1JUI0GxnF/tmuecV5OgrECL4fMDmISpCNpyJKmy8seEwo4pPCm+qPJ2kqNwa
         04Jg0ULHVPmB77z4u7/km/1P9uqnHl8u1arxDCuF7CHTaUZEIbCfB0uFZJ7Q0hoy/V5S
         9FT9z35On9K0XBWtSAQERVKXqtzW1LjICV6PLL4oOlSWKUk5ZQ9GRxnZNpLov9D1skz7
         DXVw==
X-Received: by 10.140.47.212 with SMTP id m78mr6338506qga.21.1393412650093;
 Wed, 26 Feb 2014 03:04:10 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 03:03:40 -0800 (PST)
In-Reply-To: <20140226090511.GA32537@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242716>

On Wed, Feb 26, 2014 at 4:05 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 25, 2014 at 07:22:15PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> versioncmp() is copied from string/strverscmp.c in glibc commit
>> ee9247c38a8def24a59eb5cfb7196a98bef8cfdc, reformatted to Git coding
>> style. The implementation is under LGPL-2.1 and according to [1] I c=
an
>> relicense it to GPLv2.
>
> Cool. I think doing this makes the most sense, as we do not have to
> worry about build-time config (and I do not see any particular reason
> why we would want to use the system strverscmp on glibc systems).

Another reason I want to stay away from glibc is I want to fix the
algorithm to sort YY-preXX and YY-rcXX before YY. There could be
reasons that glibc might reject such a change even if it makes sense
in our context. Even if we make it to newer glibc and fix compat
version, people on older glibc will not receive the fix while people
on compat do. Not so good.

>> +static int parse_opt_sort(const struct option *opt, const char *arg=
, int unset)
>> +{
>> +     int *sort =3D opt->value;
>> +     if (*arg =3D=3D '-') {
>> +             *sort =3D REVERSE_SORT;
>> +             arg++;
>> +     } else
>> +             *sort =3D STRCMP_SORT;
>> +     if (starts_with(arg, "version:")) {
>> +             *sort |=3D VERCMP_SORT;
>> +             arg +=3D 8;
>> +     } else if (starts_with(arg, "v:")) {
>> +             *sort |=3D VERCMP_SORT;
>> +             arg +=3D 2;
>> +     }
>> +     if (strcmp(arg, "refname"))
>> +             die(_("unsupported sort specification %s"), arg);
>
> I found this logic a bit weird, as STRCMP_SORT and VERCMP_SORT are no=
t
> mutually exclusive flags, but REVERSE and STRCMP are. I would have
> thought REVERSE is the flag, and the other two are selections. Like:
>
>   int flags =3D 0;
>
>   if (*arg =3D=3D '-') {
>           flags |=3D REVERSE_SORT;
>           arg++;
>   }
>   if (starts_with(arg, "version:")) {
>           *sort =3D VERCMP_SORT;
>           arg +=3D 8;
>   } else
>           *sort =3D STRCMP_SORT;
>
>   *sort |=3D flags;
>
> I think they end up doing the same thing, but maybe I am missing
> something.

No you're not. I did not make it absolute beautiful because I expected
it to be deleted soon after you polish your f-e-r series. Will resend
with this change shortly.
--=20
Duy
