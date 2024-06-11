Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D386EB74
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718148624; cv=none; b=MsTcyw2wiohSwu7ATiXzHADJzS4bKT0P/hqkf5S+S7EYj5BA6pxysMl1kdhPMoZB8Z/OgyKYk6bwcBZzyVHPdT4XLt7NiQSLvFRJdJ9D1crM+p4pUQiMVGnqaC18QFkVIYYVYEMXWhF3z3srFpwb/VBfGd8L9U30Rr3uiZBngfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718148624; c=relaxed/simple;
	bh=lnznkKt9a9Vk9eqMHvIcsmt2SC7rK5wrjkGOa8GIQ7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g53kvvg7Ji6Vf76cFADcQU1oc3c38trh+IwmkRYN/PzRE2tT3+yKvSJCvoVrl2qHhRP9wlsT6iColZrn0CEiDIBSepktc9IIWb4iU40lOFqqHtKDW3QBnMY8QUuitIczvTQSRAviPx0yXclVa9WctGaoZQitZ/asPEk1mJiHvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xZafOlBs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xZafOlBs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E49D228B2B;
	Tue, 11 Jun 2024 19:30:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lnznkKt9a9Vk9eqMHvIcsmt2SC7rK5wrjkGOa8
	GIQ7I=; b=xZafOlBsetCuQU32TiOU6OZPhltdKUVug8sFY20BlP5jMzUTllqLBw
	YYKs1PMx8NveJkuHf4ZBRQujrh6fV2j8OJXkMPO8V+eoWmNFlL2JcpdQfS4K3IwI
	t1CCGsodhiH2cUu0KNXSMZDTqbZuJPUafJfnrioLQcZ4sCwn10Ygg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD16B28B2A;
	Tue, 11 Jun 2024 19:30:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E90F728B29;
	Tue, 11 Jun 2024 19:30:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "darcy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  darcy <acednes@gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
In-Reply-To: <xmqq1q58ejnw.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	07 Jun 2024 10:40:03 -0700")
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	<pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
	<xmqq1q58ejnw.fsf@gitster.g>
Date: Tue, 11 Jun 2024 16:30:15 -0700
Message-ID: <xmqqtthzrraw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8F5D14B4-284A-11EF-93DE-C38742FD603B-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if this should be of timestamp_t type instead, as the check
> is done against *timestamp in parse_date_basic() where *timestamp is
> of type timestamp_t to match?

Also, as you can see at one of the GitHub CI jobs, e.g.,

  https://github.com/git/git/actions/runs/9455916669/job/26046731619#step:6:1915

you'd need to either exclude some "these are too large timestamps
for the system" tests from 32-bit systems or expect output on them
to be different from 64-bit systems.

As you are actively detecting the condition and giving an error
message "too large for _this_ system", I think it is a good idea
to actually do the latter, i.e. on 64-bit system make sure parsing
is done correctly, and on 32-bit system make sure you get that "too
large for this system" error.

Thanks.

