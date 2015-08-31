From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] submodule: implement `module_list` as a builtin helper
Date: Mon, 31 Aug 2015 17:55:07 -0400
Message-ID: <CAPig+cSOFPAca=m4TaiY6xeeB3eYPC+Rtj15JQ7WZ=CK_gmpFw@mail.gmail.com>
References: <1441048767-29729-1-git-send-email-sbeller@google.com>
	<1441048767-29729-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 23:55:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWX2r-0000d8-T2
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 23:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbbHaVzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 17:55:10 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35150 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbbHaVzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 17:55:08 -0400
Received: by qkcj187 with SMTP id j187so19422808qkc.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vPLtBHoSWGK5yY6nnhTlYOCjY5bca8dWi7RQjzFIXdo=;
        b=W5LGeTKeLM5Y0q9uYgIr9qJTTFm6dIo/YgquaSsdSHPrXiJSh0RYZ9wEROVMC/GIp1
         4tDeDpAwGfhBU6EVcsRsth3ulP2hEWtzwY7pfwMTo9sG8N97t2zy+rwJxpwpqvxPtUZv
         Tt2E7EuUEOvk3c66A58h0mcyROGuoLb9bPPChSFPS6s3FiDeow0CKmBWb4qH5k9fen16
         KNXaq3WAjHE4bU76ihYaBmaTuioMLHU57IFaxOgdH75pUZvi1R3xHRJTNtHXlkEtG26q
         hhPxad+3IUZrwNpjdwEx5xIj76eg73171rnhqvMV+dSOVti/7KTzwYDDaO6N+DIicC9x
         gD5Q==
X-Received: by 10.13.201.130 with SMTP id l124mr24316645ywd.39.1441058107973;
 Mon, 31 Aug 2015 14:55:07 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 14:55:07 -0700 (PDT)
In-Reply-To: <1441048767-29729-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: wZl3X8aAShsAcVawWy-OX6LI1lc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276947>

On Mon, Aug 31, 2015 at 3:19 PM, Stefan Beller <sbeller@google.com> wrote:
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
> git-submodule.sh similar to the builtin commands will navigate
> to the top most directory of the repository and keeping the
> subdirectories as a variable.

ECANNOTPARSE

Did you mean
    s/git-submodule.sh/&,/
    s/commands/&,/
    s/top most/top-most/
    s/keeping/keep/
    s/subdirectories/subdirectory/
?

> As the helper is called from
> within the git-submodule.sh script, we are already navigated
> to the root level, but the path arguments are stil relative

s/stil/still/

> to the subdirectory we were in when calling git-submodule.sh.
> That's why there is a `--prefix` option pointing to an alternative
> path where to anchor relative path arguments.

s/where to/at which to/

More below.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> new file mode 100644
> index 0000000..beaab7d
> --- /dev/null
> +++ b/builtin/submodule--helper.c
> @@ -0,0 +1,114 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "quote.h"
> +#include "pathspec.h"
> +#include "dir.h"
> +#include "utf8.h"
> +
> +static const struct cache_entry **ce_entries;
> +static int ce_alloc, ce_used;
> +static const char *alternative_path;

Why is 'alternative_path' declared at file scope?

> +static int module_list_compute(int argc, const char **argv,
> +                               const char *prefix,
> +                               struct pathspec *pathspec)
> +{
> +       int i;
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
> +
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
> +               return -1;
> +
> +       return 0;

Does 'ps_matched' need to be freed before these two 'return's?

> +}
> +
> +static int module_list(int argc, const char **argv, const char *prefix)
> +{
> +       int i;
> +       static struct pathspec pathspec;

Drop 'static'.

> +
> +       struct option module_list_options[] = {
> +               OPT_STRING(0, "prefix", &alternative_path,
> +                          N_("path"),
> +                          N_("alternative anchor for relative paths")),
> +               OPT_END()
> +       };
> +
> +       static const char * const git_submodule_helper_usage[] = {

You can drop this 'static' too.

Style: *const

> +               N_("git submodule--helper module_list [--prefix=<path>] [<path>...]"),
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
> +               if (ce_stage(ce)) {
> +                       printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
> +               } else {
> +                       printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
> +               }

Style: drop unnecessary braces.

> +               utf8_fprintf(stdout, "%s\n", ce->name);
> +       }
> +       return 0;
> +}
> +
> +int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> +{
> +       if (argc < 2)
> +               goto usage;
> +
> +       if (!strcmp(argv[1], "module_list"))
> +               return module_list(argc - 1, argv + 1, prefix);
> +
> +usage:
> +       usage("git submodule--helper module_list\n");

Aside:
[bikeshedding on]

I agree with Dscho that these subcommands would be better spelled with
a hyphen than an underscore. If I recall correctly, the arguments for
using underscore were (1) a less noisy diff, (2) these are internal
commands nobody will be typing anyhow. However, (1) the diff noise
will be the same with hyphens, and (2) people will want to test these
commands manually anyhow, and its easier to type hyphens and easier to
remember them since the precedent for hyphens in command-names is
already well established.

Also, the reason that the original shell code used underscores was
because hyphens are not valid characters in shell function names, but
that's an implementation detail which shouldn't be allowed to bleed
over to user-facing interface design (and these subcommands are
user-facing).

[bikeshedding off]
