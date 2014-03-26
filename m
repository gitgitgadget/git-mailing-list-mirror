From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/17] ls-files: support --max-depth
Date: Wed, 26 Mar 2014 15:50:08 -0400
Message-ID: <CAPig+cT--UV134qtuComeMytNQNRSsoidkPmNGo-unoGUe0OjQ@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:50:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStq5-0001VI-7s
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbaCZTuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 15:50:10 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:60091 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbaCZTuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 15:50:09 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so2581419yha.30
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 12:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=X4hc8hCudh3tqhcHHfPBNc9XV6JQvIwv9Kkyyeax4NE=;
        b=LrnoVU+se3I//m421Nof0ogDaaap6Fb54Jbij/SXjSBcQElkqarSvmIczFFqsN/Jly
         fwM1R6FOY3N36BxIH6ds28+6OvJ5imolyT9O46LKPhCtE7bHcy7sOZL0w324b5xb82D9
         VrHbfDMEgebQcoYJikQO3EvvQQIl29K6PBjvZ8PpERzUHGW/+gEvLXCJYROpgv82zJwm
         Ez5aCM6hsEyqsuWLugn7k5gslNTrGhfO1F5cVETheA83ybJ8AgM2zcOuvSpEwu1vU70s
         ei/0ZEeAtJ7Cg6O6zplyFGPgm1lrX8+0jNP9/NWEto71wXtW8cTTXRnEals7uiLiNIQH
         iVaA==
X-Received: by 10.236.137.8 with SMTP id x8mr83015824yhi.4.1395863408918; Wed,
 26 Mar 2014 12:50:08 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 26 Mar 2014 12:50:08 -0700 (PDT)
In-Reply-To: <1395841697-11742-9-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 8s0F2SetZtV69eRNeLqEQ6FNvE4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245220>

On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-ls-files.txt | 7 +++++++
>  builtin/ls-files.c             | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> index cd52461..3c022eb 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -162,6 +162,13 @@ a space) at the start of each line:
>         for option syntax.`--column` and `--no-column` without option=
s
>         are equivalent to 'always' and 'never' respectively.
>
> +--max-depth <depth>::

Other options in this file are documented as:

    --max-depth=3D<depth>::

> +       For each <pathspec> given on command line, descend at most <d=
epth>
> +       levels of directories. A negative value means no limit.
> +       This option is ignored if <pathspec> contains active wildcard=
s.
> +       In other words if "a*" matches a directory named "a*",
> +       "*" is matched literally so --max-depth is still effective.

Would it be worthwhile to mention the default?

> +
>  \--::
>         Do not interpret any more arguments as options.
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 335d3b0..8eef423 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -503,6 +503,7 @@ static int option_parse_exclude_standard(const st=
ruct option *opt,
>  int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix=
)
>  {
>         int require_work_tree =3D 0, show_tag =3D 0, i;
> +       int max_depth =3D -1;
>         const char *max_prefix;
>         struct dir_struct dir;
>         struct exclude_list *el;
> @@ -560,6 +561,9 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
>                         N_("pretend that paths removed since <tree-is=
h> are still present")),
>                 OPT__COLOR(&use_color, N_("show color")),
>                 OPT_COLUMN(0, "column", &colopts, N_("show files in c=
olumns")),
> +               { OPTION_INTEGER, 0, "max-depth", &max_depth, N_("dep=
th"),
> +                       N_("descend at most <depth> levels"), PARSE_O=
PT_NONEG,
> +                       NULL, 1 },
>                 OPT__ABBREV(&abbrev),
>                 OPT_BOOL(0, "debug", &debug_mode, N_("show debugging =
data")),
>                 OPT_END()
> @@ -624,8 +628,11 @@ int cmd_ls_files(int argc, const char **argv, co=
nst char *cmd_prefix)
>
>         parse_pathspec(&pathspec, 0,
>                        PATHSPEC_PREFER_CWD |
> +                      (max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID :=
 0) |
>                        PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>                        prefix, argv);
> +       pathspec.max_depth =3D max_depth;
> +       pathspec.recursive =3D 1;
>
>         /* Find common prefix for all pathspec's */
>         max_prefix =3D common_prefix(&pathspec);
> --
> 1.9.1.345.ga1a145c
