From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline
	'Subject:' header
Date: Thu, 8 Jan 2009 01:43:42 +0300
Organization: St.Petersburg State University
Message-ID: <20090107224342.GB4946@roro3>
References: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 23:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKh7x-0000o4-Id
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 23:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbZAGWm3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 17:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbZAGWm3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 17:42:29 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1173 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZAGWm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 17:42:28 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id C3F3E17B65E; Thu,  8 Jan 2009 01:42:26 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LKh7m-0003TR-Pz; Thu, 08 Jan 2009 01:43:42 +0300
Content-Disposition: inline
In-Reply-To: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104841>

On Fri, Dec 26, 2008 at 09:38:41PM +0300, Kirill Smelkov wrote:
> When native language (RU) is in use, subject header usually contains =
several
> parts, e.g.
>=20
> Subject: [Navy-patches] [PATCH]
> 	=3D?utf-8?b?0JjQt9C80LXQvdGR0L0g0YHQv9C40YHQvtC6INC/0LA=3D?=3D
> 	=3D?utf-8?b?0LrQtdGC0L7QsiDQvdC10L7QsdGF0L7QtNC40LzRi9GFINC00LvRjyA=3D=
?=3D
> 	=3D?utf-8?b?0YHQsdC+0YDQutC4?=3D

Which btw should be extracted by git-mailinfo to:

    'Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=
=B8=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=
=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=
=D1=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8'

> This exposes several bugs in builtin-mailinfo.c that I try to fix:
>=20
>=20
> 1. decode_b_segment: do not append explicit NUL -- explicit NUL was p=
reventing
>    correct header construction on parts concatenation via strbuf_addb=
uf in
>    decode_header_bq. Fixes:
>=20
> -Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8
> +Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0
>=20
>=20
> Then
>=20
> 2. (hackish) do not emit '\n' after processing of every header segmen=
t. It
>    seems we should emit previous part as-is only if it does not end w=
ith
>    '=3D?=3D'. Fixes:
>=20
> -Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8
> +Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0 =D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8
>=20
>=20
> Sorry for low-quality patch and description. I did what I could and d=
on't have
> energy and time dig more into MIME.
>=20
> Please help.
>=20
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
>=20
> ---
>  builtin-mailinfo.c  |   18 ++++++++++++++++-
>  t/t5100-mailinfo.sh |    2 +-
>  t/t5100/info0012    |    5 ++++
>  t/t5100/msg0012     |    7 ++++++
>  t/t5100/patch0012   |   30 +++++++++++++++++++++++++++++
>  t/t5100/sample.mbox |   52 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  6 files changed, 112 insertions(+), 2 deletions(-)

Junio, All,

What about this patch?

It at least exposes bug in git-mailinfo wrt handling of multiline
subjects, and in very details documents it and adds a test for it.


Yes, my fixes are of 'low quality', but may I try to attract git
community attention one more time?


Thanks beforehand,
Kirill


P.S. original post with patch:

http://marc.info/?l=3Dgit&m=3D123031899307286&w=3D2
