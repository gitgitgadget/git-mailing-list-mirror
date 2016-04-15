From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/21] t: use test_cmp_rev() where appropriate
Date: Fri, 15 Apr 2016 13:48:47 -0700
Message-ID: <xmqqtwj2a98w.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-5-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arAfi-0007p8-FO
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbcDOUsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:48:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750840AbcDOUsv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:48:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D28721386F;
	Fri, 15 Apr 2016 16:48:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l1X/CCbDCD5HIljtASZ4Fis5gLE=; b=Zx0ydD
	ehjOv5p5V+aXPP7mp9A+ISqXphm5HZHeISxjs5ZhosP5JPWE5e1b4zVohG+9uAai
	WGgfKD4gm6F1a+q56OVy7CyyqK4fcBdPdz/R5lsY9RjsbsXlY9WAGVuXr65TB0G6
	aU0Li6ppu2XakbYKqIm6FbPoSIuBSXtTLQzFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SzT8z3OV+BLo9T7+JBdo+zn2kRsTHdEQ
	z6lMXe0psC450LHW7QSBumoFLX0/7MtkNz/QnwZ/GkUxQBuPQDk7TmbKG0FvX2YG
	N0qI7pjK9IP4dnkTwQN9epuHc8LvhSj0EF82J89/+XdvgZ9Bm7mjsZ3amRZhThAx
	0FsI3g5H8ec=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9E991386E;
	Fri, 15 Apr 2016 16:48:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3BE81386C;
	Fri, 15 Apr 2016 16:48:48 -0400 (EDT)
In-Reply-To: <1460294354-7031-5-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:18:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7444760E-034B-11E6-8493-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291659>

Stephan Beyer <s-beyer@gmx.net> writes:

> test_cmp_rev() from t/test-lib-functions.sh is used to make many
> tests clearer.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>
> Notes:
>     This change is in some way independent of the bisect topic but
>     the next patch is based on this (for t6030).

It seems that with this step test_cmp_rev is only used to compare
two revisions, not "I want to see this expected one among many"
introduced by 03/21.

And they all make the resulting code look easier to read.

As I said, these tests would become more cumbersome to debug when
they break with this change, though.

Also, with this mass rewrite, it is not sensible to assume that all
of these tests that start calling test_cmp_rev() do not mind having
expect.rev and actual.rev files in their working trees (and it is
also not sensible to assume that they do not mind having hash1 and
hash2 shell variables clobbered), so not using temporary files may
be good, but perhaps something like

	test_cmp_rev () {
		test "$(git rev-parse --verify "$1")" = \
                     "$(git rev-parse --verify "$2")" && return
		echo >&2 "Revs '$1' and '$2" are different"
		return false
	}

may be necessary.  I dunno.

> diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
> index e7ba8c5..64cb449 100755
> --- a/t/t2012-checkout-last.sh
> +++ b/t/t2012-checkout-last.sh
> @@ -43,7 +43,7 @@ test_expect_success '"checkout -" attaches again' '
>  
>  test_expect_success '"checkout -" detaches again' '
>  	git checkout - &&
> -	test "z$(git rev-parse HEAD)" = "z$(git rev-parse other)" &&
> +	test_cmp_rev HEAD other &&
>  	test_must_fail git symbolic-ref HEAD
>  '
>  
> @@ -101,19 +101,19 @@ test_expect_success 'merge base test setup' '
>  test_expect_success 'another...master' '
>  	git checkout another &&
>  	git checkout another...master &&
> -	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
> +	test_cmp_rev HEAD master^
>  '
>  
>  test_expect_success '...master' '
>  	git checkout another &&
>  	git checkout ...master &&
> -	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
> +	test_cmp_rev HEAD master^
>  '
>  
>  test_expect_success 'master...' '
>  	git checkout another &&
>  	git checkout master... &&
> -	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
> +	test_cmp_rev HEAD master^
>  '
>  
>  test_expect_success '"checkout -" works after a rebase A' '
> diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
> index 19aed7e..1f72e9e 100755
> --- a/t/t3308-notes-merge.sh
> +++ b/t/t3308-notes-merge.sh
> @@ -93,7 +93,7 @@ test_expect_success 'merge non-notes ref into empty notes ref (remote-notes/orig
>  	git notes merge refs/remote-notes/origin/x &&
>  	verify_notes v &&
>  	# refs/remote-notes/origin/x and v should point to the same notes commit
> -	test "$(git rev-parse refs/remote-notes/origin/x)" = "$(git rev-parse refs/notes/v)"
> +	test_cmp_rev refs/remote-notes/origin/x refs/notes/v
>  '
>  
>  test_expect_success 'merge notes into empty notes ref (x => y)' '
> @@ -101,13 +101,13 @@ test_expect_success 'merge notes into empty notes ref (x => y)' '
>  	git notes merge x &&
>  	verify_notes y &&
>  	# x and y should point to the same notes commit
> -	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
> +	test_cmp_rev refs/notes/x refs/notes/y
>  '
>  
>  test_expect_success 'merge empty notes ref (z => y)' '
>  	git notes merge z &&
>  	# y should not change (still == x)
> -	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
> +	test_cmp_rev refs/notes/x refs/notes/y
>  '
>  
>  test_expect_success 'change notes on other notes ref (y)' '
> @@ -174,7 +174,7 @@ test_expect_success 'merge changed (y) into original (x) => Fast-forward' '
>  	verify_notes x &&
>  	verify_notes y &&
>  	# x and y should point to same the notes commit
> -	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
> +	test_cmp_rev refs/notes/x refs/notes/y
>  '
>  
>  test_expect_success 'merge empty notes ref (z => y)' '
> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
> index d557212..5e46fcf 100755
> --- a/t/t3310-notes-merge-manual-resolve.sh
> +++ b/t/t3310-notes-merge-manual-resolve.sh
> @@ -516,7 +516,7 @@ cp expect_log_w expect_log_m
>  test_expect_success 'reset notes ref m to somewhere else (w)' '
>  	git update-ref refs/notes/m refs/notes/w &&
>  	verify_notes m &&
> -	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
> +	test_cmp_rev refs/notes/m refs/notes/w
>  '
>  
>  test_expect_success 'fail to finalize conflicting merge if underlying ref has moved in the meantime (m != NOTES_MERGE_PARTIAL^1)' '
> @@ -537,8 +537,8 @@ EOF
>  	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
>  	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
>  	# Refs are unchanged
> -	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
> -	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
> +	test_cmp_rev refs/notes/m refs/notes/w &&
> +	test_cmp_rev refs/notes/y NOTES_MERGE_PARTIAL^1 &&
>  	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
>  	# Mention refs/notes/m, and its current and expected value in output
>  	grep -q "refs/notes/m" output &&
> @@ -557,7 +557,7 @@ test_expect_success 'resolve situation by aborting the notes merge' '
>  	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
>  	test_cmp /dev/null output &&
>  	# m has not moved (still == w)
> -	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
> +	test_cmp_rev refs/notes/m refs/notes/w &&
>  	# Verify that other notes refs has not changed (w, x, y and z)
>  	verify_notes w &&
>  	verify_notes x &&
> diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
> index 93516ef..3fb4d11 100755
> --- a/t/t3311-notes-merge-fanout.sh
> +++ b/t/t3311-notes-merge-fanout.sh
> @@ -135,13 +135,13 @@ test_expect_success 'No-op merge (already included) (x => y)' '
>  	git update-ref refs/notes/m refs/notes/y &&
>  	git config core.notesRef refs/notes/m &&
>  	git notes merge x &&
> -	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/y)"
> +	test_cmp_rev refs/notes/m refs/notes/y
>  '
>  
>  test_expect_success 'Fast-forward merge (y => x)' '
>  	git update-ref refs/notes/m refs/notes/x &&
>  	git notes merge y &&
> -	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/y)"
> +	test_cmp_rev refs/notes/m refs/notes/y
>  '
>  
>  cat <<EOF | sort >expect_notes_z
> @@ -394,7 +394,7 @@ test_expect_success 'verify conflict entries (with no fanout)' '
>  		exit 1
>  	done ) &&
>  	# Verify that current notes tree (pre-merge) has not changed (m == w)
> -	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
> +	test_cmp_rev refs/notes/m refs/notes/w
>  '
>  
>  cat >expect_log_m <<EOF
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index b79f442..9b15995 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -131,7 +131,7 @@ test_expect_success 'no changes are a nop' '
>  	set_fake_editor &&
>  	git rebase -i F &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
> -	test $(git rev-parse I) = $(git rev-parse HEAD)
> +	test_cmp_rev I HEAD
>  '
>  
>  test_expect_success 'test the [branch] option' '
> @@ -141,8 +141,8 @@ test_expect_success 'test the [branch] option' '
>  	set_fake_editor &&
>  	git rebase -i F branch2 &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
> -	test $(git rev-parse I) = $(git rev-parse branch2) &&
> -	test $(git rev-parse I) = $(git rev-parse HEAD)
> +	test_cmp_rev I branch2 &&
> +	test_cmp_rev I HEAD
>  '
>  
>  test_expect_success 'test --onto <branch>' '
> @@ -150,8 +150,8 @@ test_expect_success 'test --onto <branch>' '
>  	set_fake_editor &&
>  	git rebase -i --onto branch1 F &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/test-onto" &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse branch1) &&
> -	test $(git rev-parse I) = $(git rev-parse branch2)
> +	test_cmp_rev HEAD^ branch1 &&
> +	test_cmp_rev I branch2
>  '
>  
>  test_expect_success 'rebase on top of a non-conflicting commit' '
> @@ -161,12 +161,12 @@ test_expect_success 'rebase on top of a non-conflicting commit' '
>  	git rebase -i branch2 &&
>  	test file6 = $(git diff --name-only original-branch1) &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
> -	test $(git rev-parse I) = $(git rev-parse branch2) &&
> -	test $(git rev-parse I) = $(git rev-parse HEAD~2)
> +	test_cmp_rev I branch2 &&
> +	test_cmp_rev I HEAD~2
>  '
>  
>  test_expect_success 'reflog for the branch shows state before rebase' '
> -	test $(git rev-parse branch1@{1}) = $(git rev-parse original-branch1)
> +	test_cmp_rev branch1@{1} original-branch1
>  '
>  
>  test_expect_success 'exchange two commits' '
> @@ -198,7 +198,7 @@ test_expect_success 'stop on conflicting pick' '
>  	git tag new-branch1 &&
>  	set_fake_editor &&
>  	test_must_fail git rebase -i master &&
> -	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
> +	test_cmp_rev HEAD~3 master &&
>  	test_cmp expect .git/rebase-merge/patch &&
>  	test_cmp expect2 file1 &&
>  	test "$(git diff --name-status |
> @@ -209,7 +209,7 @@ test_expect_success 'stop on conflicting pick' '
>  
>  test_expect_success 'abort' '
>  	git rebase --abort &&
> -	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
> +	test_cmp_rev new-branch1 HEAD &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
>  	test_path_is_missing .git/rebase-merge
>  '
> @@ -247,7 +247,7 @@ test_expect_success 'squash' '
>  	FAKE_LINES="1 squash 2" EXPECT_HEADER_COUNT=2 \
>  		git rebase -i --onto master HEAD~2 &&
>  	test B = $(cat file7) &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse master)
> +	test_cmp_rev HEAD^ master
>  '
>  
>  test_expect_success 'retain authorship when squashing' '
> @@ -306,9 +306,9 @@ test_expect_success 'preserve merges with -p' '
>  	git update-index --refresh &&
>  	git diff-files --quiet &&
>  	git diff-index --quiet --cached HEAD -- &&
> -	test $(git rev-parse HEAD~6) = $(git rev-parse branch1) &&
> -	test $(git rev-parse HEAD~4^2) = $(git rev-parse to-be-preserved) &&
> -	test $(git rev-parse HEAD^^2^) = $(git rev-parse HEAD^^^) &&
> +	test_cmp_rev HEAD~6 branch1 &&
> +	test_cmp_rev HEAD~4^2 to-be-preserved &&
> +	test_cmp_rev HEAD^^2^ HEAD^^^ &&
>  	test $(git show HEAD~5:file1) = B &&
>  	test $(git show HEAD~3:file1) = C &&
>  	test $(git show HEAD:file1) = E &&
> @@ -335,7 +335,7 @@ test_expect_success '--continue tries to commit' '
>  	echo resolved > file1 &&
>  	git add file1 &&
>  	FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse new-branch1) &&
> +	test_cmp_rev HEAD^ new-branch1 &&
>  	git show HEAD | grep chouette
>  '
>  
> @@ -600,7 +600,7 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
>  	test $(git rev-parse branch3) != $(git rev-parse branch4) &&
>  	set_fake_editor &&
>  	git rebase -i branch3 &&
> -	test $(git rev-parse branch3) = $(git rev-parse branch4)
> +	test_cmp_rev branch3 branch4
>  
>  '
>  
> @@ -660,7 +660,7 @@ test_expect_success 'rebase -i continue with unstaged submodule' '
>  	test_must_fail git rebase -i submodule-base &&
>  	git reset &&
>  	git rebase --continue &&
> -	test $(git rev-parse submodule-base) = $(git rev-parse HEAD)
> +	test_cmp_rev submodule-base HEAD
>  '
>  
>  test_expect_success 'avoid unnecessary reset' '
> @@ -682,7 +682,7 @@ test_expect_success 'reword' '
>  	FAKE_LINES="1 2 3 reword 4" FAKE_COMMIT_MESSAGE="E changed" git rebase -i A &&
>  	git show HEAD | grep "E changed" &&
>  	test $(git rev-parse master) != $(git rev-parse HEAD) &&
> -	test $(git rev-parse master^) = $(git rev-parse HEAD^) &&
> +	test_cmp_rev master^ HEAD^ &&
>  	FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" git rebase -i A &&
>  	git show HEAD^ | grep "D changed" &&
>  	FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" git rebase -i A &&
> @@ -741,7 +741,7 @@ test_expect_success 'always cherry-pick with --no-ff' '
>  		git diff HEAD~$p original-no-ff-branch~$p > out &&
>  		test_cmp empty out
>  	done &&
> -	test $(git rev-parse HEAD~3) = $(git rev-parse original-no-ff-branch~3) &&
> +	test_cmp_rev HEAD~3 original-no-ff-branch~3 &&
>  	git diff HEAD~3 original-no-ff-branch~3 > out &&
>  	test_cmp empty out
>  '
> diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
> index a6a6c40..b5bafe8 100755
> --- a/t/t3407-rebase-abort.sh
> +++ b/t/t3407-rebase-abort.sh
> @@ -40,7 +40,7 @@ testrebase() {
>  		test_must_fail git rebase$type master &&
>  		test_path_is_dir "$dotest" &&
>  		git rebase --abort &&
> -		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
> +		test_cmp_rev to-rebase pre-rebase &&
>  		test ! -d "$dotest"
>  	'
>  
> @@ -51,9 +51,9 @@ testrebase() {
>  		test_must_fail git rebase$type master &&
>  		test_path_is_dir "$dotest" &&
>  		test_must_fail git rebase --skip &&
> -		test $(git rev-parse HEAD) = $(git rev-parse master) &&
> +		test_cmp_rev HEAD master &&
>  		git rebase --abort &&
> -		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
> +		test_cmp_rev to-rebase pre-rebase &&
>  		test ! -d "$dotest"
>  	'
>  
> @@ -69,7 +69,7 @@ testrebase() {
>  		test_must_fail git rebase --continue &&
>  		test $(git rev-parse HEAD) != $(git rev-parse master) &&
>  		git rebase --abort &&
> -		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
> +		test_cmp_rev to-rebase pre-rebase &&
>  		test ! -d "$dotest"
>  	'
>  
> diff --git a/t/t3410-rebase-preserve-dropped-merges.sh b/t/t3410-rebase-preserve-dropped-merges.sh
> index 6f73b95..99518ad 100755
> --- a/t/t3410-rebase-preserve-dropped-merges.sh
> +++ b/t/t3410-rebase-preserve-dropped-merges.sh
> @@ -51,7 +51,7 @@ test_expect_success 'skip same-resolution merges with -p' '
>  	test_commit J file1 23 &&
>  	test_commit K file7 file7 &&
>  	git rebase -i -p L &&
> -	test $(git rev-parse HEAD^^) = $(git rev-parse L) &&
> +	test_cmp_rev HEAD^^ L &&
>  	test "23" = "$(cat file1)" &&
>  	test "I" = "$(cat file6)" &&
>  	test "file7" = "$(cat file7)"
> @@ -76,7 +76,7 @@ test_expect_success 'keep different-resolution merges with -p' '
>  	echo 234 > file1 &&
>  	git add file1 &&
>  	git rebase --continue &&
> -	test $(git rev-parse HEAD^^^) = $(git rev-parse L2) &&
> +	test_cmp_rev HEAD^^^ L2 &&
>  	test "234" = "$(cat file1)" &&
>  	test "I" = "$(cat file6)" &&
>  	test "file7" = "$(cat file7)"
> diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
> index dc81bf2..d2dc55a 100755
> --- a/t/t3411-rebase-preserve-around-merges.sh
> +++ b/t/t3411-rebase-preserve-around-merges.sh
> @@ -38,8 +38,8 @@ test_expect_success 'setup' '
>  #
>  test_expect_success 'squash F1 into D1' '
>  	FAKE_LINES="1 squash 4 2 3" git rebase -i -p B1 &&
> -	test "$(git rev-parse HEAD^2)" = "$(git rev-parse C1)" &&
> -	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B1)" &&
> +	test_cmp_rev HEAD^2 C1 &&
> +	test_cmp_rev HEAD~2 B1 &&
>  	git tag E2
>  '
>  
> @@ -67,9 +67,9 @@ test_expect_success 'rebase two levels of merge' '
>  	test_commit L1 &&
>  	test_merge M1 K1 &&
>  	GIT_EDITOR=: git rebase -i -p E2 &&
> -	test "$(git rev-parse HEAD~3)" = "$(git rev-parse E2)" &&
> -	test "$(git rev-parse HEAD~2)" = "$(git rev-parse HEAD^2^2~2)" &&
> -	test "$(git rev-parse HEAD^2^1^1)" = "$(git rev-parse HEAD^2^2^1)"
> +	test_cmp_rev HEAD~3 E2 &&
> +	test_cmp_rev HEAD~2 HEAD^2^2~2 &&
> +	test_cmp_rev HEAD^2^1^1 HEAD^2^2^1
>  '
>  
>  test_done
> diff --git a/t/t3414-rebase-preserve-onto.sh b/t/t3414-rebase-preserve-onto.sh
> index ee0a6cc..5389b1a 100755
> --- a/t/t3414-rebase-preserve-onto.sh
> +++ b/t/t3414-rebase-preserve-onto.sh
> @@ -43,8 +43,8 @@ test_expect_success 'setup' '
>  test_expect_success 'rebase from B1 onto H1' '
>  	git checkout G1 &&
>  	git rebase -p --onto H1 B1 &&
> -	test "$(git rev-parse HEAD^1^1^1)" = "$(git rev-parse H1)" &&
> -	test "$(git rev-parse HEAD^2^1^1)" = "$(git rev-parse H1)"
> +	test_cmp_rev HEAD^1^1^1 H1 &&
> +	test_cmp_rev HEAD^2^1^1 H1
>  '
>  
>  # On the other hand if rebase from E1 which is within one branch,
> @@ -58,8 +58,8 @@ test_expect_success 'rebase from B1 onto H1' '
>  test_expect_success 'rebase from E1 onto H1' '
>  	git checkout G1 &&
>  	git rebase -p --onto H1 E1 &&
> -	test "$(git rev-parse HEAD^1^1)" = "$(git rev-parse H1)" &&
> -	test "$(git rev-parse HEAD^2)" = "$(git rev-parse D1)"
> +	test_cmp_rev HEAD^1^1 H1 &&
> +	test_cmp_rev HEAD^2 D1
>  '
>  
>  # And the same if we rebase from a commit in the second-parent branch.
> @@ -73,8 +73,8 @@ test_expect_success 'rebase from C1 onto H1' '
>  	git checkout G1 &&
>  	git rev-list --first-parent --pretty=oneline C1..G1 &&
>  	git rebase -p --onto H1 C1 &&
> -	test "$(git rev-parse HEAD^2^1)" = "$(git rev-parse H1)" &&
> -	test "$(git rev-parse HEAD^1)" = "$(git rev-parse F1)"
> +	test_cmp_rev HEAD^2^1 H1 &&
> +	test_cmp_rev HEAD^1 F1
>  '
>  
>  test_done
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 51f3bbb..53922d9 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -63,7 +63,7 @@ test_expect_success 'cherry-pick after renaming branch' '
>  
>  	git checkout rename2 &&
>  	git cherry-pick added &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
> +	test_cmp_rev HEAD^ rename2 &&
>  	test -f opos &&
>  	grep "Add extra line at the end" opos &&
>  	git reflog -1 | grep cherry-pick
> @@ -74,7 +74,7 @@ test_expect_success 'revert after renaming branch' '
>  
>  	git checkout rename1 &&
>  	git revert added &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
> +	test_cmp_rev HEAD^ rename1 &&
>  	test -f spoo &&
>  	! grep "Add extra line at the end" spoo &&
>  	git reflog -1 | grep revert
> diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
> index fb889ac..5f7f964 100755
> --- a/t/t3506-cherry-pick-ff.sh
> +++ b/t/t3506-cherry-pick-ff.sh
> @@ -24,7 +24,7 @@ test_expect_success 'cherry-pick using --ff fast forwards' '
>  	git reset --hard first &&
>  	test_tick &&
>  	git cherry-pick --ff second &&
> -	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify second)"
> +	test_cmp_rev HEAD second
>  '
>  
>  test_expect_success 'cherry-pick not using --ff does not fast forwards' '
> @@ -80,14 +80,14 @@ test_expect_success 'cherry pick with --ff a merge (1)' '
>  	git reset --hard A -- &&
>  	git cherry-pick --ff -m 1 C &&
>  	git diff --exit-code C &&
> -	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify C)"
> +	test_cmp_rev HEAD C
>  '
>  
>  test_expect_success 'cherry pick with --ff a merge (2)' '
>  	git reset --hard B -- &&
>  	git cherry-pick --ff -m 2 C &&
>  	git diff --exit-code C &&
> -	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify C)"
> +	test_cmp_rev HEAD C
>  '
>  
>  test_expect_success 'cherry pick a merge relative to nonexistent parent with --ff should fail' '
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 2142c1f..3517543 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -34,7 +34,7 @@ index 0cfbf08..00750ed 100644
>  EOF
>  
>  test_expect_success 'parents of stash' '
> -	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
> +	test_cmp_rev stash^ HEAD &&
>  	git diff stash^2..stash > output &&
>  	test_cmp output expect
>  '
> @@ -188,7 +188,7 @@ test_expect_success 'stash branch' '
>  	git commit file -m second &&
>  	git stash branch stashbranch &&
>  	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
> -	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
> +	test_cmp_rev HEAD master^ &&
>  	git diff --cached > output &&
>  	test_cmp output expect &&
>  	git diff > output &&
> @@ -653,7 +653,7 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
>  	git stash &&
>  	git diff-files --quiet &&
>  	git diff-index --cached --quiet HEAD &&
> -	test "$(git rev-parse stash^)" = "$(git rev-parse HEAD)" &&
> +	test_cmp_rev stash^ HEAD &&
>  	git diff stash^..stash > output &&
>  	test_cmp output expect
>  '
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index b41bd17..c6b0a0f 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -209,8 +209,8 @@ test_expect_success 'am applies patch correctly' '
>  	git am <patch1 &&
>  	test_path_is_missing .git/rebase-apply &&
>  	git diff --exit-code second &&
> -	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
> +	test_cmp_rev second HEAD &&
> +	test_cmp_rev second^ HEAD^
>  '
>  
>  test_expect_success 'am fails if index is dirty' '
> @@ -232,8 +232,8 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
>  	git am patch1.eml &&
>  	test_path_is_missing .git/rebase-apply &&
>  	git diff --exit-code second &&
> -	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
> +	test_cmp_rev second HEAD &&
> +	test_cmp_rev second^ HEAD^
>  '
>  
>  test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
> @@ -243,8 +243,8 @@ test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
>  	git am patch1-crlf.eml &&
>  	test_path_is_missing .git/rebase-apply &&
>  	git diff --exit-code second &&
> -	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
> +	test_cmp_rev second HEAD &&
> +	test_cmp_rev second^ HEAD^
>  '
>  
>  test_expect_success 'am applies patch e-mail with preceding whitespace' '
> @@ -254,8 +254,8 @@ test_expect_success 'am applies patch e-mail with preceding whitespace' '
>  	git am patch1-ws.eml &&
>  	test_path_is_missing .git/rebase-apply &&
>  	git diff --exit-code second &&
> -	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
> +	test_cmp_rev second HEAD &&
> +	test_cmp_rev second^ HEAD^
>  '
>  
>  test_expect_success 'am applies stgit patch' '
> @@ -456,7 +456,7 @@ test_expect_success 'am changes committer and keeps author' '
>  	git checkout first &&
>  	git am patch2 &&
>  	test_path_is_missing .git/rebase-apply &&
> -	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
> +	test_cmp_rev master^^ HEAD^^ &&
>  	git diff --exit-code master..HEAD &&
>  	git diff --exit-code master^..HEAD^ &&
>  	compare author master HEAD &&
> diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
> index 2b8c0ba..7ce40c5 100755
> --- a/t/t5404-tracking-branches.sh
> +++ b/t/t5404-tracking-branches.sh
> @@ -40,7 +40,7 @@ test_expect_success 'mixed-success push returns error' '
>  '
>  
>  test_expect_success 'check tracking branches updated correctly after push' '
> -	test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
> +	test_cmp_rev origin/master master
>  '
>  
>  test_expect_success 'check tracking branches not updated for failed refs' '
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index dd2e6ce..0300344 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -727,7 +727,7 @@ test_expect_success 'rename a remote' '
>  		git remote rename origin upstream &&
>  		rmdir .git/refs/remotes/origin &&
>  		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
> -		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
> +		test_cmp_rev upstream/master master &&
>  		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
>  		test "$(git config branch.master.remote)" = "upstream"
>  	)
> @@ -760,7 +760,7 @@ test_expect_success 'rename a remote with name prefix of other remote' '
>  		cd four.three &&
>  		git remote add o git://example.com/repo.git &&
>  		git remote rename o upstream &&
> -		test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
> +		test_cmp_rev origin/master master
>  	)
>  '
>  
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index c952d5e..b8c0f46 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -209,7 +209,7 @@ test_expect_success 'fast-forwards working tree if branch head is updated' '
>  	git pull . second:third 2>err &&
>  	test_i18ngrep "fetch updated the current branch head" err &&
>  	test "$(cat file)" = modified &&
> -	test "$(git rev-parse third)" = "$(git rev-parse second)"
> +	test_cmp_rev third second
>  '
>  
>  test_expect_success 'fast-forward fails with conflicting work tree' '
> @@ -220,7 +220,7 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
>  	test_must_fail git pull . second:third 2>err &&
>  	test_i18ngrep "Cannot fast-forward your working tree" err &&
>  	test "$(cat file)" = conflict &&
> -	test "$(git rev-parse third)" = "$(git rev-parse second)"
> +	test_cmp_rev third second
>  '
>  
>  test_expect_success '--rebase' '
> @@ -233,14 +233,14 @@ test_expect_success '--rebase' '
>  	git commit -m "new file" &&
>  	git tag before-rebase &&
>  	git pull --rebase . copy &&
> -	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^ copy &&
>  	test new = "$(git show HEAD:file2)"
>  '
>  
>  test_expect_success '--rebase fails with multiple branches' '
>  	git reset --hard before-rebase &&
>  	test_must_fail git pull --rebase . copy master 2>err &&
> -	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
> +	test_cmp_rev HEAD before-rebase &&
>  	test_i18ngrep "Cannot rebase onto multiple branches" err &&
>  	test modified = "$(git show HEAD:file)"
>  '
> @@ -260,7 +260,7 @@ test_expect_success 'pull.rebase' '
>  	git reset --hard before-rebase &&
>  	test_config pull.rebase true &&
>  	git pull . copy &&
> -	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^ copy &&
>  	test new = "$(git show HEAD:file2)"
>  '
>  
> @@ -268,7 +268,7 @@ test_expect_success 'branch.to-rebase.rebase' '
>  	git reset --hard before-rebase &&
>  	test_config branch.to-rebase.rebase true &&
>  	git pull . copy &&
> -	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^ copy &&
>  	test new = "$(git show HEAD:file2)"
>  '
>  
> @@ -297,8 +297,8 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase false &&
>  	git pull . copy &&
> -	test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
> -	test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^1 before-preserve-rebase &&
> +	test_cmp_rev HEAD^2 copy &&
>  	test file3 = "$(git show HEAD:file3.t)"
>  '
>  
> @@ -306,7 +306,7 @@ test_expect_success 'pull.rebase=true flattens keep-merge' '
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase true &&
>  	git pull . copy &&
> -	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^^ copy &&
>  	test file3 = "$(git show HEAD:file3.t)"
>  '
>  
> @@ -314,7 +314,7 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase 1 &&
>  	git pull . copy &&
> -	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^^ copy &&
>  	test file3 = "$(git show HEAD:file3.t)"
>  '
>  
> @@ -322,8 +322,8 @@ test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase preserve &&
>  	git pull . copy &&
> -	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
> -	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
> +	test_cmp_rev HEAD^^ copy &&
> +	test_cmp_rev HEAD^2 keep-merge
>  '
>  
>  test_expect_success 'pull.rebase=interactive' '
> @@ -346,8 +346,8 @@ test_expect_success '--rebase=false create a new merge commit' '
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase true &&
>  	git pull --rebase=false . copy &&
> -	test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
> -	test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^1 before-preserve-rebase &&
> +	test_cmp_rev HEAD^2 copy &&
>  	test file3 = "$(git show HEAD:file3.t)"
>  '
>  
> @@ -355,7 +355,7 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase preserve &&
>  	git pull --rebase=true . copy &&
> -	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^^ copy &&
>  	test file3 = "$(git show HEAD:file3.t)"
>  '
>  
> @@ -363,8 +363,8 @@ test_expect_success '--rebase=preserve rebases and merges keep-merge' '
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase true &&
>  	git pull --rebase=preserve . copy &&
> -	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
> -	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
> +	test_cmp_rev HEAD^^ copy &&
> +	test_cmp_rev HEAD^2 keep-merge
>  '
>  
>  test_expect_success '--rebase=invalid fails' '
> @@ -376,7 +376,7 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase preserve &&
>  	git pull --rebase . copy &&
> -	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
> +	test_cmp_rev HEAD^^ copy &&
>  	test file3 = "$(git show HEAD:file3.t)"
>  '
>  
> diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> index 05ebba7..4e31f6a 100755
> --- a/t/t6022-merge-rename.sh
> +++ b/t/t6022-merge-rename.sh
> @@ -788,7 +788,7 @@ test_expect_success 'merge rename + small change' '
>  
>  	test 1 -eq $(git ls-files -s | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
> -	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
> +	test_cmp_rev HEAD:renamed_file HEAD~1:file
>  '
>  
>  test_expect_success 'setup for use of extended merge markers' '
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index e74662b..05bc639 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -335,16 +335,16 @@ test_expect_success 'bisect skip only one range' '
>  	git bisect reset &&
>  	git bisect start $HASH7 $HASH1 &&
>  	git bisect skip $HASH1..$HASH5 &&
> -	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
> +	test_cmp_rev HEAD $HASH6 &&
>  	test_must_fail git bisect bad > my_bisect_log.txt &&
>  	grep "first bad commit could be any of" my_bisect_log.txt
>  '
>  
>  test_expect_success 'bisect skip many ranges' '
>  	git bisect start $HASH7 $HASH1 &&
> -	test "$HASH4" = "$(git rev-parse --verify HEAD)" &&
> +	test_cmp_rev HEAD $HASH4 &&
>  	git bisect skip $HASH2 $HASH2.. ..$HASH5 &&
> -	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
> +	test_cmp_rev HEAD $HASH6 &&
>  	test_must_fail git bisect bad > my_bisect_log.txt &&
>  	grep "first bad commit could be any of" my_bisect_log.txt
>  '
> @@ -356,7 +356,7 @@ test_expect_success 'bisect starting with a detached HEAD' '
>  	git bisect start &&
>  	test $HEAD = $(cat .git/BISECT_START) &&
>  	git bisect reset &&
> -	test $HEAD = $(git rev-parse --verify HEAD)
> +	test_cmp_rev "$HEAD" HEAD
>  '
>  
>  test_expect_success 'bisect errors out if bad and good are mistaken' '
> @@ -370,18 +370,15 @@ test_expect_success 'bisect does not create a "bisect" branch' '
>  	git bisect reset &&
>  	git bisect start $HASH7 $HASH1 &&
>  	git branch bisect &&
> -	rev_hash4=$(git rev-parse --verify HEAD) &&
> -	test "$rev_hash4" = "$HASH4" &&
> +	test_cmp_rev HEAD $HASH4 &&
>  	git branch -D bisect &&
>  	git bisect good &&
>  	git branch bisect &&
> -	rev_hash6=$(git rev-parse --verify HEAD) &&
> -	test "$rev_hash6" = "$HASH6" &&
> +	test_cmp_rev HEAD $HASH6 &&
>  	git bisect good > my_bisect_log.txt &&
>  	grep "$HASH7 is the first bad commit" my_bisect_log.txt &&
>  	git bisect reset &&
> -	rev_hash6=$(git rev-parse --verify bisect) &&
> -	test "$rev_hash6" = "$HASH6" &&
> +	test_cmp_rev bisect $HASH6 &&
>  	git branch -D bisect
>  '
>  
> @@ -481,7 +478,7 @@ test_expect_success 'optimized merge base checks' '
>  	grep "$HASH4" my_bisect_log.txt &&
>  	git bisect good > my_bisect_log2.txt &&
>  	test -f ".git/BISECT_ANCESTORS_OK" &&
> -	test "$HASH6" = $(git rev-parse --verify HEAD) &&
> +	test_cmp_rev HEAD $HASH6 &&
>  	git bisect bad > my_bisect_log3.txt &&
>  	git bisect good "$A_HASH" > my_bisect_log4.txt &&
>  	grep "merge base must be tested" my_bisect_log4.txt &&
> @@ -524,8 +521,7 @@ test_expect_success '"parallel" side branch creation' '
>  test_expect_success 'restricting bisection on one dir' '
>  	git bisect reset &&
>  	git bisect start HEAD $HASH1 -- dir1 &&
> -	para1=$(git rev-parse --verify HEAD) &&
> -	test "$para1" = "$PARA_HASH1" &&
> +	test_cmp_rev HEAD "$PARA_HASH1" &&
>  	git bisect bad > my_bisect_log.txt &&
>  	grep "$PARA_HASH1 is the first bad commit" my_bisect_log.txt
>  '
> @@ -533,31 +529,24 @@ test_expect_success 'restricting bisection on one dir' '
>  test_expect_success 'restricting bisection on one dir and a file' '
>  	git bisect reset &&
>  	git bisect start HEAD $HASH1 -- dir1 hello &&
> -	para4=$(git rev-parse --verify HEAD) &&
> -	test "$para4" = "$PARA_HASH4" &&
> +	test_cmp_rev HEAD "$PARA_HASH4" &&
>  	git bisect bad &&
> -	hash3=$(git rev-parse --verify HEAD) &&
> -	test "$hash3" = "$HASH3" &&
> +	test_cmp_rev HEAD $HASH3 &&
>  	git bisect good &&
> -	hash4=$(git rev-parse --verify HEAD) &&
> -	test "$hash4" = "$HASH4" &&
> +	test_cmp_rev HEAD $HASH4 &&
>  	git bisect good &&
> -	para1=$(git rev-parse --verify HEAD) &&
> -	test "$para1" = "$PARA_HASH1" &&
> +	test_cmp_rev HEAD "$PARA_HASH1" &&
>  	git bisect good > my_bisect_log.txt &&
>  	grep "$PARA_HASH4 is the first bad commit" my_bisect_log.txt
>  '
>  
>  test_expect_success 'skipping away from skipped commit' '
>  	git bisect start $PARA_HASH7 $HASH1 &&
> -	para4=$(git rev-parse --verify HEAD) &&
> -	test "$para4" = "$PARA_HASH4" &&
> -        git bisect skip &&
> -	hash7=$(git rev-parse --verify HEAD) &&
> -	test "$hash7" = "$HASH7" &&
> -        git bisect skip &&
> -	para3=$(git rev-parse --verify HEAD) &&
> -	test "$para3" = "$PARA_HASH3"
> +	test_cmp_rev HEAD "$PARA_HASH4" &&
> +	git bisect skip &&
> +	test_cmp_rev HEAD $HASH7 &&
> +	git bisect skip &&
> +	test_cmp_rev HEAD "$PARA_HASH3"
>  '
>  
>  test_expect_success 'erroring out when using bad path parameters' '
> @@ -644,56 +633,50 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
>  	test_cmp expected.missing-tree.default error.txt
>  '
>  
> -check_same()
> -{
> -	echo "Checking $1 is the same as $2" &&
> -	test_cmp_rev "$1" "$2"
> -}
> -
>  test_expect_success 'bisect: --no-checkout - start commit bad' '
>  	git bisect reset &&
>  	git bisect start BROKEN_HASH7 BROKEN_HASH4 --no-checkout &&
> -	check_same BROKEN_HASH6 BISECT_HEAD &&
> +	test_cmp_rev BISECT_HEAD BROKEN_HASH6 &&
>  	git bisect reset
>  '
>  
>  test_expect_success 'bisect: --no-checkout - trial commit bad' '
>  	git bisect reset &&
>  	git bisect start broken BROKEN_HASH4 --no-checkout &&
> -	check_same BROKEN_HASH6 BISECT_HEAD &&
> +	test_cmp_rev BISECT_HEAD BROKEN_HASH6 &&
>  	git bisect reset
>  '
>  
>  test_expect_success 'bisect: --no-checkout - target before breakage' '
>  	git bisect reset &&
>  	git bisect start broken BROKEN_HASH4 --no-checkout &&
> -	check_same BROKEN_HASH6 BISECT_HEAD &&
> +	test_cmp_rev BISECT_HEAD BROKEN_HASH6 &&
>  	git bisect bad BISECT_HEAD &&
> -	check_same BROKEN_HASH5 BISECT_HEAD &&
> +	test_cmp_rev BISECT_HEAD BROKEN_HASH5 &&
>  	git bisect bad BISECT_HEAD &&
> -	check_same BROKEN_HASH5 bisect/bad &&
> +	test_cmp_rev bisect/bad BROKEN_HASH5 &&
>  	git bisect reset
>  '
>  
>  test_expect_success 'bisect: --no-checkout - target in breakage' '
>  	git bisect reset &&
>  	git bisect start broken BROKEN_HASH4 --no-checkout &&
> -	check_same BROKEN_HASH6 BISECT_HEAD &&
> +	test_cmp_rev BISECT_HEAD BROKEN_HASH6 &&
>  	git bisect bad BISECT_HEAD &&
> -	check_same BROKEN_HASH5 BISECT_HEAD &&
> +	test_cmp_rev BISECT_HEAD BROKEN_HASH5 &&
>  	git bisect good BISECT_HEAD &&
> -	check_same BROKEN_HASH6 bisect/bad &&
> +	test_cmp_rev bisect/bad BROKEN_HASH6 &&
>  	git bisect reset
>  '
>  
>  test_expect_success 'bisect: --no-checkout - target after breakage' '
>  	git bisect reset &&
>  	git bisect start broken BROKEN_HASH4 --no-checkout &&
> -	check_same BROKEN_HASH6 BISECT_HEAD &&
> +	test_cmp_rev BISECT_HEAD BROKEN_HASH6 &&
>  	git bisect good BISECT_HEAD &&
> -	check_same BROKEN_HASH8 BISECT_HEAD &&
> +	test_cmp_rev BISECT_HEAD BROKEN_HASH8 &&
>  	git bisect good BISECT_HEAD &&
> -	check_same BROKEN_HASH9 bisect/bad &&
> +	test_cmp_rev bisect/bad BROKEN_HASH9 &&
>  	git bisect reset
>  '
>  
> @@ -708,7 +691,7 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
>  		rc=\$?
>  		rm -f tmp.\$\$
>  		test \$rc = 0' &&
> -	check_same BROKEN_HASH6 bisect/bad &&
> +	test_cmp_rev bisect/bad BROKEN_HASH6 &&
>  	git bisect reset
>  "
>  
> @@ -755,7 +738,7 @@ test_expect_success '"git bisect bad HEAD" behaves as "git bisect bad"' '
>  	git bisect start HEAD $HASH1 &&
>  	git bisect good HEAD &&
>  	git bisect bad HEAD &&
> -	test "$HASH6" = $(git rev-parse --verify HEAD) &&
> +	test_cmp_rev HEAD $HASH6 &&
>  	git bisect reset
>  '
>  
> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
> index 9d6621c..dd1be5d 100755
> --- a/t/t6036-recursive-corner-cases.sh
> +++ b/t/t6036-recursive-corner-cases.sh
> @@ -61,8 +61,8 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
>  	test 2 = $(git ls-files -u | wc -l) &&
>  	test 2 = $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
> -	test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
> +	test_cmp_rev :2:three L2:three &&
> +	test_cmp_rev :3:three R2:three &&
>  
>  	test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
>  	test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
> @@ -128,8 +128,8 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
>  	test 2 = $(git ls-files -u | wc -l) &&
>  	test 2 = $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
> -	test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
> +	test_cmp_rev :2:three L2:three &&
> +	test_cmp_rev :3:three R2:three &&
>  
>  	test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
>  	test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
> @@ -201,8 +201,8 @@ test_expect_success 'git detects differently handled merges conflict' '
>  	test 3 = $(git ls-files -u | wc -l) &&
>  	test 0 = $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
> -	test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
> +	test_cmp_rev :2:new_a D:new_a &&
> +	test_cmp_rev :3:new_a E:new_a &&
>  
>  	git cat-file -p B:new_a >>merged &&
>  	git cat-file -p C:new_a >>merge-me &&
> @@ -281,8 +281,8 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
>  	test 2 -eq $(git ls-files -s | wc -l) &&
>  	test 2 -eq $(git ls-files -u | wc -l) &&
>  
> -	test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
> -	test $(git rev-parse :2:file) = $(git rev-parse B:file)
> +	test_cmp_rev :1:file master:file &&
> +	test_cmp_rev :2:file B:file
>  '
>  
>  test_expect_success 'git detects conflict merging criss-cross+modify/delete, reverse direction' '
> @@ -294,8 +294,8 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
>  	test 2 -eq $(git ls-files -s | wc -l) &&
>  	test 2 -eq $(git ls-files -u | wc -l) &&
>  
> -	test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
> -	test $(git rev-parse :3:file) = $(git rev-parse B:file)
> +	test_cmp_rev :1:file master:file &&
> +	test_cmp_rev :3:file B:file
>  '
>  
>  #
> @@ -377,8 +377,8 @@ test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
>  	test 3 -eq $(git ls-files -u | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :2:file) = $(git rev-parse D:file) &&
> -	test $(git rev-parse :3:file) = $(git rev-parse E:file)
> +	test_cmp_rev :2:file D:file &&
> +	test_cmp_rev :3:file E:file
>  '
>  
>  #
> @@ -483,8 +483,8 @@ test_expect_success 'merge of D & E1 fails but has appropriate contents' '
>  	test 1 -eq $(git ls-files -u | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
> -	test $(git rev-parse :2:a) = $(git rev-parse B:a)
> +	test_cmp_rev :0:ignore-me A:ignore-me &&
> +	test_cmp_rev :2:a B:a
>  '
>  
>  test_expect_success 'merge of E1 & D fails but has appropriate contents' '
> @@ -496,8 +496,8 @@ test_expect_success 'merge of E1 & D fails but has appropriate contents' '
>  	test 1 -eq $(git ls-files -u | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
> -	test $(git rev-parse :3:a) = $(git rev-parse B:a)
> +	test_cmp_rev :0:ignore-me A:ignore-me &&
> +	test_cmp_rev :3:a B:a
>  '
>  
>  test_expect_success 'merge of D & E2 fails but has appropriate contents' '
> @@ -509,10 +509,10 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
>  	test 3 -eq $(git ls-files -u | wc -l) &&
>  	test 1 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
> -	test $(git rev-parse :3:a/file) = $(git rev-parse E2:a/file) &&
> -	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
> -	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
> +	test_cmp_rev :2:a B:a &&
> +	test_cmp_rev :3:a/file E2:a/file &&
> +	test_cmp_rev :1:a/file C:a/file &&
> +	test_cmp_rev :0:ignore-me A:ignore-me &&
>  
>  	test -f a~HEAD
>  '
> @@ -526,10 +526,10 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
>  	test 3 -eq $(git ls-files -u | wc -l) &&
>  	test 1 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
> -	test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
> -	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
> -	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
> +	test_cmp_rev :3:a B:a &&
> +	test_cmp_rev :2:a/file E2:a/file &&
> +	test_cmp_rev :1:a/file C:a/file &&
> +	test_cmp_rev :0:ignore-me A:ignore-me &&
>  
>  	test -f a~D^0
>  '
> @@ -619,7 +619,7 @@ test_expect_success 'handle rename/rename(1to2)/modify followed by what looks li
>  	test 0 -eq $(git ls-files -u | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse HEAD:newname) = $(git rev-parse E:newname)
> +	test_cmp_rev HEAD:newname E:newname
>  '
>  
>  #
> @@ -694,8 +694,8 @@ test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
>  	test 0 -eq $(git ls-files -u | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
> -	test $(git rev-parse HEAD:c) = $(git rev-parse A:a) &&
> +	test_cmp_rev HEAD:b A:a &&
> +	test_cmp_rev HEAD:c A:a &&
>  	test "$(cat a)" = "$(printf "1\n2\n3\n4\n5\n6\n7\n8\n")"
>  '
>  
> @@ -764,8 +764,8 @@ test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
>  	test 0 -eq $(git ls-files -u | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse HEAD:a) = $(git rev-parse A:a) &&
> -	test $(git rev-parse HEAD:c) = $(git rev-parse E:c)
> +	test_cmp_rev HEAD:a A:a &&
> +	test_cmp_rev HEAD:c E:c
>  '
>  
>  test_done
> diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> index 411550d..9aac880 100755
> --- a/t/t6042-merge-rename-corner-cases.sh
> +++ b/t/t6042-merge-rename-corner-cases.sh
> @@ -68,8 +68,8 @@ test_expect_failure 'rename/modify/add-source conflict resolvable' '
>  
>  	git merge -s recursive C^0 &&
>  
> -	test $(git rev-parse B:a) = $(git rev-parse b) &&
> -	test $(git rev-parse C:a) = $(git rev-parse a)
> +	test_cmp_rev B:a b &&
> +	test_cmp_rev C:a a
>  '
>  
>  test_expect_success 'setup resolvable conflict missed if rename missed' '
> @@ -105,8 +105,8 @@ test_expect_failure 'conflict caused if rename not detected' '
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
>  	test_line_count = 6 c &&
> -	test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
> -	test $(git rev-parse HEAD:b) = $(git rev-parse A:b)
> +	test_cmp_rev HEAD:a B:a &&
> +	test_cmp_rev HEAD:b A:b
>  '
>  
>  test_expect_success 'setup conflict resolved wrong if rename missed' '
> @@ -178,8 +178,8 @@ test_expect_failure 'detect rename/add-source and preserve all data' '
>  	test -f a &&
>  	test -f b &&
>  
> -	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
> -	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
> +	test_cmp_rev HEAD:b A:a &&
> +	test_cmp_rev HEAD:a C:a
>  '
>  
>  test_expect_failure 'detect rename/add-source and preserve all data, merge other way' '
> @@ -194,8 +194,8 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
>  	test -f a &&
>  	test -f b &&
>  
> -	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
> -	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
> +	test_cmp_rev HEAD:b A:a &&
> +	test_cmp_rev HEAD:a C:a
>  '
>  
>  test_expect_success 'setup content merge + rename/directory conflict' '
> @@ -281,9 +281,9 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
>  		left base right &&
>  	test_cmp left newfile~HEAD &&
>  
> -	test $(git rev-parse :1:newfile) = $(git rev-parse base:file) &&
> -	test $(git rev-parse :2:newfile) = $(git rev-parse left-conflict:newfile) &&
> -	test $(git rev-parse :3:newfile) = $(git rev-parse right:file) &&
> +	test_cmp_rev :1:newfile base:file &&
> +	test_cmp_rev :2:newfile left-conflict:newfile &&
> +	test_cmp_rev :3:newfile right:file &&
>  
>  	test -f newfile/realfile &&
>  	test -f newfile~HEAD
> @@ -432,9 +432,9 @@ test_expect_success 'merge has correct working tree contents' '
>  	test 3 -eq $(git ls-files -u | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
> -	test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
> -	test $(git rev-parse :2:c) = $(git rev-parse A:a) &&
> +	test_cmp_rev :1:a A:a &&
> +	test_cmp_rev :3:b A:a &&
> +	test_cmp_rev :2:c A:a &&
>  
>  	test ! -f a &&
>  	test $(git hash-object b) = $(git rev-parse A:a) &&
> @@ -478,10 +478,10 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
>  	test 4 -eq $(git ls-files -s | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse 3:a) = $(git rev-parse C:a) &&
> -	test $(git rev-parse 1:a) = $(git rev-parse A:a) &&
> -	test $(git rev-parse 2:b) = $(git rev-parse B:b) &&
> -	test $(git rev-parse 3:c) = $(git rev-parse C:c) &&
> +	test_cmp_rev 3:a C:a &&
> +	test_cmp_rev 1:a A:a &&
> +	test_cmp_rev 2:b B:b &&
> +	test_cmp_rev 3:c C:c &&
>  
>  	test -f a &&
>  	test -f b &&
> @@ -520,8 +520,8 @@ test_expect_failure 'rename/rename/add-source still tracks new a file' '
>  	test 2 -eq $(git ls-files -s | wc -l) &&
>  	test 0 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse HEAD:a) = $(git rev-parse C:a) &&
> -	test $(git rev-parse HEAD:b) = $(git rev-parse A:a)
> +	test_cmp_rev HEAD:a C:a &&
> +	test_cmp_rev HEAD:b A:a
>  '
>  
>  test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
> @@ -560,11 +560,11 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
>  	test 2 -eq $(git ls-files -u c | wc -l) &&
>  	test 4 -eq $(git ls-files -o | wc -l) &&
>  
> -	test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
> -	test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
> -	test $(git rev-parse :3:b) = $(git rev-parse B:b) &&
> -	test $(git rev-parse :2:c) = $(git rev-parse C:c) &&
> -	test $(git rev-parse :3:c) = $(git rev-parse B:c) &&
> +	test_cmp_rev :1:a A:a &&
> +	test_cmp_rev :2:b C:b &&
> +	test_cmp_rev :3:b B:b &&
> +	test_cmp_rev :2:c C:c &&
> +	test_cmp_rev :3:c B:c &&
>  
>  	test $(git hash-object c~HEAD) = $(git rev-parse C:c) &&
>  	test $(git hash-object c~B\^0) = $(git rev-parse B:c) &&
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index cb8fbd8..72511de 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -354,8 +354,8 @@ test_expect_success '--remap-to-ancestor with filename filters' '
>  	git filter-branch -f --remap-to-ancestor \
>  		moved-foo moved-bar A..master \
>  		-- -- foo &&
> -	test $(git rev-parse moved-foo) = $(git rev-parse moved-bar) &&
> -	test $(git rev-parse moved-foo) = $(git rev-parse master^) &&
> +	test_cmp_rev moved-foo moved-bar &&
> +	test_cmp_rev moved-foo master^ &&
>  	test $orig_invariant = $(git rev-parse invariant)
>  '
>  
> @@ -372,8 +372,8 @@ test_expect_success 'automatic remapping to ancestor with filename filters' '
>  	git filter-branch -f \
>  		moved-foo2 moved-bar2 A..master \
>  		-- -- foo &&
> -	test $(git rev-parse moved-foo2) = $(git rev-parse moved-bar2) &&
> -	test $(git rev-parse moved-foo2) = $(git rev-parse master^) &&
> +	test_cmp_rev moved-foo2 moved-bar2 &&
> +	test_cmp_rev moved-foo2 master^ &&
>  	test $orig_invariant = $(git rev-parse invariant2)
>  '
>  
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index f9b7d79..cd65715 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -337,7 +337,7 @@ test_expect_success \
>  	'a non-annotated tag created without parameters should point to HEAD' '
>  	git tag non-annotated-tag &&
>  	test $(git cat-file -t non-annotated-tag) = commit &&
> -	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
> +	test_cmp_rev non-annotated-tag HEAD
>  '
>  
>  test_expect_success 'trying to verify an unknown tag should fail' \
> diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> index a82a07a..2373684 100755
> --- a/t/t7110-reset-merge.sh
> +++ b/t/t7110-reset-merge.sh
> @@ -31,7 +31,7 @@ test_expect_success 'reset --merge is ok with changes in file it does not touch'
>      git reset --merge HEAD^ &&
>      ! grep 4 file1 &&
>      grep 4 file2 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> +    test_cmp_rev HEAD initial &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -39,7 +39,7 @@ test_expect_success 'reset --merge is ok when switching back' '
>      git reset --merge second &&
>      grep 4 file1 &&
>      grep 4 file2 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
> +    test_cmp_rev HEAD second &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -55,7 +55,7 @@ test_expect_success 'reset --keep is ok with changes in file it does not touch'
>      git reset --keep HEAD^ &&
>      ! grep 4 file1 &&
>      grep 4 file2 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> +    test_cmp_rev HEAD initial &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -63,7 +63,7 @@ test_expect_success 'reset --keep is ok when switching back' '
>      git reset --keep second &&
>      grep 4 file1 &&
>      grep 4 file2 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
> +    test_cmp_rev HEAD second &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -82,7 +82,7 @@ test_expect_success 'reset --merge discards changes added to index (1)' '
>      ! grep 4 file1 &&
>      ! grep 5 file1 &&
>      grep 4 file2 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> +    test_cmp_rev HEAD initial &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -94,7 +94,7 @@ test_expect_success 'reset --merge is ok again when switching back (1)' '
>      ! grep 4 file2 &&
>      ! grep 5 file1 &&
>      grep 4 file1 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
> +    test_cmp_rev HEAD second &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -122,7 +122,7 @@ test_expect_success 'reset --merge discards changes added to index (2)' '
>      git add file2 &&
>      git reset --merge HEAD^ &&
>      ! grep 4 file2 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> +    test_cmp_rev HEAD initial &&
>      test -z "$(git diff)" &&
>      test -z "$(git diff --cached)"
>  '
> @@ -132,7 +132,7 @@ test_expect_success 'reset --merge is ok again when switching back (2)' '
>      git reset --merge second &&
>      ! grep 4 file2 &&
>      grep 4 file1 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
> +    test_cmp_rev HEAD second &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -148,7 +148,7 @@ test_expect_success 'reset --keep keeps changes it does not touch' '
>      git add file2 &&
>      git reset --keep HEAD^ &&
>      grep 4 file2 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
> +    test_cmp_rev HEAD initial &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -156,7 +156,7 @@ test_expect_success 'reset --keep keeps changes when switching back' '
>      git reset --keep second &&
>      grep 4 file2 &&
>      grep 4 file1 &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
> +    test_cmp_rev HEAD second &&
>      test -z "$(git diff --cached)"
>  '
>  
> @@ -223,7 +223,7 @@ test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
>      git checkout third &&
>      test_must_fail git merge branch1 &&
>      git reset --merge HEAD^ &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
> +    test_cmp_rev HEAD second &&
>      test -z "$(git diff --cached)" &&
>      test -z "$(git diff)"
>  '
> @@ -249,7 +249,7 @@ test_expect_success '"reset --merge HEAD" is ok with pending merge' '
>      git reset --hard third &&
>      test_must_fail git merge branch1 &&
>      git reset --merge HEAD &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
> +    test_cmp_rev HEAD third &&
>      test -z "$(git diff --cached)" &&
>      test -z "$(git diff)"
>  '
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 8859236..3ff3126 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -415,7 +415,7 @@ test_expect_success 'checkout w/--track from non-branch HEAD fails' '
>      test_must_fail git checkout --track -b track &&
>      test_must_fail git rev-parse --verify track &&
>      test_must_fail git symbolic-ref HEAD &&
> -    test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
> +    test_cmp_rev master^0 HEAD
>  '
>  
>  test_expect_success 'checkout w/--track from tag fails' '
> @@ -424,7 +424,7 @@ test_expect_success 'checkout w/--track from tag fails' '
>      test_must_fail git checkout --track -b track frotz &&
>      test_must_fail git rev-parse --verify track &&
>      test_must_fail git symbolic-ref HEAD &&
> -    test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
> +    test_cmp_rev master^0 HEAD
>  '
>  
>  test_expect_success 'detach a symbolic link HEAD' '
> @@ -436,7 +436,7 @@ test_expect_success 'detach a symbolic link HEAD' '
>      test "z$it" = zrefs/heads/master &&
>      here=$(git rev-parse --verify refs/heads/master) &&
>      git checkout side^ &&
> -    test "z$(git rev-parse --verify refs/heads/master)" = "z$here"
> +    test_cmp_rev refs/heads/master "$here"
>  '
>  
>  test_expect_success \
> @@ -446,19 +446,19 @@ test_expect_success \
>  
>      git checkout --track origin/koala/bear &&
>      test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
> +    test_cmp_rev HEAD renamer &&
>  
>      git checkout master && git branch -D koala/bear &&
>  
>      git checkout --track refs/remotes/origin/koala/bear &&
>      test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
> +    test_cmp_rev HEAD renamer &&
>  
>      git checkout master && git branch -D koala/bear &&
>  
>      git checkout --track remotes/origin/koala/bear &&
>      test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
> -    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"
> +    test_cmp_rev HEAD renamer
>  '
>  
>  test_expect_success \
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index c6c44ec..cf50055 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -42,7 +42,7 @@ test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
>  	git reset --hard c0 &&
>  	test_config pull.ff true &&
>  	git pull . c1 &&
> -	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
> +	test_cmp_rev HEAD c1
>  '
>  
>  test_expect_success 'pull.ff=true overrides merge.ff=false' '
> @@ -50,15 +50,15 @@ test_expect_success 'pull.ff=true overrides merge.ff=false' '
>  	test_config merge.ff false &&
>  	test_config pull.ff true &&
>  	git pull . c1 &&
> -	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
> +	test_cmp_rev HEAD c1
>  '
>  
>  test_expect_success 'fast-forward pull creates merge with "false" in pull.ff' '
>  	git reset --hard c0 &&
>  	test_config pull.ff false &&
>  	git pull . c1 &&
> -	test "$(git rev-parse HEAD^1)" = "$(git rev-parse c0)" &&
> -	test "$(git rev-parse HEAD^2)" = "$(git rev-parse c1)"
> +	test_cmp_rev HEAD^1 c0 &&
> +	test_cmp_rev HEAD^2 c1
>  '
>  
>  test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
> @@ -79,17 +79,16 @@ test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
>  	git reset --hard c1 &&
>  	git config pull.octopus "recursive" &&
>  	test_must_fail git merge c2 c3 &&
> -	test "$(git rev-parse c1)" = "$(git rev-parse HEAD)"
> +	test_cmp_rev c1 HEAD
>  '
>  
>  test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octopus)' '
>  	git reset --hard c1 &&
>  	git config pull.octopus "recursive octopus" &&
>  	git merge c2 c3 &&
> -	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
> -	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
> -	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
> +	test_cmp_rev c1 HEAD^1 &&
> +	test_cmp_rev c2 HEAD^2 &&
> +	test_cmp_rev c3 HEAD^3 &&
>  	git diff --exit-code &&
>  	test -f c0.c &&
>  	test -f c1.c &&
> diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
> index 9894895..4e69fe7 100755
> --- a/t/t7603-merge-reduce-heads.sh
> +++ b/t/t7603-merge-reduce-heads.sh
> @@ -46,11 +46,10 @@ test_expect_success 'setup' '
>  test_expect_success 'merge c1 with c2, c3, c4, c5' '
>  	git reset --hard c1 &&
>  	git merge c2 c3 c4 c5 &&
> -	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
> -	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
> -	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
> -	test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
> +	test_cmp_rev c1 HEAD^1 &&
> +	test_cmp_rev c2 HEAD^2 &&
> +	test_cmp_rev c3 HEAD^3 &&
> +	test_cmp_rev c5 HEAD^4 &&
>  	git diff --exit-code &&
>  	test -f c0.c &&
>  	test -f c1.c &&
> @@ -69,11 +68,10 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
>  test_expect_success 'pull c2, c3, c4, c5 into c1' '
>  	git reset --hard c1 &&
>  	git pull . c2 c3 c4 c5 &&
> -	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
> -	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
> -	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
> -	test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
> +	test_cmp_rev c1 HEAD^1 &&
> +	test_cmp_rev c2 HEAD^2 &&
> +	test_cmp_rev c3 HEAD^3 &&
> +	test_cmp_rev c5 HEAD^4 &&
>  	git diff --exit-code &&
>  	test -f c0.c &&
>  	test -f c1.c &&
> @@ -113,8 +111,8 @@ test_expect_success 'merge E and I' '
>  '
>  
>  test_expect_success 'verify merge result' '
> -	test $(git rev-parse HEAD^1) = $(git rev-parse E) &&
> -	test $(git rev-parse HEAD^2) = $(git rev-parse I)
> +	test_cmp_rev HEAD^1 E &&
> +	test_cmp_rev HEAD^2 I
>  '
>  
>  test_expect_success 'add conflicts' '
> @@ -139,8 +137,8 @@ test_expect_success 'merge E2 and I2, causing a conflict and resolve it' '
>  '
>  
>  test_expect_success 'verify merge result' '
> -	test $(git rev-parse HEAD^1) = $(git rev-parse E2) &&
> -	test $(git rev-parse HEAD^2) = $(git rev-parse I2)
> +	test_cmp_rev HEAD^1 E2 &&
> +	test_cmp_rev HEAD^2 I2
>  '
>  
>  test_expect_success 'fast-forward to redundant refs' '
> @@ -149,7 +147,7 @@ test_expect_success 'fast-forward to redundant refs' '
>  '
>  
>  test_expect_success 'verify merge result' '
> -	test $(git rev-parse HEAD) = $(git rev-parse c5)
> +	test_cmp_rev HEAD c5
>  '
>  
>  test_expect_success 'merge up-to-date redundant refs' '
> @@ -158,7 +156,7 @@ test_expect_success 'merge up-to-date redundant refs' '
>  '
>  
>  test_expect_success 'verify merge result' '
> -	test $(git rev-parse HEAD) = $(git rev-parse c5)
> +	test_cmp_rev HEAD c5
>  '
>  
>  test_done
> diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
> index 0cb9d11..5be44f1 100755
> --- a/t/t7605-merge-resolve.sh
> +++ b/t/t7605-merge-resolve.sh
> @@ -30,9 +30,8 @@ test_expect_success 'setup' '
>  test_expect_success 'merge c1 to c2' '
>  	git reset --hard c1 &&
>  	git merge -s resolve c2 &&
> -	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
> -	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
> +	test_cmp_rev c1 HEAD^1 &&
> +	test_cmp_rev c2 HEAD^2 &&
>  	git diff --exit-code &&
>  	test -f c0.c &&
>  	test -f c1.c &&
> diff --git a/t/t9162-git-svn-dcommit-interactive.sh b/t/t9162-git-svn-dcommit-interactive.sh
> index e38d9fa..ec77a98 100755
> --- a/t/t9162-git-svn-dcommit-interactive.sh
> +++ b/t/t9162-git-svn-dcommit-interactive.sh
> @@ -21,7 +21,7 @@ test_expect_success 'answers: y [\n] yes' '
>  		( echo "y
>  
>  y" | GIT_SVN_NOTTY=1 git svn dcommit --interactive ) &&
> -		test $(git rev-parse HEAD) = $(git rev-parse remotes/git-svn)
> +		test_cmp_rev HEAD remotes/git-svn
>  	)
>  	'
>  
> @@ -33,7 +33,7 @@ test_expect_success 'answers: yes yes no' '
>  		( echo "yes
>  yes
>  no" | GIT_SVN_NOTTY=1 git svn dcommit --interactive ) &&
> -		test $(git rev-parse HEAD^^^) = $(git rev-parse remotes/git-svn) &&
> +		test_cmp_rev HEAD^^^ remotes/git-svn &&
>  		git reset --hard remotes/git-svn
>  	)
>  	'
> @@ -45,7 +45,7 @@ test_expect_success 'answers: yes quit' '
>  		echo "change #3" >> foo && git commit -a -m"change #3" &&
>  		( echo "yes
>  quit" | GIT_SVN_NOTTY=1 git svn dcommit --interactive ) &&
> -		test $(git rev-parse HEAD^^^) = $(git rev-parse remotes/git-svn) &&
> +		test_cmp_rev HEAD^^^ remotes/git-svn &&
>  		git reset --hard remotes/git-svn
>  	)
>  	'
> @@ -56,7 +56,7 @@ test_expect_success 'answers: all' '
>  		echo "change #2" >> foo && git commit -a -m"change #2" &&
>  		echo "change #3" >> foo && git commit -a -m"change #3" &&
>  		( echo "all" | GIT_SVN_NOTTY=1 git svn dcommit --interactive ) &&
> -		test $(git rev-parse HEAD) = $(git rev-parse remotes/git-svn) &&
> +		test_cmp_rev HEAD remotes/git-svn &&
>  		git reset --hard remotes/git-svn
>  	)
>  	'
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 25bb60b..c284d75 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -368,7 +368,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
>  		git prune" &&
>  	git fast-import <input &&
>  	test -f .git/TEMP_TAG &&
> -	test $(git rev-parse master) = $(git rev-parse TEMP_TAG^)
> +	test_cmp_rev master TEMP_TAG^
>  '
>  
>  test_expect_success 'B: accept empty committer' '
> @@ -1110,7 +1110,7 @@ test_expect_success 'N: copy dirty subdirectory' '
>  	INPUT_END
>  
>  	git fast-import <input &&
> -	test $(git rev-parse N2^{tree}) = $(git rev-parse N3^{tree})
> +	test_cmp_rev N2^{tree} N3^{tree}
>  '
>  
>  test_expect_success 'N: copy directory by id' '
> @@ -1507,7 +1507,7 @@ test_expect_success 'O: comments are all skipped' '
>  	INPUT_END
>  
>  	git fast-import <input &&
> -	test $(git rev-parse N3) = $(git rev-parse O1)
> +	test_cmp_rev N3 O1
>  '
>  
>  test_expect_success 'O: blank lines not necessary after data commands' '
> @@ -1528,7 +1528,7 @@ test_expect_success 'O: blank lines not necessary after data commands' '
>  	INPUT_END
>  
>  	git fast-import <input &&
> -	test $(git rev-parse N3) = $(git rev-parse O2)
> +	test_cmp_rev N3 O2
>  '
>  
>  test_expect_success 'O: repack before next test' '
> @@ -1575,7 +1575,7 @@ test_expect_success 'O: blank lines not necessary after other commands' '
>  
>  	git fast-import <input &&
>  	test 8 = $(find .git/objects/pack -type f | wc -l) &&
> -	test $(git rev-parse refs/tags/O3-2nd) = $(git rev-parse O3^) &&
> +	test_cmp_rev refs/tags/O3-2nd O3^ &&
>  	git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
>  	test_cmp expect actual
>  '
> @@ -1721,7 +1721,7 @@ test_expect_success 'P: verbatim SHA gitlinks' '
>  	git gc &&
>  	git prune &&
>  	git fast-import <input &&
> -	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
> +	test_cmp_rev subuse2 subuse1
>  '
>  
>  test_expect_success 'P: fail on inline gitlink' '
