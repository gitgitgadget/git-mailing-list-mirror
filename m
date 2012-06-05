From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv4] Read (but not write) from XDG configuration, XDG
 attributes and XDG ignore files
Date: Tue, 05 Jun 2012 14:19:16 +0200
Message-ID: <20120605141916.Horde.wKnrT3wdC4BPzflEUfYiRPA@webmail.minatec.grenoble-inp.fr>
References: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <4FCCF63B.8070609@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nguyenhu@ensibm.imag.fr, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jun 05 14:19:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbsjP-0001HZ-QB
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 14:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934020Ab2FEMTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 08:19:20 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:45473 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932623Ab2FEMTT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 08:19:19 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id B06711A0275;
	Tue,  5 Jun 2012 14:19:16 +0200 (CEST)
Received: from wifi-030246.grenet.fr (wifi-030246.grenet.fr
 [130.190.30.246]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Tue, 05 Jun 2012 14:19:16 +0200
In-Reply-To: <4FCCF63B.8070609@ramsay1.demon.co.uk>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199234>


Ramsay Jones <ramsay@ramsay1.demon.co.uk> a =E9crit=A0:
>
> So, this re-introduces the bug addressed by commit 05bab3ea. The test=
 number
> is now 29 (rather than 21) but the same test is failing; namely =20
> t3200-branch.sh
> test #29 (git branch -m q q2 without config should succeed).
>
> In order to fix the bug, I created the patch given below (on top of =20
> this patch).
> (Note that it does not address the above issues).
>
> HTH
>
> ATB,
> Ramsay Jones
>
> -- >8 --
> From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Subject: [PATCH] path.c: Fix a static buffer overwrite bug by =20
> avoiding mkpath()
>
> The v4 version of the "Read (but not write) from XDG configuration,
> XDG attributes and XDG ignore files" patch, re-introduced the bug
> addressed by commit 05bab3ea ("config.c: Fix a static buffer overwrit=
e
> bug by avoiding mkpath()", 19-11-2011). Note that the patch refactore=
d
> the code to determine the user (or home) configuration filename into
> a new function (home_config_paths()). In doing so, the new code once
> again uses mkpath() rather than mksnpath().
>
> In order to fix the bug, we introduce a new variation of the mkpath()
> function, mkpathdup(), which avoids the use of the internal static
> buffers. As the name implies, the new function returns a pointer to
> the pathname as a dynamically allocated string. It is the callers
> responsibility to free the memory for the returned string.
>
> Having introduced the new function, we can now replace the calls to
> 'xstrdup(mkpath(...))' in the home_config_paths() function with a
> call to mkpathdup() to achieve the same effect, without tickling the
> original bug.
>
> (Also, note that the 'xstrdup(mkpath(...))' pattern occurs in several
> other places in the source ...)
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  cache.h |    2 ++
>  path.c  |   20 +++++++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 0632503..fbba2d6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -619,6 +619,8 @@ extern char *git_snpath(char *buf, size_t n, =20
> const char *fmt, ...)
>  	__attribute__((format (printf, 3, 4)));
>  extern char *git_pathdup(const char *fmt, ...)
>  	__attribute__((format (printf, 1, 2)));
> +extern char *mkpathdup(const char *fmt, ...)
> +	__attribute__((format (printf, 1, 2)));
>
>  /* Return a statically allocated filename matching the sha1 signatur=
e */
>  extern char *mkpath(const char *fmt, ...) __attribute__((format =20
> (printf, 1, 2)));
> diff --git a/path.c b/path.c
> index 53f3f53..ca29bdd 100644
> --- a/path.c
> +++ b/path.c
> @@ -87,6 +87,20 @@ char *git_pathdup(const char *fmt, ...)
>  	return xstrdup(path);
>  }
>
> +char *mkpathdup(const char *fmt, ...)
> +{
> +	char path[PATH_MAX];
> +	va_list args;
> +	unsigned len;
> +
> +	va_start(args, fmt);
> +	len =3D vsnprintf(path, sizeof(path), fmt, args);
> +	va_end(args);
> +	if (len >=3D sizeof(path))
> +		return xstrdup(bad_path);
> +	return xstrdup(cleanup_path(path));
> +}
> +
>  char *mkpath(const char *fmt, ...)
>  {
>  	va_list args;
> @@ -133,17 +147,17 @@ void home_config_paths(char **global, char =20
> **xdg, char *file)
>  			*global =3D NULL;
>  	} else {
>  		if (!xdg_home) {
> -			to_free =3D strdup(mkpath("%s/.config", home));
> +			to_free =3D mkpathdup("%s/.config", home);
>  			xdg_home =3D to_free;
>  		}
>  		if (global)
> -			*global =3D xstrdup(mkpath("%s/.gitconfig", home));
> +			*global =3D mkpathdup("%s/.gitconfig", home);
>  	}
>
>  	if (!xdg_home)
>  		*xdg =3D NULL;
>  	else
> -		*xdg =3D xstrdup(mkpath("%s/git/%s", xdg_home, file));
> +		*xdg =3D mkpathdup("%s/git/%s", xdg_home, file);
>
>  	free(to_free);
>  }
> --
> 1.7.10
>

Thank you for having fixed this bug we have re-introduced with your =20
patch, we will add your modifications in our next v6 version.
