Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87517A95B
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474814; cv=none; b=b2t5hcvmtfFlwfwmlMEPeP71VWukWAzFf468B+PuXr3TOMIp36d3BSIMOOjYhnxbshW8mHEOGzH9ANP4SCG+Gax9VRqVqbstlMF+Z0tj5zd5deilp6lbmcABoQfLWEh8kBP4XZszTV2/wfzbaaogCPzMI8CkOmH55Ds5PA2G5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474814; c=relaxed/simple;
	bh=zvhBcBmXdiF9577G6bRc5w8iqvGRU2MmpCOj+ABIfic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tc9sQPl7c92OUCIN5Rx6RzumuX82c1naDWmqL0/qyLufeXPF/YFCD3mjE5VehH8ri7z0nZioVVswCRChFpy0u/D5Madv3li7ACmU4pWQzRkh9SbQryBhhJuo9GzVX94TXQ25ynRGQfD6SCBhe9+xG5zMKtS09IeffEOTlqtdJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q8qyJKJi; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q8qyJKJi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D34B82EA03;
	Tue, 26 Mar 2024 13:40:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zvhBcBmXdiF9577G6bRc5w8iqvGRU2MmpCOj+A
	BIfic=; b=Q8qyJKJiGMFXadmwdRHiz3g4MDLYV5RAAtA+sSiUCk7VVfA2cN6YIi
	tv35Y0TwYJOVk34htkAlDoIJMSVVP0sdzBNHlKHLxosAD6GU5rz5yt0/XcqlYaIY
	ajYnHyBeOPsgMEOZnkQH1vrwxAWAbGj4V0J8Ymih1gwZG6rcJG0Pw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CC5EE2EA02;
	Tue, 26 Mar 2024 13:40:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7188F2EA01;
	Tue, 26 Mar 2024 13:40:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] switch to tombstone-free khashl table
In-Reply-To: <20240325230704.262272-1-e@80x24.org> (Eric Wong's message of
	"Mon, 25 Mar 2024 23:07:00 +0000")
References: <20240325230704.262272-1-e@80x24.org>
Date: Tue, 26 Mar 2024 10:40:06 -0700
Message-ID: <xmqqy1a4ao3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E3851D24-EB97-11EE-86C1-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Wong <e@80x24.org> writes:

> The memory improvement is minor, but any memory reduction at all
> is welcome at this point.  Fortunately, this set of changes is
> unintrusive.
>
> I have some other ideas that I'll hopefully get to implement before
> swapping kills all my SSDs (see bottom).

Please describe what this topic aims at to sell the topic better.
Are we trying to reduce memory footprint?  In other words, if this
topic were to hit a released version of Git, what would the short
paragraph description for the topic in the release notes look like?

 * The khash.h hashtable implementation has been replaced with
   khashl.h that is mostly API compatible with reduced memory
   consumption, simpler insertion and a bit slower deletion.

or somesuch.

A performance oriented topic would be helped to have benchmark
numbers to show how much improvement it makes and a memory reduction
topic would be helped to have some numbers in the cover letter.  It
is OK to summarize/duplicate what appears in the proposed log
message of some step; it does not need too much text to say 100MB
total allocations reduced by 10MB or something like that, for
example.

An API improvement topic would be helped to have an example rewrite
of a caller (or just a reference to a representative one, i.e., "see
how the caller in function X gets simplified in [PATCH 04/28]") in
the cover letter.

A bugfix topic would be helped to have an end-user visible effect in
the cover letter.

Thanks.

