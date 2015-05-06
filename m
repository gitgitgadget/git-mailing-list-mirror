From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] git help: group common commands by theme
Date: Tue, 5 May 2015 23:16:37 -0400
Message-ID: <CAPig+cS=u-HK1qNicWiLOQC6RPkR7QueX+kOu8fQwpHekgs1yg@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<13c3dcbd2c5c9dfc0453381b5da53b5d68af7afe.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 05:16:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpppH-0005Vy-1I
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 05:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248AbbEFDQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2015 23:16:41 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38729 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbbEFDQi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 23:16:38 -0400
Received: by igbhj9 with SMTP id hj9so5603344igb.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=TX+FbJGiieUUEY9gS47CXROjiNkPtauqKf4XjMwtnmQ=;
        b=AGisl7Z8Y3xwlq9JS/+1g0zqEk9G1lNA0A8o4kZSre3j1wT5lg+dov5X8JYXNBucoJ
         hI8ak7oEY6UVHHy3Zn9NEn/0lc41fz8GA2OD+K3veR0NBRzFr/SioeneaU+Lzy95Hgmb
         EyjltOjPfLeQ3IaFeaFZx0E6FIBzZiA8sWjhCFGiAQLXONjRWW86sZwCYDBvp1/YOeiZ
         UfX5nLa/7uPjyhpQMN/0hI4Q43/EoXqn3E6yBPkin1T4u37VvZtT4SEmFvFqi+SY5fFS
         ms9E8JSlnVjR5jgdr4C8MuwuAyGvYnCB/suOM4436rwV0Fu4hdAoSnOfx/cv3i5EHurH
         vIzw==
X-Received: by 10.42.146.202 with SMTP id k10mr581361icv.34.1430882197910;
 Tue, 05 May 2015 20:16:37 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 5 May 2015 20:16:37 -0700 (PDT)
In-Reply-To: <13c3dcbd2c5c9dfc0453381b5da53b5d68af7afe.1430770308.git.sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: _K41X5aT8FdjupPN0p1-eE2aQfw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268442>

On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> 'git help' shows common commands in alphabetical order:
>
> The most commonly used git commands are:
>    add        Add file contents to the index
>    bisect     Find by binary search the change that introduced a bug
>    branch     List, create, or delete branches
>    checkout   Checkout a branch or paths to the working tree
>    clone      Clone a repository into a new directory
>    commit     Record changes to the repository
>    [...]
>
> without any indication of how commands relate to high-level
> concepts or each other. Revise the output to group commands by
> concept, like this:
>
> The most commonly used git commands are:
>
>    * starting a working area:
>       clone      Clone a repository into a new directory
>       init       Create an empty Git repository or reinitialize an ex=
isting one
>
>    * working on the current change:
>       add        Add file contents to the index
>       reset      Reset current HEAD to the specified state
>       [...]

This looks better. A couple minor style nits and a question below...

> ---
> diff --git a/help.c b/help.c
> index 2072a87..c8b0bb6 100644
> --- a/help.c
> +++ b/help.c
> @@ -218,18 +218,44 @@ void list_commands(unsigned int colopts,
>         }
>  }
>
> +int cmd_group_cmp(const void *elem1, const void *elem2)
> +{
> +       int group1, group2;
> +
> +       group1 =3D ((struct cmdname_help *) elem1)->group;
> +       group2 =3D ((struct cmdname_help *) elem2)->group;

Style: Drop space after the cast: (type *)var

> +
> +       if (group1 =3D=3D group2)
> +               return 0;
> +       if (group1 > group2)
> +               return 1;
> +       else
> +               return -1;

Do you also want to sort the commands alphabetically within group?
That is, something like this?

    struct cmdname_help *e1 =3D elem1;
    struct cmdname_help *e2 =3D elem2;

    if (e1->group < e2->group)
        return -1;
    if (e1->group > e2->group)
        return 1;
    return strcmp(e1->name, e2->name);

> +}
> +
>  void list_common_cmds_help(void)
>  {
>         int i, longest =3D 0;
> +       unsigned char current_grp =3D -1;
>
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>                 if (longest < strlen(common_cmds[i].name))
>                         longest =3D strlen(common_cmds[i].name);
>         }
>
> +       qsort(common_cmds, ARRAY_SIZE(common_cmds),
> +               sizeof(common_cmds[0]), cmd_group_cmp);
> +
>         puts(_("The most commonly used git commands are:"));
> +
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> -               printf("   %s   ", common_cmds[i].name);
> +               if (common_cmds[i].group !=3D current_grp) {
> +                       printf("\n   * %s:\n", _(common_cmd_groups[co=
mmon_cmds[i].group]));
> +               }

Style: Drop unnecessary braces.

> +               current_grp =3D common_cmds[i].group;

Alternately, move this assignment inside the braces.

> +               printf("      %s   ", common_cmds[i].name);
>                 mput_char(' ', longest - strlen(common_cmds[i].name))=
;
>                 puts(_(common_cmds[i].help));
>         }
> --
> 2.4.0
