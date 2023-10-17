Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8D3D3A8
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OPMZG3AI"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18C92
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 10:13:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9A881B6CA9;
	Tue, 17 Oct 2023 13:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u60eJHEAoVUI0o+Rqfyv+h3Qfbktr/k2u0nhES
	CIYCM=; b=OPMZG3AI2nYBDrvtqdVtD6Rp0VNywgFjyjOogWRhvOaZmbL+sXO7Rc
	aevXdw8yEm9+u2/5a7+UeBsf0w59L58i1smvuUOJoWh9nZxOHgKCR5hpzy8IA9Ma
	bI8DpmrAu5LQeo/lk/p3yu370w1d/kEEzG2asosiqow251WRWKnyE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C18D51B6CA8;
	Tue, 17 Oct 2023 13:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3096D1B6CA7;
	Tue, 17 Oct 2023 13:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  jonathantanmy@google.com,  calvinwan@google.com,
  glencbz@gmail.com
Subject: Re: [PATCH v3 0/5] config-parse: create config parsing library
In-Reply-To: <cover.1695330852.git.steadmon@google.com> (Josh Steadmon's
	message of "Thu, 21 Sep 2023 14:17:19 -0700")
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
	<cover.1695330852.git.steadmon@google.com>
Importance: high
Date: Tue, 17 Oct 2023 10:13:49 -0700
Message-ID: <xmqq34y9jho2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8A4ADDA8-6D10-11EE-A9F0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Josh Steadmon <steadmon@google.com> writes:

> Config parsing no longer uses global state as of gc/config-context, so the
> natural next step for libification is to turn that into its own library.
> This series starts that process by moving config parsing into
> config-parse.[c|h] so that other programs can include this functionality
> without pulling in all of config.[c|h].

This has been in list archive collecting dust.  It is unfortunate
that not many people appear to be interested in reviewing others'
patches?

> Open questions:
> - How do folks feel about the do_event() refactor in patches 2 & 3?

I gave a quick re-read and found that the code after patch 2 made it
easier to see how config.c::do_event() does its thing (even though
the patch text of that exact step was somehow a bit hard to follow).

However, the helper added by patch 3, do_event_and_flush(), that
duplicates exactly what do_event() does, is hard to reason about, at
least for me.  It returns early without setting .previous_type to
EOF and the value returned from the helper signals if that is the
case (the two early return points both return what flush_event()
gave us), but the only caller of the helper does not even inspect
the return value, unlike all the callers of do_event(), which also
looks a bit fishy.

Thanks.

