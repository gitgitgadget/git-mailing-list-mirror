From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v7 3/4] notes: add notes.mergestrategy option to select
 default strategy
Date: Sat, 15 Aug 2015 11:09:58 +0200
Message-ID: <CALKQrgcAmA021a6CS4eLwUwYh8C2BB7xXcfg9Hf7tTFwFw3KLg@mail.gmail.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
	<1439586835-15712-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 11:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQXTk-0002bh-Q0
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 11:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbbHOJKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 05:10:08 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:54845 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbbHOJKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 05:10:06 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZQXTY-000Me0-Em
	for git@vger.kernel.org; Sat, 15 Aug 2015 11:10:04 +0200
Received: by ykll84 with SMTP id l84so24682042ykl.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 02:09:58 -0700 (PDT)
X-Received: by 10.170.171.70 with SMTP id n67mr50009206ykd.22.1439629798480;
 Sat, 15 Aug 2015 02:09:58 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Sat, 15 Aug 2015 02:09:58 -0700 (PDT)
In-Reply-To: <1439586835-15712-4-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275986>

On Fri, Aug 14, 2015 at 11:13 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git-notes about "notes.mergestrategy" to select a general strategy
> for all notes merges. This enables a user to always get expected merge
> strategy such as "cat_sort_uniq" without having to pass the "-s" option
> manually.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/config.txt            |  7 ++++++
>  Documentation/git-notes.txt         | 14 +++++++++++-
>  builtin/notes.c                     | 45 ++++++++++++++++++++++++++++---------
>  notes-merge.h                       | 16 +++++++------
>  t/t3309-notes-merge-auto-resolve.sh | 29 ++++++++++++++++++++++++
>  5 files changed, 92 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index de67ad1fdedf..5e3e03459de7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1919,6 +1919,13 @@ mergetool.writeToTemp::
>  mergetool.prompt::
>         Prompt before each invocation of the merge resolution program.
>
> +notes.mergestrategy::

Just one small nit: Config keys are (AFAIK) case-insensitive, and we
can thus use
camelCasing in the documentation to make long keywords more readable (see e.g.
notes.displayRef below). So I suggest using notes.mergeStrategy here.

> +       Which merge strategy to choose by default when resolving notes
> +       conflicts. Must be one of `manual`, `ours`, `theirs`, `union`,
> +       or `cat_sort_uniq`. Defaults to `manual`. See "NOTES MERGE
> +       STRATEGIES" section of linkgit:git-notes[1] for more information
> +       on each strategy.
> +
>  notes.displayRef::
>         The (fully qualified) refname from which to show notes when
>         showing commit messages.  The value of this variable can be set
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 674682b34b83..89c8829a0543 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -101,7 +101,7 @@ merge::
>         any) into the current notes ref (called "local").
>  +
>  If conflicts arise and a strategy for automatically resolving
> -conflicting notes (see the -s/--strategy option) is not given,
> +conflicting notes (see the "NOTES MERGE STRATEGIES" section) is not given,
>  the "manual" resolver is used. This resolver checks out the
>  conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
>  and instructs the user to manually resolve the conflicts there.
> @@ -183,6 +183,7 @@ OPTIONS
>         When merging notes, resolve notes conflicts using the given
>         strategy. The following strategies are recognized: "manual"
>         (default), "ours", "theirs", "union" and "cat_sort_uniq".
> +       This option overrides the "notes.mergestrategy" configuration setting.
>         See the "NOTES MERGE STRATEGIES" section below for more
>         information on each notes merge strategy.
>
> @@ -247,6 +248,9 @@ When done, the user can either finalize the merge with
>  'git notes merge --commit', or abort the merge with
>  'git notes merge --abort'.
>
> +Users may select an automated merge strategy from among the following using
> +either -s/--strategy option or configuring notes.mergestrategy accordingly:
> +
>  "ours" automatically resolves conflicting notes in favor of the local
>  version (i.e. the current notes ref).
>
> @@ -310,6 +314,14 @@ core.notesRef::
>         This setting can be overridden through the environment and
>         command line.
>
> +notes.mergestrategy::

Same here.

> +       Which merge strategy to choose by default when resolving notes
> +       conflicts. Must be one of `manual`, `ours`, `theirs`, `union`,
> +       or `cat_sort_uniq`. Defaults to `manual`. See "NOTES MERGE
> +       STRATEGIES" section above for more information on each strategy.
> ++
> +This setting can be overridden by passing the `--strategy` option.
> +
>  notes.displayRef::
>         Which ref (or refs, if a glob or specified more than once), in
>         addition to the default set by `core.notesRef` or
[...]

Otherwise, looks good to me.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
