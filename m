Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99E14BF8D
	for <git@vger.kernel.org>; Thu, 30 May 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097931; cv=none; b=VbE2kdfhApr9JVmCwddM2im7Vbgwpuo0p/jFcwVL4ND++Yss03BLwCJnwZOZJydCk6ZqpcVtzB7iTeCEF3P2jbuz4yNezQnRRnqVlWTkgSGX4Uhhw2UhmLPlmhK1AN6BlPJ3vyoAPvqifXx/85VLc+THQXjaU+17GtFGEE02xHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097931; c=relaxed/simple;
	bh=E5yY5nU/VYc3voKxijP05og9U4lWHvTi9ZdCpxqxJO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vCAcpmYPrHDvd7O3tQoVBd0GYl8HCpcclTrTu98TVEi2JT5veWpS8gKoRVOaYVB0zShlZhQ8edlVmm7Jf1CJ5btaGBAdMKuRmd4cJMc2bmX3G8LPtMd4z0ho0tmdN2ZOXeaufLNIxQ9eYE4Q7oGZIprlyqFYZO3GENmW7wPnW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nyLg+lqG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nyLg+lqG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 885663476A;
	Thu, 30 May 2024 15:38:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E5yY5nU/VYc3voKxijP05og9U4lWHvTi9ZdCpx
	qxJO0=; b=nyLg+lqGi6c/Gu7SqI3pDytrTcWBQTUGRri2Uv7lOpZB5pWLaAqiWr
	DkC8poFhrIrxGmnO9mDklP/cuOSQDbz4f7bOQpgCjj+Z4YmApwOmXwdoCHLagqz5
	stQTc4Fr7w58iNz1qx72xR9PC/f5MaLFG85cRIul7ZGn8dqyuoDGI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8056634769;
	Thu, 30 May 2024 15:38:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CF2934768;
	Thu, 30 May 2024 15:38:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
In-Reply-To: <ZlhjN7K8JKYz6Opd@tanuki> (Patrick Steinhardt's message of "Thu,
	30 May 2024 13:29:59 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
	<xmqqplt4y1gk.fsf@gitster.g> <ZlhjN7K8JKYz6Opd@tanuki>
Date: Thu, 30 May 2024 12:38:45 -0700
Message-ID: <xmqq34pzozsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B22813C-1EBC-11EF-AC95-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Well, we do. Not in `get_fetch_map()`, but in `query_refspecs()`. It
> does weird stuff where it writes the result into either `src` or `dst`
> depending on which of these fields is provided by the caller. Which
> means that one of the fields would typically be a constant, whereas the
> other one will be allocated.

Yes, <src, dst> is used as a pair of <key, value> to query one with
the other (i.e. "where does this one go?" "where does this one come
from?").

But we are not talking about const-ness of the member (iow, once you
point a string with the member, you cannot repoint the pointer to
another string), but we are talking about const-ness of the string
that is pointed by the member (iow, not "char const *src" but "const
char *src"), no?  If I ask "I have this src, where does it go?" with
a refspec element filled with src, the dst member may need to be
updated to point at the string that is the answer of the query, but
that still can be done with "const char *src, *dst", can't it?  That
was what I was wondering.

And again you are conflating "allocated" with "read-write" here.  It
is often convenient if a variable that points at an allocated string
is of type "char *" and not "const char *", because you do not cast
it when calling free().  But if you want to make a structure member
or a variable that holds an allocated string responsible for
_owning_ the piece of memory, then you need to consistently have the
member point at an allocated piece of memory (or NULL), no?  What
this patch does, i.e. prepare an on-stack refspec_str[] array that
is initialized from a constant string, and have .src member point at
it, would not make .src freeable.  In other words, .src pointing at
an allocated piece of string "some of the time" alone is not a good
justification to make it a non-const pointer, I would think.

