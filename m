Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B05210A
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wRLbrAXJ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC823AB
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 10:57:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EB811BAC13;
	Sun, 15 Oct 2023 13:57:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xppDxgCFo/uXpyQHX7rr3rKGDOvHykBG7DFbo9
	7AvJs=; b=wRLbrAXJfI4Dqw3oIcdz+G8zsZcjzDBvasHz2EJ9wqcVKg1j0y4gxR
	Vr8dsFdwZ4e5UQ+NVWdhH4i69eUOkSsFo9USyXKdTH8eIWXOqV8aSYM6Ge/KHnbq
	k8sUzAzeOa3s/AxNTJ5K1arYkVDpVelMreQvfncgdm2H1Dtdplvpk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 570821BAC12;
	Sun, 15 Oct 2023 13:57:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C072F1BAC11;
	Sun, 15 Oct 2023 13:57:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,
  ks1322@gmail.com
Subject: Re: [PATCH] grep: die gracefully when outside repository
In-Reply-To: <20231015032636.GC554702@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 14 Oct 2023 23:26:36 -0400")
References: <6bb48aac-460c-4d7f-9057-40c3df0c807d@app.fastmail.com>
	<087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
	<20231015032636.GC554702@coredump.intra.peff.net>
Date: Sun, 15 Oct 2023 10:57:36 -0700
Message-ID: <xmqq7cnnpy3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53A2232A-6B84-11EE-AC7E-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jeff King <peff@peff.net> writes:

> Is it even reasonable for "grep --no-index" to care about leaving the
> tree in the first place? That is, is there a reason we should not allow:
>
>   git grep --no-index foo ../bar

A huge difference between the bare "grep" and "git grep" is that we
know the scope of the project tree, so it goes recursive by default.
Should the above command line recursively go below ../bar?  Would we
allow "/" to be given?

I actually do not think these "we are allowing Git tools to be used
on random garbage" is a good idea to begin with X-<.  If we invented
something nice for our variant in "git grep" and wish we can use it
outside the repository, contributing the feature to implementations
of "grep" would have been the right way to move forward, instead of
contaminating the codebase with things that are not related to Git.
Whoever did 59332d13 (Resurrect "git grep --no-index", 2010-02-06)
should be punished X-<.

Anyway.

2e48fcdb (grep docs: document --no-index option, 2010-02-25) seems
to have wanted to explicitly limit the search within the "current
directory", and I am fine to keep the search space limited by the
cwd.  On the other hand, of course, the users can shoot themselves
in the foot with "grep -r foo /", so letting them use "git grep" the
same way is perhaps OK.  Especially if it simplifies the code if we
lift the limitation, that is a very tempting thing to do.

> If we want to avoid leaving the current directory, then I think we need
> to be checking much sooner (but again, I would argue that it is not
> worth caring about in no-index mode).
