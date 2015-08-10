From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6] notes: handle multiple worktrees
Date: Mon, 10 Aug 2015 13:48:33 -0400
Organization: Twitter
Message-ID: <1439228913.5283.0.camel@twopensource.com>
References: <1439228630-25146-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 19:48:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOrBg-0007kv-9X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbbHJRsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:48:36 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34102 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbbHJRsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:48:35 -0400
Received: by iodb91 with SMTP id b91so117283111iod.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 10:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=nmNp+BVdIQ3fJ6qmz18zMScAvqF0XdY6JOGdoycFVQA=;
        b=kGGK95czaMpGk0pcBdVAfLYEgK+PFD3RlFQovduvEOwCpMOK8s0Tl2OHxXkpWykN46
         HbMR1X3DUBxMO00lNpg7ciUbfFCmqmowdhqiypCMpuh0W8bahA7nUxdurJ0OaK7nWBMX
         ddOsOExeStKJ3UdCGWrUzzHql8ETZc82zlvQ06mjvVW0Ql3nHiq5uxEBh0JFV3y6sZSI
         uiNGLke1fyUu4IyFhUm8Pg6oKJ/mTpYQZqE5T7N2SYCu46ps9lgoQg6FLkmKzEISHpgx
         2InCT5EJAxjArSkhMVGVjFhK94ZrOzjrbuv56lvhiwNaDMB05XGZUbljAb6TKLA5kHof
         tgYg==
X-Gm-Message-State: ALoCoQlqZzUs4hjRPxPUdQ2gCYAkLYS08VQivjrEcShR97OZioBrIuezO/xBDywgrTLhWp58R/MO
X-Received: by 10.107.16.139 with SMTP id 11mr26724614ioq.122.1439228915118;
        Mon, 10 Aug 2015 10:48:35 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id q79sm10727241ioi.0.2015.08.10.10.48.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Aug 2015 10:48:34 -0700 (PDT)
In-Reply-To: <1439228630-25146-1-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275642>

Sorry, that should have included the first patch as well.  Will re-send
as .v7

On Mon, 2015-08-10 at 13:43 -0400, David Turner wrote:
> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
> find_shared_symref and die if we find one.  This prevents simultaneous
> merges to the same notes branch from different worktrees.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> 
> This reroll addresses Eric Sunshine's comments on v5.
> 
> ---
>  builtin/notes.c                  |  6 ++++
>  t/t3320-notes-merge-worktrees.sh | 72 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100755 t/t3320-notes-merge-worktrees.sh
> 
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 63f95fc..0423480 100644
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
> @@ -825,10 +826,15 @@ static int merge(int argc, const char **argv, const char *prefix)
>  		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
>  			   0, UPDATE_REFS_DIE_ON_ERR);
>  	else { /* Merge has unresolved conflicts */
> +		char *existing;
>  		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
>  		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
>  			   0, UPDATE_REFS_DIE_ON_ERR);
>  		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
> +		existing = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
> +		if (existing)
> +			die(_("A notes merge into %s is already in-progress at %s"),
> +			    default_notes_ref(), existing);
>  		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
>  			die("Failed to store link to current notes ref (%s)",
>  			    default_notes_ref());
> diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
> new file mode 100755
> index 0000000..a7beef2
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
> +		grep "A notes merge into refs/notes/y is already in-progress at" err
> +	) &&
> +	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
> +'
> +
> +test_expect_success 'merge z into x while mid-merge on y succeeds' '
> +	(
> +		cd worktree2 &&
> +		git config core.notesRef refs/notes/x &&
> +		test_must_fail git notes merge z 2>&1 >out &&
> +		grep "Automatic notes merge failed" out &&
> +		grep -v "A notes merge into refs/notes/x is already in-progress in" out
> +	) &&
> +	echo "ref: refs/notes/x" > expect &&
> +	test_cmp .git/worktrees/worktree2/NOTES_MERGE_REF expect
> +'
> +
> +test_done
