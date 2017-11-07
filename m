Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587EA20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754751AbdKGBw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 20:52:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53565 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754049AbdKGBw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 20:52:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F28E9B7DE;
        Mon,  6 Nov 2017 20:52:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=00tzC6Otnqe0RMjl0qqevvojXXo=; b=wa5AQV
        k2aIQwfa29j9vJXAjpMe+3rNCUuLVOSAqa7/IwqdRrXCbYQt2KiW2IZpI0lgmvzR
        RUEKquuEF4xUim5pa8/mwPH0HWNdGR9Zzy0wwN+U0lhHkvlX2lltp2RPLLiW+KHu
        J1nYANPLeHB/T3TK7Fsi0wCJsfXzwVzGix60w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pM9dFNBT1NZCGXEl0sV9Kbm+ttlysFyE
        D8MsktyKIXtpPyakTob4J9LywSlnr6QCsIwMCNcWaiDapI/jhrynxYLI0rWUVvLK
        W/yvAPSSF7MzfePOAuUMIYkc2vBP1SYtEfIpC8OeuT6d4l8hRkw6GdQ+zTu1E4AK
        o7djmxud/p4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 760759B7DD;
        Mon,  6 Nov 2017 20:52:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7F9C9B7DC;
        Mon,  6 Nov 2017 20:52:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] Tests: document test_submodule_{,forced_}switch()
References: <20171106235021.113358-1-jonathantanmy@google.com>
Date:   Tue, 07 Nov 2017 10:52:25 +0900
In-Reply-To: <20171106235021.113358-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 6 Nov 2017 15:50:21 -0800")
Message-ID: <xmqq8tfihn3a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E833624-C35E-11E7-9852-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Factor out the commonalities from test_submodule_switch() and
> test_submodule_forced_switch() in lib-submodule-update.sh, and document
> their usage.
>
> This also makes explicit (through the KNOWN_FAILURE_FORCED_SWITCH_TESTS
> variable) the fact that, currently, all functionality tested using
> test_submodule_forced_switch() do not correctly handle the situation in
> which a submodule is replaced with an ordinary directory.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I find tests that use lib-submodule-update.sh difficult to understand
> due to the lack of clarity of what test_submodule_switch() and others do
> with their argument - I hope this will make things easier for future
> readers.
> ---
>  t/lib-submodule-update.sh | 250 +++++++++-------------------------------------
>  1 file changed, 46 insertions(+), 204 deletions(-)

I suspect that the benefit of this is a lot larger than "document" a
test helper function or two ;-)  "document & clean-up", perhaps?

> -	# ... unless there is an untracked file in its place.
> -	test_expect_success "$command: added submodule doesn't remove untracked unignored file with same name" '
> -		prolog &&
> -		reset_work_tree_to no_submodule &&
> -		(
> -			cd submodule_update &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> -			>sub1 &&
> -			test_must_fail $command add_sub1 &&
> -			test_superproject_content origin/no_submodule &&
> -			test_must_be_empty sub1
> -		)
> -	'

This is not included in the _common thing, but is added back to the
updated _switch and _forced_switch, both of which call the _common
thing, at the end.

> @@ -538,59 +529,53 @@ test_submodule_switch () {
>  			test_submodule_content sub1 origin/add_sub1
>  		)
>  	'
> -	# Updating a submodule from an invalid sha1 doesn't update the
> -	# submodule's work tree, subsequent update will succeed
> -	test_expect_$RESULT "$command: modified submodule does not update submodule work tree from invalid commit" '
> -		prolog &&
> -		reset_work_tree_to invalid_sub1 &&
> -		(
> -			cd submodule_update &&
> -			git branch -t valid_sub1 origin/valid_sub1 &&
> -			$command valid_sub1 &&
> -			test_superproject_content origin/valid_sub1 &&
> -			test_dir_is_empty sub1 &&
> -			git submodule update --init --recursive &&
> -			test_submodule_content sub1 origin/valid_sub1
> -		)
> -	'

This piece seems to have been lost from the updated code; _common
does not inherit this test, and _switch does not add it back after
calling _common.  Its copy does appear in _forced_switch, though.


I didn't compare the before-and-after with fine toothed comb, but
a cursory look didn't find anything glaringly questionable other
than the above.


