Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BEB8480
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fc74sh7c"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C47111
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 05:37:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DAB41B37B9;
	Thu, 26 Oct 2023 08:37:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v6Bl1/6ZXy28yXnPWZh8F/q8fneJzLr+btUeWR
	pIkps=; b=fc74sh7cE+L8jzJ0bTyQtp090C1Aa98hqt4BPO7B+2DGIqLfT2rSQv
	j73rgPq6JklBO4y5OfGw49HSZYHy410P1NHlFajxUHkv+wj8gaaDL/5Rt6NCDwVP
	sfBYGkiVmBo719QTAqX8plkKtZsq9DKwp0wu3Gfu8pSkMd78H9f3g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95C781B37B8;
	Thu, 26 Oct 2023 08:37:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F06CB1B37B7;
	Thu, 26 Oct 2023 08:37:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] rev-list: add commit object support in
 `--missing` option
In-Reply-To: <ZTi4Zd1by53q5gtM@tanuki> (Patrick Steinhardt's message of "Wed,
	25 Oct 2023 08:40:37 +0200")
References: <20231019121024.194317-1-karthik.188@gmail.com>
	<20231024122631.158415-1-karthik.188@gmail.com>
	<20231024122631.158415-4-karthik.188@gmail.com>
	<ZTi4Zd1by53q5gtM@tanuki>
Date: Thu, 26 Oct 2023 21:37:20 +0900
Message-ID: <xmqqwmv9r24f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68AABB80-73FC-11EE-A19D-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	if (revs->do_not_die_on_missing_objects)
>> +		oidset_init(&revs->missing_objects, 0);
>> +
>
> While we're initializing the new oidset, we never clear it. We should
> probably call `oidset_clear()` in `release_revisions()`. And if we
> unconditionally initialized the oidset here then we can also call
> `oiadset_clear()` unconditionally there, which should be preferable
> given that `oidset_init()` does not allocate memory when no initial size
> was given.

Yup, I used the conditional one to match the above, but initializing
unused oidset is cheap and frees us from having to worry about
mistakes.  I like your idea much better.

>> +
>> +	/* Missing objects to be tracked without failing traversal. */
>> +	struct oidset missing_objects;
>
> As far as I can see we only use this set to track missing commits, but
> none of the other objects. The name thus feels a bit misleading to me,
> as a reader might rightfully assume that it contains _all_ missing
> objects after the revwalk. Should we rename it to `missing_commits` to
> clarify?

Again, very good suggestion.

Thanks.
