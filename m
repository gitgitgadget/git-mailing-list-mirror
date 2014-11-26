From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add another option for receive.denyCurrentBranch
Date: Wed, 26 Nov 2014 13:02:08 -0800
Message-ID: <xmqqppc9ptf3.fsf@gitster.dls.corp.google.com>
References: <cover.1415876330.git.johannes.schindelin@gmx.de>
	<cover.1417033080.git.johannes.schindelin@gmx.de>
	<2b44016c4a233348ef0c7600ca4aaf8aa50948e8.1417033080.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtjj5-0002tv-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 22:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbaKZVCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 16:02:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbaKZVCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 16:02:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE64921059;
	Wed, 26 Nov 2014 16:02:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HIS0E5MTouFMkbpliudcWuO8lDU=; b=VCCSHM
	TUqnf7NvIJxgT0jevmAbRAy5XLkSfldSrd2V7gBGBhHGBkcxV+EoYq01fny2YJZx
	bC1gAYTxwfkj8VLf+Pc51mmtQv/HTzN8ndFr/zdxZVcS/jVJO0hHz6ob241ZXjpO
	UwcoNIokzGlhIvtTu6gQov4OXHv1t8SFrQsD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VKTikCBN0kGJy/z65K3gaZEq/SwsyvSa
	Xe1qvjCOql6lFPtYruDpyDp5s5WYVHak3zGwJfy9vjokVoTb8oSwy1ak7mWDzg7J
	ZoUeAhGxGLokESlfV3aO6eMLVy+tfRgcMYKDqejhucCPHnFRkTT20XIChinY//8P
	2fgHE+4ziyU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4C6621058;
	Wed, 26 Nov 2014 16:02:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 171C221057;
	Wed, 26 Nov 2014 16:02:10 -0500 (EST)
In-Reply-To: <2b44016c4a233348ef0c7600ca4aaf8aa50948e8.1417033080.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 26 Nov 2014 21:21:36 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7CC5EFEA-75AF-11E4-9225-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260304>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +Another option is "updateInstead" which will update the working
> +directory (must be clean) if pushing into the current branch. This option is
> +intended for synchronizing working directories when one side is not easily
> +accessible via interactive ssh (e.g. a live web site, hence the requirement
> +that the working directory be clean). This mode also comes in handy when
> +developing inside a VM to test and fix code on different Operating Systems.

Thanks; this explains the intent very clearly.

> @@ -730,11 +733,90 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  	return 0;
>  }
>  
> +static const char *update_worktree(unsigned char *sha1)
> +{
> +	const char *update_refresh[] = {
> +		"update-index", "--ignore-submodules", "--refresh", "-q", NULL
> +	};

Please have "-q" as the first parameter.

    $ git reset --hard
    $ echo >Makefile
    $ git update-index -q --refresh ; echo $?
    0
    $ git update-index --refresh -q ; echo $?
    Makefile: needs update
    1

Yes, I understand and agree that this is a "WAT???".

But update-index has processed its options from left to right from
the beginning of time, which we may want to change someday, but this
topic is more important than updating that "WAT???".

> +...
> +	const char *read_tree[] = {
> +		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
> +	};

Is everybody's compiler OK with this initialization with computed
value?  Just checking to see if somebody else says "that would not
work for my setting".

> +	/* run_command() does not clean up completely; reinitialize */
> +	child_process_init(&child);

I do not think you need that comment.  The name run_command() does
not imply "run and clean up for reuse" at all, at least to me.

> +	child.argv = diff_files;
> +	...
> +	if (run_command(&child)) {
> +		argv_array_clear(&env);
> +		return "Working directory not clean";
> +	}
> +
> +	/* run_command() does not clean up completely; reinitialize */
> +	child_process_init(&child);
> +	child.argv = diff_index;
> +	...
> +	if (run_command(&child)) {
> +		argv_array_clear(&env);
> +		return "Working directory not clean";
> +	}

Do we want to give the same message for these two cases?

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index f4da20a..b8df39c 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1330,4 +1330,25 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
>  	)
>  '
>  
> +test_expect_success 'receive.denyCurrentBranch = updateInstead' '
> +	git push testrepo master &&
> +	(cd testrepo &&
> +		git reset --hard &&
> +		git config receive.denyCurrentBranch updateInstead
> +	) &&
> +	test_commit third path2 &&
> +	git push testrepo master &&
> +	test $(git rev-parse HEAD) = $(cd testrepo && git rev-parse HEAD) &&
> +	test third = "$(cat testrepo/path2)" &&
> +	(cd testrepo &&
> +		git update-index --refresh &&
> +		git diff-files --quiet &&
> +		git diff-index --cached HEAD -- &&

This "diff-index", without "--quiet" would not signal if the index
matches HEAD with its exit status.

> +		echo changed > path2 &&

s/> />/;

> +		git add path2
> +	) &&

This made sure that the update happens in a clean state.

> +	test_commit fourth path2 &&
> +	test_must_fail git push testrepo master

And this made sure that the push fails, but does not check what
happened on the receiving repository; minimally something like this
perhaps?

	test_must_fail git push testrepo master &&
        test $(git rev-parse HEAD^) = $(git -C testrepo rev-parse HEAD) &&
	(
		cd testrepo &&
		git diff --quiet &&
		test changed = "$(cat path2)"
	)

That is, we expect that "third" is still the HEAD in testrepo, there
is no difference between the working tree and the index (because you
did "git add path2" over there previously), and path2 still has the
locally updated string in the working tree.

> +'
> +
>  test_done

Other than that, this looks pretty well done.

Thanks.

P.S. I'll be doing 2.2 final today, so I won't have time to apply
this with local tweaking to address the issues above.
