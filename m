Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2F181313
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777504; cv=none; b=j+mCuKR0LH/Gjjw/aBfdl9VDEc0qTBvSRHnIvtEPYAzSfJqTzHgOSuUs9t9aTCwyeh21F+j0jm4girXtWXNcyAQvr2WOYYftkAtMyzaKvKxbkNm0YJdZgyrwfqHmXMLVNDRH74jUnk3um2vdNlu4rBvzUIxHHv31+b6vYCtArWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777504; c=relaxed/simple;
	bh=OX6fNnoGzXijkbeHx1EzSwTQ+bSqLhEe1BkNr07m6P0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XNShh89vAS+9/S6uEgM48V3ejxni1JVpLiwqlSDEdHXmvCNvl5G12tMFAdJm2u+d4tzuRtuXNW1OwdbfC1Ya578yb6fgr3dy36vMOTshjxh1zTGbqNFA2brDhQkqRP3JRgowYRwqHl09T/TRqJEBdCOUShfvGb+yDQshyuLiiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CyFwXJQg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CyFwXJQg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ADC0430B04;
	Wed, 10 Apr 2024 15:31:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OX6fNnoGzXijkbeHx1EzSwTQ+bSqLhEe1BkNr0
	7m6P0=; b=CyFwXJQgpl1iDP73MoEIE/jSR0KNNh+I0EuU7OCycH2aYhZOtMPJuP
	uFo1sr2CHa64jwJFbhTg0MqW6UHKzVPjj1GHiddN+AXvP7XOgeY2Fpa0rSxumonO
	yShsCgXzTyV41saRhs2v11nJ4qvxxrbCOxXUMUFqknd94+qMo+VnA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A673030B03;
	Wed, 10 Apr 2024 15:31:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3310C30B00;
	Wed, 10 Apr 2024 15:31:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Stefan Haller <lists@haller-berlin.de>
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
In-Reply-To: <bb0dc4a7-e598-45f5-b707-e22de0890f26@schinagl.nl> (Olliver
	Schinagl's message of "Wed, 10 Apr 2024 21:22:31 +0200")
References: <20240330081026.362962-2-oliver@schinagl.nl>
	<864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
	<xmqqcyr3s3gj.fsf@gitster.g>
	<b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
	<4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
	<6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
	<d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
	<2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
	<c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com>
	<xmqqzfu3dcl1.fsf@gitster.g>
	<116dd27e-2e30-4915-a131-6c71c999fccd@schinagl.nl>
	<xmqqzfu1upty.fsf@gitster.g>
	<bb0dc4a7-e598-45f5-b707-e22de0890f26@schinagl.nl>
Date: Wed, 10 Apr 2024 12:31:37 -0700
Message-ID: <xmqqle5lrp46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F3B617C2-F770-11EE-A834-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Olliver Schinagl <oliver@schinagl.nl> writes:

> See, the hook is named 'post-checkout' and thus, it runs after
> checkout has been performed. So we are now on the 'broken' commit we
> do not want to test, git should have skipped this already, and not
> checked it out.

You are not the only user of this feature (by the way, do not call
this a "hook".  It should be per "git bisect" session) and others
may need to actually inspect their working tree state before being
able to say "nah, I do not want to test this version, please give me
another one" by exiting with 125.  That is why post-checkout is more
useful in general.  Contrasted with that, a check that happens
before the checkout is useful only in a much narrower "I can tell by
looking only at the commit object name" use case, which I would not
be interested in seeing.

Thanks.


