From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] When exec'ing sub-commands, fall back on execvp
	(thePATH)
Date: Sat, 20 Oct 2007 13:57:26 -0700
Message-ID: <20071020205721.GA16291@srparish.net>
References: <1192867937.v2.fusewebmail-240137@f>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 03:55:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQ25-0001c8-EQ
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbXJUByc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbXJUByb
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:54:31 -0400
Received: from smtp-gw3.mailanyone.net ([208.101.54.178]:36866 "EHLO
	smtp-gw3.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbXJUBy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 21:54:28 -0400
Received: from mailanyone.net
	by smtp-gw3.mailanyone.net with esmtp (MailAnyone extSMTP)
	id 1IjLUX-0005y3-8T; Sat, 20 Oct 2007 16:04:17 -0500
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjLNy-00045M-Ud; Sat, 20 Oct 2007 15:57:31 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sat, 20 Oct 2007 13:57:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1192867937.v2.fusewebmail-240137@f>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61859>

Actually, i didn't test it right, execve() were using the files in
my cwd. In addition to you patch, you'd need to use execvp() instead
of execve().

sRp

On Sat, Oct 20, 2007 at 03:12:17AM -0500, Scott R Parish wrote:

> Yeah, that seems to work fine. The theoretical drawback to this approach
> is that it could possibly effect the order in which the paths are tried.
> For instance, if a user did "export GIT_EXEC_PATH=", then the
> builtin_exec_path wouldn't be tried before the PATH. (i doubt that it
> would be a problem, but thought i should note it)
> 
> sRp
> 
> 
> ----- Original Message -----
> Subject: Re: [PATCH] When exec'ing sub-commands, fall back on execvp
> (thePATH)
> Date: Sat, October 20, 2007 0:30
> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> 
> > Hi,
> >
> > On Fri, 19 Oct 2007, Scott Parish wrote:
> >
> > > diff --git a/exec_cmd.c b/exec_cmd.c
> > > index 9b74ed2..674c9f3 100644
> > > --- a/exec_cmd.c
> > > +++ b/exec_cmd.c
> > > @@ -34,15 +34,15 @@ int execv_git_cmd(const char **argv)
> > >  {
> > >          char git_command[PATH_MAX + 1];
> > >          int i;
> > > +        int rc;
> > >          const char *paths[] = { current_exec_path,
> > >                                  getenv(EXEC_PATH_ENVIRONMENT),
> > >                                  builtin_exec_path };
> > > +        const char *tmp;
> > > +        size_t len;
> > >
> > >          for (i = 0; i < ARRAY_SIZE(paths); ++i) {
> > > -                size_t len;
> > > -                int rc;
> > >                  const char *exec_dir = paths[i];
> > > -                const char *tmp;
> > >
> > >                  if (!exec_dir || !*exec_dir) continue;
> > >
> > > @@ -106,8 +106,26 @@ int execv_git_cmd(const char **argv)
> > >
> > >                  argv[0] = tmp;
> > >          }
> > > -        return -1;
> > >
> > > +        rc = snprintf(git_command, sizeof(git_command), "git-%s",
> argv[0]);
> > > +        if (rc < 0 || rc >= sizeof(git_command) - len) {
> > > +                fprintf(stderr, "git: command name given is too
> long.\n");
> > > +                return -1;
> > > +        }
> > > +
> > > +        tmp = argv[0];
> > > +        argv[0] = git_command;
> > > +
> > > +        trace_argv_printf(argv, -1, "trace: exec:");
> > > +
> > > +        /* execve() can only ever return if it fails */
> > > +        execvp(git_command, (char **)argv);
> > > +
> > > +        trace_printf("trace: exec failed: %s\n", strerror(errno));
> > > +
> > > +        argv[0] = tmp;
> > > +
> > > +        return -1;
> > >  }
> >
> > I am not sure that this is elegant enough: Something like this (completely
> > untested) might be better:
> >
> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 9b74ed2..c928f37 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
> >          int i;
> >          const char *paths[] = { current_exec_path,
> >                                  getenv(EXEC_PATH_ENVIRONMENT),
> > -                                builtin_exec_path };
> > +                                builtin_exec_path,
> > +                                "" };
> >
> >          for (i = 0; i < ARRAY_SIZE(paths); ++i) {
> >                  size_t len;
> > @@ -44,9 +45,12 @@ int execv_git_cmd(const char **argv)
> >                  const char *exec_dir = paths[i];
> >                  const char *tmp;
> >
> > -                if (!exec_dir || !*exec_dir) continue;
> > +                if (!exec_dir) continue;
> >
> > -                if (*exec_dir != '/') {
> > +                if (!*exec_dir)
> > +                        /* try PATH */
> > +                        *git_command = '\0';
> > +                else if (*exec_dir != '/') {
> >                          if (!getcwd(git_command, sizeof(git_command))) {
> >                                  fprintf(stderr, "git: cannot determine "
> >                                          "current directory: %s\n",
> > @@ -81,7 +85,7 @@ int execv_git_cmd(const char **argv)
> >
> >                  len = strlen(git_command);
> >                  rc = snprintf(git_command + len, sizeof(git_command) -
> len,
> > -                              "/git-%s", argv[0]);
> > +                              "%sgit-%s", *exec_dir ? "/" : "", argv[0]);
> >                  if (rc < 0 || rc >= sizeof(git_command) - len) {
> >                          fprintf(stderr,
> >                                  "git: command name given is too long.\n");
> >
> > Ciao,
> > Dscho
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Scott Parish
http://srparish.net/
