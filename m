From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 03/13] parseopt: make OPT_INTEGER support hexadecimal
 as well
Date: Sat, 4 Feb 2012 13:15:56 +0700
Message-ID: <CACsJy8Db44OVC7+BEbp7hdbO8+3ZysCKPkwoTJyhLFvcLaF90g@mail.gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-4-git-send-email-pclouds@gmail.com> <7vaa4zmsku.fsf@alter.siamese.dyndns.org>
 <CACsJy8Ba2qxyT4XqeRmUv63Z3rT1-FmBkZ3tB6YMh6qrXjLP1Q@mail.gmail.com> <7vobtfjh9d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:16:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtYvg-0007Hb-2g
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 07:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab2BDGQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 01:16:28 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60516 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2BDGQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 01:16:27 -0500
Received: by bkcjm19 with SMTP id jm19so3607014bkc.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 22:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XCubEoNxF+ftQMPIPsnQJ0JVWb4ODFsr2E7BDKSw0fY=;
        b=dzwoIzU5FwuD3GDvb/TyFfFbRdBDZNyr71p1CirdVCIxYxP1ARFeWH2kqbKeFP+5wJ
         49r9lu3ny9CZB7KPNabIYwp9B8Ogxkltr7NutOHMwiRnpc7i7pgjsHOP5852POz9EgUe
         F5PIGUdsapQAhaEKXW6ErJRzEX/XS1NqE6WbY=
Received: by 10.204.129.203 with SMTP id p11mr4690698bks.109.1328336186422;
 Fri, 03 Feb 2012 22:16:26 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Fri, 3 Feb 2012 22:15:56 -0800 (PST)
In-Reply-To: <7vobtfjh9d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189847>

On Sat, Feb 4, 2012 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> 2012/2/4 Junio C Hamano <gitster@pobox.com>:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com>=
 writes:
>>>
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *(int *)opt->value =3D=
 strtol(arg, (char **)&s, 10);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(arg, "0=
x") || !prefixcmp(arg, "0X"))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *(int *)opt->value =3D strtol(arg + 2, (char **)&s, 16);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *(int *)opt->value =3D strtol(arg, (char **)&s, 10);
>>>
>>> Can't you just do "strtol(arg, (char **)&s, 0)" instead?
>>
>> I could but that means "01234" is now in base 8 and that's currently
>> accepted as base 10.
>
> Yes, but I wonder if that is a problem in practice. Who in the right =
mind
> would give 00001000 to tell git that they want one thousand?

That could come from a script, extracting info from a source (maybe a
log file) and not stripping leading zeros. If we go this route, I
think we should have one release that rejects such numbers first. If
nobody complains, then we proceed and allow octal in the next release.
--=20
Duy
