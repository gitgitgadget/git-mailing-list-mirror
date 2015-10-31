From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Fri, 30 Oct 2015 20:11:21 -0600
Message-ID: <CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
	<20151030193151.GB5336@sigill.intra.peff.net>
	<xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
	<CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 03:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsLdg-00041J-0S
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 03:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbbJaCLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 22:11:23 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34631 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbJaCLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 22:11:22 -0400
Received: by padhk11 with SMTP id hk11so89940039pad.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SG+IDAARtyJcjNnaAgbf6//o/GdZtm7uWsHE7ekeobs=;
        b=FioG5lourtajfiSjyjg3k3WdoqFX4aWqVoluOSy4P/hYeQbsPYDp3OlD3K8/tiDDlN
         q5+1rW4cq8dPKU9xFwOnUqE2L/xlIoQS9AZi5kOdT3xuAX714rS2AEEhlPnkAjGhFsDT
         MX66M2IdRhomaxpaS/sOOWxCwQwwylXydtMrvT7/+UyV0PEtXDJy1ka+ockEyk9n7O0O
         GFeGpxqM+T3QOp4v0FNWHm7Mwk9qu2DvNicWq5/FLyFXPrkuf6L7TLqU8gYd+rAfLRru
         kxgxiovBzGU5psxdZGy9ZKl1lMWfoGYNxaUHN8beJX7RxTe8wCRMzNGdM/XvJ/upiH0H
         TfMA==
X-Received: by 10.68.134.232 with SMTP id pn8mr12223611pbb.47.1446257482031;
 Fri, 30 Oct 2015 19:11:22 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Fri, 30 Oct 2015 19:11:21 -0700 (PDT)
In-Reply-To: <CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280565>

Ok.... this is like the previous patch (on top of my patch) but does
post_processing right after parse_options and so there's no need for
the function I had introduced before. Hope it can get your blessings
so I can send-email the _second_ patch for this feature (following the
one that has already being merged into pu, right?).

 builtin/checkout.c | 32 +++++++++++++++-----------------
1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e28c36b..9e78835 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -27,8 +27,6 @@ static const char * const checkout_usage[] = {
       NULL,
};

