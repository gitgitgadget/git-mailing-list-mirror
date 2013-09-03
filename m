From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t: branch: improve test rollback
Date: Tue, 03 Sep 2013 12:32:16 -0700
Message-ID: <xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
	<1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 21:32:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwLS-0005hd-GF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 21:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933179Ab3ICTcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 15:32:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758549Ab3ICTcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 15:32:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C75A3EBEB;
	Tue,  3 Sep 2013 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xd0EEjyejkXdIYCJM8KiOc8JiYs=; b=puAeCE
	ngA8pgFt4Qh1burJIdURBEfd5VkIkC4BOUCm6ymRGCXlCpqof6yx/7ruBpnTSjAn
	zF/YBPzcaj5s+qtoX7cvuBVNBqqaptQff+jQnFte8GAY/7OokeU9GVtGtJnDE2h/
	TRCx1lKj8Yx2QOkZgnNo3Uugu81ft1OsXRiB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dk2QDaqj61/Lw//PsSfACmLxMVqpxzw/
	76S84SCD2Tb6BwiI+j7JsR4Ex1L+fY9zCes8FEZ9qePzgnFu5Ep8U+d3vK6wx3xJ
	h3kTj1m0Vsp5++ru8xYvmrIukCannjmwUC56O1rdeq44BmmpnixYSOJxd5ODRK5E
	PcI1p/OR9n0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5A213EBE5;
	Tue,  3 Sep 2013 19:32:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E08D63EBDC;
	Tue,  3 Sep 2013 19:32:20 +0000 (UTC)
