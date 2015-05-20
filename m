From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v9 5/5] help: respect new common command grouping
Date: Wed, 20 May 2015 22:39:00 +0100
Message-ID: <555CFEF4.5000002@ramsay1.demon.co.uk>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com> <1432149781-24596-6-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, gitster@pobox.com
To: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 23:39:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvBhn-0000yC-NN
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbbETVjH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 17:39:07 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:34720 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752222AbbETVjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:39:06 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 3FB5B38408B;
	Wed, 20 May 2015 22:38:57 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id EC820384089;
	Wed, 20 May 2015 22:38:56 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Wed, 20 May 2015 22:38:56 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1432149781-24596-6-git-send-email-sebastien.guimmara@gmail.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269529>

On 20/05/15 20:23, S=C3=A9bastien Guimmara wrote:
> 'git help' shows common commands in alphabetical order:
>=20
> The most commonly used git commands are:
>    add        Add file contents to the index
>    bisect     Find by binary search the change that introduced a bug
>    branch     List, create, or delete branches
>    checkout   Checkout a branch or paths to the working tree
>    clone      Clone a repository into a new directory
>    commit     Record changes to the repository
>    [...]
>=20
> without any indication of how commands relate to high-level
> concepts or each other. Revise the output to explain their relationsh=
ip
> with the typical Git workflow:
>=20
> These are common Git commands used in various situations:
>=20
> start a working area (see also: git help tutorial)
>    clone      Clone a repository into a new directory
>    init       Create an empty Git repository or reinitialize [...]
>=20
> work on the current change (see also: git help everyday)
>    add        Add file contents to the index
>    reset      Reset current HEAD to the specified state
>=20
> examine the history and state (see also: git help revisions)
>    log        Show commit logs
>    status     Show the working tree status
>=20
>    [...]
>=20
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

This should be (at most) 'Helped-by:' - my 'contribution' was
so minor that even a 'Helped-by:' is generous! :-D

ATB,
Ramsay Jones

> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
>  help.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/help.c b/help.c
> index 2072a87..8f72051 100644
> --- a/help.c
> +++ b/help.c
> @@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
>  	}
>  }
> =20
> +static int cmd_group_cmp(const void *elem1, const void *elem2)
> +{
> +	const struct cmdname_help *e1 =3D elem1;
> +	const struct cmdname_help *e2 =3D elem2;
> +
> +	if (e1->group < e2->group)
> +		return -1;
> +	if (e1->group > e2->group)
> +		return 1;
> +	return strcmp(e1->name, e2->name);
> +}
> +
>  void list_common_cmds_help(void)
>  {
>  	int i, longest =3D 0;
> +	int current_grp =3D -1;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>  		if (longest < strlen(common_cmds[i].name))
>  			longest =3D strlen(common_cmds[i].name);
>  	}
> =20
> -	puts(_("The most commonly used git commands are:"));
> +	qsort(common_cmds, ARRAY_SIZE(common_cmds),
> +		sizeof(common_cmds[0]), cmd_group_cmp);
> +
> +	puts(_("These are common Git commands used in various situations:")=
);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> +		if (common_cmds[i].group !=3D current_grp) {
> +			printf("\n%s\n", _(common_cmd_groups[common_cmds[i].group]));
> +			current_grp =3D common_cmds[i].group;
> +		}
> +
>  		printf("   %s   ", common_cmds[i].name);
>  		mput_char(' ', longest - strlen(common_cmds[i].name));
>  		puts(_(common_cmds[i].help));
>=20
