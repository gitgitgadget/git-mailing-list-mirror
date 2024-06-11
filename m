Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2697155A5C
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149989; cv=none; b=FelDjY680CbonI+RfZF5bjPgT4IuZ7kf4KO4+CFA7Tj/q9mfMBlcI5a2fdXeYLxX2iuXRIMR7SgQzg4soakRVBY8GFW2wozkazn9qPbhSj36tG5kmK/4D9UUEBf75SP9Ld8UtT7yLBMyD8qgQGeSSkBGreNDIxMcaSzUDDFpcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149989; c=relaxed/simple;
	bh=GdRgAYH9e1ubu+KoCsXoQHnLIk/SuAiKIRXFZu+olVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RqGN4JdGj3VHCymBXNB+LC12AYGIeOZMkpJj/spmdf9zNocD6gWdo9VCePyG9r7ZMy5c+CvRlSiTYLZlv9tE7OlxCppTt+70hpt1hlQx5Ofs3JCpX4JLuZ63VvVOyCpWWvLXdgqkZQlvOxkX9mbOu04NEhFI04DcxjHv+iXQWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bjltYEfl; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bjltYEfl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AE4021AB22;
	Tue, 11 Jun 2024 19:53:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GdRgAYH9e1ubu+KoCsXoQHnLIk/SuAiKIRXFZu
	+olVA=; b=bjltYEfloYEJB4IeIk+JOQQBPN5JPCRw/j2WPz3E2alUdP3mqa2tCM
	blZxxd+6ZQu5CIH3nJ48FTOttIEzKj4rPyOGZPMvXPqnvhMXOZr0HcFi8xsX5XYE
	hSo8S9oPrJyPsGAdR70zBrPImCNYvcK5wO86glMU5c+RnZ5Hzp7Fw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A68D41AB21;
	Tue, 11 Jun 2024 19:53:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5965C1AB1C;
	Tue, 11 Jun 2024 19:52:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'darcy via GitGitGadget'" <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  "'darcy'" <acednes@gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
In-Reply-To: <114401dabc5a$08a72060$19f56120$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 11 Jun 2024 19:49:37
	-0400")
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	<pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
	<xmqq1q58ejnw.fsf@gitster.g> <xmqqtthzrraw.fsf@gitster.g>
	<114401dabc5a$08a72060$19f56120$@nexbridge.com>
Date: Tue, 11 Jun 2024 16:52:56 -0700
Message-ID: <xmqqjzivrq93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BAD3D51C-284D-11EF-930D-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

<rsbecker@nexbridge.com> writes:

>>Also, as you can see at one of the GitHub CI jobs, e.g.,
>>
>>
>> https://github.com/git/git/actions/runs/9455916669/job/26046731619#step:6:1915
>>
> Does this imply that timestamp tests will fail on 32-bit systems? I am
> unsure how to interpret this. Can you please clarify?

Sorry, but I have nothing more to clarify than what appears in the
quoted CI log.
