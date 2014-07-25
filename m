From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 11:37:09 -0400
Message-ID: <CAPig+cSyLtUmkxAcO+iatKSS2t2T5byXRrJYq=MSuBoZ3m=hcw@mail.gmail.com>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 17:37:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAhYf-0005eu-AP
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 17:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbaGYPhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 11:37:12 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:46697 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbaGYPhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 11:37:11 -0400
Received: by mail-yk0-f181.google.com with SMTP id q200so2904936ykb.12
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tiZ1zVpVQGDzBM5j61r/s9msrtLtWOZGAMZP4av6cso=;
        b=t73gf4l84glJxgvTN3YmaVwScgzEgLetJooZDglLb+EZ8giSafutvzf+B1om0cNxHS
         pZ2Z0oxXXB7gXsLTnhb2MVsPRRaFGv2MQFbBh7ihUOaxxWhQFQvPkcGqd3P4o0qi7nzJ
         Nuy0AzOF1+IcCxPG95lMcZS0EHhbbRnAdnXfprBNpygUbw5BIyhrfBxRAj4hFAttevnh
         DbFrf/FL1o6NsHg3zUyJnJEgYIdE2rFGh8Ft4p8/vuxBv+D6jbQouBcTouiNzE5nA28R
         Wv9kkuzDS0TMtXq6qmU7Rxzs4K70ez7cG8zVTwqZTKxjNoaay7wAcNR2KTSU1eiY6hR4
         9k3A==
X-Received: by 10.236.110.110 with SMTP id t74mr5813017yhg.162.1406302629993;
 Fri, 25 Jul 2014 08:37:09 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Fri, 25 Jul 2014 08:37:09 -0700 (PDT)
In-Reply-To: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: Ko69LPVh-h5MM1hyuRoxxY_cVaU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254226>

On Fri, Jul 25, 2014 at 9:44 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> When the user has no ~/.gitconfig file, git config --global --edit used
> to launch an editor on an nonexistant file name.
>
> Instead, create a file with a default content before launching the
> editor. The template contains only commented-out entries, to save a few
> keystrokes for the user. If the values are guessed properly, the user
> will only have to uncomment the entries.
>
> Advanced users teaching newbies can create a minimalistic configuration
> faster for newbies. Beginners reading a tutorial advising to run "git
> config --global --edit" as a first step will be slightly more guided for
> their first contact with Git.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  builtin/config.c | 30 +++++++++++++++++++++++++++---
>  cache.h          |  1 +
>  ident.c          |  2 +-
>  3 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index fcd8474..3821697 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -445,6 +445,20 @@ static int get_urlmatch(const char *var, const char *url)
>         return 0;
>  }
>
> +static char *default_user_config()
> +{
> +       struct strbuf buf = STRBUF_INIT;
> +       strbuf_addf(&buf,
> +                   _("# This is Git's user-wide configuration file.\n"
> +                     "[core]\n"
> +                     "# Please, adapt and uncomment the following lines:\n"
> +                     "#        user = %s\n"
> +                     "#        email = %s\n"),

"[core]", "user =", "email =" should not be translated. Would it make
sense to keep these outside of _()?

> +                   ident_default_name(),
> +                   ident_default_email());
> +       return strbuf_detach(&buf, NULL);
> +}
> +
>  int cmd_config(int argc, const char **argv, const char *prefix)
>  {
>         int nongit = !startup_info->have_repository;
> @@ -551,6 +565,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>                 }
>         }
>         else if (actions == ACTION_EDIT) {
> +               const char *config_file = given_config_source.file ?
> +                       given_config_source.file : git_path("config");
>                 check_argc(argc, 0, 0);
>                 if (!given_config_source.file && nongit)
>                         die("not in a git directory");
> @@ -559,9 +575,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>                 if (given_config_source.blob)
>                         die("editing blobs is not supported");
>                 git_config(git_default_config, NULL);
> -               launch_editor(given_config_source.file ?
> -                             given_config_source.file : git_path("config"),
> -                             NULL, NULL);
> +               if (use_global_config) {
> +                       int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
> +                       if (fd) {
> +                               char *content = default_user_config();
> +                               write_str_in_full(fd, content);

close(fd);

> +                               free(content);
> +                       }
> +                       else if (errno != EEXIST)
> +                               die_errno(_("Cannot create configuration file %s"), config_file);

Other error messages in this file (including those just above this
block) begin with a lowercase letter.

> +               }
> +               launch_editor(config_file, NULL, NULL);
>         }
>         else if (actions == ACTION_SET) {
>                 int ret;
> diff --git a/cache.h b/cache.h
> index 2f63fd1..8c79c0c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1061,6 +1061,7 @@ extern const char *git_author_info(int);
>  extern const char *git_committer_info(int);
>  extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
>  extern const char *fmt_name(const char *name, const char *email);
> +extern const char *ident_default_name(void);
>  extern const char *ident_default_email(void);
>  extern const char *git_editor(void);
>  extern const char *git_pager(int stdout_is_tty);
> diff --git a/ident.c b/ident.c
> index 1d9b6e7..77bc882 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -102,7 +102,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
>         add_domainname(email);
>  }
>
> -static const char *ident_default_name(void)
> +const char *ident_default_name(void)
>  {
>         if (!git_default_name.len) {
>                 copy_gecos(xgetpwuid_self(), &git_default_name);
> --
> 2.0.2.737.gfb43bde
