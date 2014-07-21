From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 2/2] Make locked paths absolute when current directory
 is changed
Date: Mon, 21 Jul 2014 14:27:05 +0100
Message-ID: <53CD1529.9080102@ramsay1.demon.co.uk>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com> <1405858399-23082-1-git-send-email-pclouds@gmail.com> <1405858399-23082-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 15:27:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9DcZ-000646-A5
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 15:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbaGUN1L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2014 09:27:11 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:39045 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932259AbaGUN1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 09:27:09 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id EE83E400C57;
	Mon, 21 Jul 2014 14:26:57 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id AD830400C54;
	Mon, 21 Jul 2014 14:26:57 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Mon, 21 Jul 2014 14:26:57 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405858399-23082-2-git-send-email-pclouds@gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253961>

On 20/07/14 13:13, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Locked paths are saved in a linked list so that if something wrong
> happens, *.lock are removed. This works fine if we keep cwd the same,
> which is true 99% of time except:
>=20
>  - update-index and read-tree hold the lock on $GIT_DIR/index really
>    early, then later on may call setup_work_tree() to move cwd.
>=20
>  - Suppose a lock is being held (e.g. by "git add") then somewhere
>    down the line, somebody calls real_path (e.g. "link_alt_odb_entry"=
),
>    which temporarily moves cwd away and back.
>=20
> During that time when cwd is moved (either permanently or temporarily=
)
> and we decide to die(), attempts to remove relative *.lock will fail,
> and the next operation will complain that some files are still locked=
=2E
>=20
> Avoid this case by turning relative paths to absolute when chdir() is
> called (or soon to be called, in setup_git_directory_gently case).
>=20
> Reported-by: Yue Lin Ho <yuelinho777@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

[snip]

> diff --git a/lockfile.c b/lockfile.c
> index 968b28f..cf1e795 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -288,3 +288,15 @@ void rollback_lock_file(struct lock_file *lk)
>  	}
>  	clear_filename(lk);
>  }
> +
> +void make_locked_paths_absolute(void)
> +{
> +	struct lock_file *lk;
> +	for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
> +		if (lk->filename && !is_absolute_path(lk->filename)) {
> +			char *to_free =3D lk->filename;
> +			lk->filename =3D xstrdup(absolute_path(lk->filename));
> +			free(to_free);
> +		}
> +	}
> +}

I just have to ask, why are we putting relative pathnames in this
list to begin with? Why not use an absolute path when taking the
lock in all cases? (calling absolute_path() and using the result
to take the lock, storing it in the lock_file list, should not be
in the critical path, right? Not that I have measured it, of course! :)

ATB,
Ramsay Jones
