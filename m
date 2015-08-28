From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 10:00:00 -0700
Message-ID: <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:00:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVN0c-0007Wy-Vm
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbbH1RAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:00:04 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35810 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbbH1RAB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:00:01 -0400
Received: by ykay144 with SMTP id y144so6155847yka.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6WaDnmmND5v1v4FwujgDUZqA1g9QaPaQZMJIck18nF0=;
        b=PRISLP9xvHOtrmX15wYSVJC5iAKCviNM/THRW8jNqnZ4jolg3CF2Ifmwk0wHdpwP/X
         4ZuoTo4Vbni4L5gXtDX3MRWUkbisEFOpz9wLogeebVGHgiq61X94ZgFx35uKDKICEROU
         segF2ugR/2dt61US44tEaAVCdaE/Al3V361PW/bBeVO2UCDlJwyXY0olbDOfP/r7L6ql
         PwNAVnrgy8RU1usShXPUwiIXGZ1crm43D157QRmSwmliapp1HpCrjAFSCR/RTiU90SLt
         Jelo+dppzNk6YT7SEqgaDYYdO5bxVY33LzkdHSh1UAfazAP/BHRSAvfGoNbB/eAri/KX
         EOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6WaDnmmND5v1v4FwujgDUZqA1g9QaPaQZMJIck18nF0=;
        b=elT2c1VZxQZ8sB7Xfow76AI3IKe0KRuHnGZSxouiDsrOOtrj9Yt9OWpxyr4Std97tj
         B+6yG6s+tu71VWUihbQCgSZ41Ji3I8H/JshYO5He3E1V8AfkPHiAhYau+R0dKdQ5JuyM
         cy7tQ72LlUOOAnCoGFwt4wzgWh7sJmordUIGJDPGtCYcjeA56rns9HekB0zcmOUyac3Y
         FBwLimtIb1H1xV63y4vyQbcWwBduk/8p0hmfmQkCe7Ez650l/8oncDoiagAAQkSlrR2K
         CyahiWvInokgqgcXYQ2UtzYU/T792iqJhyiI7+kMWef8V7IHFoIl0u8sLbEfy5i8lVBL
         JqQA==
X-Gm-Message-State: ALoCoQnKKIv6SFazEZBK2HBdJhKkTmXQOgoWelpP7i1Z2gM7Wcd5OElY5jS6alxCo33zj12ha6z8
X-Received: by 10.170.112.194 with SMTP id e185mr9171229ykb.119.1440781201038;
 Fri, 28 Aug 2015 10:00:01 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 28 Aug 2015 10:00:00 -0700 (PDT)
In-Reply-To: <1440724495-708-8-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276730>

On Thu, Aug 27, 2015 at 6:14 PM, Stefan Beller <sbeller@google.com> wrote:
> This makes use of the new task queue and the syncing feature of
> run-command to fetch a number of submodules at the same time.
>
> The output will look like it would have been run sequential,
> but faster.

