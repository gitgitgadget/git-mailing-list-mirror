Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5F220A25
	for <e@80x24.org>; Fri, 15 Sep 2017 02:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbdIOCso (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 22:48:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56799 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751739AbdIOCsn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 22:48:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62BE4B35AD;
        Thu, 14 Sep 2017 22:48:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HV7FHQuQQx9Lk70NCvd2BjZV7FI=; b=kmdrRO
        zEjf/7IrcDFKvI5i/5mqiocKmzhephRxTmGYAF4RwQjINUffYm+V2ZnNv0/1/x8G
        ywjLKFJy8NaFYNekEQFX+sk+1JwCuUi9NRvusu+Zogm376NFTYskgYnBH4CUvf4x
        IDvEcrm75IGd07Z+ysRCPgMIbexsArqDoeUMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UryfKzaUR79AegsW0OTgMbaTXv+55AkJ
        6sqEt8kVI/+OO5EzVoF7qKa4hCXVqRKcQD+B1aUPtM+Au+P7Sw4TkVXCnuRjimW/
        +qilRoClr+JlfMN7WRo82I/NVwrxFLe9rcQ19wfaKHpA7dGQ+KBdpI5+OXDobr4O
        X3vpg60UrKo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59742B35AC;
        Thu, 14 Sep 2017 22:48:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6FD0B35A9;
        Thu, 14 Sep 2017 22:48:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
        <cover.1505394278.git.git@grubix.eu>
        <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
Date:   Fri, 15 Sep 2017 11:48:40 +0900
In-Reply-To: <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
        (Michael J. Gruber's message of "Thu, 14 Sep 2017 15:15:19 +0200")
Message-ID: <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6227F7E0-99C0-11E7-9E55-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> In fact, per documentation "--fork-point" looks at the reflog in
> addition to doing the usual walk from the tip. The original design
> description in d96855ff51 ("merge-base: teach "--fork-point" mode",
> 2013-10-23) describes this as computing from a virtual merge-base of all
> the historical tips of refname. They may or may not all be present in
> the reflog (think pruning, non-ff fetching, fast forwarding etc.),
> so filtering by the current contents of the reflog is potentially
> harmful, and it does not seem to fulfill any purpose in the original
> design.

Let me think aloud, using the picture from the log message from that
commit.

                         o---B1
                        /
        ---o---o---B2--o---o---o---Base
                \
                 B3
                  \
                   Derived
    
    where the current tip of the "base" branch is at Base, but earlier
    fetch observed that its tip used to be B3 and then B2 and then B1
    before getting to the current commit, and the branch being rebased
    on top of the latest "base" is based on commit B3.

So the logic tries to find a merge base between "Derived" and a
virtual merge commit across Base, B1, B2 and B3.  And it finds B3.

If for some reason we didn't have B3 in the reflog, then wouldn't
the merge base computation between Derived and a virtual merge
commit across Base, B2 and B2 (but not B3 because we no longer know
about it due to its lack in the reflog) find 'o' that is the parent
of B2 and B3?  Wouldn't that lead to both B3 and Derived replayed
when the user of the fork-point potion rebases the history of
Derived?

Perhaps that is the best we could do with a pruned reflog that lacks
B3, but if that is the case, I wonder if it may be better to fail
the request saying that we cannot find the fork-point (because,
well, your reflog no longer has sufficient information), than
silently give a wrong result, and in this case, we can tell between
a correct result (i.e. the merge base is one of the commits we still
know was at the tip) and a wrong one (i.e. the merge base is not any
of the commits in the reflog).

If we declare --fork-point is the best effort option and may give an
answer that is not better than without the option, then I think this
patch is OK, but that diminishes the value of the option as a
building block, I am afraid.

Callers that are more careful could ask merge-base with --fork-point
(and happily use it knowing that the result is indeed a commit that
used to be at the tip), or fall back to the result merge-base
without --fork-point gives (because you could do no better) and deal
with duplicates that may happen due to the imprecise determination.
With this change, these callers will get result from a call to
"merge-base --fork-point" that may or may not be definite, and they
cannot tell.  For lazy users, making the option itself to fall back
may be simpler to use, and certainly is a valid stance to take when
implementing a convenience option to a Porcelain command, but I do
not know if it is a good idea to throw "merge-base --fork-point"
into that category.



>
> Remove the filtering and add a test for an out-of-reflog merge base.
>
> Reported-by: Ekelhart Jakob <jakob.ekelhart@fsw.at>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  builtin/merge-base.c  | 18 +++---------------
>  t/t6010-merge-base.sh |  8 ++++++++
>  2 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index 6dbd167d3b..926a7615ea 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -186,23 +186,11 @@ static int handle_fork_point(int argc, const char **argv)
>  	 * There should be one and only one merge base, when we found
>  	 * a common ancestor among reflog entries.
>  	 */
> -	if (!bases || bases->next) {
> +	if (!bases || bases->next)
>  		ret = 1;
> -		goto cleanup_return;
> -	}
> -
> -	/* And the found one must be one of the reflog entries */
> -	for (i = 0; i < revs.nr; i++)
> -		if (&bases->item->object == &revs.commit[i]->object)
> -			break; /* found */
> -	if (revs.nr <= i) {
> -		ret = 1; /* not found */
> -		goto cleanup_return;
> -	}
> -
> -	printf("%s\n", oid_to_hex(&bases->item->object.oid));
> +	else
> +		printf("%s\n", oid_to_hex(&bases->item->object.oid));
>  
> -cleanup_return:
>  	free_commit_list(bases);
>  	return ret;
>  }
> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index 17fffd7998..850463d4f2 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -267,6 +267,14 @@ test_expect_success '--fork-point works with empty reflog' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--fork-point works with merge-base outside reflog' '
> +	git -c core.logallrefupdates=false checkout no-reflog &&
> +	git -c core.logallrefupdates=false commit --allow-empty -m "Commit outside reflogs" &&
> +	git rev-parse base >expect &&
> +	git merge-base --fork-point no-reflog derived >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'merge-base --octopus --all for complex tree' '
>  	# Best common ancestor for JE, JAA and JDD is JC
>  	#             JE
