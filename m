From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH 1/2] checkout: progress on non-tty. progress with lf
Date: Sat, 24 Oct 2015 19:50:17 -0600
Message-ID: <CAOc6etbn3656Az9hhK3B5ZAwjSVmqj=XU+6F=v-8VyUOvD90zw@mail.gmail.com>
References: <1445698786-22673-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 02:50:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqASO-0003G0-2W
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 02:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbbJYBuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 21:50:19 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34785 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbbJYBuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 21:50:18 -0400
Received: by padhk11 with SMTP id hk11so152374464pad.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=3h1IIguMFjVS50WlCABpbMIOUvlIT3lIsEUmd8Z70J4=;
        b=d41tUzQtSYPn4H2pBMyYIankGuPN7YPip6fxetyNlYX2aEP8Yw00klN6LjuUe6pIU6
         YgiCHM5wd8U9Hq+5QfgfxWaYSSDfXLn9Bk5nvDYBvlGOEO/DmVSdQBdaF2j8aaWmML0F
         5DehKBSbSM+auWhBdCQyLLXzRflsaGA4qDwe8PU0LSE7bReAfnO464sMa97Hja7t8nZX
         Htuhlm+okz8tXNvgYYhP+lehZdhF53i4C2p/ChVy9V1Efa9QlJuqN2yqxafxzPbrZwfA
         M58wxMYX7iqmm41aJrmWMnCRM5eCyo4xyvsjzwH7GB+mcXP9nc5791CFtwvkbFYyO5ng
         oi7Q==
X-Received: by 10.68.69.79 with SMTP id c15mr32989597pbu.90.1445737817424;
 Sat, 24 Oct 2015 18:50:17 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Sat, 24 Oct 2015 18:50:17 -0700 (PDT)
In-Reply-To: <1445698786-22673-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280136>

Hello, everybody!

So, this is my first patch ever for git. What would be the expected
workflow for this patch from a newcomer like me? Maybe getting some
fire starting monday?

On the technical side, I was wondering if it made more sense to use a
"boolean" value to control if progress should use CR or LF, instead of
allowing to set whatever we wanted in struct progress.eol.

Something like

diff --git a/progress.c b/progress.c
index 3af0594..8584e48 100644
--- a/progress.c
+++ b/progress.c
@@ -36,7 +36,7 @@ struct progress {
       unsigned delay;
       unsigned delayed_percent_treshold;
       struct throughput *throughput;
-       const char *eol;
+       int eol_lf;
};

static volatile sig_atomic_t progress_update;
@@ -100,7 +100,7 @@ static int display(struct progress *progress,
unsigned n, const char *done)

       progress->last_value = n;
       tp = (progress->throughput) ? progress->throughput->display.buf : "";
