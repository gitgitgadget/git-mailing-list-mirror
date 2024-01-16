Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B21C6AB
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J8AY7792"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB26D1E5E61;
	Tue, 16 Jan 2024 11:54:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W33Wv4URotbG+o1/WoW1EOKXVvi5daFjP5Swvy
	d56Lg=; b=J8AY77927QA++xhWs2nrB+O0IIB/rZmnbjKbOJ7pnzDcMVxYlVbQ5i
	CCjLxybAqiKXI20wY44SyfZmRZcRaK98a8uKjFfU7HkbN+hsFdztvB3UFcK9d2xG
	XJsPSM2EBoPUgUkQyUATpP8jZ8x7eq1TB0xF2cqV4kOMNuK7wkCRw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2EA61E5E60;
	Tue, 16 Jan 2024 11:54:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0D341E5E5F;
	Tue, 16 Jan 2024 11:54:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Nikolay Edigaryev <edigaryev@gmail.com>
Subject: Re: [PATCH] rev-list-options: fix off-by-one in
 '--filter=blob:limit=<n>' explainer
In-Reply-To: <pull.1645.git.git.1705261850650.gitgitgadget@gmail.com> (Nikolay
	Edigaryev via GitGitGadget's message of "Sun, 14 Jan 2024 19:50:50
	+0000")
References: <pull.1645.git.git.1705261850650.gitgitgadget@gmail.com>
Date: Tue, 16 Jan 2024 08:54:23 -0800
Message-ID: <xmqqo7dl1ao0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E75E00F8-B48F-11EE-BB92-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Nikolay Edigaryev <edigaryev@gmail.com>
>
> '--filter=blob:limit=<n>' was introduced in 25ec7bcac0 (list-objects:
> filter objects in traverse_commit_list, 2017-11-21) and later expanded
> to bitmaps in 84243da129 (pack-bitmap: implement BLOB_LIMIT filtering,
> 2020-02-14)
>
> The logic that was introduced in these commits (and that still persists
> to this day) omits blobs larger than _or equal_ to n bytes or units.

Good eyes.  The former does this

		if (object_length < filter_data->max_bytes)
			goto include_it;

and the latter does this


                if (!bitmap_get(tips, pos) &&
                    get_size_by_pos(bitmap_git, pos) >= limit)
                        bitmap_unset(to_filter, pos);

> However, the documentation (Documentation/rev-list-options.txt) states:
>
>>The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n
> bytes or units. n may be zero.
>
> Moreover, the t6113-rev-list-bitmap-filters.sh tests for exactly this
> logic, so it seems it is the documentation that needs fixing, not the
> code.

Yup.  The mechanism is used for things like "we do not want a large
blob, like 100MB", and a byte on the boundary does not matter all
that much in such a countext, but it does not hurt to be more
correct ;-)

>  The form '--filter=blob:none' omits all blobs.
>  +
> -The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
> -or units.  n may be zero.  The suffixes k, m, and g can be used to name
> -units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
> -as 'blob:limit=1024'.
> +The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
> +bytes or units.  n may be zero.  The suffixes k, m, and g can be used
> +to name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k'
> +is the same as 'blob:limit=1024'.

With unnecessary paragraph wrapping, it is a bit hard to compare the
preimage and the postimage, but I manually checked that this only
does

	"larger than" -> "of size at least"

and nothing else, which is expected and in line with what the
proposed commit message claimed to do.  Good job.

Will queue.  Thanks.

>  +
>  The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects
>  which are not of the requested type.
>
> base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
