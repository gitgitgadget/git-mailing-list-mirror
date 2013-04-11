From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 2/3] Teach mv to move submodules using a gitfile
Date: Thu, 11 Apr 2013 14:07:11 +0530
Message-ID: <CALkWK0kUdKfAp36HSdoTOK_Wt-Rs_4f3HKHLbLi8e3pzx0iEGw@mail.gmail.com>
References: <515C88FE.9020203@web.de> <515C8987.2060804@web.de>
 <7vwqsbnvxz.fsf@alter.siamese.dyndns.org> <51659A8A.80605@web.de> <5165D469.2020603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 11 10:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQD16-0006LC-Ti
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 10:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161538Ab3DKIhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 04:37:55 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:34052 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab3DKIhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 04:37:51 -0400
Received: by mail-ia0-f178.google.com with SMTP id f27so1184447iae.23
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 01:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZdTDr8JeHHCsUvEpo8GJ3g/uG0aDkLO5Gw/0/ddjyd8=;
        b=pB3raPgM4KMudXVsadaxJ36+pHUw4aH6TcToVslk6vjg27bv7Vod8j8C2FIins2hWC
         YaOYq5b4yZsS0EnfR7NNUaIFq2dHkC7oT9Kh9GTMGt2j2Jgn7R39XVK/QQk4XOZAkuBN
         +LNVSIEJyCgeGX6ouh3lTWSngt0LomC/Jt398aqKdPSugtbq9Z6u/v951E67/M6Fn5H2
         kGk+GYXv1xK8VRqfP5v8M6X5KA38YD00pnek64zXr5e+qdj7+LktwV7lYm64+uFajzHi
         JuWFNX/RPG7hneqJ6vbctp6SegIWr5UC7AQ1oYM24DKOF3yc7n0yvp7/FAd5XRFRdsCg
         Diog==
X-Received: by 10.50.17.166 with SMTP id p6mr15619512igd.12.1365669471445;
 Thu, 11 Apr 2013 01:37:51 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 01:37:11 -0700 (PDT)
In-Reply-To: <5165D469.2020603@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220834>

Jens Lehmann wrote:
> When moving a submodule which uses a gitfile to point to the git directory
> stored in .git/modules/<name> of the superproject two changes must be made
> to make the submodule work: the .git file and the core.worktree setting
> must be adjusted to point from work tree to git directory and back.

Isn't it untrue that the git directory is stored in
.git/modules/<name>: it is stored in .git/modules/path/to/module.  I
thought the whole point of this complex scheme was to avoid name
conflicts with submodules with the same name in other directories.
Then why aren't you moving the object store as well?  What happens if
I try to create a submodule in the old path of this moved submodule in
the future?  How will you fail, and how will the user recover from
this?

A nit on the wording.  Perhaps: "the .git file in the worktree must be
adjusted to point to $GITDIR, and core.worktree must be set to point
to the worktree."

> Achieve that by remembering which submodule uses a gitfile by storing the
> result of read_gitfile() of each submodule. If that is not NULL the new
> function connect_work_tree_and_git_dir() is called after renaming the
> submodule's work tree which updates the two settings to the new values.

Oh God.  Can't you figure out at mv-time if the submodule uses a
gitfile?  Why are you storing it?  Where are you storing it exactly?

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 361028d..609bbb8 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -9,6 +9,7 @@
>  #include "cache-tree.h"
>  #include "string-list.h"
>  #include "parse-options.h"
> +#include "submodule.h"
>
>  static const char * const builtin_mv_usage[] = {
>         N_("git mv [options] <source>... <destination>"),
> @@ -65,7 +66,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                 OPT_BOOLEAN('k', NULL, &ignore_errors, N_("skip move/rename errors")),
>                 OPT_END(),
>         };
> -       const char **source, **destination, **dest_path;
> +       const char **source, **destination, **dest_path, **submodule_gitfile;
>         enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
>         struct stat st;
>         struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
> @@ -84,6 +85,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>         source = copy_pathspec(prefix, argv, argc, 0);
>         modes = xcalloc(argc, sizeof(enum update_mode));
>         dest_path = copy_pathspec(prefix, argv + argc, 1, 0);
> +       submodule_gitfile = xcalloc(argc, sizeof(char *));

This is cmd_mv, and you're allocating argc number of char * pointers
to submodule_gitfile.  Why?  Are you guaranteed that there are argc
number of submodule_gitfiles?

