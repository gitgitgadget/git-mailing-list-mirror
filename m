From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: Re: git-send-email: bug with sendemail.multiedit
Date: Tue, 10 Jan 2012 09:23:59 -0500
Message-ID: <B281FA72-A179-4782-A439-02A71B1C61BF@gmail.com>
References: <1AC16B4B-8376-4A50-A900-BB8E704FAB82@gmail.com> <20120109225542.GB9902@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, pierre.habouzit@m4x.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 15:19:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkcXm-0001vi-Dk
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 15:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab2AJOTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 09:19:13 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36200 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab2AJOTM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 09:19:12 -0500
Received: by qats34 with SMTP id s34so1641651qat.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        bh=IAjeTiuuKK8e8zEGdjEtg/KMJW+NnNOiunxfLOjW8wc=;
        b=u8v4TsUOnjkO3X5VlZsBPvMGFEbwjqD3smY9cpUFlfZr4wzTq4b/+AvtahUDpKn00y
         NTnDyc+2z9e4i8iUBuDIEzu3O+FTNp938s3qr9EoQPJeTySbvokXai/T+7pi4kFoZh9U
         9T2RnXkd2y1ez7YNiE8yTK+6EdbuZ2TsjjGOw=
Received: by 10.224.197.73 with SMTP id ej9mr24942346qab.30.1326205151828;
        Tue, 10 Jan 2012 06:19:11 -0800 (PST)
Received: from jfdmac.sonatest.net (modemcable066.15-37-24.static.videotron.ca. [24.37.15.66])
        by mx.google.com with ESMTPS id dx7sm130536769qab.3.2012.01.10.06.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 06:19:10 -0800 (PST)
In-Reply-To: <20120109225542.GB9902@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188251>

Tested with 0/1/true/false, all works as expected, i.e. fix is backward=
 compatible.
git version 1.7.8.2

On Jan 9, 2012, at 17:55, Jeff King wrote:

> On Mon, Jan 09, 2012 at 02:09:30PM -0500, Jean-Francois Dagenais wrot=
e:
>=20
>> I think there is a bug with git-send-email.perl's evaluation of the
>> sendemail.multiedit config variable.
>>=20
>> I was only able to make the "do_edit()" function detect it as false =
by
>> setting the variable to "0" instead of "false", like so:
>=20
> I think it's this:
>=20
> -- >8 --
> Subject: [PATCH] send-email: multiedit is a boolean config option
>=20
> The sendemail.multiedit variable is meant to be a boolean.
> However, it is not marked as such in the code, which means
> we store its value literally. Thus in the do_edit function,
> perl ends up coercing it to a boolean value according to
> perl rules, not git rules. This works for "0", but "false",
> "no", or "off" will erroneously be interpreted as true.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
Tested-by: Jean-Fran=E7ois Dagenais <jeff.dagenais@gmail.com>
> ---
> git-send-email.perl |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index d491db9..ef30c55 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -210,6 +210,7 @@ my %config_bool_settings =3D (
>     "signedoffbycc" =3D> [\$signed_off_by_cc, undef],
>     "signedoffcc" =3D> [\$signed_off_by_cc, undef],      # Deprecated
>     "validate" =3D> [\$validate, 1],
> +    "multiedit" =3D> [\$multiedit, undef]
> );
>=20
> my %config_settings =3D (
> @@ -227,7 +228,6 @@ my %config_settings =3D (
>     "bcc" =3D> \@bcclist,
>     "suppresscc" =3D> \@suppress_cc,
>     "envelopesender" =3D> \$envelope_sender,
> -    "multiedit" =3D> \$multiedit,
>     "confirm"   =3D> \$confirm,
>     "from" =3D> \$sender,
>     "assume8bitencoding" =3D> \$auto_8bit_encoding,
> --=20
> 1.7.8
>=20