And it breaks the tests t5526-fetch-submodules.sh as the output is done
on stderr only, instead of putting "Fetching submodule <submodule-path>
to stdout. :(

I guess combining stdout and stderr is not a good strategy after all now.
Advantages:
* The order is preserved if everything is in one stream.
Disadvantages:
* It's a change, which may not be expected.
* It's harder to make it machine parsable, as that probably
   relied on having 2 channels.

So now I need to come up with a way to either buffer 2 channels at the same
time, or we need to redefine parallel submodule fetch output semantics a bit.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/fetch-options.txt |   7 +++
>  builtin/fetch.c                 |   6 ++-
>  builtin/pull.c                  |   6 +++
>  submodule.c                     | 100 +++++++++++++++++++++++++++++++++-------
>  submodule.h                     |   2 +-
>  5 files changed, 102 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 45583d8..e2a59c3 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -100,6 +100,13 @@ ifndef::git-pull[]
>         reference to a commit that isn't already in the local submodule
>         clone.
>
> +-j::
> +--jobs=<n>::
> +       Number of threads to be used for fetching submodules. Each thread
> +       will fetch from different submodules, such that fetching many
> +       submodules will be faster. By default the number of cpus will
> +       be used .
> +
>  --no-recurse-submodules::
>         Disable recursive fetching of submodules (this has the same effect as
>         using the '--recurse-submodules=no' option).
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ee1f1a9..636707e 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -37,6 +37,7 @@ static int prune = -1; /* unspecified */
>  static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
>  static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  static int tags = TAGS_DEFAULT, unshallow, update_shallow;
> +static int max_threads;
>  static const char *depth;
>  static const char *upload_pack;
>  static struct strbuf default_rla = STRBUF_INIT;
> @@ -99,6 +100,8 @@ static struct option builtin_fetch_options[] = {
>                     N_("fetch all tags and associated objects"), TAGS_SET),
>         OPT_SET_INT('n', NULL, &tags,
>                     N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
> +       OPT_INTEGER('j', "jobs", &max_threads,
> +                   N_("number of threads used for fetching")),
>         OPT_BOOL('p', "prune", &prune,
>                  N_("prune remote-tracking branches no longer on remote")),
>         { OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
> @@ -1217,7 +1220,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>                 result = fetch_populated_submodules(&options,
>                                                     submodule_prefix,
>                                                     recurse_submodules,
> -                                                   verbosity < 0);
> +                                                   verbosity < 0,
> +                                                   max_threads);
>                 argv_array_clear(&options);
>         }
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 722a83c..fbbda67 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -94,6 +94,7 @@ static int opt_force;
>  static char *opt_tags;
>  static char *opt_prune;
>  static char *opt_recurse_submodules;
> +static char *max_threads;
>  static int opt_dry_run;
>  static char *opt_keep;
>  static char *opt_depth;
> @@ -177,6 +178,9 @@ static struct option pull_options[] = {
>                 N_("on-demand"),
>                 N_("control recursive fetching of submodules"),
>                 PARSE_OPT_OPTARG),
> +       OPT_PASSTHRU('j', "jobs", &max_threads, N_("n"),
> +               N_("number of threads used for fetching submodules"),
> +               PARSE_OPT_OPTARG),
>         OPT_BOOL(0, "dry-run", &opt_dry_run,
>                 N_("dry run")),
>         OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
> @@ -524,6 +528,8 @@ static int run_fetch(const char *repo, const char **refspecs)
>                 argv_array_push(&args, opt_prune);
>         if (opt_recurse_submodules)
>                 argv_array_push(&args, opt_recurse_submodules);
> +       if (max_threads)
> +               argv_array_push(&args, max_threads);
>         if (opt_dry_run)
>                 argv_array_push(&args, "--dry-run");
>         if (opt_keep)
> diff --git a/submodule.c b/submodule.c
> index 9fcc86f..50266a8 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -12,6 +12,7 @@
>  #include "sha1-array.h"
>  #include "argv-array.h"
>  #include "blob.h"
> +#include "thread-utils.h"
>
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
>  static struct string_list changed_submodule_paths;
> @@ -615,13 +616,79 @@ static void calculate_changed_submodule_paths(void)
>         initialized_fetch_ref_tips = 0;
>  }
>
> +struct submodule_parallel_fetch {
> +       struct child_process cp;
> +       struct argv_array argv;
> +       int *result;
> +};
> +
> +#ifndef NO_PTHREADS
> +static pthread_mutex_t output_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
> +static void set_output_mutex(struct submodule_parallel_fetch *spf)
> +{
> +       spf->cp.sync_mutex = &output_mutex;
> +}
> +
> +#define lock_output_mutex() pthread_mutex_lock(&output_mutex)
> +
> +#define unlock_output_mutex() pthread_mutex_unlock(&output_mutex)
> +
> +static void destroy_output_mutex()
> +{
> +       pthread_mutex_destroy(&output_mutex);
> +}
> +
> +#else
> +#define set_output_mutex()
> +#define destroy_output_mutex()
> +#define lock_output_mutex()
> +#define unlock_output_mutex()
> +#endif
> +
> +static struct submodule_parallel_fetch *submodule_parallel_fetch_create()
> +{
> +       struct submodule_parallel_fetch *spf = xmalloc(sizeof(*spf));
> +       child_process_init(&spf->cp);
> +       spf->cp.env = local_repo_env;
> +       spf->cp.git_cmd = 1;
> +       spf->cp.no_stdin = 1;
> +       spf->cp.stdout_to_stderr = 1;
> +       spf->cp.sync_buf = xmalloc(sizeof(spf->cp.sync_buf));
> +       strbuf_init(spf->cp.sync_buf, 0);
> +
> +       argv_array_init(&spf->argv);
> +       return spf;
> +}
> +
> +static int run_command_and_cleanup(struct task_queue *tq, void *arg)
> +{
> +       int code;
> +       struct submodule_parallel_fetch *spf = arg;
> +
> +       spf->cp.argv = spf->argv.argv;
> +
> +       code = run_command(&spf->cp);
> +       if (code) {
> +               lock_output_mutex();
> +               *spf->result = code;
> +               unlock_output_mutex();
> +       }
> +
> +       argv_array_clear(&spf->argv);
> +       free((char*)spf->cp.dir);
> +       free(spf);
> +       return 0;
> +}
> +
>  int fetch_populated_submodules(const struct argv_array *options,
>                                const char *prefix, int command_line_option,
> -                              int quiet)
> +                              int quiet, int max_parallel_jobs)
>  {
>         int i, result = 0;
> -       struct child_process cp = CHILD_PROCESS_INIT;
> +       struct task_queue *tq;
>         struct argv_array argv = ARGV_ARRAY_INIT;
> +       struct submodule_parallel_fetch *spf;
>         const char *work_tree = get_git_work_tree();
>         if (!work_tree)
>                 goto out;
> @@ -635,12 +702,9 @@ int fetch_populated_submodules(const struct argv_array *options,
>         argv_array_push(&argv, "--recurse-submodules-default");
>         /* default value, "--submodule-prefix" and its value are added later */
>
> -       cp.env = local_repo_env;
> -       cp.git_cmd = 1;
> -       cp.no_stdin = 1;
> -
>         calculate_changed_submodule_paths();
>
> +       tq = create_task_queue(max_parallel_jobs);
>         for (i = 0; i < active_nr; i++) {
>                 struct strbuf submodule_path = STRBUF_INIT;
>                 struct strbuf submodule_git_dir = STRBUF_INIT;
> @@ -693,24 +757,26 @@ int fetch_populated_submodules(const struct argv_array *options,
>                 if (!git_dir)
>                         git_dir = submodule_git_dir.buf;
>                 if (is_directory(git_dir)) {
> +                       spf = submodule_parallel_fetch_create();
> +                       spf->result = &result;
> +                       spf->cp.dir = strbuf_detach(&submodule_path, NULL);
>                         if (!quiet)
> -                               printf("Fetching submodule %s%s\n", prefix, ce->name);
> -                       cp.dir = submodule_path.buf;
> -                       argv_array_push(&argv, default_argv);
> -                       argv_array_push(&argv, "--submodule-prefix");
> -                       argv_array_push(&argv, submodule_prefix.buf);
> -                       cp.argv = argv.argv;
> -                       if (run_command(&cp))
> -                               result = 1;
> -                       argv_array_pop(&argv);
> -                       argv_array_pop(&argv);
> -                       argv_array_pop(&argv);
> +                               strbuf_addf(spf->cp.sync_buf,
> +                                           "Fetching submodule %s%s",
> +                                           prefix, ce->name);
> +                       argv_array_pushv(&spf->argv, argv.argv);
> +                       argv_array_push(&spf->argv, default_argv);
> +                       argv_array_push(&spf->argv, "--submodule-prefix");
> +                       argv_array_push(&spf->argv, submodule_prefix.buf);
> +                       set_output_mutex(spf);
> +                       add_task(tq, run_command_and_cleanup, spf);
>                 }
>                 strbuf_release(&submodule_path);
>                 strbuf_release(&submodule_git_dir);
>                 strbuf_release(&submodule_prefix);
>         }
>         argv_array_clear(&argv);
> +       destroy_output_mutex();
>  out:
>         string_list_clear(&changed_submodule_paths, 1);
>         return result;
> diff --git a/submodule.h b/submodule.h
> index 5507c3d..cbc0003 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -31,7 +31,7 @@ void set_config_fetch_recurse_submodules(int value);
>  void check_for_new_submodule_commits(unsigned char new_sha1[20]);
>  int fetch_populated_submodules(const struct argv_array *options,
>                                const char *prefix, int command_line_option,
> -                              int quiet);
> +                              int quiet, int max_parallel_jobs);
>  unsigned is_submodule_modified(const char *path, int ignore_untracked);
>  int submodule_uses_gitfile(const char *path);
>  int ok_to_remove_submodule(const char *path);
> --
> 2.5.0.264.g5e52b0d
>
