Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87821869
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ONTgJHy9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8978E1BF04A;
	Fri, 15 Dec 2023 19:44:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6mNTfxvyjCQcu0JsW7FtyA8P9pROKs1hZBIt/k
	aNu4E=; b=ONTgJHy92vcbi8WEhMdRvTG9xg21mD+FRmizbaYATXMxIDt+lLu/j+
	hTm+HOGQHV2jNhy5Cy1gqEb0a5rc5AYwbtMWYNKu+ZEqtpKRP5EgqAcmkRAIK8oI
	gnkDuX/URZZUXQJ9t2TqIOqDhPQwxzM96QelTfeA3scpqHuuUasbE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81E651BF049;
	Fri, 15 Dec 2023 19:44:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB84F1BF048;
	Fri, 15 Dec 2023 19:44:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/5] make room for "special ref"
In-Reply-To: <321b8084-fddb-4b5d-86af-7f88cb3edf7b@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 15 Dec 2023 22:44:01 +0000")
References: <20231215203245.3622299-1-gitster@pobox.com>
	<xmqq5y0zkvqx.fsf@gitster.g>
	<321b8084-fddb-4b5d-86af-7f88cb3edf7b@ramsayjones.plus.com>
Date: Fri, 15 Dec 2023 16:44:47 -0800
Message-ID: <xmqq7clfj7r4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 50E87668-9BAC-11EE-9549-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Yes, I was going to suggest exactly this, after Patrick pointed out
> that there were only two 'special psuedo-refs' (I had a vague feeling
> there were some more than that) FETCH_HEAD and MERGE_HEAD.

Glad to see that I am not alone.  We should be able to treat
MERGE_HEAD similarly.  It is used to communicate the list of "other
parents" from "git merge" that stops in the middle (either for merge
conflict, or in response to the "--no-commit" command line option)
to "git commit" that concludes such an unfinished merge.  Many
commands merely use the presence of MERGE_HEAD as a sign that a
merge is in progress (e.g. "git status"), which would not break if
we just started to record the first parent in a pseudoref MERGE_HEAD
and wrote the other octopus parents elsewhere, but some commands do
need all these parents from MERGE_HEAD (e.g. "git blame" that
synthesizes a fake starting commit out of the working tree state).

If we cannot get rid of all "special refs" anyway, however, I think
there is little that we can gain from doing such "make FETCH_HEAD
and MERGE_HEAD into a single-object pseudoref, and write other info
in separate files" exercise.  We can treat the current FETCH_HEAD
and MERGE_HEAD as "file that is not and is more than a ref", which
is what the current code is doing anyway, which means we would
declare that they have to stay to be files under $GIT_DIR/ and will
be accessed via the filesystem access.  At that point, calling them
"special ref" might even be more misleading than its worth and we
may be better off to admit that they are not even refs but a
datafile some commands can use to obtain input from, but the phrase
we use to refer to them, be it "special ref" or some random
datafile, does not make a fundamental change on anything.


