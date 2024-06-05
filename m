Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9F107B6
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608786; cv=none; b=fTJAq5pLgrh36eUT35TPPQMpFKA549P2zTS+egnFEcUgFPwcvsheAfivxqNnhIMtKO/oEHCPprbmc9fL1viDuGvpVhPmEVjOys49pbHVpz+1vMypklFQAj3NV6wOSg5hp5LNC7um5YEDgBeWJOjsZ5OfSHiuRxxRnChvenPUnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608786; c=relaxed/simple;
	bh=ZIFLuGtJw8H1RSdimIUiFjmgnlkef5HsCkSpBEpeCwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WMP2J5MiVDzR8bIegesixLxniubwM9VkesmerQY2oQEEy6gbh17pkfTpOvb0oYJiMR0vxGx/VpQ7a04FbTJSiyxehf7a0J8L3gWtlHajUn7Y6S51QcjhZcnWqyTA6MLHerAV/MhGrOlqRJLkrmYVex39ZKfTJQmniUqgUPI3ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AOd5H0xo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AOd5H0xo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C1731E891;
	Wed,  5 Jun 2024 13:33:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZIFLuGtJw8H1RSdimIUiFjmgnlkef5HsCkSpBE
	peCwI=; b=AOd5H0xoylspZ3auayM4DUl5KWrNYJDNmkVVa7G4iXgu4GRriPHJ2L
	O7IxQuq/RNPgvikxx/XYmBOFzqbQydne9865ZqMikACjXXtmSdJCUCaXRuq/LOhd
	EIrAxzYh02QJ51suKCTCIsS9Ss3CrPxZzMMQvA9pxh55NRzfGlYg8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D12381E890;
	Wed,  5 Jun 2024 13:33:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0BB61E88F;
	Wed,  5 Jun 2024 13:32:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Danoloan <danolo@danoloan.es>
Cc: git@vger.kernel.org
Subject: Re: Git submodule recursive update not syncing submodule URLs makes
 the operation fail for commits updating the URLs
In-Reply-To: <7869f213fe59fa80b9e8331dde89e795bd8cd5d4.camel@danoloan.es>
	(Danoloan's message of "Wed, 05 Jun 2024 16:02:10 +0200")
References: <7869f213fe59fa80b9e8331dde89e795bd8cd5d4.camel@danoloan.es>
Date: Wed, 05 Jun 2024 10:32:58 -0700
Message-ID: <xmqqtti7s3at.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A76B6C56-2361-11EF-BBBF-6488940A682E-77302942!pb-smtp2.pobox.com

Danoloan <danolo@danoloan.es> writes:

> the old one. This is typical when the new URL may be a fork or a mirror
> in another server.

Isn't the flip side of the same coin that you can sneak in a change
to .gitmodules in the superproject ("hey I have this neat fork of
the superproject at this other URL, please pull from me"), so that
it points at a malicious URL?  If the end-user is not given a chance
to inspect where the URL moved to and agree (or disagree) to switch
to that other URL, your "recursive" update will end up fetching from
an unverified URL into the submodule without anybody watching, no?

So, I suspect that it is working as a security measure that it does
not blindly sync.

Yes "git clone --recursive" may be looser, but I would actually
consider use of "--recursive" there as a security lapse.
