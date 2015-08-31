From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] submodule: implement `module_clone` as a builtin helper
Date: Mon, 31 Aug 2015 18:35:57 -0400
Message-ID: <CAPig+cQVe+qmTsqqdnTXDABxNkQoeEqz07pP2pYbY_n11XMDWA@mail.gmail.com>
References: <1441048767-29729-1-git-send-email-sbeller@google.com>
	<1441048767-29729-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 00:36:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWXgc-0003n5-D1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 00:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbbHaWgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 18:36:01 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33991 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbbHaWf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 18:35:58 -0400
Received: by qkct7 with SMTP id t7so20723200qkc.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OqNGIPb08AJQ9ao2plawvuCuERd7O9MyqdTrAShDLIs=;
        b=LdShbwuudDmNSr20Eh3n4Sk/xElp0iDVBAUEfOmc/YEMgsdhby/qKlI0oeOrOwLLBq
         gCRNoS0rS43aYTlzLUDFYDgWM7/5+jisr9kkWlW7BYEgq1fAVV+fO5DhhwjwsLBCRVdD
         v49szhprCEuAp3UBG46wo0QNpTB5issrNNq+DRDeajZ2sCQZXoTmK39Oslq22Gtx8sGA
         ydiZr57u8rOgwywFFDLhv6PI3j/xsDir7OOmsoRLE+8vv0PPr7VpX+RM0AogkHJeKkms
         Vh7BimfOZzt5Vy4J6T942foJUJ7C+6IpI1zJ3YkWZghZLVUW0RPNygNIGfN6/xZrII+e
         cAPQ==
X-Received: by 10.129.41.209 with SMTP id p200mr16876563ywp.131.1441060557287;
 Mon, 31 Aug 2015 15:35:57 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 15:35:57 -0700 (PDT)
In-Reply-To: <1441048767-29729-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: iy9CDRF7Y4mPSZIIHmOWf4lRea8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276952>

On Mon, Aug 31, 2015 at 3:19 PM, Stefan Beller <sbeller@google.com> wrote:
> `module_clone` is part of the update command,
> which I want to convert to C next.

