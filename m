Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668F2E3FA
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OkJuWXwW"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE50392
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:49:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 229C81B880C;
	Tue, 17 Oct 2023 16:49:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=30zz/VRKfBVQd2iYqrr7jiWTGA69YcAdEaS8yA
	Tt2SI=; b=OkJuWXwWSvFXkYvKRKlNFi5LRwRZkO9l4uftiBUZGZRT26D65AWMPA
	snY+5/C/k0m5d+K4FIcAw4J4qmhezvsgA653BxDtny32g2AIMvYnhKXA9lL+frbZ
	IBHvd3Jk8niyBaYCzdBeLssLD2RX4xc015hgsEOrnq1TC3xsKY2dE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BB901B880B;
	Tue, 17 Oct 2023 16:49:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A2991B880A;
	Tue, 17 Oct 2023 16:49:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  stolee@gmail.com
Subject: Re: [PATCH 0/8] t7900: untangle test dependencies
In-Reply-To: <8cd788dc-7d16-4cfd-9f70-7889dcaa7199@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 17 Oct 2023 22:14:03 +0200")
References: <cover.1697319294.git.code@khaugsbakk.name>
	<xmqqbkcxhvf9.fsf@gitster.g>
	<8cd788dc-7d16-4cfd-9f70-7889dcaa7199@app.fastmail.com>
Date: Tue, 17 Oct 2023 13:49:38 -0700
Message-ID: <xmqqv8b5ezz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0AE7662-6D2E-11EE-A364-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Tue, Oct 17, 2023, at 21:59, Junio C Hamano wrote:
>> It is kind-of surprising that with only 8 patches you can reach such
>> a state, but ...
>>
>>> # The tests that used to depend on each other should still pass
>>> # when run together
>>> ./t7900-maintenance.sh --quiet --run=setup,30,31 &&
>>
>> ... this puzzles me.  What does it mean for tests to "depend on each
>> other"?  Does this mean running #31 with or without running #30 runs
>> under different condition and potentially run different things?
>
> What I mean is that some preceding test has a side-effect that a test
> depends on.

I see.  And 31 used to depend on the side effect of having ran 30,
but in the updated test, the precondition 31 depends on is created
by itself without relying on what 30 did (and in fact, perhaps in
the updated test, 30 may rewind what it did as part of the clean-up
process using test_when_finished).  That makes sense.

> I don't know what the policy is. :) My motivation was that I was working
> on something else which seemed to break the suite, then I tried to reduce
> the tests that were run to get rid of the noise (`--verbose`), but then it
> got confusing because I didn't know if I had really broken some tests
> myself or if more tests would start failing by only running a subset of
> them.

Yeah, it is a laudable goal, but I am not sure how practical it is
to expect developers to maintain that propertly.  Unless there is
some automated test to enforce the independence of the tests, that
is.

Thanks.
