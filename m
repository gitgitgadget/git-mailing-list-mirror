From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 26/27] gc: support prune --repos
Date: Fri, 7 Mar 2014 01:40:08 -0500
Message-ID: <CAPig+cTVdCYCs4BvtcXFkp4WXFueP8HepD7YzFh5hfLDgNH1xg@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-27-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 07:40:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLoS9-0001V7-8M
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 07:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbaCGGkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 01:40:10 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:40343 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaCGGkJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 01:40:09 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so3890860yha.28
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 22:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=41z0uZSTpDlP5/V8T2I3E9ax4X6tPW4BQyg0jFhBkLs=;
        b=uFSD1rX15VigF+VnVsO40+8YbJckO+mVJMcI/dMbZIb0EsNVcFuNUsPNQmyL3TR+mi
         4hHcDMfNADHAARDhils4k/AGjFWyGQEDyB/6kv6/vNTzg5EktPrG9H0aADGMaH9RtgIB
         2u1LX68cRPuFZGIcoBDAMty2SjnCUTCGnbJbR/PsBaQymupTNIq7uZ7xF6PJWgmdgE3J
         wloeCSIq/XHhtlPq62zNtr1+kS5NnMjud6l5zDgj2oAfOj+MtY+7IZHpYlo9C0dBZ9WA
         JHWr0o7y+JBBsiTc9JRrealkaEhaoYLaFBH5FO6/uX9R97GKj/vyEYUGeQKou9WhYHKb
         qbhA==
X-Received: by 10.236.32.36 with SMTP id n24mr1400207yha.116.1394174408360;
 Thu, 06 Mar 2014 22:40:08 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Thu, 6 Mar 2014 22:40:08 -0800 (PST)
In-Reply-To: <1393675983-3232-27-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: ipbajcguBpJM80xDe-ivbmsaOJM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243601>

On Sat, Mar 1, 2014 at 7:13 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt |  6 ++++++
>  builtin/gc.c             | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 313d4b3..438b213 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1183,6 +1183,12 @@ gc.pruneexpire::
>         "now" may be used to disable this  grace period and always pr=
une
>         unreachable objects immediately.
>
> +gc.prunereposexpire::
> +       When 'git gc' is run, it will call 'prune --repos --expire 3.=
months.ago'.
> +       Override the grace period with this config variable.  The val=
ue
> +       "now" may be used to disable this  grace period and always pr=
une

Extra space between "this" and "grace". However, "the grace period"
sounds a bit better.

> +       $GIT_DIR/repos immediately.
> +
>  gc.reflogexpire::
>  gc.<pattern>.reflogexpire::
>         'git reflog expire' removes reflog entries older than
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 39d9b27..85c3c0c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -30,11 +30,13 @@ static int aggressive_window =3D 250;
>  static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
>  static const char *prune_expire =3D "2.weeks.ago";
> +static const char *prune_repos_expire =3D "3.months.ago";
>
>  static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
>  static struct argv_array reflog =3D ARGV_ARRAY_INIT;
>  static struct argv_array repack =3D ARGV_ARRAY_INIT;
>  static struct argv_array prune =3D ARGV_ARRAY_INIT;
> +static struct argv_array prune_repos =3D ARGV_ARRAY_INIT;
>  static struct argv_array rerere =3D ARGV_ARRAY_INIT;
>
>  static char *pidfile;
> @@ -81,6 +83,14 @@ static int gc_config(const char *var, const char *=
value, void *cb)
>                 }
>                 return git_config_string(&prune_expire, var, value);
>         }
> +       if (!strcmp(var, "gc.prunereposexpire")) {
> +               if (value && strcmp(value, "now")) {
> +                       unsigned long now =3D approxidate("now");
> +                       if (approxidate(value) >=3D now)
> +                               return error(_("Invalid %s: '%s'"), v=
ar, value);
> +               }
> +               return git_config_string(&prune_repos_expire, var, va=
lue);
> +       }
>         return git_default_config(var, value, cb);
>  }
>
> @@ -274,6 +284,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>         argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
>         argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
>         argv_array_pushl(&prune, "prune", "--expire", NULL);
> +       argv_array_pushl(&prune_repos, "prune", "--repos", "--expire"=
, NULL);
>         argv_array_pushl(&rerere, "rerere", "gc", NULL);
>
>         git_config(gc_config, NULL);
> @@ -334,6 +345,12 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>                         return error(FAILED_RUN, prune.argv[0]);
>         }
>
> +       if (prune_repos_expire) {
> +               argv_array_push(&prune_repos, prune_repos_expire);
> +               if (run_command_v_opt(prune_repos.argv, RUN_GIT_CMD))
> +                       return error(FAILED_RUN, prune_repos.argv[0])=
;
> +       }
> +
>         if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
>                 return error(FAILED_RUN, rerere.argv[0]);
>
> --
> 1.9.0.40.gaa8c3ea
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
