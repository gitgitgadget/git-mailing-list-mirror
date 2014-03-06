From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 22/27] checkout: clean up half-prepared directories in
 --to mode
Date: Thu, 6 Mar 2014 05:06:57 -0500
Message-ID: <CAPig+cROi2TR+T8f+T_fRmAgBrBtBpC3qo5pCYAMSfRp0JoWWw@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-23-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:07:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLVCm-0007KT-CV
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 11:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbaCFKHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 05:07:00 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35516 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaCFKG6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 05:06:58 -0500
Received: by mail-yk0-f173.google.com with SMTP id 10so6101969ykt.4
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 02:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=6YiiJTLlwwVPaDHLAdWeEPbsGQic+ie0/87Mf0KWpro=;
        b=fGJUmnK0noSlkr8QeL3CjVEq+b5S0SGSiIMqwEjnFU5uTPUVcCPmUqxWlYGDSAKoXT
         HhINzIC3LatVq6Amem4YDxPnsEeeJipPzbSuSs81dSeM2EcAXW2GMI3M3YpolxKcF1Tb
         D/LBG2zGiexYewbDdKhYXLlLuD0Mwfo2ESJE5vvRYLGvq0gbagcKMK3K6WfV6vI4Herb
         RlsjoKXKjO/JjT/V0/u/QaEFS6Y2lRDI6GZN0tzYud1hasFrvpUwxckTt+9dWLw01v+A
         G8rdO44UU7pT1w2tBP8fYssDPZKOBkPDgPE8yet5Bwh1cuqy3rfP1yrMmnD2Rw8F8JEa
         lNqg==
X-Received: by 10.236.46.18 with SMTP id q18mr13407487yhb.21.1394100417666;
 Thu, 06 Mar 2014 02:06:57 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Thu, 6 Mar 2014 02:06:57 -0800 (PST)
In-Reply-To: <1393675983-3232-23-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: aA9pQgmCyOOEzgFU5Kemttc45io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243509>

On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/checkout.c | 49 ++++++++++++++++++++++++++++++++++++++++++++=
+++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index fa7b54a..28f9ac1 100644
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
> +               strbuf_reset(&sb);
> +       }

strbuf_release(&sb);

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
> 1.9.0.40.gaa8c3ea
