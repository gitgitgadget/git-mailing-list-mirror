From: Andres Perera <andres.p@zoho.com>
Subject: Re: [PATCH v4] gc: reject if another gc is running, unless --force is given
Date: Fri, 9 Aug 2013 11:59:39 -0430
Message-ID: <CAPrKj1bO1jBsv73beA6LoeN09S-jWq8FYOP+WQ-AFwb1dn4Wsw@mail.gmail.com>
References: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
	<1375959938-6395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 18:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7pZQ-0004K4-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 18:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968077Ab3HIQ3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 12:29:41 -0400
Received: from mail-vb0-f44.google.com ([209.85.212.44]:44197 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967927Ab3HIQ3k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Aug 2013 12:29:40 -0400
Received: by mail-vb0-f44.google.com with SMTP id e13so4280516vbg.17
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=uGJkWx1BAkTMjLyH6GxnMlH3GigKUkkpohWhrTp9W64=;
        b=EmtnniOH+tZE1K53N33pFW+MB2MZuGdBcilXIQvt1xX8wO2r+o9eNQ9c9OFKP/tNIr
         PEc1ARzQgSY8TyoflZpIUFpwf5VH/9nF809MHlm3d/yUfEo6EEPi5uqAQNa/4VOUfOrd
         vTSUwbqlOikjZMeIE+m7nDTaZLb9HT85X4ImOv63x7Mjwxfsn7n/4IqYbscgVRomOrxx
         XOO38wN6ITuCk/22Y25BpgvyCp1bEqQ4+p84eQPH0DCJ4MF5nDvbfCvGiXEZ8jJNXS7t
         cREHvZkaobmvuE++tcl7dw09bOZdYnBq4o4Sgz6s3vRLbOWUt6ftmjMZiWQ7KVEypb0q
         5DEQ==
X-Received: by 10.58.80.38 with SMTP id o6mr6381037vex.69.1376065779124; Fri,
 09 Aug 2013 09:29:39 -0700 (PDT)
Received: by 10.58.207.110 with HTTP; Fri, 9 Aug 2013 09:29:39 -0700 (PDT)
In-Reply-To: <1375959938-6395-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: ElaoqSXAs30jfGMvdCF1I9mTMw4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231992>

On Thu, Aug 8, 2013 at 6:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This may happen when `git gc --auto` is run automatically, then the
> user, to avoid wait time, switches to a new terminal, keeps working
> and `git gc --auto` is started again because the first gc instance ha=
s
> not clean up the repository.
>
> This patch tries to avoid multiple gc running, especially in --auto
> mode. In the worst case, gc may be delayed 12 hours if a daemon reuse=
s
> the pid stored in gc.pid.
>
> kill(pid, 0) support is added to MinGW port so it should work on
> Windows too.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  this patch is getting cooler:
>
>  - uname() is dropped in favor of gethostbyname(), which is supported
>    by MinGW port.
>  - host name is stored in gc.pid as junio suggested so...
>  - now we can say "gc is already running on _this host_ with _this pi=
d_..."
>
>  Documentation/git-gc.txt |  6 ++++-
>  builtin/gc.c             | 67 ++++++++++++++++++++++++++++++++++++++=
++++++++++
>  compat/mingw.c           |  6 +++++
>  3 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 2402ed6..e158a3b 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the l=
ocal repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git gc' [--aggressive] [--auto] [--quiet] [--prune=3D<date> | --no-=
prune]
> +'git gc' [--aggressive] [--auto] [--quiet] [--prune=3D<date> | --no-=
prune] [--force]
>
>  DESCRIPTION
>  -----------
> @@ -72,6 +72,10 @@ automatic consolidation of packs.
>  --quiet::
>         Suppress all progress reports.
>
> +--force::
> +       Force `git gc` to run even if there may be another `git gc`
> +       instance running on this repository.
> +
>  Configuration
>  -------------
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6be6c8d..99682f0 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -167,11 +167,69 @@ static int need_to_gc(void)
>         return 1;
>  }
>
> +/* return NULL on success, else hostname running the gc */
> +static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
> +{
> +       static struct lock_file lock;
> +       static char locking_host[128];
> +       char my_host[128];
> +       struct strbuf sb =3D STRBUF_INIT;
> +       struct stat st;
> +       uintmax_t pid;

pid_t is always an signed type, therefore unintmax_t does not make
sense as a catch all value

fork() returns -1 on failure, and its return type is pid_t. i don't
know what fantasy unix system has an unsigned pid_t

> +       FILE *fp;
> +       int fd, should_exit;
> +
> +       if (gethostname(my_host, sizeof(my_host)))
> +               strcpy(my_host, "unknown");
> +
> +       fd =3D hold_lock_file_for_update(&lock, git_path("gc.pid"),
> +                                      LOCK_DIE_ON_ERROR);
> +       if (!force) {
> +               fp =3D fopen(git_path("gc.pid"), "r");
> +               memset(locking_host, 0, sizeof(locking_host));
> +               should_exit =3D
> +                       fp !=3D NULL &&
> +                       !fstat(fileno(fp), &st) &&
> +                       /*
> +                        * 12 hour limit is very generous as gc shoul=
d
> +                        * never take that long. On the other hand we
> +                        * don't really need a strict limit here,
> +                        * running gc --auto one day late is not a bi=
g
> +                        * problem. --force can be used in manual gc
> +                        * after the user verifies that no gc is
> +                        * running.
> +                        */
> +                       time(NULL) - st.st_mtime <=3D 12 * 3600 &&
> +                       fscanf(fp, "%"PRIuMAX" %127c", &pid, locking_=
host) =3D=3D 2 &&

similar comment wrt PRIuMAX

> +                       !strcmp(locking_host, my_host) &&
> +                       !kill(pid, 0);
> +               if (fp !=3D NULL)
> +                       fclose(fp);
> +               if (should_exit) {
> +                       if (fd >=3D 0)
> +                               rollback_lock_file(&lock);
> +                       *ret_pid =3D pid;
> +                       return locking_host;

why not exponential backoff?

> +               }
> +       }
> +
> +       strbuf_addf(&sb, "%"PRIuMAX" %s",
> +                   (uintmax_t) getpid(), my_host);
> +       write_in_full(fd, sb.buf, sb.len);
> +       strbuf_release(&sb);
> +       commit_lock_file(&lock);
> +
> +       return NULL;
> +}
> +
>  int cmd_gc(int argc, const char **argv, const char *prefix)
>  {
>         int aggressive =3D 0;
>         int auto_gc =3D 0;
>         int quiet =3D 0;
> +       int force =3D 0;
> +       const char *name;
> +       pid_t pid;
>
>         struct option builtin_gc_options[] =3D {
>                 OPT__QUIET(&quiet, N_("suppress progress reporting"))=
,
> @@ -180,6 +238,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>                         PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expir=
e },
>                 OPT_BOOLEAN(0, "aggressive", &aggressive, N_("be more=
 thorough (increased runtime)")),
>                 OPT_BOOLEAN(0, "auto", &auto_gc, N_("enable auto-gc m=
ode")),
> +               OPT_BOOL(0, "force", &force, N_("force running gc eve=
n if there may be another gc running")),
>                 OPT_END()
>         };
>
> @@ -225,6 +284,14 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>         } else
>                 add_repack_all_option();
>
> +       name =3D lock_repo_for_gc(force, &pid);
> +       if (name) {
> +               if (auto_gc)
> +                       return 0; /* be quiet on --auto */
> +               die(_("gc is already running on machine '%s' pid %"PR=
IuMAX" (use --force if not)"),
> +                   name, (uintmax_t)pid);
> +       }
> +
>         if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GI=
T_CMD))
>                 return error(FAILED_RUN, pack_refs_cmd.argv[0]);
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index bb92c43..22ee9ef 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1086,6 +1086,12 @@ int mingw_kill(pid_t pid, int sig)
>                 errno =3D err_win_to_posix(GetLastError());
>                 CloseHandle(h);
>                 return -1;
> +       } else if (pid > 0 && sig =3D=3D 0) {
> +               HANDLE h =3D OpenProcess(PROCESS_QUERY_INFORMATION, F=
ALSE, pid);
> +               if (h) {
> +                       CloseHandle(h);
> +                       return 0;
> +               }
>         }
>
>         errno =3D EINVAL;
> --
> 1.8.2.83.gc99314b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
