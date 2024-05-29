Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC821B960
	for <git@vger.kernel.org>; Wed, 29 May 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016118; cv=none; b=djaBCMQDzu4GJ93VLT0l2/7aufWgIpaPu0otBK0E2Ph/lbnFeErBsv8qrGEWnGIadNupTXeOPSaht22gLc5LEPXbzulU6LqNthMtnT8ws67QAVu6cR+IAF/ImcWpxu8qG4dqAsWIrTpfhllWyIIWKEL3GVugzdCR1MHAwQ92WgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016118; c=relaxed/simple;
	bh=o7pmi2jVSY0dSx5ENxkbZq7HdG/zcVq8RnxBmc4Jqaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZAzuic+LYWySl8llKjSS5M+HL2NJCDYlGEMivjMKW8FOl/os2aomBAVgg3ihLiGYR6sL54PbdXBmSfcuy4ZzG2Z+KEgypd7KuenxfAstwz+W0AaNT0KKGovCb4Zv647Fg9C7agzCVfvqvEMaQHo+sJo57q0gVdmSX4AV1ZAuerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HaMO3CKx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HaMO3CKx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7B5B34829;
	Wed, 29 May 2024 16:55:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o7pmi2jVSY0dSx5ENxkbZq7HdG/zcVq8RnxBmc
	4Jqaw=; b=HaMO3CKxu5yG1nhFEBQzGMnsmQgEkl2hXNJxTd6LqR4lR17CB+BrlN
	BJ0EnXCPHt17kbGcPtV4UBD8CMz2ZZIWiifTTv89/YO3Cyo4x3fUK9oS6qcY7Yl+
	j48Z6MkAa+b+gb5lWJoXrP0VzIZXi3FGBHYXLd8Xhv/9JgkCysWx8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFB6F34828;
	Wed, 29 May 2024 16:55:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5371434827;
	Wed, 29 May 2024 16:55:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 16/19] imap-send: fix leaking memory in `imap_server_conf`
In-Reply-To: <357d69fa8b538baba23cd110b8d16174234a58dc.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:45:18 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<357d69fa8b538baba23cd110b8d16174234a58dc.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 13:55:13 -0700
Message-ID: <xmqqle3suymm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF342CE2-1DFD-11EF-BA0B-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We never free any of the config strings that we populate into the
> `struct imap_server_conf`. Fix this by creating a common exit path where
> we can free resources.

This is more like the previous step got rid of the anchor that made
these strings reachable, so we need to turn around to free them,
which is sort-of Meh, especially given that the leaked pieces of
memory are small and very much bounded.

The main benefit of this change is to allow us prepare on the
constness change in the other (read: API this thing uses from
elsewhere) parts of the system, which is a very worthy goal.

> While at it, drop the unused variables `imap_server_conf::name` and
> `nongit_ok`.

The removal of the .name member may be correct, but I suspect the
change to nongit_ok is a change in behaviour, and it could even be a
regression.

> -	setup_git_directory_gently(&nongit_ok);
> +	setup_git_directory_gently(NULL);

The general idea behind &nongit_ok is that

 - Usually setup_git_directory_gently() dies if NULL is passed
   instead of a pointer to &nongit_ok.  Most of the Git command
   wants to make sure they have a repository to operate on, so this
   is a reasonable default behaviour.

 - Some commands would want to work also without having any
   repository, possibly with limited capability (e.g., "git apply"
   may want to work as a better "GNU patch", but obviously it cannot
   do "git apply --binary --3way" without having the object
   database).  They tell setup_git_directory_gently() not to die
   when outside a repository by passing a pointer to &nongit_ok, and
   instead tell if we are in a repository by storing 0/1 in it.

The idea is that a command that is willing to work outside a
repository can disable selected features based on what it sees in
nongit_ok.  In the case of "imap-send", there is no such features
that it needs to special case, perhaps because everything it does is
supposed to work outside a repository?

So the short version of what worries me in this change is that we
used to be able to operate without having a repository at all, but
now we would barf if run outside a repository, no?

Thanks.
