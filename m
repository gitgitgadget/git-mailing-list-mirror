Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OalRoZkV"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0659ABA
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 09:14:24 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 80D1F24AFC;
	Mon, 20 Nov 2023 12:14:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jFc7t31UfjiaLn+WVxghmKVuwjKDSWHzLd0yZZ
	7ngcw=; b=OalRoZkVKc2CYQrmHqmFiJ0C2ESg8Wu/WjktVDXVO3dWL9bdb4YV9m
	o5M1vDpP3/L3BCRCRjavBTDGK73Z9ZIH9//7Si+rcv42j7t/VHraro7EK11qJEtX
	09nkrL2RLvW2VLDGF9BVl+uBV8ykvBP2KM3XKzyOfObDG6qDGc8xE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7971024AFB;
	Mon, 20 Nov 2023 12:14:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 100B624AF9;
	Mon, 20 Nov 2023 12:14:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Carlos =?utf-8?Q?Andr=C3=A9s_Ram=C3=ADrez_Cata=C3=B1o?=
 <antaigroupltda@gmail.com>
Subject: Re: [PATCH] object-name: reject too-deep recursive ancestor queries
In-Reply-To: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 20 Nov 2023 11:13:45 -0500")
References: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>
Date: Tue, 21 Nov 2023 02:14:18 +0900
Message-ID: <xmqqjzqcl53p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E239348-87C8-11EE-9947-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Since this is a local-only exploit, a user would have to be tricked into
> running such a query by an adversary. Even if they were successfully
> tricked into running the malicious query, the blast radius is limited to
> a local stack overflow, which does not have meaningful paths to remote
> code execution, arbitrary memory reads, or any more grave security
> concerns.
> ...

So the difference in practice is if we make a controlled call to
die() or just let it crash?  It still does sound worthwhile thing to
do to make sure we make a controlled death.  But ...

> +static int get_nth_ancestor_max_depth = 4096;
> +static int get_nth_ancestor_curr_depth;

... do we have a lock at a much higher level that prevents multiple
name-to-oid look-ups from running simultaneously, or something
similar, to make use of this static counter safe?  I am not offhand
sure how safe it is to assume that we'd always be single-threaded.
This variable leaves a bad taste in my mouth.

I am not offhand sure how hard it is to count the depth per
callpath; get_oid_1() is the sole caller of get_nth_ancestor(), so
if you rename the former into a separate helper with a new
"recursion_depth" parameter, create a thin wrapper around it that
starts the recursion at depth 0 and have everybody else (i.e.,
peel_onion() and get_oid_with_context_1()) call it, and have
get_nth_ancestor increment (and die as needed) the counter, would
that be sufficient to ensure that we count the depth per call
invocation?

Thanks.
