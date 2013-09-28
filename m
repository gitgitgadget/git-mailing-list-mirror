From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] gc: remove gc.pid file at end of execution
Date: Sat, 28 Sep 2013 10:42:41 +0700
Message-ID: <CACsJy8Ax1YypAnVb0FAQPsvvZixq0aJHP=ahfMaXn26KTaN1VA@mail.gmail.com>
References: <1380187098-8519-1-git-send-email-Matthieu.Moy@imag.fr> <20130928003319.GR9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 28 05:43:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPlRI-0001kV-Gm
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 05:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673Ab3I1DnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 23:43:12 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45045 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660Ab3I1DnL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 23:43:11 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so2576125oag.24
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ul/hXj4fCnM1LxzPCvHnYVI3xPNzAhr3ueh1hjDOlp8=;
        b=rhAfHH+B4+wqDnvJY2MLzv6ksv6Odwg3VfUZsM4EInnGkT+mgVgooqfCuUMQpj+awg
         4AvHq0fUnfRYdjmDkEIuMFy8y3uduN8Z1tjD9y4X1GUiIneP9yuPFAbmVoIlQ/EoWpsi
         tWk2xvWKAsmFk5tMJUDIxF+DjR5+CDaoZqXE99XE30pJJCK+7Ci7d2N/pjc4BAaVXTLO
         eqEODlDEJMKPRIhLa8bBBf9a9oxG4QPWQKlXwU3Tps5u5tzOf0hMst56wN3TImkQAsZM
         /Wklz/tcg72F5zGhXmbSwYXlgwM+Nw6/wWR4PYv3bOX9iy+z+9Kxx/41n+sOCOmgQAjx
         IlSA==
X-Received: by 10.182.44.134 with SMTP id e6mr8872167obm.14.1380339791107;
 Fri, 27 Sep 2013 20:43:11 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Fri, 27 Sep 2013 20:42:41 -0700 (PDT)
In-Reply-To: <20130928003319.GR9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235487>

On Sat, Sep 28, 2013 at 7:33 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Matthieu Moy wrote:
>
>> This file isn't really harmful, but isn't useful either, and can create
>> minor annoyance for the user:
>
> Would something like the following make sense, to ensure the gc.pid file is
> always removed on normal exit?
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> diff --git c/builtin/gc.c i/builtin/gc.c
> index 6e0d81a..fbbc144 100644
> --- c/builtin/gc.c
> +++ i/builtin/gc.c
> @@ -14,6 +14,7 @@
>  #include "cache.h"
>  #include "parse-options.h"
>  #include "run-command.h"
> +#include "sigchain.h"
>  #include "argv-array.h"
>
>  #define FAILED_RUN "failed to run %s"
> @@ -167,6 +168,21 @@ static int need_to_gc(void)
>         return 1;
>  }
>
> +static char *pidfile;
> +
> +static void remove_pidfile(void)
> +{
> +       if (pidfile)
> +               unlink(pidfile);
> +}
> +
> +static void remove_pidfile_on_signal(int signo)
> +{
> +       remove_pidfile();
> +       sigchain_pop(signo);
> +       raise(signo);
> +}
> +
>  /* return NULL on success, else hostname running the gc */
>  static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  {
> @@ -179,13 +195,19 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>         FILE *fp;
>         int fd, should_exit;
>
> +       if (pidfile)
> +               /* already locked */
> +               return NULL;
> +
>         if (gethostname(my_host, sizeof(my_host)))
>                 strcpy(my_host, "unknown");
>
> -       fd = hold_lock_file_for_update(&lock, git_path("gc.pid"),
> +       pidfile = git_pathdup("gc.pid");
> +
> +       fd = hold_lock_file_for_update(&lock, pidfile,
>                                        LOCK_DIE_ON_ERROR);
>         if (!force) {
> -               fp = fopen(git_path("gc.pid"), "r");
> +               fp = fopen(pidfile, "r");
>                 memset(locking_host, 0, sizeof(locking_host));
>                 should_exit =
>                         fp != NULL &&
> @@ -208,6 +230,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>                 if (should_exit) {
>                         if (fd >= 0)
>                                 rollback_lock_file(&lock);
> +                       pidfile = NULL;
>                         *ret_pid = pid;
>                         return locking_host;
>                 }
> @@ -219,6 +242,9 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>         strbuf_release(&sb);

It may be a bit simpler to delay setting pidfile until we get here.
lock.filename still contains gc.pid until commit_lock_file is called.

>         commit_lock_file(&lock);
>
> +       sigchain_push_common(remove_pidfile_on_signal);
> +       atexit(remove_pidfile);
> +
>         return NULL;
>  }
-- 
Duy
