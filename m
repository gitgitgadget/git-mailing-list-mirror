From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH 1/1] change contract between system_path and it's callers
Date: Wed, 26 Nov 2014 09:53:34 +0600
Message-ID: <CANCZXo63q2YmTcYr9Vf99fAAnENNj7vE1nC18QJDYve=-OcXyQ@mail.gmail.com>
References: <CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com>
	<1416939854-29930-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqfvd7rnkb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 04:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtTgF-0000uN-1g
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 04:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbaKZDxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 22:53:35 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:49692 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbaKZDxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 22:53:35 -0500
Received: by mail-oi0-f50.google.com with SMTP id a141so1423699oig.37
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 19:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vhOHEfsDTGFdnYv9ScFbhHlqVEukXxwcP0JZPgZY1p0=;
        b=bTHfbUV02TUL9rqTkKS8J7r5h/M1/u+HiGcJezYw6ZobtWixgDUR6obvEcUI6qC4re
         +I3Kva5Qz1CUMDXGyV0OGbuFg81OSn3BZB3o5+ZsQe3WN2QmSo3xcbcT2TuUbzN1vzeB
         F+OatjGR8qI4wefMcW9B6TM509JMM+fFhxXkh3vkDjC52sOUk/ijRqXDphQJemIWPy4E
         3Hu6Ity11SVrKcmuRgHufpDrLjCmg8xIj7Yjy+L3sTe99qs+skIq7PXAglwGABqQz8xb
         ZGXon57IT0yeu9MUnh6TKg90opOWMUHA9m78zaGm+j+5SYemNDQvfL53SxkwNhTIpaVR
         tnDw==
X-Received: by 10.60.55.200 with SMTP id u8mr18517694oep.43.1416974014301;
 Tue, 25 Nov 2014 19:53:34 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Tue, 25 Nov 2014 19:53:34 -0800 (PST)
In-Reply-To: <xmqqfvd7rnkb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260267>

>
> Comparing this with what I sent out...
>
> >  builtin/help.c | 10 +++++++---
> >  exec_cmd.c     | 17 +++++++++--------
> >  exec_cmd.h     |  4 ++--
> >  git.c          | 16 ++++++++++++----
> >  4 files changed, 30 insertions(+), 17 deletions(-)
> >
> > @@ -372,7 +373,9 @@ static void show_man_page(const char *git_cmd)
> >  static void show_info_page(const char *git_cmd)
> >  {
> >       const char *page = cmd_to_page(git_cmd);
> > -     setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
> > +     char *git_info_path = system_path(GIT_INFO_PATH);
> > +     setenv("INFOPATH", git_info_path, 1);
> > +     free(git_info_path);
>
> We are just about to exec; does this warrant the code churn?

hmm... Can't understand what's the problem here? We get git_info_path
from system_path which returns pointer which will need to free, set it in
environment var and than free it...

>
> >       execlp("info", "info", "gitman", page, (char *)NULL);
> >       die(_("no info viewer handled the request"));
>
> > @@ -34,8 +34,7 @@ const char *system_path(const char *path)
> >  #endif
> >
> >       strbuf_addf(&d, "%s/%s", prefix, path);
> > -     path = strbuf_detach(&d, NULL);
> > -     return path;
> > +     return d.buf;
>
> These happens to be the same with the current strbuf implementation,
> but it is a good manner to use strbuf_detach(&d, NULL) here.  We
> don't know what other de-initialization tomorrow's implementation of
> the strbuf API may have to do in strbuf_detach().

How to do it in correct way?


    strbuf_addf(&d, "%s/%s", prefix, path);
    path = strbuf_detach(&d, NULL);
    return (char*)path;

Or something else?

>
> > @@ -68,16 +67,16 @@ void git_set_argv_exec_path(const char *exec_path)
> >
> >
> >  /* Returns the highest-priority, location to look for git programs. */
> > -const char *git_exec_path(void)
> > +char *git_exec_path(void)
> >  {
> >       const char *env;
> >
> >       if (argv_exec_path)
> > -             return argv_exec_path;
> > +             return strdup(argv_exec_path);
> >
> >       env = getenv(EXEC_PATH_ENVIRONMENT);
> >       if (env && *env) {
> > -             return env;
> > +             return strdup(env);
> >       }
>
> Now you are making callers of git_exec_path() responsible for
> freeing the result they receive.
>
> git_exec_path() may be called quite a lot, which means we may end up
> calling system_path() many times during the life of a process
> without freeing its return value, so this change may be worth doing,
> but this patch is insufficient, isn't it?
>
> You just added load_command_list() in help.c a new leak or two, for
> example.  There probably are other callers of this function but I
> don't have time to look at all of them myself right now.

Yes, need to do that all git_exec_path() callers free result of git_exec_path.

>
> > @@ -95,8 +94,10 @@ void setup_path(void)
> >  {
> >       const char *old_path = getenv("PATH");
> >       struct strbuf new_path = STRBUF_INIT;
> > +     char* exec_path = git_exec_path();
> >
> > -     add_path(&new_path, git_exec_path());
> > +     add_path(&new_path, exec_path);
> > +     free(exec_path);
> >       add_path(&new_path, argv0_path);
>
> This part by itself is good, provided if we make it the caller's
> responsiblity to free string returned by git_exec_path().
>
> > diff --git a/git.c b/git.c
> > index 82d7a1c..d01c4f1 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -95,17 +95,25 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> >                       if (*cmd == '=')
> >                               git_set_argv_exec_path(cmd + 1);
> >                       else {
> > -                             puts(git_exec_path());
> > +                             char *exec_path = git_exec_path();
> > +                             puts(exec_path);
> > +                             free(exec_path);
> >                               exit(0);
> >                       }
> >               } else if (!strcmp(cmd, "--html-path")) {
> > -                     puts(system_path(GIT_HTML_PATH));
> > +                     char *git_html_path = system_path(GIT_HTML_PATH);
> > +                     puts(git_html_path);
> > +                     free(git_html_path);
> >                       exit(0);
> >               } else if (!strcmp(cmd, "--man-path")) {
> > -                     puts(system_path(GIT_MAN_PATH));
> > +                     char *git_man_path = system_path(GIT_MAN_PATH);
> > +                     puts(git_man_path);
> > +                     free(git_man_path);
> >                       exit(0);
> >               } else if (!strcmp(cmd, "--info-path")) {
> > -                     puts(system_path(GIT_INFO_PATH));
> > +                     char *git_info_path = system_path(GIT_INFO_PATH);
> > +                     puts(git_info_path);
> > +                     free(git_info_path);
> >                       exit(0);
> >               } else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
> >                       use_pager = 1;
>
> None of these warrant the code churn, I would say.

Sorry, english is not my first language, what did you mean when saying:
"code churn"? Code duplication or something else?
