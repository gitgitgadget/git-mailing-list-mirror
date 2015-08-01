From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v4 2/2] notes: handle multiple worktrees
Date: Sat, 1 Aug 2015 15:51:18 +0200
Message-ID: <CALKQrgcrpQ2j2J-65RJhN7owwmSzhqyGinGjUbicFbY=m82tNA@mail.gmail.com>
References: <1438380669-11012-1-git-send-email-dturner@twopensource.com>
	<1438380669-11012-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 15:51:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLXCR-0005kH-BV
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 15:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbbHANv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 09:51:27 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:52729 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbHANv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 09:51:26 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZLXC8-0000RK-4a
	for git@vger.kernel.org; Sat, 01 Aug 2015 15:51:24 +0200
Received: by ykax123 with SMTP id x123so79758549yka.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 06:51:18 -0700 (PDT)
X-Received: by 10.170.171.70 with SMTP id n67mr347332ykd.22.1438437078113;
 Sat, 01 Aug 2015 06:51:18 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Sat, 1 Aug 2015 06:51:18 -0700 (PDT)
In-Reply-To: <1438380669-11012-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275121>

On Sat, Aug 1, 2015 at 12:11 AM, David Turner <dturner@twopensource.com> wrote:
> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
> find_shared_symref and die if we find one.  This prevents simultaneous
> merges to the same notes branch from different worktrees.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/notes.c                  |  5 +++
>  t/t3320-notes-merge-worktrees.sh | 72 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100755 t/t3320-notes-merge-worktrees.sh
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 63f95fc..e4dda79 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -19,6 +19,7 @@
>  #include "string-list.h"
>  #include "notes-merge.h"
>  #include "notes-utils.h"
> +#include "branch.h"
>
>  static const char * const git_notes_usage[] = {
>         N_("git notes [--ref <notes-ref>] [list [<object>]]"),
> @@ -825,10 +826,14 @@ static int merge(int argc, const char **argv, const char *prefix)
>                 update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
>                            0, UPDATE_REFS_DIE_ON_ERR);
>         else { /* Merge has unresolved conflicts */
> +               char *existing;
>                 /* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
>                 update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
>                            0, UPDATE_REFS_DIE_ON_ERR);
>                 /* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
> +               existing = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());

Please confirm my assumption here: existing originally comes from a
strbuf_detach(), so it's the caller's (i.e. our) responsibility to
free() it, but we don't care, as we just die()d anyway. Correct?

> +               if (existing)
> +                       die(_("A notes merge on %s is already in-progress for %s"), default_notes_ref(), existing);

Not sure about your prepositions here. Would this maybe read better?:

  A notes merge into %s is already in-progress at %s

>                 if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
>                         die("Failed to store link to current notes ref (%s)",
>                             default_notes_ref());
> diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
> new file mode 100755
> index 0000000..997621f
> --- /dev/null
> +++ b/t/t3320-notes-merge-worktrees.sh
> @@ -0,0 +1,72 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2015 Twitter, Inc
> +#
> +
> +test_description='Test merging of notes trees in multiple worktrees'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup commit' '
> +       test_commit tantrum
> +'
> +
> +commit_tantrum=$(git rev-parse tantrum^{commit})
> +
> +test_expect_success 'setup notes ref (x)' '
> +       git config core.notesRef refs/notes/x &&
> +       git notes add -m "x notes on tantrum" tantrum
> +'
> +
> +test_expect_success 'setup local branch (y)' '
> +       git update-ref refs/notes/y refs/notes/x &&
> +       git config core.notesRef refs/notes/y &&
> +       git notes remove tantrum
> +'
> +
> +test_expect_success 'setup remote branch (z)' '
> +       git update-ref refs/notes/z refs/notes/x &&
> +       git config core.notesRef refs/notes/z &&
> +       git notes add -f -m "conflicting notes on tantrum" tantrum
> +'
> +
> +test_expect_success 'modify notes ref ourselves (x)' '
> +       git config core.notesRef refs/notes/x &&
> +       git notes add -f -m "more conflicting notes on tantrum" tantrum
> +'
> +
> +test_expect_success 'create some new worktrees' '
> +       git worktree add -b newbranch worktree master &&
> +       git worktree add -b newbranch2 worktree2 master
> +'
> +
> +test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
> +       git config core.notesRef refs/notes/y &&
> +       test_must_fail git notes merge z &&
> +       echo "ref: refs/notes/y" > expect &&
> +       test_cmp .git/NOTES_MERGE_REF expect
> +'
> +
> +test_expect_success 'merge z into y while mid-merge in another workdir fails' '
> +       (
> +               cd worktree &&
> +               git config core.notesRef refs/notes/y &&
> +               test_must_fail git notes merge z 2>err &&
> +               grep "A notes merge on refs/notes/y is already in-progress for" err
> +       ) &&
> +       test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
> +'
> +
> +test_expect_success 'merge z into x while mid-merge on y succeeds' '
> +       (
> +               cd worktree2 &&
> +               git config core.notesRef refs/notes/x &&
> +               test_must_fail git notes merge z 2>&1 >out &&
> +               grep "Automatic notes merge failed" out

Missing &&?

> +               grep -v "A notes merge on refs/notes/x is already in-progress for" out
> +       ) &&
> +       echo "ref: refs/notes/x" > expect &&
> +       test_cmp .git/worktrees/worktree2/NOTES_MERGE_REF expect
> +'
> +
> +test_done

Otherwise, this looks good to me.


...Johan

> --
> 2.0.4.315.gad8727a-twtrsrc
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Johan Herland, <johan@herland.net>
www.herland.net
