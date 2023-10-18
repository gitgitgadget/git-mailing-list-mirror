Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A978A27700
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LpdIqXiw"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD3F7
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 08:32:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA5451BFD09;
	Wed, 18 Oct 2023 11:32:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OO9YPStbuvhAISr4PdrPSpTkSIEjgIQ1wKmk2M
	v7Mpg=; b=LpdIqXiwTxbxkP71kbGwKM8mmRuHJ8zwhkSBTzge4It7a1KFOaspgh
	BgGQQD3FxuPSggXTyub6V+Yw+PfXhoC3IeOVBE6Y0UkLKGA2M+3rZ+pct/fLM2Bg
	ME3bj76n0cx7RyblNVDLS5AL3jgo800vtKFxaLVDSzoaEj0UGdPe0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E1E21BFD08;
	Wed, 18 Oct 2023 11:32:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAA4E1BFD07;
	Wed, 18 Oct 2023 11:32:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 00/11] t: reduce direct disk access to data structures
In-Reply-To: <cover.1697607222.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 18 Oct 2023 07:35:03 +0200")
References: <cover.1697607222.git.ps@pks.im>
Date: Wed, 18 Oct 2023 08:32:01 -0700
Message-ID: <xmqqbkcwuetq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CF3845A-6DCB-11EE-B334-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patrick Steinhardt <ps@pks.im> writes:

> this patch series refactors a bunch of our tests to perform less direct
> disk access to on-disk data structures. Instead, the tests are converted
> to use Git tools or our test-tool to access data to the best extent
> possible. This serves two benefits:

Laudable goal.

>     - We increase test coverage of our own code base.

Meaning the new code added to test-tool for this series will also
get tested and bugs spotted?

>     - We become less dependent on the actual on-disk format.

Yes, this is very desirable.  Without looking at the implementation,
I see some issues aiming for this goal may involve. [a] using the
production code for validation would mean our expectation to be
compared to the reality to be validated can be affected by the same
bug, making two wrongs to appear right; [b] using a separate
implementation used only for validation would at least mean we will
have to make the same mistake in unique part of both implementations
that is less likely to miss bugs compared to [a], but bugs in shared
part of the production code and validation code will be hidden the
same way as [a].

But you have thought about this series a lot deeper and longer than
I have, so let me read on and find out what your solution is.


> The main motivation for this patch series was the second bullet point as
> it is preparatory work to get the reftable backend upstreamed.

Yay.

> My intent
> is to get rid of many or even most of the current blockers in the Git
> project before trying to send the reftable implementation upstream.
> While this will be a lot of up-front work that is going to span over a
> long time period, I think this approach will make everyones live easier
> by doing comparatively small and incremental improvements to the Git
> project.

Thank you very much for being considerate.  I assume this approach
is what those in the Contributors' Summit agreed to be the best way
forward to do anything sizeable.

> Ultimately, the final patch series should in the best case only
> contain the new backend as well as testing infrastructure, but not much
> else.

;-)
