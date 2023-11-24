Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u1d3nqYW"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5F4D53
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 01:44:39 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C468A1C439;
	Fri, 24 Nov 2023 04:44:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6uV81LXvZmEOS9hV1eNJqgiGOcBajVwCiG1VZO
	sO1LM=; b=u1d3nqYW6G4IndJmQ3zmv3QUKVW5aUdIIcbwYMuhUzREdsnzLKvpBA
	HAWV3Y7pfd0Y+rE2BR4dgh+vrWW17YHuW99F3U7N1nCJT4jojUKWVrqSVMm/CK8E
	cv7GlCh26lZq85FvrS3c7jGxneG1NJOIGmalakZZ+/hkhlan95pWA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD1021C438;
	Fri, 24 Nov 2023 04:44:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 627571C437;
	Fri, 24 Nov 2023 04:44:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Carlos =?utf-8?Q?Andr=C3=A9s_Ram=C3=ADrez_Cata=C3=B1o?=
 <antaigroupltda@gmail.com>
Subject: Re: [PATCH] object-name: reject too-deep recursive ancestor queries
In-Reply-To: <ZV9Za7iCL6WiE-Py@tanuki> (Patrick Steinhardt's message of "Thu,
	23 Nov 2023 14:53:47 +0100")
References: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>
	<ZV9Za7iCL6WiE-Py@tanuki>
Date: Fri, 24 Nov 2023 18:44:33 +0900
Message-ID: <xmqqy1en7af2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 13ADAE6C-8AAE-11EE-B005-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I have to wonder whether we should tighten restrictions even further:
> instead of manually keeping track of how deep in the stack we are, we
> limit the length of revisions to at most 1MB. I would claim that this
> limit is sufficiently large to never be a problem in practice.

Tempting.

> Revisions
> are limited to 4kB on most platforms anyway due to the maximum path
> length.

I do not quite get this part, though.

When we get "HEAD~~~~~~~~~^2~~~~~~" from the user, do we somehow try
to create a file or a directory with that name and fail due to
ENAMETOOLONG?

There are ways like "git rev-list --stdin" to cause Git read input
lines of arbitrary length, so I do not think the command line length
limit does not come into the picture, either.

But I do agree that the only useful use of such a revision string
that is longer than 1MB would be to attack.

