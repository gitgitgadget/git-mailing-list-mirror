Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B542E3E3
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vhQgecUW"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D94F5
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 12:59:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BF31C2DDD5;
	Tue, 17 Oct 2023 15:59:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ObjsYNVLd+tofrTM8MwaSZAd+r5toZFlXiqbDI
	7qots=; b=vhQgecUWomouwtJdQFUTGIGev9G95mHKLsiG1RL7jUqPCmTJHekQho
	iX8Hk1ClCUOu3p1MSWyXkkb4UKZsNmGLNWbEff6CExtWa7aVE2KRwpnB3aGoPJDF
	NM4JjELhYuKOaEjPaCrzjoslBr0RMd3/2Io+uAKhtuVgx4QiMoXRQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B7FB52DDD4;
	Tue, 17 Oct 2023 15:59:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3F2E22DDD3;
	Tue, 17 Oct 2023 15:59:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  stolee@gmail.com
Subject: Re: [PATCH 0/8] t7900: untangle test dependencies
In-Reply-To: <cover.1697319294.git.code@khaugsbakk.name> (Kristoffer
	Haugsbakk's message of "Sat, 14 Oct 2023 23:45:51 +0200")
References: <cover.1697319294.git.code@khaugsbakk.name>
Date: Tue, 17 Oct 2023 12:59:38 -0700
Message-ID: <xmqqbkcxhvf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B4FDB5D6-6D27-11EE-914D-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> #!/bin/sh
> cd t
> # Every test run together with `setup` should pass
> for i in $(seq 1 42)
> do
>     ./t7900-maintenance.sh --quiet --run=setup,$i || return 1
> done &&

It is kind-of surprising that with only 8 patches you can reach such
a state, but ...

> # The tests that used to depend on each other should still pass
> # when run together
> ./t7900-maintenance.sh --quiet --run=setup,30,31 &&

... this puzzles me.  What does it mean for tests to "depend on each
other"?  Does this mean running #31 with or without running #30 runs
under different condition and potentially run different things?

One might argue that, in an ideal world, our tests should work when
any non-setup tests are omitted (so, instead of $i above, you'll
have an arbitrary subsequence of 1..42 and your tests still pass),
and it may be a worthy goal, but at the same time, it may be a bit
impractical, as setting things up is costly, but what you can do in
the common "setup" will be very small.  Or you'll have so much
"recovering from damage" in test_when_finished for each test that
makes such untangling of dependencies too costly.

