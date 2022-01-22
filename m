Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6587DC433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 08:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiAVIKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 03:10:05 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:3316 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbiAVIKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 03:10:05 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Jgpnk3s91z5tl9;
        Sat, 22 Jan 2022 09:10:00 +0100 (CET)
Message-ID: <3063ea48-077c-df12-de91-1e8f2f62d3e9@kdbg.org>
Date:   Sat, 22 Jan 2022 09:10:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] checkout: avoid BUG() when hitting a broken repository
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?B?UGV0ciDFoHBsw61jaGFs?= <psplicha@redhat.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <YemTGQZ97vAPUPY0@pobox.com>
 <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
 <xmqqlez8d2e6.fsf@gitster.g> <xmqqbl04d1s9.fsf_-_@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqbl04d1s9.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.01.22 um 01:58 schrieb Junio C Hamano:
> So, taking the two earlier comments from me together...
> 
> I _think_ I was the one who spotted the funny skip_prefix() whose
> result was not used, and suggested this unrelated check, during the
> review.  Sorry about that.
> 
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> 
> Subject: [PATCH] checkout: avoid BUG() when hitting a broken repository
> 
> When 9081a421 (checkout: fix "branch info" memory leaks, 2021-11-16)
> cleaned up existing memory leaks, we added an unrelated sanity check
> to ensure that a local branch is truly local and not a symref to
> elsewhere that dies with BUG() otherwise.  This was misguided in two
> ways.  First of all, such a tightening did not belong to a leak-fix
> patch.  And the condition it detected was *not* a bug in our program
> but a problem in user data, where warning() or die() would have been
> more appropriate.
> 
> As the condition is not fatal (the result of computing the local
> branch name in the code that is involved in the faulty check is only
> used as a textual label for the commit), let's revert the code to
> the original state, i.e. strip "refs/heads/" to compute the local
> branch name if possible, and otherwise leave it NULL.  The consumer
> of the information in merge_working_tree() is prepared to see NULL
> in there and act accordingly.
> 
> cf. https://bugzilla.redhat.com/show_bug.cgi?id=2042920
> 
> Reported-by: Petr Šplíchal <psplicha@redhat.com>
> Reported-by: Todd Zullinger <tmz@pobox.com>
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/checkout.c         |  3 ---
>  t/t2018-checkout-branch.sh | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 43d0275187..1fb34d537d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1094,9 +1094,6 @@ static int switch_branches(const struct checkout_opts *opts,
>  		const char *p;
>  		if (skip_prefix(old_branch_info.path, prefix, &p))
>  			old_branch_info.name = xstrdup(p);
> -		else
> -			BUG("should be able to skip past '%s' in '%s'!",
> -			    prefix, old_branch_info.path);
>  	}
>  
>  	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 93be1c0eae..5dda5ad4cb 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -85,6 +85,19 @@ test_expect_success 'setup' '
>  	git branch -m branch1
>  '
>  
> +test_expect_success 'checkout a branch without refs/heads/* prefix' '
> +	git clone --no-tags . repo-odd-prefix &&
> +	(
> +		cd repo-odd-prefix &&
> +
> +		origin=$(git symbolic-ref refs/remotes/origin/HEAD) &&
> +		git symbolic-ref refs/heads/a-branch "$origin" &&
> +
> +		git checkout -f a-branch &&
> +		git checkout -f a-branch

I haven't grasped the hairy details of the circumstances regarding this
issue, and are observing this thread only from the sideline. I wonder
whether there is a significance that there are two identical checkout
commands in a row. In particular, could the second checkout not just
switch back to main? A comment in the test case would help me and future
readers.

> +	)
> +'
> +
>  test_expect_success 'checkout -b to a new branch, set to HEAD' '
>  	test_when_finished "
>  		git checkout branch1 &&

-- Hannes
