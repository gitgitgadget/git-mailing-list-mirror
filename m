Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857114B07A
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725666331; cv=none; b=vBF45BvhEXU2tnMHrwwCdu+h8gOPYZJeahZC7N+CuRW+FvJKK+Z3INRRsT5Hfs2axMpad5loi6h+vmBF72wePTH0bcVX7dpWIOaEnDRbg3mbTKywomGf7kMgtyIpb7ten3uNdiYcTIxrXxvv3qd8fTaSLCzthtP5tgBOTSWGap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725666331; c=relaxed/simple;
	bh=6t6cspPC6tKvTnW4SBkwzpYb4CRL0rjNRlztUu6TC3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sm1VwWw54Qzh79J7rOY8h0z/cmpqae0cPHyBW3RmESfBmmyvZYV1/CehZSQRRHoJ32cwa1zSg+5ZamS+d/FlnMhq+SsoYCNIOlG6N7gKtBnQF/sKorqTJaEd93PG+XvXvrSUrBfr2iIYOQQFnq9hdmqTxdTlcoKEmKJXpawTdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ddKTDhhk; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ddKTDhhk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DC2E3BB62;
	Fri,  6 Sep 2024 19:45:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6t6cspPC6tKvTnW4SBkwzpYb4CRL0rjNRlztUu
	6TC3Y=; b=ddKTDhhk6hEZwLXEqi/hxkslE19K+Cbc4Wzbvvc4zpYCCBRZ5j8yu5
	2Wv8/axWj7X7zsksLLQeyKiaiCZQzUPrK1ZukdswRbNMuDCPHM8a20XFm7+cVDc5
	cg2uoJwPO8PaXwDnSBMVDDFWjjlG9mJPp6JJTAz+L2hEL4ZJginis=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7305C3BB61;
	Fri,  6 Sep 2024 19:45:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D945A3BB60;
	Fri,  6 Sep 2024 19:45:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net,  Jason@zx2c4.com,
  dsimic@manjaro.org
Subject: Re: [PATCH v3 3/6] libgit-sys: add repo initialization and config
 access
In-Reply-To: <20240906222116.270196-3-calvinwan@google.com> (Calvin Wan's
	message of "Fri, 6 Sep 2024 22:21:13 +0000")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-3-calvinwan@google.com>
Date: Fri, 06 Sep 2024 16:45:21 -0700
Message-ID: <xmqq8qw4uz1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1549054E-6CAA-11EF-B47B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> Wrap a few repo setup and config access functions in libgit-sys. These
> were selected as proof-of-concept items to show that we can access local
> config from Rust.
>
> Co-authored-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Change-Id: I6dd886af8c63e1f0f3251064cd8903aecdf768bb
> ---


Common to all other steps, I suspect that you meant to but forgot to
strip out the Change-Id: thing here?

Also there are a few whitespace breakages in this step.

Applying: libgit-sys: add repo initialization and config access
.git/rebase-apply/patch:129: trailing whitespace.
         * for the existence of a key rather than a specific value
.git/rebase-apply/patch:138: trailing whitespace.
        unsafe {
.git/rebase-apply/patch:143: trailing whitespace.
        unsafe {
warning: 3 lines add whitespace errors.


There is another one in a later step.

Applying: libgit: add higher-level libgit crate
.git/rebase-apply/patch:325: trailing whitespace.
        // ConfigSet retrieves correct value
warning: 1 line adds whitespace errors.

