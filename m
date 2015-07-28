From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: handle multiple worktrees
Date: Tue, 28 Jul 2015 15:12:26 -0700
Message-ID: <xmqqtwsoaq45.fsf@gitster.dls.corp.google.com>
References: <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<1438118624-26107-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:12:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKD77-0007BV-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 00:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbbG1WMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 18:12:43 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35984 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbbG1WMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 18:12:30 -0400
Received: by pdjr16 with SMTP id r16so78778933pdj.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9wJMVAIS98cdjZumo+RQdMl4uzQA8kiCQOGOwiNSCAM=;
        b=ly+Sbd3MZ3UvJIBarrmWLhsRWJffRwbv12rzMyzFZA+q6YaXE6LPXEEPYRpBo367N2
         wJO/L3+fexFOvnD0JT8fPT9a2CZgvRN8h+wXW87Tp6tBNz4IgCz3Jvo9equ+JAu7loNN
         PJqisINdAPxMCQchdTT+YW2xVnTcVqs9aad5ZuRmqgETE1/lfrd0WENSUH/mm/giulyH
         FpSPSgugI7lRZKZrhcVEtGD0FE9uCwG2/IAgbpP9QpAKHq7Z8E05cirsCP+VwAVL/J83
         kR0J+bKeZyX7SxY9iaY6TuyKIKvQyulmX4QueZt/IyPMkg9Fd9BnDeibj7nkBRgxSNo/
         mjGw==
X-Received: by 10.70.103.37 with SMTP id ft5mr8804376pdb.83.1438121549741;
        Tue, 28 Jul 2015 15:12:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id to5sm37158023pac.33.2015.07.28.15.12.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 15:12:27 -0700 (PDT)
In-Reply-To: <1438118624-26107-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 28 Jul 2015 17:23:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274859>

David Turner <dturner@twopensource.com> writes:

> Prevent merges to the same notes branch from different worktrees.
> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using the same
> code we use to check that two HEADs in different worktrees don't point
> to the same branch.  Modify that code, die_if_checked_out, to take a
> "head" ref to examine; previously, it just looked at HEAD.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

Thanks for following through.  As I didn't report anything, I do not
deserve that label, but it's OK ;-)

I know that it is a requirement to protect NOTES_MERGE_REF from
being used by multiple places for "notes merge" to play well with
the multi-worktree world order, but because I do not know if that is
sufficient, I'm asking a few people for further review.

This is a totally unrelated tangent, but I wonder if "branch -M" to
rename the current branch to an existing branch misbehaves in the
multi-worktree world.  I do not see any die-if-checked-out call in
rename_branch() where create_symref() is used to adjust HEAD for the
current branch.  Duy?

>  branch.c                         | 15 +++++----
>  branch.h                         |  2 +-
>  builtin/checkout.c               |  2 +-
>  builtin/notes.c                  |  2 ++
>  builtin/worktree.c               |  2 +-
>  t/t3320-notes-merge-worktrees.sh | 71 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 84 insertions(+), 10 deletions(-)
>  create mode 100755 t/t3320-notes-merge-worktrees.sh

