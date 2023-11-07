Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741038D
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EfX/HoQv"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5EE1BF
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:42:23 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F41AB1C546B;
	Mon,  6 Nov 2023 20:42:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HwMd13dNbiNfKH2QfEpk0H7q5pEl9gj5HPbL4R
	l6zGU=; b=EfX/HoQv24u6Ve1or/BJg2wgusg4RBBaGzWiCaOe8iGh2lXxsAI46/
	Iaa5d3TwU+ijI0gqu+ybiqWmn2XxpSBHA6KkvVBvjq02FnlG0K1jUdWkG4r2i2Dv
	LpUIlHR0ePt8ciGbt2UPdQAryTccff6i7rG0lS/2Kpxp/gGi85OYI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC12E1C546A;
	Mon,  6 Nov 2023 20:42:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44EB11C5469;
	Mon,  6 Nov 2023 20:42:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] revision: exclude all packed objects with `--unpacked`
In-Reply-To: <cover.1699311386.git.me@ttaylorr.com> (Taylor Blau's message of
	"Mon, 6 Nov 2023 17:56:27 -0500")
References: <cover.1699311386.git.me@ttaylorr.com>
Date: Tue, 07 Nov 2023 10:42:21 +0900
Message-ID: <xmqqy1fabapu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E52D41F8-7D0E-11EE-91D3-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> While working on my longer series to enable verbatim pack reuse across
> multiple packs[^1], I noticed a couple of oddities with the `--unpacked`
> rev-walk flag.
>
> While it does exclude packed commits, it does not exclude (all) packed
> trees/blobs/annotated tags. This problem exists in the pack-bitmap
> machinery, too, which will over-count queries like:
>
>     $ git rev-list --use-bitmap-index --all --unpacked --objects
>
> , etc.
>
> The fix is relatively straightforward, split across two patches that
> Peff and I worked on together earlier today.
>
> This is technically a backwards-incompatible change, but the existing
> behavior is broken and does not match the documented behavior, so I
> think in this case we are OK to change --unpacked to faithfully
> implement its documentation.

Yeah, it does sound like a straight bugfix to me.

>
> [^1]: Which, I'm very excited to say, is working :-).
>
> Taylor Blau (2):
>   list-objects: drop --unpacked non-commit objects from results
>   pack-bitmap: drop --unpacked non-commit objects from results
>
>  list-objects.c                     |  3 +++
>  pack-bitmap.c                      | 27 +++++++++++++++++++++++++++
>  t/t6000-rev-list-misc.sh           | 13 +++++++++++++
>  t/t6113-rev-list-bitmap-filters.sh | 13 +++++++++++++
>  t/t6115-rev-list-du.sh             |  7 +++++++
>  5 files changed, 63 insertions(+)
>
>
> base-commit: bc5204569f7db44d22477485afd52ea410d83743
