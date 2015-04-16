From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 17:10:02 +0200
Message-ID: <1429197002.3097.16.camel@elego.de>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 17:17:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YilXv-0006N7-CP
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbbDPPRe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2015 11:17:34 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:40490 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbbDPPRd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 11:17:33 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2015 11:17:33 EDT
Received: from centaur.local (p57A97B07.dip0.t-ipconnect.de [87.169.123.7])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id F37F4DE730
	for <git@vger.kernel.org>; Thu, 16 Apr 2015 17:10:02 +0200 (CEST)
In-Reply-To: <1429193112-41184-1-git-send-email-cmn@elego.de>
X-Mailer: Evolution 3.12.9-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267294>

On Thu, 2015-04-16 at 16:05 +0200, Carlos Mart=C3=ADn Nieto wrote:
> Some text editors like Notepad or LibreOffice write an UTF-8 BOM in
> order to indicate that the file is Unicode text rather than whatever =
the
> current locale would indicate.
>=20
> If someone uses such an editor to edit a gitignore file, we are left
> with those three bytes at the beginning of the file. If we do not ski=
p
> them, we will attempt to match a filename with the BOM as prefix, whi=
ch
> won't match the files the user is expecting.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

which I keep forgetting.

>=20
> ---
>=20
> If you're wondering how I came up with LibreOffice, I was doing a
> workshop recently and one of the participants was not content with th=
e
> choice of vim or nano, so he opened LibreOffice to edit the gitignore
> file with confusing consequences.
>=20
> This codepath doesn't go as far as the config code in validating that
> we do not have a partial BOM which would mean there's some invalid
> content, but we don't really have invalid content any other way, as
> we're just dealing with a list of paths in the file.
>=20
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
> +	if (size >=3D 3 && !memcmp(buf, utf8_bom, 3))
> +		entry =3D buf + 3;
> +	else
> +		entry =3D buf;
> +
>  	for (i =3D 0; i < size; i++) {
>  		if (buf[i] =3D=3D '\n') {
>  			if (entry !=3D buf + i && entry[0] !=3D '#') {
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index 460789b..0a06fbf 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -13,6 +13,8 @@ EOF
> =20
>  test_expect_success 'status untracked directory with --ignored' '
>  	echo "ignored" >.gitignore &&
> +	sed -e "s/^/\xef\xbb\xbf/" .gitignore >.gitignore.new &&
> +	mv .gitignore.new .gitignore &&
>  	mkdir untracked &&
>  	: >untracked/ignored &&
>  	: >untracked/uncommitted &&
