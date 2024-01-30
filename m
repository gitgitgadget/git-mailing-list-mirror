Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D077866A
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653819; cv=none; b=ujtZALE31msHbwjYwBgtKvJN+zyIE4PlzkAHfNNlTn0mZb06o6xiukdBEGt9UnT3jCjNMcnihIvj3TwYSN8VJEI9bQ7EYNvQe0es2uLdgiO1tpDyZRsuQ3ttjfNMiEovl1v2hhOQWSeH6ZYqaKth49064lFZJWCSdm63/YSyCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653819; c=relaxed/simple;
	bh=/QbUrhrRmcZ/K5b7YEkj/AchcqHSQj7iKnYYQWkRJ0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5JboYM+gUU4jYn7v/NtV7znK4YNKfyuu8Wl+KewYkxFY0nqNXHzJ0Ft+J4HX79X7JWux8wcY3fUtuxiqOpwbe8hxc27YU8kz5cqdFTRpY7Cx0pHx9aK3+tjxtg7f/pWsOy6IHN3fTYxIqFV7lGJu5vvsMkJ0rY99QZfashzEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uaAfwT/S; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uaAfwT/S"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E5362ADD9;
	Tue, 30 Jan 2024 17:30:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/QbUrhrRmcZ/K5b7YEkj/AchcqHSQj7iKnYYQW
	kRJ0I=; b=uaAfwT/S5YRJlEdQK2E3O8XJqoYmM7eQYsVhIKvqzE1PWW71Q6bJR+
	I0YX8yXhnMivYs+byHvA9phusCLAiGiSH2FVImAzeYkyv5KGbdy7VSk6gLGYLkJ4
	Mblv4379cCYRd8eclmiKbGkz7xDh9MEfP3H42QvOsYGUeYCvK4EuA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 766D22ADD8;
	Tue, 30 Jan 2024 17:30:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89C952ADD4;
	Tue, 30 Jan 2024 17:30:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Willem Verstraeten <willem.verstraeten@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a
 branch used elsewhere
In-Reply-To: <CAGX9RpF=tvPwiLO6UYA+uR5f2oqOLUSNaDL-jfn=T=BQ9FNtkQ@mail.gmail.com>
	(Willem Verstraeten's message of "Tue, 30 Jan 2024 13:37:26 +0100")
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
	<xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g>
	<xmqqpm01au0w.fsf_-_@gitster.g>
	<bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com>
	<xmqqwmu42ccb.fsf@gitster.g>
	<b3532261-3cf4-4666-9cbd-4ce668cd2e49@gmail.com>
	<CAGX9RpH0RJfBADQwJ=c7PCHU955vOqd0Wdc7Yi7XUuAQQW_FNQ@mail.gmail.com>
	<CAPig+cSGF+vQrnD0f99cbdpQOOC7X6ULa9tFe+FwVrG0SF4PGg@mail.gmail.com>
	<xmqqsf4c39e9.fsf@gitster.g>
	<CAGX9RpF=tvPwiLO6UYA+uR5f2oqOLUSNaDL-jfn=T=BQ9FNtkQ@mail.gmail.com>
Date: Tue, 30 Jan 2024 14:30:04 -0800
Message-ID: <xmqqeddya1zn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E767D4C-BFBF-11EE-B95F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Willem Verstraeten <willem.verstraeten@gmail.com> writes:

> Sorry for dropping out of the conversation, but I see that the changes
> landed on the master, ready for the 2.44.0 release.
>
> Thank you very much!

Thanks for your initial report that led to the update.
