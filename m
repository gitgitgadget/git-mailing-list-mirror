From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Thu, 13 Jun 2013 11:07:10 -0700
Message-ID: <7vvc5hubox.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBve-00085A-WF
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab3FMSHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:07:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab3FMSHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:07:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1F6276F3;
	Thu, 13 Jun 2013 18:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k7zSjJgnjW42pmwwEH35OWS1oFI=; b=aX/JLP
	C5wDDAQuluUeVhiTWsH9vwEUtY08T+jNCDK9LjbocbsA6/bxyEMAk4gkSBRrMWf8
	QZen1gKbelbcp/BDa1x5A72WvU9R0nCmuESuRtp6EszAgg0c8xq0GZAheKF4y52K
	++qli0K34ee9B5wxW/ZKK8On5nMbMMlHqe2DM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LNFXFEhYG2O2BEhv7ifJW8+zSExaeV2L
	+q4EECvqWRiZBju3SPcDSmOG9G390FTnsiVaPQe69w44UJAJkFcRxUybCeBKdWbp
	A4SDN/fREdneyxsAPNgEb+R74Jg0SOrfGIKUllPQ/867OsjInDfNBnPiup3LqpM/
	E6mchjg8SJY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4251E276F1;
	Thu, 13 Jun 2013 18:07:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75AE6276EC;
	Thu, 13 Jun 2013 18:07:12 +0000 (UTC)
In-Reply-To: <1371130349-30651-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 13 Jun 2013 19:02:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 126283E6-D454-11E2-92D1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227760>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> b397ea4 (status: show more info than "currently not on any branch",
> 2013-03-13) made the output of 'git status' richer in the case of a
> detached HEAD.  Before this patch, with a detached HEAD:
>
>   $ git status
>   # Not currently on any branch.
>
> After the patch:
>
>   $ git checkout v1.8.2
>   # HEAD is now detached
>   $ git status
>   # HEAD detached at v1.8.2.
>
> It works by digging the reflog for the most recent message of the form
> "checkout: moving from xxxx to yyyy".  It then asserts that HEAD and
> "yyyy" are the same, and displays this message.  When they aren't equal,
> it displays:
>
>   $ git status
>   # HEAD detached from fe11db.
>
> At this point, the utility of such a message is in question.

You can question, but I am not convinced the answer is an
unambiguous "not useful"

You were at 1.8.2 but no longer are, so in the following sequence:

    $ git checkout v1.8.2
    $ git status
    $ git reset --hard HEAD^
    $ git status
    
the former would say "detached at v1.8.2" while the latter should
*not*, because we are no longer at v1.8.2.  "detached from v1.8.2"
is too subtle a way to express the state, and is confusing, but I
would not be surprised if people find it useful to be able to learn
"v1.8.2" even after you strayed away.

> Moreover,
> there are several tests in t/status-help that explicitly rely on rebase
> writing "checkout: " messages to the reflog.  As evidenced by the
> failing tests in t/checkout-last, these messages are completely
> unintended and flaky.  

The above only helps to convince me that "rebase should not affect
what the last checked-out branch was by letting 'checkout' it
internally calls to write reflog entries for it"  With patches 6, 2,
and 3, I thought you fixed that issue.

So I am not convinced that is a good argument to justify to regress
"HEAD detached from" message to "Not on any branch".

At least, not just yet.

> This issue is not isolated to rebase at all.  Several other scripts like
> bisect write (confusing) "checkout: " messages to the reflog.  Fixing
> them is left as an exercise to other contributors.