In-Reply-To: <1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 23:31:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D36259E-14CF-11E3-96C3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233763>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> After every test the environment should be as close as to how it was
> before as possible.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Very good in general; a few points (not "the patch breaks things",
but more like "tests after the patch are still depending on the
previous state") below, though.

>  t/t3200-branch.sh | 71 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index d85306f..3d4f634 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -328,7 +328,7 @@ test_expect_success 'tracking setup fails on non-matching refspec' '
>  '
>  
>  test_expect_success 'test tracking setup via config' '
> -	git config branch.autosetupmerge true &&
> +	test_config branch.autosetupmerge true &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -338,20 +338,18 @@ test_expect_success 'test tracking setup via config' '
>  '
>  
>  test_expect_success 'test overriding tracking setup via --no-track' '
> -	git config branch.autosetupmerge true &&
> +	test_config branch.autosetupmerge true &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
>  	git branch --no-track my2 local/master &&
> -	git config branch.autosetupmerge false &&
>  	! test "$(git config branch.my2.remote)" = local &&
>  	! test "$(git config branch.my2.merge)" = refs/heads/master
>  '
>  
>  test_expect_success 'no tracking without .fetch entries' '
> -	git config branch.autosetupmerge true &&
> +	test_config branch.autosetupmerge true &&
>  	git branch my6 s &&
> -	git config branch.autosetupmerge false &&
>  	test -z "$(git config branch.my6.remote)" &&
>  	test -z "$(git config branch.my6.merge)"
>  '

The four tests after this one used to expect to start with
branch.autosetupmerge explicitly set to false, but this change
leaves the variable unset---as a side effect we start testing a
different thing.  As long as we do not introduce a bug that allows
an exlicit branch.autosetupmerge=false defeat --track on the command
line, this side effect does not hurt, but I think the 'test tracking
setup via --track but deeper' was the only test that checks this
interaction between 'false in config, --track on the command line'
combination.

> @@ -386,9 +384,8 @@ test_expect_success 'test --track without .fetch entries' '
>  '
>  
>  test_expect_success 'branch from non-branch HEAD w/autosetupmerge=always' '
> -	git config branch.autosetupmerge always &&
> -	git branch my9 HEAD^ &&
> -	git config branch.autosetupmerge false
> +	test_config branch.autosetupmerge always &&
> +	git branch my9 HEAD^
>  '

Likewise for three subsequent tests but what they test are not
primarily whether tracking is done, so it does not matter as much as
the previous.

>  test_expect_success 'branch from non-branch HEAD w/--track causes failure' '
> @@ -405,9 +402,9 @@ test_expect_success '--set-upstream-to fails on multiple branches' '
>  '
>  
>  test_expect_success '--set-upstream-to fails on detached HEAD' '
> +	test_when_finished "git checkout -" &&
>  	git checkout HEAD^{} &&
> -	test_must_fail git branch --set-upstream-to master &&
> -	git checkout -
> +	test_must_fail git branch --set-upstream-to master
>  '
>  
>  test_expect_success '--set-upstream-to fails on a missing dst branch' '
> @@ -459,9 +456,9 @@ test_expect_success '--unset-upstream should fail on multiple branches' '
>  '
>  
>  test_expect_success '--unset-upstream should fail on detached HEAD' '
> +	test_when_finished "git checkout -" &&
>  	git checkout HEAD^{} &&
> -	test_must_fail git branch --unset-upstream &&
> -	git checkout -
> +	test_must_fail git branch --unset-upstream
>  '
>  
>  test_expect_success 'test --unset-upstream on a particular branch' '
> @@ -540,7 +537,8 @@ test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates
>  '
>  
>  test_expect_success 'avoid ambiguous track' '
> -	git config branch.autosetupmerge true &&
> +	test_when_finished "git remote rm ambi1 && git remote rm ambi2" &&
> +	test_config branch.autosetupmerge true &&
>  	git config remote.ambi1.url lalala &&
>  	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
>  	git config remote.ambi2.url lilili &&
> @@ -552,7 +550,7 @@ test_expect_success 'avoid ambiguous track' '
>  test_expect_success 'autosetuprebase local on a tracked local branch' '
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> -	git config branch.autosetuprebase local &&
> +	test_config branch.autosetuprebase local &&
>  	(git show-ref -q refs/remotes/local/o || git fetch local) &&
>  	git branch mybase &&
>  	git branch --track myr1 mybase &&
> @@ -564,7 +562,7 @@ test_expect_success 'autosetuprebase local on a tracked local branch' '
>  test_expect_success 'autosetuprebase always on a tracked local branch' '
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> -	git config branch.autosetuprebase always &&
> +	test_config branch.autosetuprebase always &&
>  	(git show-ref -q refs/remotes/local/o || git fetch local) &&
>  	git branch mybase2 &&
>  	git branch --track myr2 mybase &&
> @@ -576,7 +574,7 @@ test_expect_success 'autosetuprebase always on a tracked local branch' '
>  test_expect_success 'autosetuprebase remote on a tracked local branch' '
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> -	git config branch.autosetuprebase remote &&
> +	test_config branch.autosetuprebase remote &&
>  	(git show-ref -q refs/remotes/local/o || git fetch local) &&
>  	git branch mybase3 &&
>  	git branch --track myr3 mybase2 &&
> @@ -588,7 +586,7 @@ test_expect_success 'autosetuprebase remote on a tracked local branch' '
>  test_expect_success 'autosetuprebase never on a tracked local branch' '
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> -	git config branch.autosetuprebase never &&
> +	test_config branch.autosetuprebase never &&
>  	(git show-ref -q refs/remotes/local/o || git fetch local) &&
>  	git branch mybase4 &&
>  	git branch --track myr4 mybase2 &&
> @@ -600,7 +598,7 @@ test_expect_success 'autosetuprebase never on a tracked local branch' '
>  test_expect_success 'autosetuprebase local on a tracked remote branch' '
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> -	git config branch.autosetuprebase local &&
> +	test_config branch.autosetuprebase local &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
>  	git branch --track myr5 local/master &&
>  	test "$(git config branch.myr5.remote)" = local &&
> @@ -611,7 +609,7 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
>  test_expect_success 'autosetuprebase never on a tracked remote branch' '
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> -	git config branch.autosetuprebase never &&
> +	test_config branch.autosetuprebase never &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
>  	git branch --track myr6 local/master &&
>  	test "$(git config branch.myr6.remote)" = local &&
> @@ -622,7 +620,7 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
>  test_expect_success 'autosetuprebase remote on a tracked remote branch' '
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> -	git config branch.autosetuprebase remote &&
> +	test_config branch.autosetuprebase remote &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
>  	git branch --track myr7 local/master &&
>  	test "$(git config branch.myr7.remote)" = local &&
> @@ -633,7 +631,7 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
>  test_expect_success 'autosetuprebase always on a tracked remote branch' '
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> -	git config branch.autosetuprebase remote &&
> +	test_config branch.autosetuprebase remote &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
>  	git branch --track myr8 local/master &&
>  	test "$(git config branch.myr8.remote)" = local &&
> @@ -642,7 +640,7 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
>  '
>  
>  test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
> -	git config --unset branch.autosetuprebase &&
> +	test_unconfig branch.autosetuprebase &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -684,7 +682,7 @@ test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
>  '
>  
>  test_expect_success 'autosetuprebase never on an untracked local branch' '
> -	git config branch.autosetuprebase never &&
> +	test_config branch.autosetuprebase never &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -695,7 +693,7 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
>  '
>  
>  test_expect_success 'autosetuprebase local on an untracked local branch' '
> -	git config branch.autosetuprebase local &&
> +	test_config branch.autosetuprebase local &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -706,7 +704,7 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
>  '
>  
>  test_expect_success 'autosetuprebase remote on an untracked local branch' '
> -	git config branch.autosetuprebase remote &&
> +	test_config branch.autosetuprebase remote &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -717,7 +715,7 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
>  '
>  
>  test_expect_success 'autosetuprebase always on an untracked local branch' '
> -	git config branch.autosetuprebase always &&
> +	test_config branch.autosetuprebase always &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -728,7 +726,7 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
>  '
>  
>  test_expect_success 'autosetuprebase never on an untracked remote branch' '
> -	git config branch.autosetuprebase never &&
> +	test_config branch.autosetuprebase never &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -739,7 +737,7 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
>  '
>  
>  test_expect_success 'autosetuprebase local on an untracked remote branch' '
> -	git config branch.autosetuprebase local &&
> +	test_config branch.autosetuprebase local &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -750,7 +748,7 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
>  '
>  
>  test_expect_success 'autosetuprebase remote on an untracked remote branch' '
> -	git config branch.autosetuprebase remote &&
> +	test_config branch.autosetuprebase remote &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -761,7 +759,7 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
>  '
>  
>  test_expect_success 'autosetuprebase always on an untracked remote branch' '
> -	git config branch.autosetuprebase always &&
> +	test_config branch.autosetuprebase always &&
>  	git config remote.local.url . &&
>  	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>  	(git show-ref -q refs/remotes/local/master || git fetch local) &&
> @@ -772,8 +770,8 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
>  '
>  
>  test_expect_success 'autosetuprebase always on detached HEAD' '
> -	git config branch.autosetupmerge always &&
> -	test_when_finished git checkout master &&
> +	test_when_finished "git checkout -" &&

I think the explicit 'master' was better.  We are not in the
business of checking @{-1} completion here, and depending on the
outcome of the "git checkout" in the test, "checkout -" will take us
to a different place, no?

> +	test_config branch.autosetupmerge always &&

This used to be propagated down, but now branch.autosetupmerge is
kept unset after this.  The tests after this one do not seem to
newly create branches that need auto-setup-merge, so I think this
change is very good.

>  	git checkout HEAD^0 &&
>  	git branch my11 &&
>  	test -z "$(git config branch.my11.remote)" &&
> @@ -781,15 +779,15 @@ test_expect_success 'autosetuprebase always on detached HEAD' '
>  '
>  
>  test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
> -	git config branch.autosetuprebase garbage &&
> +	test_config branch.autosetuprebase garbage &&
>  	test_must_fail git branch
>  '
>  
>  test_expect_success 'detect misconfigured autosetuprebase (no value)' '
> -	git config --unset branch.autosetuprebase &&
> +	test_when_finished "test_unconfig branch.autosetuprebase" &&
> +	test_unconfig branch.autosetuprebase &&
>  	echo "[branch] autosetuprebase" >>.git/config &&
> -	test_must_fail git branch &&
> -	git config --unset branch.autosetuprebase
> +	test_must_fail git branch
>  '
>  
>  test_expect_success 'attempt to delete a branch without base and unmerged to HEAD' '
> @@ -856,6 +854,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
>  '
>  
>  test_expect_success 'refuse --edit-description on unborn branch for now' '
> +	test_when_finished "git checkout -" &&

I am not sure if this is a good change.  Depending on the outcome of
the "git checkout" in the test (it may succeed and set @{-1} to the
branch we were on when we entered the test, or it may fail and leave
@{-1} to the branch before we were on when we entered the test),
this will take us to a different place, no?

>  	write_script editor <<-\EOF &&
>  		echo "New contents" >"$1"
>  	EOF
