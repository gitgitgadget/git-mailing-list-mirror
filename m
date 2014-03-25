From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Allow --pretty to be passed to git-describe.
Date: Tue, 25 Mar 2014 01:50:35 -0400
Message-ID: <CAPig+cTXSt7V2MkoXBxrs+L+=xzzqRqM4VTvZAju9ES4t901qg@mail.gmail.com>
References: <1395709444-11220-1-git-send-email-tipecaml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Cyril Roelandt <tipecaml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 06:50:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSKG2-00051F-3l
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 06:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbaCYFuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 01:50:37 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:64065 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbaCYFug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 01:50:36 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so6198513yho.32
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 22:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1tDDpFqwlPPQnHEr8CpfIx0vEmx4NCGvjNbWu7ydZKI=;
        b=QKymWfdehbfyoRm2DtwQZQo1fmj6XXh1QsCl7ZUOwvi23L1b/Rx5YW316FJMyCTn6u
         0ET5WuVlzLQZHNgvzcWKnOZBwhCWSShtj/MwAKM7GZdFooFhhdbMRXcbpINSAEKNRSx+
         32VlCVe23zNI3Bh8Kn3h8fwqq0whyN+w8GAB285MiEBSQIYmPo6OC7mD3NGIVjzUDAVC
         4RzCrybfU+ZtY5Y6rHMuFBmPmBgbWelETU6OEEyzPpdGe2fmsw03sVsbHV4lRWeJ8zsb
         1y9w1KJQaLspgLAWe3XRLOimHfoH8KWrLJv3xh2k4c6gNLnLKO/tIr+zfL9C2KQc78Oz
         DUMA==
X-Received: by 10.236.155.106 with SMTP id i70mr15822484yhk.38.1395726635594;
 Mon, 24 Mar 2014 22:50:35 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 24 Mar 2014 22:50:35 -0700 (PDT)
In-Reply-To: <1395709444-11220-1-git-send-email-tipecaml@gmail.com>
X-Google-Sender-Auth: 9Mp-QavO_Qa6q5GgzwugDB2qpJI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244905>

On Mon, Mar 24, 2014 at 9:04 PM, Cyril Roelandt <tipecaml@gmail.com> wrote:
> In some cases, ony may want to find the the most recent tag that is reachable

s/ony/one/

> from a commit and have it pretty printed, using the formatting options available
> in git-log and git-show.
>
> Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>
> ---
>  Documentation/git-describe.txt |  4 ++++
>  builtin/describe.c             | 39 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index d20ca40..fae4713 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -93,6 +93,10 @@ OPTIONS
>         This is useful when you wish to not match tags on branches merged
>         in the history of the target commit.
>
> +include::pretty-options.txt[]
> +
> +include::pretty-formats.txt[]
> +
>  EXAMPLES
>  --------
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 24d740c..4c0ebae 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -8,8 +8,8 @@
>  #include "diff.h"
>  #include "hashmap.h"
>  #include "argv-array.h"
> +#include "revision.h"
>
> -#define SEEN           (1u << 0)
>  #define MAX_TAGS       (FLAG_BITS - 1)
>
>  static const char * const describe_usage[] = {
> @@ -30,6 +30,8 @@ static int have_util;
>  static const char *pattern;
>  static int always;
>  static const char *dirty;
> +static const char *fmt_pretty;
> +static enum cmit_fmt commit_format;
>
>  /* diff-index command arguments to check if working tree is dirty. */
>  static const char *diff_index_args[] = {
> @@ -266,8 +268,14 @@ static void describe(const char *arg, int last_one)
>                  * Exact match to an existing ref.
>                  */
>                 display_name(n);
> -               if (longformat)
> +               if (longformat) {
>                         show_suffix(0, n->tag ? n->tag->tagged->sha1 : sha1);
> +               } else if (fmt_pretty) {
> +                       struct strbuf buf = STRBUF_INIT;
> +                       pp_commit_easy(commit_format, cmit, &buf);
> +                       printf("%s", buf.buf);
> +                       strbuf_release(&buf);
> +               }
>                 if (dirty)
>                         printf("%s", dirty);
>                 printf("\n");
> @@ -386,9 +394,16 @@ static void describe(const char *arg, int last_one)
>                 }
>         }
>
> -       display_name(all_matches[0].name);
> -       if (abbrev)
> -               show_suffix(all_matches[0].depth, cmit->object.sha1);
> +       if (fmt_pretty) {
> +               struct strbuf buf = STRBUF_INIT;
> +               pp_commit_easy(commit_format, cmit, &buf);
> +               printf("%s", buf.buf);
> +               strbuf_release(&buf);
> +       } else {
> +               display_name(all_matches[0].name);
> +               if (abbrev)
> +                       show_suffix(all_matches[0].depth, cmit->object.sha1);
> +       }
>         if (dirty)
>                 printf("%s", dirty);
>         printf("\n");
> @@ -419,6 +434,10 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>                 {OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
>                         N_("append <mark> on dirty working tree (default: \"-dirty\")"),
>                         PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
> +               OPT_STRING(0, "pretty",      &fmt_pretty, N_("pattern"),
> +                          N_("pretty print")),
> +               OPT_STRING(0, "format",      &fmt_pretty, N_("pattern"),
> +                          N_("pretty print")),
>                 OPT_END(),
>         };
>
> @@ -437,6 +456,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>         if (longformat && abbrev == 0)
>                 die(_("--long is incompatible with --abbrev=0"));
>
> +       if (longformat && fmt_pretty)
> +               die(_("--long is incompatible with --pretty"));
> +
>         if (contains) {
>                 struct argv_array args;
>
> @@ -458,6 +480,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>                 return cmd_name_rev(args.argc, args.argv, prefix);
>         }
>
> +       if (fmt_pretty) {
> +               struct rev_info rev;
> +               init_revisions(&rev, prefix);
> +               get_commit_format(fmt_pretty, &rev);
> +               commit_format = rev.commit_format;
> +       }
> +
>         hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, 0);
>         for_each_rawref(get_name, NULL);
>         if (!names.size && !always)
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