-static int option_progress = -1;
-
struct checkout_opts {
       int patch_mode;
       int quiet;
@@ -39,6 +37,7 @@ struct checkout_opts {
       int overwrite_ignore;
       int ignore_skipworktree;
       int ignore_other_worktrees;
+       int show_progress;

       const char *new_branch;
       const char *new_branch_force;
@@ -419,19 +418,7 @@ static int reset_tree(struct tree *tree, const
struct checkout_opts *o,
       opts.reset = 1;
       opts.merge = 1;
       opts.fn = oneway_merge;
-       /**
-        * Rules to display progress:
-        * -q is selected
-        *      no verbiage
-        * -q is _not_ selected and --no-progress _is_ selected,
-        *      progress will be skipped
-        * -q is _not_ selected and --progress _is_ selected,
-        *      progress will be printed to stderr
-        * -q is _not_ selected and --progress is 'undefined'
-        *      progress will be printed to stderr _if_ working on a terminal
-        */
-       opts.verbose_update = !o->quiet && (option_progress > 0 ||
-                                          (option_progress < 0 && isatty(2)));
+       opts.verbose_update = o->show_progress;
       opts.src_index = &the_index;
       opts.dst_index = &the_index;
       parse_tree(tree);
@@ -515,7 +502,7 @@ static int merge_working_tree(const struct
checkout_opts *opts,
               topts.update = 1;
               topts.merge = 1;
               topts.gently = opts->merge && old->commit;
-               topts.verbose_update = !opts->quiet && isatty(2);
+               topts.verbose_update = opts->show_progress;
               topts.fn = twoway_merge;
               if (opts->overwrite_ignore) {
                       topts.dir = xcalloc(1, sizeof(*topts.dir));
@@ -1170,7 +1157,7 @@ int cmd_checkout(int argc, const char **argv,
const char *prefix)
                               N_("second guess 'git checkout
<no-such-branch>'")),
               OPT_BOOL(0, "ignore-other-worktrees",
&opts.ignore_other_worktrees,
                        N_("do not check if another worktree is
holding the given ref")),
-               OPT_BOOL(0, "progress", &option_progress, N_("force
progress reporting")),
+               OPT_BOOL(0, "progress", &opts.show_progress, N_("force
progress reporting")),
               OPT_END(),
       };

@@ -1178,6 +1165,7 @@ int cmd_checkout(int argc, const char **argv,
const char *prefix)
       memset(&new, 0, sizeof(new));
       opts.overwrite_ignore = 1;
       opts.prefix = prefix;
+       opts.show_progress = -1;

       gitmodules_config();
       git_config(git_checkout_config, &opts);
@@ -1187,6 +1175,16 @@ int cmd_checkout(int argc, const char **argv,
const char *prefix)
       argc = parse_options(argc, argv, prefix, options, checkout_usage,
                            PARSE_OPT_KEEP_DASHDASH);

+       /*
+        * Final processing of show_progress
+        * Any of these 3 conditions will make progress output be skipped:
+        * - selected --quiet
+        * - selected --no-progress
+        * - didn't select --progress and not working on a terminal
+        */
+       opts.show_progress = !opts.quiet && opts.show_progress &&
+                            (opts.show_progress >= 0 || isatty(2));
+
       if (conflict_style) {
               opts.merge = 1; /* implied */
               git_xmerge_config("merge.conflictstyle", conflict_style, NULL);

On Fri, Oct 30, 2015 at 6:58 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Fri, Oct 30, 2015 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Actually, using a single variable is my preference.  In this case I
>> wanted to illustrate that the value parsed by parse_options() does
>> not have to be the one that is used in the final location deep in
>> the callchain for educational purposes, and I found it clearer to
>> use two separate variables in the illustration.
>
> From all your feedback, I think I got a working example not using the
> static variable, also reworked the wording to explain in what cases
> progress will be skipped.
>
> So... on top of my patch, I think this sums it up:
>
>  builtin/checkout.c | 33 ++++++++++++++++-----------------
> 1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e28c36b..a2e5cd3 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -27,8 +27,6 @@ static const char * const checkout_usage[] = {
>        NULL,
> };
>
> -static int option_progress = -1;
> -
> struct checkout_opts {
>        int patch_mode;
>        int quiet;
> @@ -39,6 +37,7 @@ struct checkout_opts {
>        int overwrite_ignore;
>        int ignore_skipworktree;
>        int ignore_other_worktrees;
> +       int show_progress;
>
>        const char *new_branch;
>        const char *new_branch_force;
> @@ -406,6 +405,17 @@ static void describe_detached_head(const char
> *msg, struct commit *commit)
>        strbuf_release(&sb);
> }
>
> +/*
> + * Any of these conditions will make progress output be skipped:
> + * - selected --quiet
> + * - selected --no-progress
> + * - (didn't select --progress nor --no-progress) and not working on a terminal
> + */
> +static int verbose_update(const struct checkout_opts *o)
> +{
> +       return !o->quiet && o->show_progress && (o->show_progress >= 0
> || isatty(2));
> +}
> +
> static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>                      int worktree, int *writeout_error)
> {
> @@ -419,19 +429,7 @@ static int reset_tree(struct tree *tree, const
> struct checkout_opts *o,
>        opts.reset = 1;
>        opts.merge = 1;
>        opts.fn = oneway_merge;
> -       /**
> -        * Rules to display progress:
> -        * -q is selected
> -        *      no verbiage
> -        * -q is _not_ selected and --no-progress _is_ selected,
> -        *      progress will be skipped
> -        * -q is _not_ selected and --progress _is_ selected,
> -        *      progress will be printed to stderr
> -        * -q is _not_ selected and --progress is 'undefined'
> -        *      progress will be printed to stderr _if_ working on a terminal
> -        */
> -       opts.verbose_update = !o->quiet && (option_progress > 0 ||
> -                                          (option_progress < 0 && isatty(2)));
> +       opts.verbose_update = verbose_update(o);
>        opts.src_index = &the_index;
>        opts.dst_index = &the_index;
>        parse_tree(tree);
> @@ -515,7 +513,7 @@ static int merge_working_tree(const struct
> checkout_opts *opts,
>                topts.update = 1;
>                topts.merge = 1;
>                topts.gently = opts->merge && old->commit;
> -               topts.verbose_update = !opts->quiet && isatty(2);
> +               topts.verbose_update = verbose_update(opts);
>                topts.fn = twoway_merge;
>                if (opts->overwrite_ignore) {
>                        topts.dir = xcalloc(1, sizeof(*topts.dir));
> @@ -1170,7 +1168,7 @@ int cmd_checkout(int argc, const char **argv,
> const char *prefix)
>                                N_("second guess 'git checkout
> <no-such-branch>'")),
>                OPT_BOOL(0, "ignore-other-worktrees",
> &opts.ignore_other_worktrees,
>                         N_("do not check if another worktree is
> holding the given ref")),
> -               OPT_BOOL(0, "progress", &option_progress, N_("force
> progress reporting")),
> +               OPT_BOOL(0, "progress", &opts.show_progress, N_("force
> progress reporting")),
>                OPT_END(),
>        };
>
> @@ -1178,6 +1176,7 @@ int cmd_checkout(int argc, const char **argv,
> const char *prefix)
>        memset(&new, 0, sizeof(new));
>        opts.overwrite_ignore = 1;
>        opts.prefix = prefix;
> +       opts.show_progress = -1;
>
>        gitmodules_config();
>        git_config(git_checkout_config, &opts);
