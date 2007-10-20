From: "Scott R Parish" <srp@srparish.net>
Subject: Re: [PATCH] When exec'ing sub-commands,
      fall back on execvp (thePATH)
Date: Sat, 20 Oct 2007 03:12:17 -0500 (CDT)
Message-ID: <1192867937.v2.fusewebmail-240137@f>
Reply-To: srp@srparish.net
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 10:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij9Rq-0001a2-4H
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 10:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762503AbXJTIMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 04:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbXJTIMY
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 04:12:24 -0400
Received: from smtp-gw7.mailanyone.net ([208.70.128.55]:47426 "EHLO
	smtp-gw7.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760414AbXJTIMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 04:12:19 -0400
Received: from mailanyone.net
	by smtp-gw7.mailanyone.net with esmtpa (MailAnyone extSMTP srp)
	id 1Ij9RS-0001tJ-5P; Sat, 20 Oct 2007 03:12:18 -0500
Received: from 127.0.0.1
        (FuseMail web AccountID 240137)
        by webmail.fusemail.com with HTTP;
        Sat, 20 Oct 2007 03:12:17 -0500 (CDT)
User-Agent: FuseMail W
X-Priority: 3
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61810>

Yeah, that seems to work fine. The theoretical drawback to this approach
is that it could possibly effect the order in which the paths are tried.
For instance, if a user did "export GIT_EXEC_PATH=", then the
builtin_exec_path wouldn't be tried before the PATH. (i doubt that it
would be a problem, but thought i should note it)

sRp


----- Original Message -----
Subject: Re: [PATCH] When exec'ing sub-commands, fall back on execvp
(thePATH)
Date: Sat, October 20, 2007 0:30
From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>

> Hi,
>
> On Fri, 19 Oct 2007, Scott Parish wrote:
>
> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 9b74ed2..674c9f3 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -34,15 +34,15 @@ int execv_git_cmd(const char **argv)
> >  {
> >          char git_command[PATH_MAX + 1];
> >          int i;
> > +        int rc;
> >          const char *paths[] = { current_exec_path,
> >                                  getenv(EXEC_PATH_ENVIRONMENT),
> >                                  builtin_exec_path };
> > +        const char *tmp;
> > +        size_t len;
> >
> >          for (i = 0; i < ARRAY_SIZE(paths); ++i) {
> > -                size_t len;
> > -                int rc;
> >                  const char *exec_dir = paths[i];
> > -                const char *tmp;
> >
> >                  if (!exec_dir || !*exec_dir) continue;
> >
> > @@ -106,8 +106,26 @@ int execv_git_cmd(const char **argv)
> >
> >                  argv[0] = tmp;
> >          }
> > -        return -1;
> >
> > +        rc = snprintf(git_command, sizeof(git_command), "git-%s",
argv[0]);
> > +        if (rc < 0 || rc >= sizeof(git_command) - len) {
> > +                fprintf(stderr, "git: command name given is too
long.\n");
> > +                return -1;
> > +        }
> > +
> > +        tmp = argv[0];
> > +        argv[0] = git_command;
> > +
> > +        trace_argv_printf(argv, -1, "trace: exec:");
> > +
> > +        /* execve() can only ever return if it fails */
> > +        execvp(git_command, (char **)argv);
> > +
> > +        trace_printf("trace: exec failed: %s\n", strerror(errno));
> > +
> > +        argv[0] = tmp;
> > +
> > +        return -1;
> >  }
>
> I am not sure that this is elegant enough: Something like this (completely
> untested) might be better:
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 9b74ed2..c928f37 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
>          int i;
>          const char *paths[] = { current_exec_path,
>                                  getenv(EXEC_PATH_ENVIRONMENT),
> -                                builtin_exec_path };
> +                                builtin_exec_path,
> +                                "" };
>
>          for (i = 0; i < ARRAY_SIZE(paths); ++i) {
>                  size_t len;
> @@ -44,9 +45,12 @@ int execv_git_cmd(const char **argv)
>                  const char *exec_dir = paths[i];
>                  const char *tmp;
>
> -                if (!exec_dir || !*exec_dir) continue;
> +                if (!exec_dir) continue;
>
> -                if (*exec_dir != '/') {
> +                if (!*exec_dir)
> +                        /* try PATH */
> +                        *git_command = '\0';
> +                else if (*exec_dir != '/') {
>                          if (!getcwd(git_command, sizeof(git_command))) {
>                                  fprintf(stderr, "git: cannot determine "
>                                          "current directory: %s\n",
> @@ -81,7 +85,7 @@ int execv_git_cmd(const char **argv)
>
>                  len = strlen(git_command);
>                  rc = snprintf(git_command + len, sizeof(git_command) -
len,
> -                              "/git-%s", argv[0]);
> +                              "%sgit-%s", *exec_dir ? "/" : "", argv[0]);
>                  if (rc < 0 || rc >= sizeof(git_command) - len) {
>                          fprintf(stderr,
>                                  "git: command name given is too long.\n");
>
> Ciao,
> Dscho
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
