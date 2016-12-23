Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38ABE1FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 21:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932715AbcLWV1p (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 16:27:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58625 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932694AbcLWV1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 16:27:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84E875AA52;
        Fri, 23 Dec 2016 16:27:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j3I8ROVbD9LF07jTi12pacfj82Y=; b=hIsqGq
        JmYNDl2IySfHASXD/Ht5bnGoQjovAje2npgW54eRgSIg7j4eB8p9I/fUMRAvXrXG
        aocl+6igOWbmAh99vPa531dLLBUrxlDzvaNlKTf/OkLCO1Or0owjNr+DT+EVc+v6
        nIFb6/HMVS+GcPs0t0imQtzmXxQg+G9rV59Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OLhxOD0O0pOzT0En+u1oX6hQuTWrXs0f
        tT4Al3Yh7wRQ+Zz+87O18pt070VjejlK8rYgAFJJilRH97HnvqyYP1cUDT6PPTGc
        hqjT8I2bWufki5/LM7SE5BM9YapOZZuCtkMLyau26esnUe+YrZGDq56d8v92zRme
        q3p7Z6gtIUg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CC245AA51;
        Fri, 23 Dec 2016 16:27:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA7E15AA50;
        Fri, 23 Dec 2016 16:27:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, novalis@novalis.org
Subject: Re: [PATCH v2 1/2] auto gc: don't write bitmaps for incremental repacks
References: <1482522215-13401-1-git-send-email-dturner@twosigma.com>
Date:   Fri, 23 Dec 2016 13:27:40 -0800
In-Reply-To: <1482522215-13401-1-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Fri, 23 Dec 2016 14:43:34 -0500")
Message-ID: <xmqq4m1ue3oz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2EB9272-C956-11E6-8EE3-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> +test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
> +	test_config gc.auto 3 &&
> +	test_config gc.autodetach false &&
> +	test_config pack.writebitmaps true &&
> +	# We need to create two object whose sha1s start with 17
> +	# since this is what git gc counts.  As it happens, these
> +	# two blobs will do so.
> +	test_commit 263 &&
> +	test_commit 410 &&
> +	# Our first gc will create a pack; our second will create a second pack
> +	git gc --auto &&
> +	ls .git/objects/pack |grep -v bitmap >existing_packs &&

Missing SP (compare with the second invocation of the same).

> +	test_commit 523 &&
> +	test_commit 790 &&
> +
> +	git gc --auto 2>err &&
> +	test_i18ngrep ! "^warning:" err &&
> +	ls .git/objects/pack/ | grep -v bitmap >post_packs &&
> +	! test_cmp existing_packs post_packs

This does not look good for two reasons.  test_cmp tries to
highlight test breakage by being verbose when two files are
different while keeping quiet when they are the same.  Running it
with "!" does not change its expectation.  This undesirable effect
should be visible when this test is run with "-v" option.

Another is that this only tests if the set of packs before and after
are different.  I think you are expecting that the second invocation
will create a new one while leaving the old one intact but this test
will not catch a breakage if the second repack instead created just
one pack replacing the old one.

> +'
> +
> +
>  test_done

Thanks.
