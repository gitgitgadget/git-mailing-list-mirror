From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] send-pack: don't send a thin pack to a server which
 doesn't support it
Date: Sat, 23 Nov 2013 17:17:29 +0100
Message-ID: <1385223449.2665.21.camel@centaur.cmartin.tk>
References: <1385222875-13369-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jrnieder@gmail.com, pclouds@gmail.com,
	spearce@spearce.org, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 23 17:17:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkFu1-0008Eg-R4
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 17:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab3KWQRb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Nov 2013 11:17:31 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:57443 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922Ab3KWQRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 11:17:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id E6BCFDE05B;
	Sat, 23 Nov 2013 17:17:29 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gHVxQcaVCYp4; Sat, 23 Nov 2013 17:17:29 +0100 (CET)
Received: from [192.168.1.4] (p57A1F0F3.dip0.t-ipconnect.de [87.161.240.243])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 9A345DE056;
	Sat, 23 Nov 2013 17:17:29 +0100 (CET)
In-Reply-To: <1385222875-13369-1-git-send-email-cmn@elego.de>
X-Mailer: Evolution 3.8.5-2+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238237>

On Sat, 2013-11-23 at 17:07 +0100, Carlos Mart=C3=ADn Nieto wrote:
> Up to now git has assumed that all servers are able to fix thin
> packs. This is however not always the case.
>=20
> Document the 'no-thin' capability and prevent send-pack from generati=
ng
> a thin pack if the server advertises it.

Sorry,

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

> ---
>=20
> This is a re-roll of the series I sent earlier this month, switching
> it around by adding the "no-thin"=20
>=20
>  Documentation/technical/protocol-capabilities.txt | 20 +++++++++++++=
++-----
>  send-pack.c                                       |  2 ++
>  2 files changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Docu=
mentation/technical/protocol-capabilities.txt
> index fd8ffa5..3a75e79 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -72,15 +72,25 @@ interleaved with S-R-Q.
>  thin-pack
>  ---------
> =20
> -This capability means that the server can send a 'thin' pack, a pack
> -which does not contain base objects; if those base objects are avail=
able
> -on client side. Client requests 'thin-pack' capability when it
> -understands how to "thicken" it by adding required delta bases makin=
g
> -it self-contained.
> +A thin pack is one with deltas which reference base objects not
> +contained within the pack (but are known to exist at the receiving
> +end). This can reduce the network traffic significantly, but it
> +requires the receiving end to know how to "thicken" these packs by
> +adding the missing bases to the pack.
> +
> +The upload-pack server advertises 'thin-pack' when it can generate a=
nd
> +send a thin pack. The receive-pack server advertises 'no-thin' if
> +it does not know how to "thicken" the pack it receives.
> +
> +A client requests the 'thin-pack' capability when it understands how
> +to "thicken" it.
> =20
>  Client MUST NOT request 'thin-pack' capability if it cannot turn a t=
hin
>  pack into a self-contained pack.
> =20
> +Client MUST NOT send a thin pack if the server advertises the
> +'no-thin' capability.
> +
> =20
>  side-band, side-band-64k
>  ------------------------
> diff --git a/send-pack.c b/send-pack.c
> index 7d172ef..9877eb9 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -205,6 +205,8 @@ int send_pack(struct send_pack_args *args,
>  		quiet_supported =3D 1;
>  	if (server_supports("agent"))
>  		agent_supported =3D 1;
> +	if (server_supports("no-thin"))
> +		args->use_thin_pack =3D 0;
> =20
>  	if (!remote_refs) {
>  		fprintf(stderr, "No refs in common and none specified; doing nothi=
ng.\n"
