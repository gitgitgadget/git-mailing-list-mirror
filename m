From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 1/6] worktree.c: add find_worktree()
Date: Fri, 3 Jun 2016 16:00:51 +0100
Message-ID: <57519BA3.207@ramsayjones.plus.com>
References: <20160530104939.28407-1-pclouds@gmail.com>
 <20160603121944.28980-1-pclouds@gmail.com>
 <20160603121944.28980-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 17:01:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8qax-00062G-QF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbcFCPBD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 11:01:03 -0400
Received: from avasout01.plus.net ([84.93.230.227]:38028 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbcFCPBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 11:01:02 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 2F0s1t0055VX2mk01F0ttf; Fri, 03 Jun 2016 16:00:57 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=BCjA09oAAAAA:8 a=pGLkceISAAAA:8 a=xs9gPQGJmp-YAEhO9LoA:9 a=QEXdDO2ut3YA:10
 a=jYKBPJSq9nmHKCndOPe9:22 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160603121944.28980-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296334>



On 03/06/16 13:19, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> So far we haven't needed to identify an existing worktree from comman=
d
> line. Future commands such as lock or move will need it. The current
> implementation identifies worktrees by path (*). In future, the funct=
ion
> could learn to identify by $(basename $path) or tags...
>=20
> (*) We could probably go cheaper with comparing inode number (and
> probably more reliable than paths when unicode enters the game). But =
not
> all systems have good inode that so let's stick to something simple f=
or
> now.
>=20
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  worktree.c | 15 +++++++++++++++
>  worktree.h |  8 ++++++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/worktree.c b/worktree.c
> index e2a94e0..554f566 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -214,6 +214,21 @@ const char *get_worktree_git_dir(const struct wo=
rktree *wt)
>  		return git_common_path("worktrees/%s", wt->id);
>  }
> =20
> +struct worktree *find_worktree(struct worktree **list,
> +			       const char *prefix,
> +			       const char *arg)
> +{
> +	char *path;
> +
> +	arg =3D prefix_filename(prefix, strlen(prefix), arg);
> +	path =3D xstrdup(real_path(arg));
> +	for (; *list; list++)
> +		if (!fspathcmp(path, real_path((*list)->path)))

The results of the call to real_path() should probably be cached
in the worktree structure, since real_path() is relatively expensive
(it calls chdir(), lstat(), readlink() etc.), so you don't want to
re-compute the same result time-after-time ...

> +			break;
> +	free(path);
> +	return *list;
> +}
> +

ATB,
Ramsay Jones