Hmm, place commentary below "---".

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c8f7e0c..d29499c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -124,6 +125,147 @@ static int module_name(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static int clone_submodule(const char *path, const char *gitdir, const char *url,
> +                          const char *depth, const char *reference, int quiet)
> +{
> +       struct child_process cp;
> +       child_process_init(&cp);
> +
> +       argv_array_push(&cp.args, "clone");
> +       argv_array_push(&cp.args, "--no-checkout");
> +       if (quiet)
> +               argv_array_push(&cp.args, "--quiet");
> +       if (depth && strcmp(depth, "")) {

More idiomatic:

    if (depth && *depth) {

> +               argv_array_push(&cp.args, "--depth");
> +               argv_array_push(&cp.args, depth);

These would be easier to read if you consolidate them with argv_array_pushl():

    argv_array_pushl(&cp.args, "--depth", depth, NULL);

and it would allow you to drop the noisy braces.

> +       }
> +       if (reference && strcmp(reference, "")) {

    if (reference && *reference) {

> +               argv_array_push(&cp.args, "--reference");
> +               argv_array_push(&cp.args, reference);

    argv_array_pushl(&cp.args, "--reference", reference, NULL);

> +       }
> +       if (gitdir) {

Why is this case different than the others, in that it doesn't check
for the zero-length string ""?

> +               argv_array_push(&cp.args, "--separate-git-dir");
> +               argv_array_push(&cp.args, gitdir);

    argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);

> +       }
> +       argv_array_push(&cp.args, url);
> +       argv_array_push(&cp.args, path);
> +
> +       cp.git_cmd = 1;
> +       cp.env = local_repo_env;
> +
> +       cp.no_stdin = 1;
> +       cp.no_stdout = 1;
> +       cp.no_stderr = 1;
> +
> +       return run_command(&cp);
> +}
> +
> +static int module_clone(int argc, const char **argv, const char *prefix)
> +{
> +       const char *path = NULL, *name = NULL, *url = NULL;
> +       const char *reference = NULL, *depth = NULL;
> +       int quiet = 0;
> +       FILE *submodule_dot_git;
> +       const char *sm_gitdir, *p;

Why is 'sm_gitdir' declared const even though it's always pointing at
memory which this function owns and needs to free? If you drop the
'const', then you won't have to cast it to non-const in a couple
places below.

> +       struct strbuf rel_path = STRBUF_INIT;
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       struct option module_update_options[] = {
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
> +               OPT_END()
> +       };
> +
> +       static const char * const git_submodule_helper_usage[] = {

You can drop this 'static'.

> +               N_("git submodule--helper update [--prefix=<path>] [--quiet] [--remote] [-N|--no-fetch]"
> +                  "[-f|--force] [--rebase|--merge] [--reference <repository>]"
> +                  "[--depth <depth>] [--recursive] [--] [<path>...]"),
> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, module_update_options,
> +                            git_submodule_helper_usage, 0);
> +
> +       if (getenv("GIT_QUIET"))
> +               quiet = 1;

I understand that you're simply replicating the behavior of the shell
code, but this is "yuck".

'module_clone' is only called from two places in git-submodule.sh, so
how about a cleanup patch which makes 'module_clone' accept a --quiet
flag and have the two callers pass it explicitly? Finally, have this C
replacement accept --quiet as a proper command-line option rather than
via this hidden backdoor method.

> +       strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> +       sm_gitdir = strbuf_detach(&sb, NULL);
> +
> +       if (!file_exists(sm_gitdir)) {
> +               safe_create_leading_directories_const(sm_gitdir);

Why is it that the return value of
safe_create_leading_directories_const() is sometimes checked in this
function and sometimes not?

> +               if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
> +                       die(N_("Clone of '%s' into submodule path '%s' failed"),
> +                           url, path);
> +       } else {
> +               safe_create_leading_directories_const(path);
> +               unlink(sm_gitdir);

Check the return value of unlink()?

> +       }
> +
> +       /* Write a .git file in the submodule to redirect to the superproject. */
> +       if (alternative_path && !strcmp(alternative_path, "")) {

Maybe?

    if (alternative_path && !*alternative_path) {

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

Why the mix of capitalized and lowercase-only error messages in this function?

Also, the original shell code consistently uses eval_gettext(), so
_("...") seems warranted.

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

s/superprojects/superproject's/

> +       if (!is_absolute_path(sm_gitdir)) {
> +               char *s = (char*)sm_gitdir;
> +               if (strbuf_getcwd(&sb))
> +                       die_errno("unable to get current working directory");
> +               strbuf_addf(&sb, "/%s", sm_gitdir);
> +               sm_gitdir = strbuf_detach(&sb, NULL);
> +               free(s);

Why squirrel-away 'sm_gitdir' in 's' unnecessarily? Equivalent:

    if (strbuf_getcwd(&sb))
        die_errno(...);
    strbuf_addf(&sb, "/%s, sm_gitdir);
    free(sm_gitdir);
    sm_gitdir = strbuf_detach(&sb, NULL);

> +       }
> +
> +       if (strbuf_getcwd(&sb))
> +               die_errno("unable to get current working directory");

The conditional block just above here also gets 'cwd'. If you move
this code above the !is_absolute_path(sm_gitdir) conditional block,
then you can avoid the duplication.

> +       strbuf_addf(&sb, "/%s", path);
> +
> +       p = git_pathdup_submodule(path, "config");
> +       if (!p)
> +               die("Could not get submodule directory for '%s'", path);
> +       git_config_set_in_file(p, "core.worktree",
> +                              relative_path(sb.buf, sm_gitdir, &rel_path));
> +       strbuf_release(&sb);
> +       free((char *)sm_gitdir);
> +       return 0;
> +}
> +
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>  {
>         if (argc < 2)
> @@ -135,6 +277,10 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>         if (!strcmp(argv[1], "module_name"))
>                 return module_name(argc - 2, argv + 2, prefix);
>
> +       if (!strcmp(argv[1], "module_clone"))
> +               return module_clone(argc - 1, argv + 1, prefix);
> +
>  usage:
> -       usage("git submodule--helper [module_list | module_name]\n");
> +       usage("git submodule--helper [module_list | module_name | "
> +             "module_clone]\n");
>  }
> diff --git a/git-submodule.sh b/git-submodule.sh
> index e6ff38d..fb5155e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -178,80 +178,6 @@ get_submodule_config () {
>         printf '%s' "${value:-$default}"
>  }
