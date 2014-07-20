From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 23/31] checkout: clean up half-prepared directories in
 --to mode
Date: Sun, 20 Jul 2014 19:55:46 -0400
Message-ID: <CAPig+cRE0xOhQM4mtJQRX_gSQ3_OMr6ws87wU03TZ1eaUXui2g@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-24-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X913y-0006KD-25
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 02:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbaGTXzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 19:55:48 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:52519 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbaGTXzr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2014 19:55:47 -0400
Received: by mail-yh0-f41.google.com with SMTP id b6so3438372yha.0
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 16:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=wqmSJeO94AwqMYwKCVHLaF/N4Uw0smmwi4P1td2E/Bw=;
        b=fMSEq8Hxsoh7qUnlCOa5hmqbb7p6HEUP455nOutfGgSDHMLI25Y2K5i2GRa8UkNUzw
         dcCkzw3trkYIwA+KirBPfE+AHqKvVhVWQ3GTTeCbJ4ddsKr1mfRdN1Ik39Ib6Lo2zl9K
         MwyjOBbooK+qtXyhCvEuGyDzHPXjaJqn3mOSevMIppm6+foRCcdWIltzOUBxy60bvb/Q
         blfsdMoo+M5wTHxADtmzeN2BW38sOGMiG/B8OB4tYUiRwaEg0G45cvok9Ao0cUHLKDnY
         x1ps1oDtXJQCJmE8myychKD566FjPtPY/nez7buIXgdvHVLFDZGp5fIc3gk4c+fLttRW
         LUqg==
X-Received: by 10.236.130.77 with SMTP id j53mr10557670yhi.139.1405900546751;
 Sun, 20 Jul 2014 16:55:46 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Sun, 20 Jul 2014 16:55:46 -0700 (PDT)
In-Reply-To: <1405227068-25506-24-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 8XBGBAAS-eqyRCjoXlkdoJFVBrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253938>

On Sun, Jul 13, 2014 at 12:51 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/checkout.c | 49 ++++++++++++++++++++++++++++++++++++++++++++=
+++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 81adb74..3167fd2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -20,6 +20,7 @@
>  #include "resolve-undo.h"
>  #include "submodule.h"
>  #include "argv-array.h"
> +#include "sigchain.h"
>
>  static const char * const checkout_usage[] =3D {
>         N_("git checkout [options] <branch>"),
> @@ -814,6 +815,35 @@ static int switch_branches(const struct checkout=
_opts *opts,
>         return ret || writeout_error;
>  }
>
> +static const char *junk_work_tree;
> +static const char *junk_git_dir;
> +static int is_junk;
> +static pid_t junk_pid;
> +
> +static void remove_junk(void)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       if (!is_junk || getpid() !=3D junk_pid)
> +               return;
> +       if (junk_git_dir) {
> +               strbuf_addstr(&sb, junk_git_dir);
> +               remove_dir_recursively(&sb, 0);
> +               strbuf_reset(&sb);
> +       }
> +       if (junk_work_tree) {
> +               strbuf_addstr(&sb, junk_work_tree);
> +               remove_dir_recursively(&sb, 0);
> +       }
> +       strbuf_release(&sb);
> +}
> +
> +static void remove_junk_on_signal(int signo)
> +{
> +       remove_junk();
> +       sigchain_pop(signo);
> +       raise(signo);
> +}
> +
>  static int prepare_linked_checkout(const struct checkout_opts *opts,
>                                    struct branch_info *new)
>  {
> @@ -822,7 +852,7 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
>         const char *path =3D opts->new_worktree, *name;
>         struct stat st;
>         struct child_process cp;
> -       int counter =3D 0, len;
> +       int counter =3D 0, len, ret;
>
>         if (!new->commit)
>                 die(_("no branch specified"));
> @@ -848,13 +878,21 @@ static int prepare_linked_checkout(const struct=
 checkout_opts *opts,
>                 strbuf_addf(&sb_repo, "%d", counter);
>         }
>         name =3D strrchr(sb_repo.buf, '/') + 1;
> +
> +       junk_pid =3D getpid();
> +       atexit(remove_junk);
> +       sigchain_push_common(remove_junk_on_signal);
> +
>         if (mkdir(sb_repo.buf, 0777))
>                 die_errno(_("could not create directory of '%s'"), sb=
_repo.buf);
> +       junk_git_dir =3D sb_repo.buf;

I've managed to convince myself that, although junk_git_dir becomes a
dangling pointer by the end of prepare_linked_checkout(), it should
never afterward be accessed. Perhaps it would make sense to make this
easier to follow by clearing junk_git_dir when is_junk is cleared?

> +       is_junk =3D 1;
>
>         strbuf_addf(&sb_git, "%s/.git", path);
>         if (safe_create_leading_directories_const(sb_git.buf))
>                 die_errno(_("could not create leading directories of =
'%s'"),
>                           sb_git.buf);
> +       junk_work_tree =3D path;
>
>         write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
>                    real_path(get_git_common_dir()), name);
> @@ -879,7 +917,14 @@ static int prepare_linked_checkout(const struct =
checkout_opts *opts,
>         memset(&cp, 0, sizeof(cp));
>         cp.git_cmd =3D 1;
>         cp.argv =3D opts->saved_argv;
> -       return run_command(&cp);
> +       ret =3D run_command(&cp);
> +       if (!ret)
> +               is_junk =3D 0;

Here: perhaps also set is_junk_dir to NULL since it otherwise is about
to become a dangling pointer.

> +       strbuf_release(&sb);
> +       strbuf_release(&sb_repo);
> +       strbuf_release(&sb_git);
> +       return ret;
> +
>  }
>
>  static int git_checkout_config(const char *var, const char *value, v=
oid *cb)
> --
> 1.9.1.346.ga2b5940