>         if (dest_path[0][0] == '\0')
>                 /* special case: "." was normalized to "" */
> @@ -119,8 +121,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                 else if (src_is_dir) {
>                         int first = cache_name_pos(src, length);
>                         if (first >= 0) {
> +                               struct strbuf submodule_dotgit = STRBUF_INIT;
>                                 if (!S_ISGITLINK(active_cache[first]->ce_mode))
>                                         die (_("Huh? Directory %s is in index and no submodule?"), src);
> +                               strbuf_addf(&submodule_dotgit, "%s/.git", src);
> +                               submodule_gitfile[i] = read_gitfile(submodule_dotgit.buf);

What?!  read_gitfile() returns the path to the git directory, if it is
found.  How are you assigning the path to a $GITDIR to a variable
named submodule_gitfile?

> +                               if (submodule_gitfile[i])
> +                                       submodule_gitfile[i] = xstrdup(submodule_gitfile[i]);

Doesn't read as smoothly, but saves you an extra char *.  Okay.

> +                               strbuf_release(&submodule_dotgit);
>                         } else {
>                                 const char *src_w_slash = add_slash(src);
>                                 int last, len_w_slash = length + 1;
> @@ -215,9 +223,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                 int pos;
>                 if (show_only || verbose)
>                         printf(_("Renaming %s to %s\n"), src, dst);
> -               if (!show_only && mode != INDEX &&
> -                               rename(src, dst) < 0 && !ignore_errors)
> -                       die_errno (_("renaming '%s' failed"), src);
> +               if (!show_only && mode != INDEX) {
> +                       if (rename(src, dst) < 0 && !ignore_errors)
> +                               die_errno (_("renaming '%s' failed"), src);
> +                       if (submodule_gitfile[i])
> +                               connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
> +               }

Okay, scratch my previous comment about allocating argc char *
pointers for submodule_gitfile().  Since your logic is in a loop that
loops argc times, you really have no choice.

> diff --git a/submodule.c b/submodule.c
> index 975bc87..9a3eb85 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1001,3 +1001,67 @@ int merge_submodule(unsigned char result[20], const char *path,
>         free(merges.objects);
>         return 0;
>  }
> +
> +/* Update gitfile and core.worktree setting to connect work tree and git dir */
> +void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
> +{
> +       struct strbuf core_worktree_setting = STRBUF_INIT;
> +       struct strbuf configfile_name = STRBUF_INIT;
> +       struct strbuf gitfile_content = STRBUF_INIT;
> +       struct strbuf gitfile_name = STRBUF_INIT;
> +       const char *real_work_tree = real_path(work_tree);
> +       const char *pathspec[] = { real_work_tree, git_dir, NULL };
> +       const char *max_prefix = common_prefix(pathspec);
> +       FILE *fp;
> +
> +       if (max_prefix) {       /* skip common prefix */
> +               size_t max_prefix_len = strlen(max_prefix);
> +               real_work_tree += max_prefix_len;
> +               git_dir += max_prefix_len;
> +       }
> +
> +       /*
> +        * Update gitfile
> +        */
> +       strbuf_addstr(&gitfile_content, "gitdir: ");
> +       if (real_work_tree[0]) {
> +               const char *s = real_work_tree;
> +               do {
> +                       strbuf_addstr(&gitfile_content, "../");
> +                       s++;
> +               } while ((s = strchr(s, '/')));
> +       }
> +       strbuf_addstr(&gitfile_content, git_dir);
> +       strbuf_addch(&gitfile_content, '\n');

Yuck.  Just yuck.  Why don't you just fopen the gitfile and write one
line to it directly (ie. the absolute path of the worktree)?  Why do
you need a strbuf for this at all?  Ah, absolute paths would break if
you moved the entire superproject to a different location.  This is
reason #347 I don't like keeping GITDIRs in the superproject's
.git/modules/.  In any case, why don't you use relative_path() in
path.c instead of reinventing the wheel?

> +       strbuf_addf(&gitfile_name, "%s/.git", work_tree);

Why work_tree, not real_work_tree?
strbuf is an overkill for this: why not mkpath()?

> +       fp = fopen(gitfile_name.buf, "w");
> +       if (!fp)
> +               die(_("Could not create git link %s"), gitfile_name.buf);
> +       fprintf(fp, "%s", gitfile_content.buf);

Not checking the return value of fprintf() for possible failure?

> +       fclose(fp);
> +
> +       strbuf_release(&gitfile_content);
> +       strbuf_release(&gitfile_name);
> +
> +       /*
> +        * Update core.worktree setting
> +        */
> +       if (git_dir[0]) {
> +               const char *s = git_dir;
> +               do {
> +                       strbuf_addstr(&core_worktree_setting, "../");
> +                       s++;
> +               } while ((s = strchr(s, '/')));
> +       }

Can't use relative_path()?

> +       strbuf_addstr(&core_worktree_setting, real_work_tree);
> +
> +       strbuf_addf(&configfile_name, "%s/config", git_dir);

mkpath() to avoid the strbuf.  If you have to use strbufs, why aren't
you re-using a "pathbuf" strbuf?
