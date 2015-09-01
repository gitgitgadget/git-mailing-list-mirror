From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4 3/3] submodule: implement `clone` as a builtin helper
Date: Tue, 1 Sep 2015 14:52:54 -0400
Message-ID: <CAPig+cRxQdquKZXdmpiZjj8JFB2wdCE4UcbW6qYUwvtZsVw=ug@mail.gmail.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
	<1441131869-29474-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 20:53:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqfz-0007rU-Ma
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbbIASw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:52:56 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36156 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbIASwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:52:55 -0400
Received: by qkbp67 with SMTP id p67so55390461qkb.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+jjAKFMR8Bsi+FJtAqDOYOKFB1s3opyOUUtt6XdHLx8=;
        b=CsHLAZLAaACvA8JRgQhNYaJv+KsmBfg8Uf8zSbc/Elpw58/L1KRRKq8ewN8VRuyzb2
         Smqaa9A6myvy1J4PRcNUmbFLvqk9pvVQd92rkKWzjY5WWureK5TsjwHI0zGOAP7eXcnU
         30DK4UNFpgbJ9UQOnaNxOEIY/yIpeJxhzGOl8RzaoNd5/TccI36KvusrzDuYZQn7U/zE
         Kraf8zi+vcUsbuN7Tzz9+gjH4ZANA7X6Aqif5xzOYcaXG/X1cxLtRb1Mu3g0ez5AMjMO
         aHIvG89ba5bv9fbT2IXac7McPpsR4vGkb21+L48EAC6dRJV6BcuPJig9OZ89YfTgTHQR
         3V2Q==
X-Received: by 10.129.92.8 with SMTP id q8mr29583126ywb.163.1441133574481;
 Tue, 01 Sep 2015 11:52:54 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Tue, 1 Sep 2015 11:52:54 -0700 (PDT)
In-Reply-To: <1441131869-29474-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: IZbWMSVH4qQxzdkrgYr3SIGkVr0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277027>

On Tue, Sep 1, 2015 at 2:24 PM, Stefan Beller <sbeller@google.com> wrote:
> This converts implements the helper `module_clone`. This functionality is

Mentioned previously[1]: "converts implements"?

[1]: http://article.gmane.org/gmane.comp.version-control.git/276966

> needed for converting `git submodule update` later on, which we want to
> add threading to.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f5e408a..63f535a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> +static int module_clone(int argc, const char **argv, const char *prefix)
> +{
> +       const char *path = NULL, *name = NULL, *url = NULL;
> +       const char *reference = NULL, *depth = NULL;
> +       const char *alternative_path = NULL, *p;
> +       int quiet = 0;
> +       FILE *submodule_dot_git;
> +       char *sm_gitdir;
> +       struct strbuf rel_path = STRBUF_INIT;
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       struct option module_clone_options[] = {
> +               OPT_STRING(0, "prefix", &alternative_path,
> +                          N_("path"),
> +                          N_("alternative anchor for relative paths")),
> +               OPT_STRING(0, "path", &path,
> +                          N_("path"),
> +                          N_("where the new submodule will be cloned to")),
> +               OPT_STRING(0, "name", &name,
> +                          N_("string"),
> +                          N_("name of the new submodule")),
> +               OPT_STRING(0, "url", &url,
> +                          N_("string"),
> +                          N_("url where to clone the submodule from")),
> +               OPT_STRING(0, "reference", &reference,
> +                          N_("string"),
> +                          N_("reference repository")),
> +               OPT_STRING(0, "depth", &depth,
> +                          N_("string"),
> +                          N_("depth for shallow clones")),
> +               OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
> +               OPT_END()
> +       };
> +
> +       const char * const git_submodule_helper_usage[] = {

Style: *const

> +               N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
> +                  "[--reference <repository>] [--name <name>] [--url <url>]"
> +                  "[--depth <depth>] [--] [<path>...]"),
> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, module_clone_options,
> +                            git_submodule_helper_usage, 0);
> +
> +       strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> +       sm_gitdir = strbuf_detach(&sb, NULL);
> +
> +       if (!file_exists(sm_gitdir)) {
> +               if (safe_create_leading_directories_const(sm_gitdir) < 0)
> +                       die(_("could not create directory '%s'"), sm_gitdir);
> +               if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
> +                       die(N_("clone of '%s' into submodule path '%s' failed"),
> +                           url, path);

s/N_/_/

> +       } else {
> +               if (safe_create_leading_directories_const(path) < 0)
> +                       die(_("could not create directory '%s'"), path);
> +               if (unlink(sm_gitdir) < 0)
> +                       die_errno(_("failed to delete '%s'"), sm_gitdir);
> +       }
> +
> +       /* Write a .git file in the submodule to redirect to the superproject. */
> +       if (alternative_path && *alternative_path)) {
> +               p = relative_path(path, alternative_path, &sb);
> +               strbuf_reset(&sb);
> +       } else
> +               p = path;
> +
> +       if (safe_create_leading_directories_const(p) < 0)
> +               die(_("could not create directory '%s'"), p);
> +
> +       strbuf_addf(&sb, "%s/.git", p);
> +
> +       if (safe_create_leading_directories_const(sb.buf) < 0)
> +               die(_("could not create leading directories of '%s'"), sb.buf);
> +       submodule_dot_git = fopen(sb.buf, "w");
> +       if (!submodule_dot_git)
> +               die (_("cannot open file '%s': %s"), sb.buf, strerror(errno));

Style: drop space before '('

Also, can't you use die_errno() here?

> +       fprintf(submodule_dot_git, "gitdir: %s\n",
> +               relative_path(sm_gitdir, path, &rel_path));
> +       if (fclose(submodule_dot_git))
> +               die(_("could not close file %s"), sb.buf);
> +       strbuf_reset(&sb);
> +
> +       /* Redirect the worktree of the submodule in the superproject's config */
> +       if (strbuf_getcwd(&sb))
> +               die_errno(_("unable to get current working directory"));
> +
> +       if (!is_absolute_path(sm_gitdir)) {
> +               if (strbuf_getcwd(&sb))
> +                       die_errno(_("unable to get current working directory"));

Why does this need to call getcwd() on 'sb' when it was called
immediately above the conditional and its value hasn't changed?

> +               strbuf_addf(&sb, "/%s", sm_gitdir);
> +               free(sm_gitdir);
> +               sm_gitdir = strbuf_detach(&sb, NULL);
> +       }
> +
> +
> +       strbuf_addf(&sb, "/%s", path);
> +
> +       p = git_pathdup_submodule(path, "config");
> +       if (!p)
> +               die(_("could not get submodule directory for '%s'"), path);
> +       git_config_set_in_file(p, "core.worktree",
> +                              relative_path(sb.buf, sm_gitdir, &rel_path));
> +       strbuf_release(&sb);

Is 'rel_path' being leaked here?

> +       free(sm_gitdir);
> +       return 0;
> +}
>
>  struct cmd_struct {
>         const char *cmd;
> @@ -132,6 +271,7 @@ struct cmd_struct {
>  static struct cmd_struct commands[] = {
>         {"list", module_list},
>         {"name", module_name},
> +       {"clone", module_clone},
>  };
