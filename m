From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 18:10:45 +0200
Message-ID: <552FDF05.4060000@web.de>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?windows-1252?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 18:10:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YimNU-00060C-N9
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 18:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbbDPQKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2015 12:10:53 -0400
Received: from mout.web.de ([212.227.15.3]:53560 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbbDPQKv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 12:10:51 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0Ly7vR-1ZTbkJ41XJ-015b8Z; Thu, 16 Apr 2015 18:10:48
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1429193112-41184-1-git-send-email-cmn@elego.de>
X-Provags-ID: V03:K0:TT+byLxJoexx+SbR6j/EWv9f3VavMptevTnX4+kkRfv8vpcjiQ8
 E4kOQFrRVMkrcHOXaZ3m3F0MwTLr7olAqvscvQNe7ULsC2Kz3menQZbFZJfYGitULDh+9FX
 dNa/55P9A8SWM9uxq4r4as9BzZbNPVCpKi1QTZzwVkwTUh/csVxqVJpIWtbMcTGT031mXo9
 X7vKTOZ8EvO0e8HddsM/Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267305>

On 2015-04-16 16.05, Carlos Mart=EDn Nieto wrote:
[]
May be it is easier to move this into an own function, like remove_utf8=
_bom() ?

>  dir.c                      | 8 +++++++-
>  t/t7061-wtstatus-ignore.sh | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/dir.c b/dir.c
> index 0943a81..6368247 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -581,6 +581,7 @@ int add_excludes_from_file_to_list(const char *fn=
ame,
>  	struct stat st;
>  	int fd, i, lineno =3D 1;
>  	size_t size =3D 0;
> +	static const unsigned char *utf8_bom =3D (unsigned char *) "\xef\xb=
b\xbf";
Do we really need to cast here (and if, is the cast dropping the "const=
" ?)

Another suggestion, see below:
either:
	static const size_t bom_len =3D 3;
or
	static const size_t bom_len =3D strlen(utf8_bom);

>  	char *buf, *entry;
> =20
>  	fd =3D open(fname, O_RDONLY);
> @@ -617,7 +618,12 @@ int add_excludes_from_file_to_list(const char *f=
name,
>  	}
> =20
>  	el->filebuf =3D buf;
> -	entry =3D buf;
> +
And now we can avoid magic numbers:
	if (size >=3D bom_len && !memcmp(buf, utf8_bom, bom_len))
		entry =3D buf + bom_len;
	else
		entry =3D buf;
[]