-       eol = done ? done : (progress->eol ? progress->eol : "   \r");
+       eol = done ? done : (progress->eol_lf ? "\n" : "   \r");
       if (progress->total) {
               unsigned percent = n * 100 / progress->total;
               if (percent != progress->last_percent || progress_update) {


Thanks!

On Sat, Oct 24, 2015 at 8:59 AM, Edmundo Carmona <eantoranz@gmail.com> wrote:
> From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
>
> --progress-no-tty: option to write progress even if not working on a TTY
> --progress-lf: option to print progress using LF instead of CR
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  builtin/checkout.c | 12 ++++++++++--
>  progress.c         |  8 +++++++-
>  progress.h         |  1 +
>  unpack-trees.c     |  3 +++
>  unpack-trees.h     |  2 ++
>  5 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bc703c0..2c86a9a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -37,6 +37,8 @@ struct checkout_opts {
>         int overwrite_ignore;
>         int ignore_skipworktree;
>         int ignore_other_worktrees;
> +       int progress_lf;
> +       int progress_notty;
>
>         const char *new_branch;
>         const char *new_branch_force;
> @@ -417,7 +419,8 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>         opts.reset = 1;
>         opts.merge = 1;
>         opts.fn = oneway_merge;
> -       opts.verbose_update = !o->quiet && isatty(2);
> +       opts.verbose_update = !o->quiet && (o->progress_notty || isatty(2));
> +       opts.eol = o->progress_lf ? _("\n") : NULL;
>         opts.src_index = &the_index;
>         opts.dst_index = &the_index;
>         parse_tree(tree);
> @@ -501,7 +504,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>                 topts.update = 1;
>                 topts.merge = 1;
>                 topts.gently = opts->merge && old->commit;
> -               topts.verbose_update = !opts->quiet && isatty(2);
> +               topts.verbose_update = !opts->quiet && (opts->progress_notty || isatty(2));
> +               topts.eol = opts->progress_lf ? _("\n") : NULL;
>                 topts.fn = twoway_merge;
>                 if (opts->overwrite_ignore) {
>                         topts.dir = xcalloc(1, sizeof(*topts.dir));
> @@ -1156,6 +1160,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>                                 N_("second guess 'git checkout <no-such-branch>'")),
>                 OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
>                          N_("do not check if another worktree is holding the given ref")),
> +               OPT_BOOL(0, "progress-lf", &opts.progress_lf,
> +                        N_("write progress using lf instead of cr")),
> +               OPT_BOOL(0, "progress-no-tty", &opts.progress_notty,
> +                        N_("write progress info even if not using a TTY")),
>                 OPT_END(),
>         };
>
> diff --git a/progress.c b/progress.c
> index 353bd37..3af0594 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -36,6 +36,7 @@ struct progress {
>         unsigned delay;
>         unsigned delayed_percent_treshold;
>         struct throughput *throughput;
> +       const char *eol;
>  };
>
>  static volatile sig_atomic_t progress_update;
> @@ -99,7 +100,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
>
>         progress->last_value = n;
>         tp = (progress->throughput) ? progress->throughput->display.buf : "";
> -       eol = done ? done : "   \r";
> +       eol = done ? done : (progress->eol ? progress->eol : "   \r");
>         if (progress->total) {
>                 unsigned percent = n * 100 / progress->total;
>                 if (percent != progress->last_percent || progress_update) {
> @@ -221,6 +222,7 @@ struct progress *start_progress_delay(const char *title, unsigned total,
>         progress->delayed_percent_treshold = percent_treshold;
>         progress->delay = delay;
>         progress->throughput = NULL;
> +       progress->eol = NULL;
>         set_progress_signal();
>         return progress;
>  }
> @@ -230,6 +232,10 @@ struct progress *start_progress(const char *title, unsigned total)
>         return start_progress_delay(title, total, 0, 0);
>  }
>
> +void set_progress_eol(struct progress *p_progress, const char *eol) {
> +       p_progress->eol = eol;
> +}
> +
>  void stop_progress(struct progress **p_progress)
>  {
>         stop_progress_msg(p_progress, _("done"));
> diff --git a/progress.h b/progress.h
> index 611e4c4..dbde34e 100644
> --- a/progress.h
> +++ b/progress.h
> @@ -8,6 +8,7 @@ int display_progress(struct progress *progress, unsigned n);
>  struct progress *start_progress(const char *title, unsigned total);
>  struct progress *start_progress_delay(const char *title, unsigned total,
>                                        unsigned percent_treshold, unsigned delay);
> +void set_progress_eol(struct progress *p_progress, const char *eol);
>  void stop_progress(struct progress **progress);
>  void stop_progress_msg(struct progress **progress, const char *msg);
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8e2032f..250482b 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -202,6 +202,9 @@ static int check_updates(struct unpack_trees_options *o)
>
>                 progress = start_progress_delay(_("Checking out files"),
>                                                 total, 50, 1);
> +               if (o->eol) {
> +                       set_progress_eol(progress, o->eol);
> +               }
>                 cnt = 0;
>         }
>
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 36a73a6..3e4bc47 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -71,6 +71,8 @@ struct unpack_trees_options {
>         struct index_state *src_index;
>         struct index_state result;
>
> +       const char *eol;
> +
>         struct exclude_list *el; /* for internal use */
>  };
>
> --
> 2.6.1
>
