From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] notes: handle multiple worktrees
Date: Tue, 28 Jul 2015 17:42:32 -0400
Organization: Twitter
Message-ID: <1438119752.18134.43.camel@twopensource.com>
References: <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	 <1438118624-26107-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 23:42:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKCdz-0002IZ-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbbG1Vmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:42:35 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34335 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbG1Vmf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 17:42:35 -0400
Received: by qkfc129 with SMTP id c129so57686790qkf.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 14:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WNAJab9xIdcDzglb6+QoMicCQqlO/J2a7FO1kHfLGF8=;
        b=DhgEYhp9jMTA1PnZQcPb71CwfyX+ga6Cnaa5WlrpEh+krcQcgzB8LXEWHn40klhrDR
         QV3BCrpjzRJis19JCnMWcfOj+T1rexkK0LvEZgp3QWfhJa7+/fHVad8ji7G4c2AdT8i3
         SCO2ku97fGxPr17oWa70t65y9Ru/Ab1lxsziz5BWoYmKlkrZRF5NUsxOop7h/ovXKkpa
         G1yEq4Xxvn/xe0qC/+nHfHACUlpgHFZtjuxXOzFdCMUCGNw1IPeE5tYH1GmEsAjfDMTA
         U9m98Z6jOXwB7mj/bW+00cKxV3NvvEry33ESbNBWPmVDtVOiaj/stKBrNcNm0wVOF8V6
         I2Jw==
X-Gm-Message-State: ALoCoQlz8QQbXav7tSbTTO0B94ZJQpLmXE0QbWLQCPx3FQOQXOn+M00vnaB1n7y5HoYE2z7SwdMv
X-Received: by 10.55.56.73 with SMTP id f70mr43948972qka.78.1438119754061;
        Tue, 28 Jul 2015 14:42:34 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id l74sm12103708qgd.7.2015.07.28.14.42.32
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 14:42:33 -0700 (PDT)
In-Reply-To: <1438118624-26107-1-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274855>

Sorry, this one is on top of next.

On Tue, 2015-07-28 at 17:23 -0400, David Turner wrote:
> Prevent merges to the same notes branch from different worktrees.
> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using the same
> code we use to check that two HEADs in different worktrees don't point
> to the same branch.  Modify that code, die_if_checked_out, to take a
> "head" ref to examine; previously, it just looked at HEAD.
> 
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  branch.c                         | 15 +++++----
>  branch.h                         |  2 +-
>  builtin/checkout.c               |  2 +-
>  builtin/notes.c                  |  2 ++
>  builtin/worktree.c               |  2 +-
>  t/t3320-notes-merge-worktrees.sh | 71 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 84 insertions(+), 10 deletions(-)
>  create mode 100755 t/t3320-notes-merge-worktrees.sh
> 
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
