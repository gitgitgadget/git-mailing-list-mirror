Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3421F858
	for <e@80x24.org>; Thu, 28 Jul 2016 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844AbcG1TK2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 15:10:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753876AbcG1TK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 15:10:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 808012ED64;
	Thu, 28 Jul 2016 15:10:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8y7JFef5iXUPtf60VFOkNsnX48U=; b=v2sRdk
	xz2CLFNUhaoNQxZgrFnBPZ1EUpPPyY9F4sDziVD7KMuI+jEZmBQeGeNJJUzJenlZ
	q2dyYqhrINYaboYgGrKZlNew8Li+ekF2dI6aDYiXtV3GsvZmWVyNVUdMkkdg2gET
	eRoVXkCwQJaf3lDGUOhVQmpxrGb9yGm2f4WVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Op1xMkQjRz/EOzOkafDmn5Ib2yvlZZh9
	/kETl8y57K4zzpHn/d1tIeMtFglLYco7C6v4mt9YONvF6WovwHc2bCkYLO6eF4UN
	smWGJ5ZiHeyBaTiBrTAUPR2y+RAuyjFdfTEjgqZRdlSHANz69VBmV8UySLuCkW5L
	9Fz8MrEHn4Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76EDB2ED63;
	Thu, 28 Jul 2016 15:10:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF9932ED60;
	Thu, 28 Jul 2016 15:10:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCHv2 2/2] submodule update: allow '.' for branch value
References: <20160728172641.8376-3-sbeller@google.com>
	<20160728182132.25088-1-sbeller@google.com>
Date:	Thu, 28 Jul 2016 12:10:22 -0700
In-Reply-To: <20160728182132.25088-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 28 Jul 2016 11:21:32 -0700")
Message-ID: <xmqq7fc5shnl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F00B6962-54F6-11E6-A4EC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Gerrit has a "superproject subscription" feature[1], that triggers a
> commit in a superproject that is subscribed to its submodules.
> Conceptually this Gerrit feature can be done on the client side with
> Git via:
>
>     git -C <superproject> submodule update --remote --force
>     git -C <superproject> commit -a -m "Update submodules"
>     git -C <superproject> push
>
> for each branch in the superproject.

Which I imagine would be useful if you only have one submodule.  If
you work on submodules A and B and then want to give the updated
superproject that binds the latest in both A and B as an atomic
update, the three lines above would not quite work, no?

> To ease the configuration in Gerrit
> a special value of "." has been introduced for the submodule.<name>.branch
> to mean the same branch as the superproject[2], such that you can create a
> new branch on both superproject and the submodule and this feature
> continues to work on that new branch.
>
> Now we have find projects in the wild with such a .gitmodules file.

That's annoying.

> To have Git working well with these, we imitate the behavior and
> look up the superprojects branch name if the submodules branch is
> configured to ".". In projects that do not use Gerrit, this value
> whould be never configured as "." is not a valid branch name.

I find that the last sentence is somewhat misleading.  I agree it is
justifiable that using "." as the name to trigger a new (to us)
feature is safe, because such a setting wouldn't have meant anything
useful without this change, but I initially misread it and thought
you added "are we using Gerrit?  Error out if we are not" logic,
which is not the case here.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 4ec7546..1eb33ad 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -590,7 +590,6 @@ cmd_update()
>  
>  		name=$(git submodule--helper name "$sm_path") || exit
>  		url=$(git config submodule."$name".url)
> -		branch=$(get_submodule_config "$name" branch master)
>  		if ! test -z "$update"
>  		then
>  			update_module=$update
> @@ -616,6 +615,14 @@ cmd_update()
>  
>  		if test -n "$remote"
>  		then
> +			branch=$(get_submodule_config "$name" branch master)
> +			if test "$branch" = "."
> +			then
> +				if ! branch=$(git symbolic-ref --short -q HEAD)
> +				then
> +					die "$(eval_gettext "submodule branch configured to inherit branch from superproject, but it's not on any branch")"
> +				fi
> +			fi

I see that you narrowed the scope of "$branch" (which is only used
when $remote exists), but it is a bit annoying to see that change
mixed with "now a dot means something different" change.

I wonder if the above 8-line block wants to be encapsulated to
become a part of "git submodule--helper" interface, though.  IOW,
branch=$(git submodule--helper branch "$name") or something?

> +test_expect_success 'submodule update --remote should fetch upstream changes with .' '
> +	(cd super &&
> +	 git config -f .gitmodules submodule."submodule".branch "." &&
> +	 git add .gitmodules &&
> +	 git commit -m "submodules: update from the respective superproject branch"
> +	) &&
>  	(cd submodule &&
> +	 echo line4a >> file &&
> +	 git add file &&
> +	 test_tick &&
> +	 git commit -m "upstream line4a" &&
> +	 git checkout -b test-branch &&
> +	 test_commit on-test-branch
> +	) &&
> +	(cd super &&
> +	 git submodule update --remote --force submodule &&
> +	 (cd submodule &&
> +	  test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline master)"

A few issues:

  * A crash in "git log" would not be noticed with this.  Perhaps

	git log -1 --oneline $one_way_to_invoke >expect &&
        git log -1 --oneline $the_other_way >actual &&
        test_cmp expect actual

    would be better?

  * What exactly is this testing?  The current branch (in submodule)
    pointing at the same commit as the tip of 'master'?  Or the
    current branch _is_ 'master'?

  * What exactly is the reason why one has GIT_DIR=... and the other
    does not?  I do not think this a place to test that "gitdir: "
    in .git points at the right place, so it must be testing
    something else, but I cannot guess.

> +	 ) &&
>  	 git checkout -b test-branch &&
> +	 git submodule update --remote --force submodule &&
> +	 (cd submodule &&
> +	  test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline test-branch)"
> +	 ) &&
> +	 git checkout master &&
> +	 git branch -d test-branch
> +	)
> +'
> +
> +test_expect_success 'branch = . does not confuse the rest of update' '
> +	(cd super &&
> +	 git checkout --detach &&
> +	 # update is not confused by branch="." even if the the superproject
> +	 # is not on any branch currently
> +	 git submodule update &&
> +	 git revert HEAD &&

"revert" is rather unusual thing to see in the test.  Also I am not
sure why cmd_update that now has an explicit check to die when
branch is set to "." and the head is detached is expected "not" to
be confused.  Perhaps I misread the main part of the patch?

Puzzled.

> +	 git checkout master
> +	)
> +'
> +
> +test_expect_success 'local config should override .gitmodules branch' '
> +	(cd submodule &&
> +	 git checkout test-branch &&
>  	 echo line5 >> file &&
>  	 git add file &&
>  	 test_tick &&
