From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 5/5] help: respect new common command grouping
Date: Thu, 21 May 2015 10:29:05 -0400
Message-ID: <CAPig+cRX9_1h4W6sWxb22FF3Hwgqx2f=hK=tQkfTUdkTJiQo-w@mail.gmail.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432213989-3932-6-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 16:29:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvRTD-0003tb-Aw
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 16:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbbEUO3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 10:29:06 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34439 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbEUO3F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 10:29:05 -0400
Received: by igbhj9 with SMTP id hj9so11557384igb.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=4c+mN+rO+fQXSJZe9BQU2Y5nqtcFIt4ij0EktFlqKgs=;
        b=bZM1q4DUFbancfGyqqxLmygARMWFbXgrRs7BSuNETHOvGwhveY8/9MnVZIxDNkbOXm
         ap/JPtUkBTC0Y+rDbJGi2QGGUAAK7IESeLymBalu8PgzQZaZuHglazh/NdQmDzD2gpEZ
         eeVUESJ44U+SnekqlFLY1UdZUbliFiUFWaxwXpJeX3zEKluM9XHBQAY+CO1mPrsqvVGb
         05DKjf6GkYFnEjiBy1v9uqZLeRMHm4Xyx9WRwlh9SYQqeHJEGoFJUhqGXFjLUvyCb2fp
         p7rkvAEYHLX770hYtVuQArrTXLEuwFi2ZI0EttFnPccGISNoISerlmtlp7YBRtLs+L6p
         cdqg==
X-Received: by 10.107.151.75 with SMTP id z72mr3725082iod.46.1432218545131;
 Thu, 21 May 2015 07:29:05 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 07:29:05 -0700 (PDT)
In-Reply-To: <1432213989-3932-6-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: OaP3YDyUOWzT35PtkvOb0qYepDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269596>

On Thu, May 21, 2015 at 9:13 AM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> 'git help' shows common commands in alphabetical order:
> [...]
> without any indication of how commands relate to high-level
> concepts or each other. Revise the output to explain their relationsh=
ip
> with the typical Git workflow:
> [...]
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/help.c b/help.c
> index 2072a87..8f72051 100644
> --- a/help.c
> +++ b/help.c
> @@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
>  void list_common_cmds_help(void)
>  {
>         int i, longest =3D 0;
> +       int current_grp =3D -1;
>
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>                 if (longest < strlen(common_cmds[i].name))
>                         longest =3D strlen(common_cmds[i].name);
>         }
>
> -       puts(_("The most commonly used git commands are:"));
> +       qsort(common_cmds, ARRAY_SIZE(common_cmds),
> +               sizeof(common_cmds[0]), cmd_group_cmp);
> +
> +       puts(_("These are common Git commands used in various situati=
ons:"));

The clause "in various situations" is quite nebulous and thus adds no
substance. If you remove it, then you're effectively left with the
original

    "The most commonly used git commands are:"

which reads just as well or better and has the attribute of being more
concise. I'd opt to drop this change and just keep the original
wording.

Other than that minor observation, the patch looks fine.

> +
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> +               if (common_cmds[i].group !=3D current_grp) {
> +                       printf("\n%s\n", _(common_cmd_groups[common_c=
mds[i].group]));
> +                       current_grp =3D common_cmds[i].group;
> +               }
> +
>                 printf("   %s   ", common_cmds[i].name);
>                 mput_char(' ', longest - strlen(common_cmds[i].name))=
;
>                 puts(_(common_cmds[i].help));
> --
> 2.4.0.GIT
