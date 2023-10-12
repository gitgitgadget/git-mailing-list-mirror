Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEF3F4CB
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EJ9s8CUk"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66520B8
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 15:11:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 649F319FC10;
	Thu, 12 Oct 2023 18:11:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6fqlBobYtanQ8M9iCY+Uyt7gwSX3yChfrHyOXO
	ptqis=; b=EJ9s8CUkzsfLWHU9V3+5dWDbFjZ/bUruWuV8Tr6OO8/JXzgV3+6UR8
	fBziBHI58pMhZQYw2mr/22SXuPJ7ZzR+IhLDo/yZHkqIxgRITFwsNpSP6QXpYLev
	9yaN0iiNoPEUJGCT1aoSc1rneMTCMbjY9hLu88xzGCz9dYMu+4d2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B38719FC0E;
	Thu, 12 Oct 2023 18:11:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC05819FC0A;
	Thu, 12 Oct 2023 18:11:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jason Hatton
 <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
In-Reply-To: <ZShsG1SKfrefsCtu@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 12 Oct 2023 21:58:51 +0000")
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
	<20231012160930.330618-3-sandals@crustytoothpaste.net>
	<xmqqpm1jn2nh.fsf@gitster.g>
	<ZShsG1SKfrefsCtu@tapette.crustytoothpaste.net>
Date: Thu, 12 Oct 2023 15:11:39 -0700
Message-ID: <xmqqzg0n32zo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 51EAE9E8-694C-11EE-B69C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> nor should we support 8- or 16-bit systems.  If you'd prefer "uint32_t",
> I can do that.

Going into statinfo.h and updating sd_size to uint32_t is totally
outside the scope of this fix.

> I think using 2^31 is better because it's far away from very small
> values and very large values, which means that it's a hard to modify a
> file which used to have its value as a multiple of 4 GiB and
> accidentally make Git think it was unchanged.  Using 1 would make a
> simple "echo > foo" possibly think things were unchanged in some cases,
> which we should avoid.

The reason I gave the extreme "1-byte" was to gauge how much actual
"size" we are relying on the correctness of this change.  As mtime
is giving the primary protection from false matching of cached stat
information, I do not think "echo >foo" would be a huge issue.  IOW
my stance is 1U<<31 is as good as 1U<<0, so I do not oppose to the
former, either.  But in a few years, 64-bit integers may cease to be
too odd, who knows ;-)


