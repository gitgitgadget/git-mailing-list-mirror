From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 09/24] ls-files.c: use index api
Date: Sat, 30 Nov 2013 16:17:56 +0700
Message-ID: <CACsJy8D6q5Y4uLTcxD+9pY7U9_2qkO6o-_JeciWWAwJFrsqrzQ@mail.gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com> <1385553659-9928-10-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, tr@thomasrast.ch,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 10:18:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmgh7-00062p-Gz
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 10:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325Ab3K3JSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 04:18:30 -0500
Received: from mail-qe0-f54.google.com ([209.85.128.54]:46494 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3K3JS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 04:18:27 -0500
Received: by mail-qe0-f54.google.com with SMTP id cy11so9424535qeb.41
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OXiPgNTLRREHROUC3upuHQvCUqBTBeNRHjfO9RojYw4=;
        b=IgiswnIILDCqgyecpGgLvs1NZ3EHtQ4J6K4GEt+a6mrsh+e4SrEwc8sjQMyIUGlWsk
         j6g6U74RB0NsMGp+TZO0H21aW6r050FP5rdu+RHXav+zDX/5gJFDKWgpiI9YyONEP1Oy
         5/RUgtRQYsV2yxLZGTgbok0PL2sDleqcw3mHr2qTHhfnGT76wlSw72fylddE6Z5utLu0
         L986nOeBhxsda9CW2jybL27Tr++IMg0ZZt3wgNLIDi5rFAPQjY7Vezrx8Mw90rwofdap
         MZcBKQMY2+PCmOeZO864jN0k+5MI5TJqnmpXUwz71pNdpIaOhVJP341x9KVFz/8uVC5d
         SEdg==
X-Received: by 10.224.171.196 with SMTP id i4mr95286952qaz.38.1385803106489;
 Sat, 30 Nov 2013 01:18:26 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Sat, 30 Nov 2013 01:17:56 -0800 (PST)
In-Reply-To: <1385553659-9928-10-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238550>

On Wed, Nov 27, 2013 at 7:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> @@ -447,6 +463,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>         struct dir_struct dir;
>         struct exclude_list *el;
>         struct string_list exclude_list = STRING_LIST_INIT_NODUP;
> +       struct filter_opts *opts = xmalloc(sizeof(*opts));
>         struct option builtin_ls_files_options[] = {
>                 { OPTION_CALLBACK, 'z', NULL, NULL, NULL,
>                         N_("paths are separated with NUL character"),
> @@ -512,9 +529,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>                 prefix_len = strlen(prefix);
>         git_config(git_default_config, NULL);
>
> -       if (read_cache() < 0)
> -               die("index file corrupt");
> -
>         argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
>                         ls_files_usage, 0);
>         el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
> @@ -550,6 +564,24 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>                        PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>                        prefix, argv);
>
> +       if (!with_tree && !needs_trailing_slash_stripped()) {
> +               memset(opts, 0, sizeof(*opts));
> +               opts->pathspec = &pathspec;
> +               opts->read_staged = 1;
> +               if (show_resolve_undo)
> +                       opts->read_resolve_undo = 1;
> +               if (read_cache_filtered(opts) < 0)
> +                       die("index file corrupt");
> +       } else {
> +               if (read_cache() < 0)
> +                       die("index file corrupt");
> +               parse_pathspec(&pathspec, 0,
> +                              PATHSPEC_PREFER_CWD |
> +                              PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> +                              prefix, argv);

So we ran parse_pathspec() once (not shown in the context), if found
trailing slashes, we read full cache and rerun parse_pathspec()
because the index is not loaded on the first run.

This is fine. Just a note for future improvement: as _SLASH_CHEAP only
needs to look at a few entries with cache_name_pos(), we could take
advantage of v5 to peek individual entries (or in v2, load full cache
first). Nothing needs to be done now, I think we have not decided
whether to combine _SLASH_CHEAP and _SLASH_EXPENSIVE into one.

> +       }
> +
>         /* Find common prefix for all pathspec's */
>         max_prefix = common_prefix(&pathspec);
>         max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
-- 
Duy
