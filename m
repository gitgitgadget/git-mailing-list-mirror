Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4CB020756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbdAQVWr (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:22:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60162 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751031AbdAQVVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:21:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53C1461F26;
        Tue, 17 Jan 2017 16:15:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9JTFHPq6XF8Wv0gHtDAI6pE9dNo=; b=XGlDqG
        IVNFW6CibnJq0+FODJjN2ZyJKxGgDoUHE9+z34uJyEvbtkfARQ0QLuYIuTlyPUWw
        naSebfkt8t3MFr4lx50aPgKWLUf9BN/qVaArlWkKDNG8F68MDsyL1idIefUr005N
        WeCByMR0hc9+vkqgcQOLPM81l8tubU7GgkBN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rUSzqiKXly9hLYI4YM+vF0LW6VSyME1Q
        r/XYokiTry0M7ie9mD14gzA4hYdBcEtA1NuZFoBJMIGvdlJMSKoYKTcyvq5w0MMk
        TIdPsuUwLjGNRXE1Ln+kR6WXk34+MwxgLylnNO11t8Ig0FuCcwoKa6sd69AlzdBU
        t9LCvqBIO6I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B97B61F25;
        Tue, 17 Jan 2017 16:15:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A582661F24;
        Tue, 17 Jan 2017 16:15:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/6] fsck: prepare dummy objects for --connectivity-check
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
        <20170116213204.e7ykwowqzafkexqd@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 13:15:57 -0800
In-Reply-To: <20170116213204.e7ykwowqzafkexqd@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Jan 2017 16:32:04 -0500")
Message-ID: <xmqqa8ape6b6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24190C24-DCFA-11E6-B040-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +static void mark_object_for_connectivity(const unsigned char *sha1)
> +{
> +	struct object *obj = lookup_object(sha1);
> +
> +	/*
> +	 * Setting the object type here isn't strictly necessary here for a
> +	 * connectivity check.

Drop one of these "here"s?


> The cmd_fsck() part of the diff is pretty nasty without
> "-b".

True.  I also wonder if swapping the if/else arms make the end
result and the patch easier to read. i.e.

+	if (connectivity_only) {
+		mark loose for connectivity;
+		mark packed for connectivity;
+	} else {
		... existing code comes here reindented ...
	}                

But the patch makes sense.

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index e88ec7747..c1b2dda33 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -523,9 +523,21 @@ test_expect_success 'fsck --connectivity-only' '
>  		touch empty &&
>  		git add empty &&
>  		test_commit empty &&
> +
> +		# Drop the index now; we want to be sure that we
> +		# recursively notice that we notice the broken objects
> +		# because they are reachable from refs, not because
> +		# they are in the index.
> +		rm -f .git/index &&
> +
> +		# corrupt the blob, but in a way that we can still identify
> +		# its type. That lets us see that --connectivity-only is
> +		# not actually looking at the contents, but leaves it
> +		# free to examine the type if it chooses.
>  		empty=.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
> -		rm -f $empty &&
> -		echo invalid >$empty &&
> +		blob=$(echo unrelated | git hash-object -w --stdin) &&
> +		mv $(sha1_file $blob) $empty &&
> +
>  		test_must_fail git fsck --strict &&
>  		git fsck --strict --connectivity-only &&
>  		tree=$(git rev-parse HEAD:) &&
> @@ -537,6 +549,13 @@ test_expect_success 'fsck --connectivity-only' '
>  	)
>  '
>  
> +test_expect_success 'fsck --connectivity-only with explicit head' '
> +	(
> +		cd connectivity-only &&
> +		test_must_fail git fsck --connectivity-only $tree
> +	)
> +'

Most of the earlier "tree=..." assignments are done in subshells,
and it is not clear which tree this refers to.  Is this the one that
was written in 'rev-list --verify-objects with bad sha1' that has
been removed in its when-finished handler?

>  remove_loose_object () {
>  	sha1="$(git rev-parse "$1")" &&
>  	remainder=${sha1#??} &&
