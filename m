From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 3/3] submodule: implement `module-clone` as a builtin helper
Date: Mon, 31 Aug 2015 22:41:21 -0400
Message-ID: <CAPig+cRgSb5bD-pOH1rQ-ES61-aPKktXz8-LX-sB9kCqLrCWaw@mail.gmail.com>
References: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
	<1441068029-19158-1-git-send-email-sbeller@google.com>
	<1441068029-19158-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:41:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWbVm-0003fD-V9
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 04:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbbIAClX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 22:41:23 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35566 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317AbbIAClW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 22:41:22 -0400
Received: by qkcj187 with SMTP id j187so27673984qkc.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 19:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZUv7cqXUT1yufWaWcMcFjhj9ncoAkg3hmk8JUF7W/w8=;
        b=e0wr8tOA66Qtzc7ZZtGA2E2YppLPLoLJTniIe47lt7rsnl0z9k9qb0AXCDoSkqENFV
         luqnQ41pCVvnQRC4AN36ORUirr02tOiHh3s81GoZMg1BhB+a3OE/c6NchOnTYMCM0KZ0
         4/UMYJSRqNR+8mK/cQEQALet3F3vBlYo7w8IYBTZRP3brJaLa5mO0Kbcn9YA4EKxVM7Q
         VkpSp0wF/SPkAbNrAdNSHsRtjgqet2TEJdzbGWOfRQDcRIEI5rcsjXD8KhPjglNX3IZJ
         TY0BWAVpldJOFhztem2jCwoyyK9VJXC1ILXtq0S/OiXJDcmSevT0UaMVamTNSvtFPRQA
         8PmQ==
X-Received: by 10.129.92.8 with SMTP id q8mr24411817ywb.163.1441075281972;
 Mon, 31 Aug 2015 19:41:21 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 19:41:21 -0700 (PDT)
In-Reply-To: <1441068029-19158-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: NxwxfpiOI4tTzikGklDQ3bD7ytY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276966>

On Mon, Aug 31, 2015 at 8:40 PM, Stefan Beller <sbeller@google.com> wrote:
> This converts implements the helper `module_clone`. This functionality is

"converts implements"?

> needed for converting `git submodule update` later on, which we want to
> add threading to.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
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
> +       struct option module_update_options[] = {

s/update/clone/ maybe?

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
> +       static const char * const git_submodule_helper_usage[] = {

You can still drop 'static'.

> +               N_("git submodule--helper update [--prefix=<path>] [--quiet] [--remote] [-N|--no-fetch]"

"update"?

> +                  "[-f|--force] [--rebase|--merge] [--reference <repository>]"
> +                  "[--depth <depth>] [--recursive] [--] [<path>...]"),

Also, what's all this "--force", "--rebase", "--remote", "--recursive" stuff?

> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, module_update_options,
> +                            git_submodule_helper_usage, 0);
> +
> +       strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> +       sm_gitdir = strbuf_detach(&sb, NULL);
> +
> +       if (!file_exists(sm_gitdir)) {
> +               safe_create_leading_directories_const(sm_gitdir);

Still inconsistent checking of return value of
safe_create_leading_directories_const() in this function.

In fact, it looks like pretty much all of my v2 review comments are
still relevant to the remainder of this function. Rather than
repeating them, I'll just give a reference[1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/276952

> +               if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
> +                       die(N_("Clone of '%s' into submodule path '%s' failed"),
> +                           url, path);
> +       } else {
> +               safe_create_leading_directories_const(path);
> +               unlink(sm_gitdir);
> +       }
> +
> +       /* Write a .git file in the submodule to redirect to the superproject. */
> +       if (alternative_path && !strcmp(alternative_path, "")) {
> +               p = relative_path(path, alternative_path, &sb);
> +               strbuf_reset(&sb);
> +       } else
> +               p = path;
> +
> +       if (safe_create_leading_directories_const(p) < 0)
> +               die("Could not create directory '%s'", p);
> +
> +       strbuf_addf(&sb, "%s/.git", p);
> +
> +       if (safe_create_leading_directories_const(sb.buf) < 0)
> +               die(_("could not create leading directories of '%s'"), sb.buf);
> +       submodule_dot_git = fopen(sb.buf, "w");
> +       if (!submodule_dot_git)
> +               die ("Cannot open file '%s': %s", sb.buf, strerror(errno));
> +
> +       fprintf(submodule_dot_git, "gitdir: %s\n",
> +               relative_path(sm_gitdir, path, &rel_path));
> +       if (fclose(submodule_dot_git))
> +               die("Could not close file %s", sb.buf);
> +       strbuf_reset(&sb);
> +
> +       /* Redirect the worktree of the submodule in the superprojects config */
> +       if (!is_absolute_path(sm_gitdir)) {
> +               char *s = (char*)sm_gitdir;
> +               if (strbuf_getcwd(&sb))
> +                       die_errno("unable to get current working directory");
> +               strbuf_addf(&sb, "/%s", sm_gitdir);
> +               sm_gitdir = strbuf_detach(&sb, NULL);
> +               free(s);
> +       }
> +
> +       if (strbuf_getcwd(&sb))
> +               die_errno("unable to get current working directory");
> +       strbuf_addf(&sb, "/%s", path);
> +
> +       p = git_pathdup_submodule(path, "config");
> +       if (!p)
> +               die("Could not get submodule directory for '%s'", path);
> +       git_config_set_in_file(p, "core.worktree",
> +                              relative_path(sb.buf, sm_gitdir, &rel_path));
> +       strbuf_release(&sb);
> +       free(sm_gitdir);
> +       return 0;
> +}
