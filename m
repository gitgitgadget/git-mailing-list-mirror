Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AF2AEF1
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852877; cv=none; b=pmuaO+0VzE9qOQ7uTPQulTkGCzGyzhYNpQ0JLk5cyA+bxiULFDrCwdDw9+Byb19HN8WCmfpQQnvAAvKZLq+kaBViqbygA/cW9Z4f2+GpBIhkIXZHgE+ERzPLlkaD2PcQfnccbqox7/2d6ZIF7/SL04xa+89RDaMMzS2IKzpkXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852877; c=relaxed/simple;
	bh=6ycEwPwDytEL+HKeItH/gee6EGpxAMN+W9Dm5AiSFAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjjB6b1XQodvPAKU6ApTTssIXCtcJUCzXDC2t3yHQkqN3GA1C4dooe1BsJO0Y9RJlOzdD/L0IZ39X6T2+/M1Qx1CWhBeQy2SYhuqQFWPrB1/2OES/cbXpndrD2zLlDKrYPJE2Q5GKyY4X+zFDyik8afk1FXp2eZ11vFTjH8bOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MbDjZXaj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MbDjZXaj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBEA41C375;
	Fri, 20 Sep 2024 13:21:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6ycEwPwDytEL+HKeItH/gee6EGpxAMN+W9Dm5A
	iSFAs=; b=MbDjZXaj2yIFn63ZbbeCh+lCXnRTB9h8TdTTt5Hb1opcTgx3GEX0CY
	0Brh4ZNBEn3xWCsuCuI1SdHCrkriK2OrxySPPn+gcTnQumTvUvAdQofmdOFAVIob
	PuuB4c2cXkYH5SI8j2P+VLIVICa03Fpy4oU3g/TQrjr2K7aN3t1Sk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E35271C374;
	Fri, 20 Sep 2024 13:21:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50A101C373;
	Fri, 20 Sep 2024 13:21:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/23] parse-options: free previous value of
 `OPTION_FILENAME`
In-Reply-To: <330b6c52a0a99ba8fa18378310250e5b617d40c2.1726484308.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 13:45:59 +0200")
References: <cover.1726484308.git.ps@pks.im>
	<330b6c52a0a99ba8fa18378310250e5b617d40c2.1726484308.git.ps@pks.im>
Date: Fri, 20 Sep 2024 10:21:13 -0700
Message-ID: <xmqqy13m2qd2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD0D3FDC-7774-11EF-9A64-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `OPTION_FILENAME` option always assigns either an allocated string
> or `NULL` to the value. In case it is passed multiple times it does not
> know to free the previous value though, which causes a memory leak.

Our earlier attitude was "the user gave --filename twice from the
command line, fully knowing that the last one wins rule will make
the earlier one have no effect; not worth worrying about".

But defining the memory ownership rules and make sure the
library-ish part of the codebase honors these rules is absolutely
the right thing to do.

We saw earlier that OPT_PASSTHRU correctly frees the original value
before assigning the new value, and this makes OPT_FILENAME do the
same thing.  Nice.
