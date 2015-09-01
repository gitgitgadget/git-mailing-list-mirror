From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 1/3] submodule: implement `module-list` as a builtin helper
Date: Mon, 31 Aug 2015 22:22:40 -0400
Message-ID: <CAPig+cSF=xM5YYh_pzGFtowpSTjkX9A-ENbmsBMX7gkB8nMU4g@mail.gmail.com>
References: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
	<1441068029-19158-1-git-send-email-sbeller@google.com>
	<1441068029-19158-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:23:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWbDx-00051B-N1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 04:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbbIACWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 22:22:42 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36018 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbbIACWm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 22:22:42 -0400
Received: by qkbp67 with SMTP id p67so26952594qkb.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YqUspgTCmP2xuqfmxvnDeESFOk+ojQi5+lGDGLMZy1o=;
        b=TabKyg9UWX4Q0PTovJslSF1jk6XYzSlcjC+FnwIa96Gfp3EWFGTWkkY4w0ykQLkDdh
         JAMds3FyKwsbgG32uhGNddBAZGclcFrb+XbMgU6g1o/MoEsxOXKo6G9sYWYoiYiJtty1
         2hSRED4v8ckpxhRezG4TFihgMOsTwIVe9/fhpU2mYkrEKpdeu5HpBNd8ATkB3x6kDyZq
         DP9jn9BUH8A0qGfvx4qRmu2rG6HdQvMWtqbDgzev6MAiw2uv/O9HCJDSzDVfPFXCBp0k
         issgNwNXfO5XcR91A5SHSSG8JJVMkzP87kKeQ+RRUFgwjBGo1B5T4DsIXd3RoGEoJN4S
         GHgg==
X-Received: by 10.13.201.130 with SMTP id l124mr25312019ywd.39.1441074161050;
 Mon, 31 Aug 2015 19:22:41 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 19:22:40 -0700 (PDT)
In-Reply-To: <1441068029-19158-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: MduKGo5V8v57UfjZr0GWN37WxZE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276964>

On Mon, Aug 31, 2015 at 8:40 PM, Stefan Beller <sbeller@google.com> wrote:
> Most of the submodule operations work on a set of submodules.
> Calculating and using this set is usually done via:
>
>        module_list "$@" | {
>            while read mode sha1 stage sm_path
>            do
>                 # the actual operation
>            done
>        }
>
> Currently the function `module_list` is implemented in the
> git-submodule.sh as a shell script wrapping a perl script.
> The rewrite is in C, such that it is faster and can later be
> easily adapted when other functions are rewritten in C.
>
> git-submodule.sh, similar to the builtin commands, will navigate
> to the top-most directory of the repository and keep the
> subdirectory as a variable. As the helper is called from
> within the git-submodule.sh script, we are already navigated
> to the root level, but the path arguments are still relative
> to the subdirectory we were in when calling git-submodule.sh.
> That's why there is a `--prefix` option pointing to an alternative
> path which to anchor relative path arguments.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> new file mode 100644
> index 0000000..44310f5
> --- /dev/null
> +++ b/builtin/submodule--helper.c
> +static int module_list_compute(int argc, const char **argv,
> +                               const char *prefix,
> +                               struct pathspec *pathspec)
> +{
> +       int i, result = 0;
> +       char *max_prefix, *ps_matched = NULL;
> +       int max_prefix_len;
> +       parse_pathspec(pathspec, 0,
> +                      PATHSPEC_PREFER_FULL |
> +                      PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> +                      prefix, argv);
> +
> +       /* Find common prefix for all pathspec's */
> +       max_prefix = common_prefix(pathspec);
> +       max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> +
> +       if (pathspec->nr)
> +               ps_matched = xcalloc(pathspec->nr, 1);
> +
> +       if (read_cache() < 0)
> +               die("index file corrupt");

die(_("..."));

> +       for (i = 0; i < active_nr; i++) {
> +               const struct cache_entry *ce = active_cache[i];
> +
> +               if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +                                   max_prefix_len, ps_matched,
> +                                   S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
> +                       continue;
> +
> +               if (S_ISGITLINK(ce->ce_mode)) {
> +                       ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
> +                       ce_entries[ce_used++] = ce;
> +               }
> +
> +               while (i + 1 < active_nr && !strcmp(ce->name, active_cache[i + 1]->name))
> +                       /*
> +                        * Skip entries with the same name in different stages
> +                        * to make sure an entry is returned only once.
> +                        */
> +                       i++;
> +       }
> +       free(max_prefix);
> +
> +       if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
> +               result = -1;
> +
> +       free(ps_matched);
> +
> +       return result;
> +}
> +
> +static int module_list(int argc, const char **argv, const char *prefix)
> +{
> +       int i;
> +       struct pathspec pathspec;
> +       const char *alternative_path;
> +
> +       struct option module_list_options[] = {
> +               OPT_STRING(0, "prefix", &alternative_path,
> +                          N_("path"),
> +                          N_("alternative anchor for relative paths")),
> +               OPT_END()
> +       };
> +
> +       const char *const git_submodule_helper_usage[] = {
> +               N_("git submodule--helper module_list [--prefix=<path>] [<path>...]"),

s/module_list/module-list/

> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, module_list_options,
> +                            git_submodule_helper_usage, 0);
> +
> +       if (module_list_compute(argc, argv, alternative_path
> +                                           ? alternative_path
> +                                           : prefix, &pathspec) < 0) {
> +               printf("#unmatched\n");
> +               return 1;
> +       }
> +
> +       for (i = 0; i < ce_used; i++) {
> +               const struct cache_entry *ce = ce_entries[i];
> +
> +               if (ce_stage(ce))
> +                       printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
> +               else
> +                       printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
> +
> +               utf8_fprintf(stdout, "%s\n", ce->name);
> +       }
> +       return 0;
> +}
> +
> +int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> +{
> +       if (argc < 2)
> +               die(N_("fatal: submodule--helper subcommand must be called with "
> +                      "a subcommand, which is module-list\n"));
> +
> +       if (!strcmp(argv[1], "module-list"))

Can we drop the "module-" prefix altogether from these subcommands,
please? Considering that the parent name is already
"submodule--helper", the "module-" prefix is probably pure redundancy.
Instead:

    submodule--helper list
    submodule--helper name
    submodule--helper clone

> +               return module_list(argc - 1, argv + 1, prefix);
> +
> +       die(N_("fatal: '%s' is not a valid submodule--helper subcommand, "
> +              "which is module-list\n"),
> +           argv[1]);
> +}
