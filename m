From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH V3] git clone: is an URL local or ssh
Date: Wed, 30 Oct 2013 08:11:49 +0100
Message-ID: <5270B135.8030501@viscovery.net>
References: <201310292207.50869.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, peff@peff.net, pclouds@gmail.com
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 30 08:11:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPwa-0001xu-FM
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab3J3HLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 03:11:52 -0400
Received: from so.liwest.at ([212.33.55.16]:20630 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301Ab3J3HLw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 03:11:52 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VbPwU-0000Xb-08; Wed, 30 Oct 2013 08:11:50 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AE2CF16613;
	Wed, 30 Oct 2013 08:11:49 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <201310292207.50869.tboegi@web.de>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236992>

Am 10/29/2013 22:07, schrieb Torsten B=C3=B6gershausen:
> @@ -610,17 +623,17 @@ struct child_process *git_connect(int fd[2], co=
nst char *url_orig,
>  	} else
>  		end =3D host;
> =20
> -	path =3D strchr(end, c);
> -	if (path && !has_dos_drive_prefix(end)) {
> -		if (c =3D=3D ':') {
> -			if (host !=3D url || path < strchrnul(host, '/')) {
> -				protocol =3D PROTO_SSH;
> -				*path++ =3D '\0';
> -			} else /* '/' in the host part, assume local path */
> -				path =3D end;
> +	path =3D strchr(end, separator);
> +	if (separator =3D=3D ':') {
> +		if (path && protocol =3D=3D PROTO_LOCAL_OR_SSH) {
> +			/* We have a ':' */
> +			protocol =3D PROTO_SSH;
> +			*path++ =3D '\0';
> +		} else {/* assume local path */
> +			protocol =3D PROTO_LOCAL;
> +			path =3D end;
>  		}
> -	} else
> -		path =3D end;
> +	}
> =20
>  	if (!path || !*path)
>  		die("No path specified. See 'man git-pull' for valid url syntax");

This hunk breaks on Windows. You removed the has_dos_drive_prefix check=
=2E

The check for has_dos_drive_prefix check must happen *before* you furth=
er
investigate the path/url/host for ssh protocol, and if it returns true,
then the path is local, no matter what follows.

-- Hannes
