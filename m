From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 13:08:37 +0000
Message-ID: <57518fd10712200508x4b15f9acy10aed83a3cebeba@mail.gmail.com>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	 <20071219184457.GC3015@steel.home>
	 <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
	 <4769A7FB.1070904@lsrfire.ath.cx>
	 <57518fd10712200244o656c7f44j426cc71c89515de3@mail.gmail.com>
	 <476A5DFF.40803@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 20 14:09:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5L93-00038z-H9
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 14:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757780AbXLTNIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 08:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbXLTNIi
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 08:08:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:56888 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbXLTNIi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 08:08:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3038631rvb.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 05:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=aldPRffk2SvKT8d6ftEo0P0xfjhxXLSWMZ7DB3F3Fiw=;
        b=RKG3TemDTzRTq5kBJrQYdrg5L7zP7CsJPrcF14kR//n4Lyh4a0yS+yXV7jij/gRZRXyqzViEr7RHbYHQlxyPl8JGiJbNoItyo0felAyBxXilFxfCQ6T+hzEpuQ9l8/76cx6LarV+B8dFlaigf2tC1btUlMp5EiCgyzDTmSjx6eE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kkelLHiEGvSMAgE44mxEGEgMaKVOaALTapdxqov/fXqFyDGa/YXKJ1lhbeuds2cSXlxSXcvLN6xu+MNxtPerjk3sy5vEqU7JaqLII1tzpbR7xxr5KJ83r4f/pIjLuJQeecNrA5gqG4lfZTnCi1A4D2SJsq1vV6Cs8Qm2TERWEi4=
Received: by 10.141.141.3 with SMTP id t3mr3458938rvn.52.1198156117319;
        Thu, 20 Dec 2007 05:08:37 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Thu, 20 Dec 2007 05:08:37 -0800 (PST)
In-Reply-To: <476A5DFF.40803@lsrfire.ath.cx>
Content-Disposition: inline
X-Google-Sender-Auth: f8c0158a9cdeca20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69004>

On Dec 20, 2007 12:20 PM, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> =
wrote:
> Jonathan del Strother schrieb:
> > On Dec 19, 2007 11:23 PM, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.=
cx> wrote:
> >> Just a shot in the dark: does this patch on top of master make a d=
ifference?
> > No luck with that, I'm afraid.
>
> And how is this one?
>
> The first chunk is the same as in the last try -- it guards against c=
ommit
> messages ending with a NUL without a prior \n _and_ being followed by=
 a \n
> (in memory which shouldn't be accessed by us at all as it doesn't bel=
ong to
> the commit message).  I guess that's quite rare.
>
> The second chunk keeps the body offset from being incremented by the =
for
> loop if we've already found a terminating NUL.
>
> diff --git a/pretty.c b/pretty.c
> index 9db75b4..5b1078b 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -412,7 +412,7 @@ static void parse_commit_header(struct format_com=
mit_context *context)
>                 if (i =3D=3D eol) {
>                         state++;
>                         /* strip empty lines */
> -                       while (msg[eol + 1] =3D=3D '\n')
> +                       while (msg[eol] =3D=3D '\n' && msg[eol + 1] =3D=
=3D '\n')
>                                 eol++;
>                 } else if (!prefixcmp(msg + i, "author ")) {
>                         context->author.off =3D i + 7;
> @@ -425,6 +425,8 @@ static void parse_commit_header(struct format_com=
mit_context *context)
>                         context->encoding.len =3D eol - i - 9;
>                 }
>                 i =3D eol;
> +               if (!msg[i])
> +                       break;
>         }
>         context->body_off =3D i;
>         context->commit_header_parsed =3D 1;
>

Winnar!

Yep, that seems to have fixed things.  Wonder how I managed to get the
null into the commit message...
