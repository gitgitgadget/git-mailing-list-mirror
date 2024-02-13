Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649061662
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857979; cv=none; b=QKBz5crxO6KiUVe0zT62QmWKsUX7j8nqEUVyRTzJ8HzPnY8J36MJKJQCYrz0gpu6lQXVuznQWqd1YYcsTGHk8tLJenNKp74Wi6wawmL9xLvI1BTp3oaL9x4AV/lWni4pHHVlSkbIOh01RXH4nYW8HvcGR3+kFqQCaruFQESuHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857979; c=relaxed/simple;
	bh=Bz+65eNc1nU18IOpLYxzdOygnCfB866a7KRFPs5MCm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QOROWOeBXWv89q1oT90x4wNqnu8EkDDg6rgzRFBldKiZA97As2n3HBwEdOg0Y2Tf6kgxDiefsMgM3D1x3zzj21V7V/1rblXrKewpiVrUwOcZVmJ/LU0DK6DqM5wcxBEG1CpUoAp+rXmzVLBS+ADZzEwVrApeSs4fFj3HUCUBd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IE3JcFbc; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IE3JcFbc"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3316D1A13A;
	Tue, 13 Feb 2024 15:59:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Bz+65eNc1nU18IOpLYxzdOygnCfB866a7KRFPs
	5MCm0=; b=IE3JcFbcN9XdaTM7il0vcaZrRB5JbcetQNzTJ+BiMZkzUhWME92VrH
	pp9tslDZ9SDOBivxNaoFAIg4l48DazPPQJvIj2BdOBCsnsG/WC1axutKiSApfwx4
	WIuTt+bv0B5M4irnMCfED3zGaQLSJ9DXD4BKJPCeh8dWvVpaNKEa4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BB571A139;
	Tue, 13 Feb 2024 15:59:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C75621A138;
	Tue, 13 Feb 2024 15:59:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] column: guard against negative padding
In-Reply-To: <6446a48c-4b9a-4095-9083-071f95ce3b84@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 13 Feb 2024 21:35:44 +0100")
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
	<cover.1707839454.git.code@khaugsbakk.name>
	<9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
	<xmqqcyt08fa1.fsf@gitster.g>
	<69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
	<xmqqle7o5f34.fsf@gitster.g>
	<b9ca1ab7-f8f6-4fe0-885a-51728d9ec708@gmail.com>
	<6446a48c-4b9a-4095-9083-071f95ce3b84@app.fastmail.com>
Date: Tue, 13 Feb 2024 12:59:32 -0800
Message-ID: <xmqqjzn83wsr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CA13023A-CAB2-11EE-9637-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> (All I know is that it can be tricky balancing such defensive checks
> with readability and maintanability.)

Personally I think v3 is a good enough place to stop and we are now
entering into the realm of diminishing returns.

Thanks.
