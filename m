From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 3/4] enter_repo: do not modify input
Date: Fri, 30 Sep 2011 21:00:00 +0200
Message-ID: <4E8611B0.7020709@lsrfire.ath.cx>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com> <1317329963-6656-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 21:00:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9iJp-0008Tr-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 21:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682Ab1I3TAO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 15:00:14 -0400
Received: from india601.server4you.de ([85.25.151.105]:55557 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531Ab1I3TAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 15:00:13 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id B40452F803A;
	Fri, 30 Sep 2011 21:00:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <1317329963-6656-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182502>

Am 29.09.2011 22:59, schrieb Erik Faye-Lund:
> diff --git a/path.c b/path.c
> index 6f3f5d5..f7dfd0b 100644
> --- a/path.c
> +++ b/path.c
> @@ -283,7 +283,7 @@ return_null:
>   * links.  User relative paths are also returned as they are given,
>   * except DWIM suffixing.
>   */
> -char *enter_repo(char *path, int strict)
> +const char *enter_repo(const char *path, int strict)
>  {
>  	static char used_path[PATH_MAX];
>  	static char validated_path[PATH_MAX];
> @@ -297,14 +297,15 @@ char *enter_repo(char *path, int strict)
>  		};
>  		int len =3D strlen(path);
>  		int i;
> -		while ((1 < len) && (path[len-1] =3D=3D '/')) {
> -			path[len-1] =3D 0;
> +		while ((1 < len) && (path[len-1] =3D=3D '/'))
>  			len--;
> -		}
> +
>  		if (PATH_MAX <=3D len)
>  			return NULL;
> -		if (path[0] =3D=3D '~') {
> -			char *newpath =3D expand_user_path(path);
> +		strncpy(used_path, path, len);
> +
> +		if (used_path[0] =3D=3D '~') {
> +			char *newpath =3D expand_user_path(used_path);
>  			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
>  				free(newpath);
>  				return NULL;
> @@ -316,24 +317,21 @@ char *enter_repo(char *path, int strict)
>  			 * anyway.
>  			 */
>  			strcpy(used_path, newpath); free(newpath);
> -			strcpy(validated_path, path);
> -			path =3D used_path;
> +			strcpy(validated_path, used_path);
>  		}
>  		else if (PATH_MAX - 10 < len)
>  			return NULL;
> -		else {
> -			path =3D strcpy(used_path, path);
> -			strcpy(validated_path, path);
> -		}
> -		len =3D strlen(path);
> +		else
> +			strcpy(validated_path, used_path);
> +		len =3D strlen(used_path);
>  		for (i =3D 0; suffix[i]; i++) {
> -			strcpy(path + len, suffix[i]);
> -			if (!access(path, F_OK)) {
> +			strcpy(used_path + len, suffix[i]);
> +			if (!access(used_path, F_OK)) {
>  				strcat(validated_path, suffix[i]);
>  				break;
>  			}
>  		}
> -		if (!suffix[i] || chdir(path))
> +		if (!suffix[i] || chdir(used_path))
>  			return NULL;
>  		path =3D validated_path;
>  	}

The use of strcpy and strncpy makes me nervous, but I can't spot a bug
currently and strcpy and even strcat calls had been already in there
before your patch.

Ren=E9
