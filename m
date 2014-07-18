From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Make locked paths absolute when current directory is
 changed
Date: Fri, 18 Jul 2014 22:44:07 +0200
Message-ID: <53C98717.3060600@kdbg.org>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 22:44:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8F0r-0006Pf-3k
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 22:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762178AbaGRUoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 16:44:12 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:56725 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756032AbaGRUoM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 16:44:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1032A1300AB;
	Fri, 18 Jul 2014 22:44:09 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4FFE119F47C;
	Fri, 18 Jul 2014 22:44:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253845>

Am 18.07.2014 15:08, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> diff --git a/lockfile.c b/lockfile.c
> index 8fbcb6a..a70d107 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -280,3 +280,19 @@ void rollback_lock_file(struct lock_file *lk)
>  	}
>  	lk->filename[0] =3D 0;
>  }
> +
> +void make_locked_paths_absolute(void)
> +{
> +	struct lock_file *lk;
> +	const char *abspath;
> +	for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
> +		if (!lk->filename[0] || lk->filename[0] =3D=3D '/')

Please use is_absolute_path().

> +			continue;
> +		abspath =3D absolute_path(lk->filename);
> +		if (strlen(abspath) >=3D sizeof(lk->filename))
> +			warning("locked path %s is relative when current directory "
> +				"is changed", lk->filename);
> +		else
> +			strcpy(lk->filename, abspath);
> +	}
> +}

> --- a/run-command.c
> +++ b/run-command.c
> @@ -399,7 +399,7 @@ fail_pipe:
>  			close(cmd->out);
>  		}
> =20
> -		if (cmd->dir && chdir(cmd->dir))
> +		if (cmd->dir && chdir_safe(cmd->dir))

This one shouldn't be necessary: It's in the child, and the child
process does not release the locks; see the check for the owner in
remove_lock_file.

>  			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
>  			    cmd->dir);
>  		if (cmd->env) {

-- Hannes
