Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497A41F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdAYUCe (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:02:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52711 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751152AbdAYUCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:02:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D6CD6325E;
        Wed, 25 Jan 2017 15:02:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nDPC678px171xt7yh/x/UxrztNk=; b=vNQQxf
        Gucq9D4IfwlA2hu6IxTX9OtYp5hsnjw0/VZgAObPvBVjmz8a+ABekmQai5LkNs42
        Avca73UtkTl/vsXZn2GuDmhRwk9b0nufPKeH0B1H44Wex9PH0kxLMB5ywdoE4+iY
        tk9rwpdoaFSUS4/OijoZuPbeNSqvsdGuzQ1ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wUJzUwRBhDjzT5I1DARLFlW0oqjQoXy5
        a1NUQ6SoE6D3fb7qKJP6YMXV3/KVfAXAQZl43Liaheklpgg2igG4L48jjfDuOaqG
        5ATEXJeG42iVVR6ykSolKGdMBCXRYxqlPjEtOTtr3EPlUeMEhqnlITx8/ZUmcaF6
        i8bAg/BbSvM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AB6B6325D;
        Wed, 25 Jan 2017 15:02:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D639F6325C;
        Wed, 25 Jan 2017 15:02:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/12] receive-pack: avoid duplicates between our refs and alternates
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124004818.7resjwbe6ldqjfyx@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 12:02:30 -0800
In-Reply-To: <20170124004818.7resjwbe6ldqjfyx@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Jan 2017 19:48:18 -0500")
Message-ID: <xmqq60l2c3hl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34BE9446-E339-11E6-9E98-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We de-duplicate ".have" refs among themselves, but never
> check if they are duplicates of our local refs. It's not
> unreasonable that they would be if we are a "--shared" or
> "--reference" clone of a similar repository; we'd have all
> the same tags.
>
> We can handle this by inserting our local refs into the
> oidset, but obviously not suppressing duplicates (since the
> refnames are important).

Makes sense.

> +extract_ref_advertisement () {
> +	perl -lne '
> +		# \\ is there to skip capabilities after \0
> +		/push< ([^\\]+)/ or next;
> +		exit 0 if $1 eq "0000";
> +		print $1;
> +	'

Parsing TRACE_PACKET output?  Yuck.  But I think this has to do, as
any other solution will bound to be uglier.

> +test_expect_success 'receive-pack de-dupes .have lines' '
> +	git init shared &&
> +	git -C shared commit --allow-empty -m both &&
> +	git clone -s shared fork &&
> +	(
> +		cd shared &&
> +		git checkout -b only-shared &&
> +		git commit --allow-empty -m only-shared &&
> +		git update-ref refs/heads/foo HEAD
> +	) &&
> +
> +	# Notable things in this expectation:
> +	#  - local refs are not de-duped
> +	#  - .have does not duplicate locals
> +	#  - .have does not duplicate itself
> +	local=$(git -C fork rev-parse HEAD) &&
> +	shared=$(git -C shared rev-parse only-shared) &&
> +	cat >expect <<-EOF &&
> +	$local refs/heads/master
> +	$local refs/remotes/origin/HEAD
> +	$local refs/remotes/origin/master
> +	$shared .have
> +	EOF

We may want to sort this thing and the extracted one when comparing;
the order of the entries is not part of the feature we cast in stone.

> +
> +	GIT_TRACE_PACKET=$(pwd)/trace git push fork HEAD:foo &&
> +	extract_ref_advertisement <trace >refs &&
> +	test_cmp expect refs
> +'
> +
>  test_done
