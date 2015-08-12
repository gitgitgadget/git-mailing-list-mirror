From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v4 3/4] notes: add notes.merge option to select default strategy
Date: Wed, 12 Aug 2015 02:04:21 +0200
Message-ID: <CALKQrgcYpbae0eu2sT_rOZYq3DsnVSpYua1SZr=TC=dYfG_fpw@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 02:04:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPJX1-0007mG-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 02:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbbHLAEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 20:04:30 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:50019 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbbHLAE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 20:04:29 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZPJWt-000KmQ-TX
	for git@vger.kernel.org; Wed, 12 Aug 2015 02:04:28 +0200
Received: by ykdt205 with SMTP id t205so1196784ykd.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 17:04:22 -0700 (PDT)
X-Received: by 10.170.171.70 with SMTP id n67mr31695078ykd.22.1439337862035;
 Tue, 11 Aug 2015 17:04:22 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 11 Aug 2015 17:04:21 -0700 (PDT)
In-Reply-To: <1439326641-9447-4-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275747>

On Tue, Aug 11, 2015 at 10:57 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git-notes about "notes.merge" to select a general strategy for all
> notes merges. This enables a user to always get expected merge strategy
> such as "cat_sort_uniq" without having to pass the "-s" option manually.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/config.txt            |  7 ++++++
>  Documentation/git-notes.txt         | 14 +++++++++++-
>  builtin/notes.c                     | 44 +++++++++++++++++++++++--------------
>  notes-merge.h                       | 16 ++++++++------
>  t/t3309-notes-merge-auto-resolve.sh | 29 ++++++++++++++++++++++++
>  5 files changed, 86 insertions(+), 24 deletions(-)
>
[...]
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 63f95fc55439..3c705f5e26ff 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -737,6 +737,24 @@ static int merge_commit(struct notes_merge_options *o)
>         return ret;
>  }
>
> +static int parse_notes_strategy(const char *arg, enum notes_merge_strategy *strategy)
> +{
> +       if (!strcmp(arg, "manual"))
> +               *strategy = NOTES_MERGE_RESOLVE_MANUAL;
> +       else if (!strcmp(arg, "ours"))
> +               *strategy = NOTES_MERGE_RESOLVE_OURS;
> +       else if (!strcmp(arg, "theirs"))
> +               *strategy = NOTES_MERGE_RESOLVE_THEIRS;
> +       else if (!strcmp(arg, "union"))
> +               *strategy = NOTES_MERGE_RESOLVE_UNION;
> +       else if (!strcmp(arg, "cat_sort_uniq"))
> +               *strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> +       else
> +               return -1;
> +
> +       return 0;
> +}
> +
>  static int merge(int argc, const char **argv, const char *prefix)
>  {
>         struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
> @@ -745,7 +763,7 @@ static int merge(int argc, const char **argv, const char *prefix)
>         struct notes_merge_options o;
>         int do_merge = 0, do_commit = 0, do_abort = 0;
>         int verbosity = 0, result;
> -       const char *strategy = NULL;
> +       const char *strategy = NULL, *configured_strategy = NULL;
>         struct option options[] = {
>                 OPT_GROUP(N_("General options")),
>                 OPT__VERBOSITY(&verbosity),
> @@ -795,21 +813,15 @@ static int merge(int argc, const char **argv, const char *prefix)
>         expand_notes_ref(&remote_ref);
>         o.remote_ref = remote_ref.buf;
>
> -       if (strategy) {
> -               if (!strcmp(strategy, "manual"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
> -               else if (!strcmp(strategy, "ours"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_OURS;
> -               else if (!strcmp(strategy, "theirs"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
> -               else if (!strcmp(strategy, "union"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_UNION;
> -               else if (!strcmp(strategy, "cat_sort_uniq"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> -               else {
> -                       error("Unknown -s/--strategy: %s", strategy);
> -                       usage_with_options(git_notes_merge_usage, options);
> -               }
> +       git_config_get_string_const("notes.merge", &configured_strategy);
> +
> +       if (configured_strategy &&
> +           parse_notes_strategy(configured_strategy, &o.strategy))
> +               die("Unknown notes merge strategy: %s", configured_strategy);
> +
> +       if (strategy && parse_notes_strategy(strategy, &o.strategy)) {
> +               error("Unknown -s/--strategy: %s", strategy);
> +               usage_with_options(git_notes_merge_usage, options);
>         }

Do you need to look at the notes.merge config variable at all if
-s/--strategy is given?
I'd expect the above to rather look something like:

if (strategy) {
        if (parse_notes_strategy(strategy, &o.strategy)) {
                error("Unknown -s/--strategy: %s", strategy);
                usage_with_options(git_notes_merge_usage, options);
        }
} else if (configured_strategy) {
        if (parse_notes_strategy(configured_strategy, &o.strategy))
                die("Unknown notes merge strategy: %s", configured_strategy);
} /* else o.strategy = NOTES_MERGE_RESOLVE_MANUAL; */


Otherwise, this patch looks good to me.

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
