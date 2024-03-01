Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BFB4C9C
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317835; cv=none; b=qy5Cew8S1NXo+Y+gDy+IwAyvbVSGzMLYipLh/GPJ/lBMFJBlWwpxOsLIvpUiHZYngJc318gqI4/gHUA35W+G6jVCV86fXt36SBJDjCsHkr6RA38VPTdWTnDl+B13O3eYxJrtKApKLmCNDD37y7caFquWsHBEZG6wvNAddmGZWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317835; c=relaxed/simple;
	bh=iuoj4TwlEgawtD3RPUVncOnRZEPnqrTlsyDT4D7TaOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qX5r+GNR/L1uLEEv7HUezPWd85Feo5KQAwZh2O5BL7YgR9bOsG2O4FpfpXa9g2qpwg7oG4LVGPLqfts4fjzHOoTbvxPWwX2FhAa76INvms6S3mCYibltGFngGQiDBJR9n7jD84HpmT8UUj603x/Xy3Ps5bRw6uZPsM+5hYu0/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QohdLFe1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QohdLFe1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B3911D8173;
	Fri,  1 Mar 2024 13:30:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iuoj4TwlEgawtD3RPUVncOnRZEPnqrTlsyDT4D
	7TaOQ=; b=QohdLFe1XLBtJHdPnjjhErB2CgufWhxvCb9JRVLgLyyR10aJEiKPDj
	dmkI3OyXNGDzSVEQ5AdooF5HtJ9nGZRsBincVG2yIlSh+TQvgtpDiy2k1eeh3LD8
	k9PhlIA+H4kfNfWZp6KEfxtFLU1+d75vgTCMusV0kU76AXpJP+9eg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 529DE1D8172;
	Fri,  1 Mar 2024 13:30:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBD411D8171;
	Fri,  1 Mar 2024 13:30:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc: Sergey Organov <sorganov@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
In-Reply-To: <xmqqmsrh6d2f.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	01 Mar 2024 10:07:20 -0800")
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
	<xmqqmsrh6d2f.fsf@gitster.g>
Date: Fri, 01 Mar 2024 10:30:25 -0800
Message-ID: <xmqq7cil6bzy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C63E1024-D7F9-11EE-9DD2-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Getting rid of "config_set", which was an extra variable that kept
> track of where "force" came from, does make the logic cleaner, I
> guess.  What we want to happen is that one of -i/-n/-f is required
> when clean.requireForce is *not* unset (i.e. 0 <= require_force).

Oh, noes.  require_force is unset explicitly it would be 0, so this
should have read (i.e. require_force != 0).  Sorry for a thinko.

