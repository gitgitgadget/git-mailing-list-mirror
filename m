Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF3F4FB
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lo2aNQkT"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAE2D9
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 09:31:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 526D01BA57A;
	Sun, 15 Oct 2023 12:31:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XLGYjnaLY1BBfo71uYj6zox7psAeOzLcFWlWzm
	6Hio4=; b=Lo2aNQkT8+Mc4dYfraJN/8YgrmAHiUjf4e8887H8W3LHZm9REIxrTO
	7FuFxwgZImOl8TVPdKxu5UaahLFnr1A0HgxntJUdg21LRJSUfkkLKG2vJhaEa+fu
	DXRq2M9mNXJr0ZdwAHp6aSKTwQqz/f+b0UXStgykEM137+9yFPjV0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49E5C1BA579;
	Sun, 15 Oct 2023 12:31:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A72251BA578;
	Sun, 15 Oct 2023 12:31:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Thiel <sebastian.thiel@icloud.com>
Cc: Elijah Newren <newren@gmail.com>,  Josh Triplett
 <josh@joshtriplett.org>,  git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
In-Reply-To: <B088FC28-BE30-424D-9CDD-7A53EDFC1710@icloud.com> (Sebastian
	Thiel's message of "Sun, 15 Oct 2023 09:33:17 +0200")
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
	<xmqqttqytnqb.fsf@gitster.g> <ZSouSI_zPusOefsv@localhost>
	<CABPp-BEg6vxiUpcJAG_=KB_sTrVgCF19JZh-+ZGCTPXdbo9ekg@mail.gmail.com>
	<B088FC28-BE30-424D-9CDD-7A53EDFC1710@icloud.com>
Date: Sun, 15 Oct 2023 09:31:31 -0700
Message-ID: <xmqqmswjsv8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4CFDB478-6B78-11EE-BB41-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sebastian Thiel <sebastian.thiel@icloud.com> writes:

> A particularly interesting question brought up here also was the question
> of what's more important: untracked files, or precious files? Are they
> effectively treated the same, or is there a difference?

Think of it this way.  There are two orthogonal axes.

 (1) Are you a candidate to be tracked, even though you are not
     tracked right now?

 (2) Should you be kept and make an operation fail that wants to
     remove you to make room?

For untracked files, both are "Yes".  As we already saw in the long
discussion, precious files are "not to be added and not to be
clobbered", so you'd answer "No" and "Yes" [*].

In other words, both are equally protected from getting cloberred.

    Side note: for completeness, for ignored files, the answers are
    "No", and "No".  The introduction of "precious" class makes a
    combination "No-Yes" that hasn't been possible so far.

Elijah, thanks for doing a very good job of creating a catalog of
kludges we accumulated over the years for the lack of proper support
for the precious paths.  I think they should be kept for backward
compatibility, but for new users they should not have to learn any
of them once we have the support for precious paths.