Any scripted Porcelain that use "checkout", with patch 6, should be
able to do so with reflog-action environment variable, right?  And 2
and 3 are examples of such fixes to two of them, which argues even
more strongly that 6 should be earier in the series, I think.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t7512-status-help.sh | 24 +++++++++++-------------
>  wt-status.c            | 11 ++++-------
>  2 files changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index bf08d4e..ed9d57c 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -188,10 +188,9 @@ test_expect_success 'status when rebasing -i in edit mode' '
>  	export FAKE_LINES &&
>  	test_when_finished "git rebase --abort" &&
>  	ONTO=$(git rev-parse --short HEAD~2) &&
> -	TGT=$(git rev-parse --short two_rebase_i) &&
>  	git rebase -i HEAD~2 &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $TGT
> +	# Not currently on any branch.
>  	# You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)
> @@ -246,11 +245,10 @@ test_expect_success 'status after editing the last commit with --amend during a
>  	export FAKE_LINES &&
>  	test_when_finished "git rebase --abort" &&
>  	ONTO=$(git rev-parse --short HEAD~3) &&
> -	TGT=$(git rev-parse --short three_amend) &&
>  	git rebase -i HEAD~3 &&
>  	git commit --amend -m "foo" &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $TGT
> +	# Not currently on any branch.
>  	# You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)
> @@ -280,7 +278,7 @@ test_expect_success 'status: (continue first edit) second edit' '
>  	git rebase -i HEAD~3 &&
>  	git rebase --continue &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)
> @@ -302,7 +300,7 @@ test_expect_success 'status: (continue first edit) second edit and split' '
>  	git rebase --continue &&
>  	git reset HEAD^ &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (Once your working directory is clean, run "git rebase --continue")
>  	#
> @@ -329,7 +327,7 @@ test_expect_success 'status: (continue first edit) second edit and amend' '
>  	git rebase --continue &&
>  	git commit --amend -m "foo" &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)
> @@ -351,7 +349,7 @@ test_expect_success 'status: (amend first edit) second edit' '
>  	git commit --amend -m "a" &&
>  	git rebase --continue &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)
> @@ -374,7 +372,7 @@ test_expect_success 'status: (amend first edit) second edit and split' '
>  	git rebase --continue &&
>  	git reset HEAD^ &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (Once your working directory is clean, run "git rebase --continue")
>  	#
> @@ -402,7 +400,7 @@ test_expect_success 'status: (amend first edit) second edit and amend' '
>  	git rebase --continue &&
>  	git commit --amend -m "d" &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)
> @@ -426,7 +424,7 @@ test_expect_success 'status: (split first edit) second edit' '
>  	git commit -m "e" &&
>  	git rebase --continue &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)
> @@ -451,7 +449,7 @@ test_expect_success 'status: (split first edit) second edit and split' '
>  	git rebase --continue &&
>  	git reset HEAD^ &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (Once your working directory is clean, run "git rebase --continue")
>  	#
> @@ -481,7 +479,7 @@ test_expect_success 'status: (split first edit) second edit and amend' '
>  	git rebase --continue &&
>  	git commit --amend -m "h" &&
>  	cat >expected <<-EOF &&
> -	# HEAD detached from $ONTO
> +	# Not currently on any branch.
>  	# You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>  	#   (use "git commit --amend" to amend the current commit)
>  	#   (use "git rebase --continue" once you are satisfied with your changes)
> diff --git a/wt-status.c b/wt-status.c
> index 2511270..f7d46a1 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1173,15 +1173,12 @@ void wt_status_print(struct wt_status *s)
>  		if (!prefixcmp(branch_name, "refs/heads/"))
>  			branch_name += 11;
>  		else if (!strcmp(branch_name, "HEAD")) {
> +			unsigned char sha1[20];
>  			branch_status_color = color(WT_STATUS_NOBRANCH, s);
> -			if (state.detached_from) {
> -				unsigned char sha1[20];
> +			if (state.detached_from && !get_sha1("HEAD", sha1) &&
> +				!hashcmp(sha1, state.detached_sha1)) {
>  				branch_name = state.detached_from;
> -				if (!get_sha1("HEAD", sha1) &&
> -				    !hashcmp(sha1, state.detached_sha1))
> -					on_what = _("HEAD detached at ");
> -				else
> -					on_what = _("HEAD detached from ");
> +				on_what = _("HEAD detached at ");
>  			} else {
>  				branch_name = "";
>  				on_what = _("Not currently on any branch.");
