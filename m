Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233F71F461
	for <e@80x24.org>; Wed, 10 Jul 2019 17:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGJRob (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 13:44:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63664 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfGJRoa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 13:44:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35D0462AB5;
        Wed, 10 Jul 2019 13:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BbJsxgII/RD78oTv7QZCiQKWpN0=; b=nL7+6m
        VKIPT3i4kTE+cpoyH3Nfy1dLnNMF75JLsdGd4rZwFe8Rrb3tuLmZVR5++AvMezXw
        FBSjIWSLAIo0bbxWXAlAkjoj6wX9AFR+wdqipe2NzdBizWMNiyrKp9USSqAT2Pwa
        BbRFqKObKxVPmhF5U7bg52XL6Q31dOEuXluNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uAtxdYQV54+wg6PP0frDvG/0M8Fuh/Jk
        d+nI1OtZFYc6Ii7JryM8DqeEYvBV939x8QC4l/CtQXZ+WrWt3n3qi9R9lhYHJGc2
        XB6Ao+9Mv3NHJ1o2F0Lgf7t19qpj7WQlIc3yIMPDcL3puSggs4utxh58PKnpeIpW
        65OKg+45JxI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F5E562AB3;
        Wed, 10 Jul 2019 13:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5808662AB2;
        Wed, 10 Jul 2019 13:44:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
References: <20190709211043.48597-1-emilyshaffer@google.com>
Date:   Wed, 10 Jul 2019 10:44:22 -0700
In-Reply-To: <20190709211043.48597-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Tue, 9 Jul 2019 14:10:43 -0700")
Message-ID: <xmqqpnmhu6mh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B1FA544-A33A-11E9-B6B2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
> +	# Setup upstream repo - empty for now
> +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
> +	git init --bare "$d" &&
> +	test_config -C "$d" http.receivepack true &&
> +	up="$HTTPD_URL"/smart/atomic-branches.git &&
> +
> +	# Tell up about two branches for now

-ECANTPARSE "Tell up" part.

> +	test_commit atomic1 &&
> +	test_commit atomic2 &&
> +	git branch collateral &&
> +	git push "$up" master collateral &&

OK, so an initially empty directory $d that appears to network
clients as $up now has two branches, 'master' and 'collateral',
both pointing at the same history that ends with two commits,
atomic2 whose parent is atomic1.

> +	# collateral is a valid push, but should be failed by atomic push
> +	git checkout collateral &&
> +	test_commit collateral1 &&
> +
> +	# Make master incompatible with upstream to provoke atomic
> +	git checkout master &&
> +	git reset --hard HEAD^ &&

collateral grows, master rewinds.

> +	# Add a new branch which should be failed by atomic push. This is a
> +	# regression case.
> +	git branch atomic &&

Another branch atomic is added

> +	# --atomic should cause entire push to be rejected
> +	test_must_fail git push --atomic "$up" master atomic collateral 2>output &&

Attempt to push all three: collateral alone would be OK, so is
atomic, but because master rewinds, we expect none of the three to
go through.

> +	# the new branch should not have been created upstream
> +	test_must_fail git -C "$d" rev-parse refs/heads/atomic &&

The new branch should not have been created; if this rev-parse
succeeded, it would be a bug.

Up to point, I have no possible improvements to offer ;-)
Very well done.

> +	# the failed refs should be indicated
> +	grep "master -> master" output | grep rejected &&

I'd rather see the effect, i.e. what the command did that can be
observed externally, than the report, i.e. what the command claims
to have done, if it is equally straight-forward to verify either.

That can be done by making sure that the output from "git -C "$d"
rev-parse refs/heads/master" match output from "git rev-parse
atomic2", no?  That ensures 'master' in the receiving end stayed the
same.

> +	# the collateral failure refs should be indicated
> +	grep "atomic -> atomic" output | grep "atomic push failed" &&
> +	grep "collateral -> collateral" output | grep "atomic push failed"

Likewise for the other two.  

FWIW, these three can further lose a process each, i.e.

	grep "^ ! .*rejected.* master -> master" output

even if we for some reason do not want to check the effect and take
the claim by the command being tested at the face value (which I do
not think is a good idea).

Thanks.
