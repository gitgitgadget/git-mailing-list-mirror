From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] help.c: make term_columns() cached and export it
Date: Sat, 11 Feb 2012 11:36:23 +0700
Message-ID: <CACsJy8AjqqEpJr64DJUqVumw1sB2g3pvuz-g4DxhmS-ZbGhY3w@mail.gmail.com>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
 <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl> <1328891972-23695-3-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sat Feb 11 05:37:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw4iO-0003VX-A0
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 05:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758810Ab2BKEgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 23:36:55 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35132 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab2BKEgy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 23:36:54 -0500
Received: by wics10 with SMTP id s10so2447267wic.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 20:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vCPwY+ur8MB3iSwpZ4eCEFhz8+hu39wzquoHPdp1gFA=;
        b=sjNKfzforxm6N8oekt4oTJ2gE4i6OdGSNr+nGgnkH797N14KmE9HfaXOzmt0li3wRr
         wyJ6TxoCKoXOWGrKgkXD327Zo7AdRrdnFuVWwE9+YHKJ1ZhSzIORtGYBQznftYwwvAHR
         Z4TKS0FfHyEgd+iBh/ef8Xkepg1UV3c5rGd80=
Received: by 10.180.85.105 with SMTP id g9mr7008901wiz.12.1328935013217; Fri,
 10 Feb 2012 20:36:53 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Fri, 10 Feb 2012 20:36:23 -0800 (PST)
In-Reply-To: <1328891972-23695-3-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190482>

2012/2/10 Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>:
> Since term_columns() will usually fail, when a pager is installed,
> the cache is primed before the pager is installed. If a pager is not
> installed, then the cache will be set on first use.

Conflict alert. term_columns() is also moved out of help.c in
nd/columns series on pu, commit cb0850f (Save terminal width before
setting up pager - 2012-02-04)

>
> Conforms to The Single UNIX Specification, Version 2
> (http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html#tag_002=
_003).
>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
> =C2=A0help.c =C2=A0| =C2=A0 37 +++++++++++++++++++++++++++++--------
> =C2=A0help.h =C2=A0| =C2=A0 =C2=A02 ++
> =C2=A0pager.c | =C2=A0 =C2=A05 +++++
> =C2=A03 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/help.c b/help.c
> index bc15066..5d1cb1d 100644
> --- a/help.c
> +++ b/help.c
> @@ -5,26 +5,47 @@
> =C2=A0#include "help.h"
> =C2=A0#include "common-cmds.h"
>
> -/* most GUI terminals set COLUMNS (although some don't export it) */
> -static int term_columns(void)
> +/*
> + * Cache for term_columns() value. Set on first use or when
> + * installing a pager and replacing stdout.
> + */
> +static int term_columns_cache;
> +
> +/*
> + * Return cached value (if set) or $COLUMNS (if set and positive) or
> + * ioctl(1, TIOCGWINSZ).ws_col (if positive) or 80.
> + *
> + * $COLUMNS even if set, is usually not exported, so
> + * the variable can be used to override autodection.
> + */
> +int term_columns(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 char *col_string =3D getenv("COLUMNS");
> + =C2=A0 =C2=A0 =C2=A0 char *col_string;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int n_cols;
>
> - =C2=A0 =C2=A0 =C2=A0 if (col_string && (n_cols =3D atoi(col_string)=
) > 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return n_cols;
> + =C2=A0 =C2=A0 =C2=A0 if (term_columns_cache)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return term_column=
s_cache;
> +
> + =C2=A0 =C2=A0 =C2=A0 col_string =3D getenv("COLUMNS");
> + =C2=A0 =C2=A0 =C2=A0 if (col_string && (n_cols =3D atoi(col_string)=
) > 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 term_columns_cache=
 =3D n_cols;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return term_column=
s_cache;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0#ifdef TIOCGWINSZ
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct winsize=
 ws;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ioctl(1, =
TIOCGWINSZ, &ws)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ws.ws_col)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ws.ws_col;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ws.ws_col) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 term_columns_cache =3D ws.ws_col;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return term_columns_cache;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0#endif
>
> - =C2=A0 =C2=A0 =C2=A0 return 80;
> + =C2=A0 =C2=A0 =C2=A0 term_columns_cache =3D 80;
> + =C2=A0 =C2=A0 =C2=A0 return term_columns_cache;
> =C2=A0}
>
> =C2=A0void add_cmdname(struct cmdnames *cmds, const char *name, int l=
en)
> diff --git a/help.h b/help.h
> index b6b12d5..880a4b4 100644
> --- a/help.h
> +++ b/help.h
> @@ -29,4 +29,6 @@ extern void list_commands(const char *title,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct cmdnames *main_cmds,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct cmdnames *other_cmds);
>
> +extern int term_columns(void);
> +
> =C2=A0#endif /* HELP_H */
> diff --git a/pager.c b/pager.c
> index 975955b..e7032de 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -1,6 +1,7 @@
> =C2=A0#include "cache.h"
> =C2=A0#include "run-command.h"
> =C2=A0#include "sigchain.h"
> +#include "help.h"
>
> =C2=A0#ifndef DEFAULT_PAGER
> =C2=A0#define DEFAULT_PAGER "less"
> @@ -76,6 +77,10 @@ void setup_pager(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pager)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> + =C2=A0 =C2=A0 =C2=A0 /* prime the term_columns() cache before it is=
 too
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* late and stdout is replaced */
> + =C2=A0 =C2=A0 =C2=A0 (void) term_columns();
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setenv("GIT_PAGER_IN_USE", "true", 1);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* spawn the pager */
> --
> 1.7.9.263.g4be11.dirty
>



--=20
Duy
