From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 29/32] gc: support prune --repos
Date: Wed, 9 Jul 2014 06:05:02 -0400
Message-ID: <CAPig+cThYY9ERTrUrMM_JcGoALqcn1RTRGa_0k60cPJXcaLkLQ@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1404891197-18067-30-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 12:05:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4okV-0007bf-8Q
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 12:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbaGIKFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 06:05:09 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48846 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbaGIKFE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2014 06:05:04 -0400
Received: by mail-lb0-f173.google.com with SMTP id s7so4904632lbd.32
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ESybcM8RjtY1+7ARP/18b2nvfQCJZ9Yx5HAkzhzDXgk=;
        b=x6fXPuBohafFOv7XcPYY0XuuAvDeNzCyY5X/aKrnwOWJQFI5Tdd9sDF45siQaVJEg6
         Ur8yugJ/lbEa/kNm6H8bb/yhOYDCyK3bGjmm8Pdm+aV4Y2DVwd82ptqnf24b+KnDvOWg
         xs7LoFT76coeBEI5a6UHvULF07rnTkneDiB7BtLjkvLfHaTK/Jt3tRo4TDjA/c+7fJpH
         jHbO8PBNPQn54RaPQbuuR8I26GQkzRKzVwShgNy+4TsR2kubVMPfhQvrnSIQIK/Qvcex
         mIO1kA4MpgkNMIWXE+0CPbdks1xGOLFRMNFSeFMPFc2xDIrKebcOSszoxKND08FxCRzC
         yniA==
X-Received: by 10.152.29.200 with SMTP id m8mr32406123lah.4.1404900302623;
 Wed, 09 Jul 2014 03:05:02 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Wed, 9 Jul 2014 03:05:02 -0700 (PDT)
In-Reply-To: <1404891197-18067-30-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: F4dU6aOakSj-NLfJF6M809jyfIk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253110>

On Wed, Jul 9, 2014 at 3:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt |  7 +++++++
>  builtin/gc.c             | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 286e539..470f979 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1211,6 +1211,13 @@ gc.pruneexpire::
>         "now" may be used to disable this  grace period and always pr=
une
>         unreachable objects immediately.
>
> +gc.prunereposexpire::
> +       When 'git gc' is run, it will call
> +       'prune --repos --expire 3.months.ago'.
> +       Override the grace period with this config variable. The valu=
e
> +       "now" may be used to disable the grace period and always prun=
e
> +       $GIT_DIR/repos immediately.

nit: This reads very slightly better without "always":

    ... disable the grace period and prune [...] immediately.

More below.

> +
>  gc.reflogexpire::
>  gc.<pattern>.reflogexpire::
>         'git reflog expire' removes reflog entries older than
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 53f1302..1190183 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -33,11 +33,13 @@ static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
>  static int detach_auto =3D 1;
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
> @@ -92,6 +94,14 @@ static int gc_config(const char *var, const char *=
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

This logic is copied from the "gc.pruneexpire" case immediately above
it. Would it make sense to factor it out into a helper function (or is
it not worth the bother for just two cases)?

> +       }
>         return git_default_config(var, value, cb);
>  }
>
> @@ -299,6 +309,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>         argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
>         argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
>         argv_array_pushl(&prune, "prune", "--expire", NULL);
> +       argv_array_pushl(&prune_repos, "prune", "--repos", "--expire"=
, NULL);
>         argv_array_pushl(&rerere, "rerere", "gc", NULL);
>
>         git_config(gc_config, NULL);
> @@ -368,6 +379,12 @@ int cmd_gc(int argc, const char **argv, const ch=
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
> 1.9.1.346.ga2b5940
