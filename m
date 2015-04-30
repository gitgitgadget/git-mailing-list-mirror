From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH] rebase -i: redo tasks that die during cherry-pick
Date: Thu, 30 Apr 2015 11:54:50 +0200
Message-ID: <5541FBEA.6080804@gmail.com>
References: <1430261720-9051-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: Phil Hord <hordp@cisco.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 11:55:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnlBO-0006Tb-27
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 11:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbbD3Jy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 05:54:56 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:34102 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbD3Jyz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 05:54:55 -0400
Received: by laat2 with SMTP id t2so40079205laa.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5+M5clr+gQ805QM5P4x8QmIHAV17zPxji3gk2Rg3GXI=;
        b=ZliD4TpVrRkjCu/zrzzYpPWfTiyq6R7ZX++zUNePy1XbYOrWMA0OBLldIZmUzf5AR8
         lh27r3PRjibFWVLe/qHISGDGlaj7WtU0FZ5JC7VuyE6Jj3DPGvlFQ1jtWyV4q/tH5A+9
         JfNiPppHKsJFU9pIaGlP570lxPg10G/jactMeCsEyybcCzMf4qqUdXu1mARZJNgQ6ogX
         sLyYmX5fxw2+dqvhaZhh/H5YG9lKulhxkI2NZgyPBwHC0jn6rAc6lRAHAUTkEjeC1Y+1
         mMucrv9d6u1qCZrGaaVW6AxULpEOA+FH0zwWpK+x6OInR99UnRfMFRqzDtbfoyWP6dkk
         PMrA==
X-Received: by 10.152.206.103 with SMTP id ln7mr3136486lac.40.1430387693720;
        Thu, 30 Apr 2015 02:54:53 -0700 (PDT)
Received: from client.googlemail.com (putty.olf.sgsnet.se. [46.239.119.252])
        by mx.google.com with ESMTPSA id at2sm455401lbc.12.2015.04.30.02.54.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 02:54:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1430261720-9051-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268066>

Hi,

Phil Hord writes:
> When rebase--interactive processes a task, it removes the item from
> the todo list and appends it to another list of executed tasks. If a
> pick (this includes squash and fixup) fails before the index has
> recorded the changes, take the corresponding item and put it on the todo
> list again. Otherwise, the changes introduced by the scheduled commit
> would be lost.
> 
> That kind of decision is possible since the cherry-pick command
> signals why it failed to apply the changes of the given commit. Either
> the changes are recorded in the index using a conflict (return value 1)
> and rebase does not continue until they are resolved or the changes
> are not recorded in the index (return value neither 0 nor 1) and
> rebase has to try again with the same task.
> 
> Add a test cases for regression testing to the "rebase-interactive"
> test suite.
> 
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---
> 
> Notes:
>     Last year in ${gmane}/250126 Fabian Ruch helpfully provided a patch
>     to fix a rebase bug I complained about. I have simplified it a bit
>     and merged in the tests which had been in a separate commit.

Thanks for picking this up again.

It seems like the bug still shows when git-rebase is asked to
recreate merges (option -p):

   set_fake_editor &&
   # 1 (A) adds file4, 2 (I) adds file6
   FAKE_LINES="edit 1 2" git rebase -i -p A &&
   git commit --amend &&
   >file6 &&
   # merge fails because file6 would be overwritten
   test_must_fail git rebase --continue &&
   # succeeds because 2 was popped and is not tried again
   git rebase --continue &&
   # ERROR: top commit is A because I was skipped
   test $(git cat-file commit HEAD | sed -ne \$p) = I

(The git-commit command in the third line forces
pick_one_preserving_merges to recreate rather than fast-forward to
the commit that adds file6. Normally, one would instruct git-rebase
to do so by specifying the --no-ff option. However, another bug
(thread 252946) causes the --no-ff to be ignored in conjunction with
-p; this example case then succeeds for the wrong reasons.)

>     It has bitten me twice since the original discussion and has also
>     been reported by others, though I haven't found those emails to
>     add them to the CC list yet.
>     
>     CC: Michael Haggerty <mhagger@alum.mit.edu>
> 
>  git-rebase--interactive.sh    | 16 +++++++++++++++
>  t/t3404-rebase-interactive.sh | 47 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 08e5d86..bab0dcc 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -132,6 +132,16 @@ mark_action_done () {
>  	fi
>  }
>  
> +# Put the last action marked done at the beginning of the todo list
> +# again. If there has not been an action marked done yet, leave the list of
> +# items on the todo list unchanged.
> +reschedule_last_action () {
> +	tail -n 1 "$done" | cat - "$todo" >"$todo".new
> +	sed -e \$d <"$done" >"$done".new
> +	mv -f "$todo".new "$todo"
> +	mv -f "$done".new "$done"
> +}
> +
>  append_todo_help () {
>  	git stripspace --comment-lines >>"$todo" <<\EOF
>  
> @@ -252,6 +262,12 @@ pick_one () {
>  	output eval git cherry-pick \
>  			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
>  			"$strategy_args" $empty_args $ff "$@"
> +
> +	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
> +	# previous task so this commit is not lost.
> +	ret=$?
> +	case "$ret" in [01]) ;; *) reschedule_last_action ;; esac
> +	return $ret
>  }

If -p is specified, pick_one doesn't reach the git-cherry-pick
command line shown here. Instead, it enters
pick_one_preserving_merges one line above and returns from pick_one
immediately afterwards.

   Fabian

>  pick_one_preserving_merges () {
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index eed76cc..ac429a0 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1055,4 +1055,51 @@ test_expect_success 'todo count' '
>  	grep "^# Rebase ..* onto ..* ([0-9]" actual
>  '
>  
> +test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
> +	git checkout --force branch2 &&
> +	git clean -f &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1 2" git rebase -i A &&
> +	test_cmp_rev HEAD F &&
> +	test_path_is_missing file6 &&
> +	>file6 &&
> +	test_must_fail git rebase --continue &&
> +	test_cmp_rev HEAD F &&
> +	rm file6 &&
> +	git rebase --continue &&
> +	test_cmp_rev HEAD I
> +'
> +
> +test_expect_success 'rebase -i commits that overwrite untracked files (squash)' '
> +	git checkout --force branch2 &&
> +	git clean -f &&
> +	git tag original-branch2 &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1 squash 2" git rebase -i A &&
> +	test_cmp_rev HEAD F &&
> +	test_path_is_missing file6 &&
> +	>file6 &&
> +	test_must_fail git rebase --continue &&
> +	test_cmp_rev HEAD F &&
> +	rm file6 &&
> +	git rebase --continue &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
> +	git reset --hard original-branch2
> +'
> +
> +test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
> +	git checkout --force branch2 &&
> +	git clean -f &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1 2" git rebase -i --no-ff A &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
> +	test_path_is_missing file6 &&
> +	>file6 &&
> +	test_must_fail git rebase --continue &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
> +	rm file6 &&
> +	git rebase --continue &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = I
> +'
> +
>  test_done
