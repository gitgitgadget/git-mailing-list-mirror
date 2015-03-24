From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] gc: save log from daemonized gc --auto and print it next time
Date: Tue, 24 Mar 2015 18:12:05 -0400
Message-ID: <CAPig+cS8zn5XThxShZHYCPs=xUeiwHXKSueor3jX_7E0X_uhuA@mail.gmail.com>
References: <1427199448-28278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:12:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaX3U-0000aa-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 23:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbbCXWMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 18:12:08 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:33502 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbCXWMH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 18:12:07 -0400
Received: by labto5 with SMTP id to5so5630769lab.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Wo5o0cBj1Y4UgKQIdewZvLATpx3TsdtomndiT1XCIWE=;
        b=RLyiHWarrOJeZXdnj3AUklHh35dy3aqoyxAaiUdyPRUO5fI0RsAdnu2/cxQF+ZmuRr
         zcB8WFR+XhPwNElxWhhdjX4c23k5NsWCYHDjn/c+GNrXXZbHfUY48DHrUSiCUHCbzMG5
         tdsxijJy2Q4wh0MrfpuGYnlQo/EHAASl0oPTx7jMjz7baUoq4gZeNqbDEtfDh9W9+Qlw
         XKrHYXRWqPP3WYtEFLism0A3Aqp6eT6y2sFW5sNkBhwoghUgDm0bjtt9x0FYBVT9k10Y
         k56DLWcZHswi0n8Oran60wh4fV7pJDNz2Wz2Frh5z1izrgDJx8/SE2TLNNEbyl2Kqbld
         lYSw==
X-Received: by 10.112.163.229 with SMTP id yl5mr5654667lbb.60.1427235125384;
 Tue, 24 Mar 2015 15:12:05 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 24 Mar 2015 15:12:05 -0700 (PDT)
In-Reply-To: <1427199448-28278-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: OJgnT8E92hs4ma9WbdXLoxt5FkM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266233>

On Tue, Mar 24, 2015 at 8:17 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> While commit 9f673f9 (gc: config option for running --auto in
> background - 2014-02-08) helps reduce some complaints about 'gc
> --auto' hogging the terminal, it creates another set of problems.
>
> The latest in this set is, as the result of daemonizing, stderr is
> closed and all warnings are lost. This warning at the end of cmd_gc()
> is particularly important because it tells the user how to avoid "gc
> --auto" running repeatedly. Because stderr is closed, the user does
> not know, naturally they complain about 'gc --auto' wasting CPU.
>
> Besides reverting 9f673f9 and looking at the problem from another
> angle, we could save the stderr in $GIT_DIR/gc.log. Next time, 'gc
> --auto' will print the saved warnings, delete gc.log and exit.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/gc.c  | 37 ++++++++++++++++++++++++++++++++++++-
>  t/t6500-gc.sh | 20 ++++++++++++++++++++
>  2 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 5c634af..07769a9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -32,6 +32,8 @@ static int aggressive_window =3D 250;
>  static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
>  static int detach_auto =3D 1;
> +static struct strbuf log_filename =3D STRBUF_INIT;
> +static int daemonized;
>  static const char *prune_expire =3D "2.weeks.ago";
>
>  static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
> @@ -44,6 +46,15 @@ static char *pidfile;
>
>  static void remove_pidfile(void)
>  {
> +       if (daemonized && log_filename.len) {
> +               struct stat st;
> +
> +               close(2);
> +               if (stat(log_filename.buf, &st) ||
> +                   !st.st_size ||
> +                   rename(log_filename.buf, git_path("gc.log")))
> +                       unlink(log_filename.buf);
> +       }
>         if (pidfile)
>                 unlink(pidfile);
>  }
> @@ -324,13 +335,25 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>                         fprintf(stderr, _("See \"git help gc\" for ma=
nual housekeeping.\n"));
>                 }
>                 if (detach_auto) {
> +                       struct strbuf sb =3D STRBUF_INIT;
> +
> +                       if (strbuf_read_file(&sb, git_path("gc.log"),=
 0) > 0) {
> +                               warning(_("Last gc run reported the f=
ollowing, gc skipped"));

When I read this message, it makes me think that the previous gc was
skipped, even though it's actually skipping the current one. Perhaps
rephrase as "skipping gc; last gc reported:"?

> +                               fputs(sb.buf, stderr);
> +                               strbuf_release(&sb);
> +                               /* let the next gc --auto run as usua=
l */
> +                               unlink(git_path("gc.log"));
> +                               return 0;
> +                       }
> +
>                         if (gc_before_repack())
>                                 return -1;
>                         /*
>                          * failure to daemonize is ok, we'll continue
>                          * in foreground
>                          */
> -                       daemonize();
> +                       if (!daemonize())
> +                               daemonized =3D 1;
>                 }
>         } else
>                 add_repack_all_option();
> @@ -343,6 +366,18 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>                     name, (uintmax_t)pid);
>         }
>
> +       if (daemonized) {
> +               int fd;
> +
> +               strbuf_addstr(&log_filename, git_path("gc.log_XXXXXX"=
));
> +               fd =3D xmkstemp(log_filename.buf);
> +               if (fd >=3D 0) {
> +                       dup2(fd, 2);
> +                       close(fd);
> +               } else
> +                       strbuf_release(&log_filename);
> +       }
> +
>         if (gc_before_repack())
>                 return -1;
>
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 63194d8..54bc9c4 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -30,4 +30,24 @@ test_expect_success 'gc -h with invalid configurat=
ion' '
>         test_i18ngrep "[Uu]sage" broken/usage
>  '
>
> +test_expect_success !MINGW 'gc --auto and logging' '
> +       git init abc &&
> +       (
> +               cd abc &&
> +               # These create blobs starting with the magic number "=
17"
> +               for i in 901 944; do
> +                       echo $i >test && git hash-object -w test >/de=
v/null
> +               done &&
> +               git config gc.auto 1 &&
> +               LANG=3DC git gc --auto &&
> +               sleep 1 && # give it time to daemonize
> +               while test -f .git/gc.pid; do sleep 1; done &&
> +               grep "too many unreachable loose objects" .git/gc.log=
 &&
> +               LANG=3DC git gc --auto 2>error &&
> +               grep skipped error &&
> +               grep "too many unreachable loose objects" error &&
> +               ! test -f .git/gc.log
> +       )
> +'
> +
>  test_done
> --
> 2.3.0.rc1.137.g477eb31
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