> diff --git a/branch.c b/branch.c
> index c85be07..60eadc6 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -311,21 +311,22 @@ void remove_branch_state(void)
>  	unlink(git_path("SQUASH_MSG"));
>  }
>  
> -static void check_linked_checkout(const char *branch, const char *id)
> +static void check_linked_checkout(const char *head, const char *branch,
> +				  const char *id)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	struct strbuf path = STRBUF_INIT;
>  	struct strbuf gitdir = STRBUF_INIT;
>  
>  	/*
> -	 * $GIT_COMMON_DIR/HEAD is practically outside
> +	 * $GIT_COMMON_DIR/$head is practically outside
>  	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
>  	 * uses git_path). Parse the ref ourselves.
>  	 */
>  	if (id)
> -		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
> +		strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, head);
>  	else
> -		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> +		strbuf_addf(&path, "%s/%s", get_git_common_dir(), head);
>  
>  	if (!strbuf_readlink(&sb, path.buf, 0)) {
>  		if (!starts_with(sb.buf, "refs/") ||
> @@ -356,13 +357,13 @@ done:
>  	strbuf_release(&gitdir);
>  }
>  
> -void die_if_checked_out(const char *branch)
> +void die_if_checked_out(const char *head, const char *branch)
>  {
>  	struct strbuf path = STRBUF_INIT;
>  	DIR *dir;
>  	struct dirent *d;
>  
> -	check_linked_checkout(branch, NULL);
> +	check_linked_checkout(head, branch, NULL);
>  
>  	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
>  	dir = opendir(path.buf);
> @@ -373,7 +374,7 @@ void die_if_checked_out(const char *branch)
>  	while ((d = readdir(dir)) != NULL) {
>  		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>  			continue;
> -		check_linked_checkout(branch, d->d_name);
> +		check_linked_checkout(head, branch, d->d_name);
>  	}
>  	closedir(dir);
>  }
> diff --git a/branch.h b/branch.h
> index 58aa45f..3577fe5 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -57,6 +57,6 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
>   * worktree and die (with a message describing its checkout location) if
>   * it is.
>   */
> -extern void die_if_checked_out(const char *branch);
> +extern void die_if_checked_out(const char *head, const char *branch);
>  
>  #endif
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e1403be..a5e9f2d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1107,7 +1107,7 @@ static int checkout_branch(struct checkout_opts *opts,
>  		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
>  		if (head_ref &&
>  		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
> -			die_if_checked_out(new->path);
> +			die_if_checked_out("HEAD", new->path);
>  		free(head_ref);
>  	}
>  
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 63f95fc..8794ba1 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -19,6 +19,7 @@
>  #include "string-list.h"
>  #include "notes-merge.h"
>  #include "notes-utils.h"
> +#include "branch.h"
>  
>  static const char * const git_notes_usage[] = {
>  	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
> @@ -829,6 +830,7 @@ static int merge(int argc, const char **argv, const char *prefix)
>  		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
>  			   0, UPDATE_REFS_DIE_ON_ERR);
>  		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
> +		die_if_checked_out("NOTES_MERGE_REF", default_notes_ref());
>  		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
>  			die("Failed to store link to current notes ref (%s)",
>  			    default_notes_ref());
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 430b51e..bfdb90f 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -203,7 +203,7 @@ static int add_worktree(const char *path, const char *refname,
>  	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
>  		 ref_exists(symref.buf)) { /* it's a branch */
>  		if (!opts->force)
> -			die_if_checked_out(symref.buf);
> +			die_if_checked_out("HEAD", symref.buf);
>  	} else { /* must be a commit */
>  		commit = lookup_commit_reference_by_name(refname);
>  		if (!commit)
> diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
> new file mode 100755
> index 0000000..b102c23
> --- /dev/null
> +++ b/t/t3320-notes-merge-worktrees.sh
> @@ -0,0 +1,71 @@
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
> +	test_commit tantrum
> +'
> +
> +commit_tantrum=$(git rev-parse tantrum^{commit})
> +
> +test_expect_success 'setup notes ref (x)' '
> +	git config core.notesRef refs/notes/x &&
> +	git notes add -m "x notes on tantrum" tantrum
> +'
> +
> +test_expect_success 'setup local branch (y)' '
> +	git update-ref refs/notes/y refs/notes/x &&
> +	git config core.notesRef refs/notes/y &&
> +	git notes remove tantrum
> +'
> +
> +test_expect_success 'setup remote branch (z)' '
> +	git update-ref refs/notes/z refs/notes/x &&
> +	git config core.notesRef refs/notes/z &&
> +	git notes add -f -m "conflicting notes on tantrum" tantrum
> +'
> +
> +test_expect_success 'modify notes ref ourselves (x)' '
> +	git config core.notesRef refs/notes/x &&
> +	git notes add -f -m "more conflicting notes on tantrum" tantrum
> +'
> +
> +test_expect_success 'create some new worktrees' '
> +	git worktree add -b newbranch worktree master &&
> +	git worktree add -b newbranch2 worktree2 master
> +'
> +
> +test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
> +	git config core.notesRef refs/notes/y &&
> +	test_must_fail git notes merge z &&
> +	echo "ref: refs/notes/y" > expect &&
> +	test_cmp .git/NOTES_MERGE_REF expect
> +'
> +
> +test_expect_success 'merge z into y while mid-merge in another workdir fails' '
> +	(
> +		cd worktree &&
> +		git config core.notesRef refs/notes/y &&
> +		test_must_fail git notes merge z 2>err &&
> +		grep "is already checked out" err
> +	) &&
> +	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
> +'
> +
> +test_expect_success 'merge z into x while mid-merge on y succeeds' '
> +	(
> +		cd worktree2 &&
> +		git config core.notesRef refs/notes/x &&
> +		test_must_fail git notes merge z 2>&1 >out &&
> +		grep -v "is already checked out" out
> +	) &&
> +	echo "ref: refs/notes/x" > expect &&
> +	test_cmp .git/worktrees/worktree2/NOTES_MERGE_REF expect
> +'
> +
> +test_done
