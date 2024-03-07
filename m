Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6A136991
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840141; cv=none; b=BrJ7Z0SXFu8L95xs8bj4zEbLwZugGdxZFg1Kx2I3ktvavbsUCXwLBO4FIzobLYBuXh6/R0nmj1AKVn0U0NNgiI2CZVPRRbYEUSkDhh920fEHjbTK+x4VQd2UBiZtp1Okl33c1gtJgttpXAPC5R0Z/isepInhW7/SNzosL1GwbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840141; c=relaxed/simple;
	bh=MVX4wB/pTsVcHcp4shfUHWLBFFxKmfZ0O50suqxuE6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OYEbl6mOc9uLCGbdNCbVuraY1HmXsUwsnfRGUAw5j4QSv/HIy4vS5yPv8XZzHoqvUNvOz7uorDmtsbqTMlV0CEELpG2DV4y2793mx39FbpSxmTORnM9PMs4DQxJL58r72e1an9/+9cDxcbBKXX0Mv2PYJddFRq9BnRlGVjzkAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IOCmrDLI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IOCmrDLI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C99AA288F8;
	Thu,  7 Mar 2024 14:35:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MVX4wB/pTsVcHcp4shfUHWLBFFxKmfZ0O50suq
	xuE6k=; b=IOCmrDLIHFrmoFBIuYutPDuD11Sgcr1ahaOHNukbn4verD5XZEnpJV
	yybm+BKibwtozNIUd8sWfoWBP6VBMkRm6TcO7m9dXRYnpxnzQlnPXazKcpEgSSxC
	yfzOpPslcTdiRrQBScgbOaogOUsG1wLX0j8z7W695FAIzdsyeO/n0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C1F78288F7;
	Thu,  7 Mar 2024 14:35:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B5CF288F6;
	Thu,  7 Mar 2024 14:35:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org,  Jonathan Davies <jonathan.davies@nutanix.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Denton Liu
 <liu.denton@gmail.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
In-Reply-To: <20240307183743.219951-1-flosch@nutanix.com> (Florian Schmidt's
	message of "Thu, 7 Mar 2024 18:37:38 +0000")
References: <20240307183743.219951-1-flosch@nutanix.com>
Date: Thu, 07 Mar 2024 11:35:34 -0800
Message-ID: <xmqqsf11ltrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DF071D02-DCB9-11EE-A668-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Florian Schmidt <flosch@nutanix.com> writes:

> Side remark: Since strstr() doesn't consider len, and will always search
> up to a null byte, I now wonder whether it would be safer to create a
> new strbuf that only contains the len bytes we want to operate on.

That is a valid concern in general, but does not seem to apply to
the current codebase.  Thanks for being careful.

Two of the three callers of wt_status_locate_end() feed the pointer
into a piece of memory that is owned by strbuf, which guarantees
that the memory has an extra NUL to terminate it as a string even if
you did

	strbuf buf = STRBUF_INIT;
	strbuf_addch(&buf, 'A');

The other one is in commit.c:ignored_log_message_bytes() that still
takes <buf, len> as input, but again, two of its three callers call
it with a pointer that points at the beginning of memory held by an
instance of strbuf.

That leaves us trailer.c:find_end_of_log_message() the only one to
worry about, but it uses strlen() on the pointer before calling
ignored_log_message_bytes() so the region of the memory pointed at
by the pointer is assumed to be NUL-terminated already, and
presumably (I didn't follow the logic there too closely) the length
is also computed within that NUL-terminated string.


