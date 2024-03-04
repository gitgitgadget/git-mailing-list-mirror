Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A84D9FF
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569065; cv=none; b=aBRg7iaHipZ8lVTEdNlNVe7Ad/RkCdmRV1A3qAsGfDwYNaAcP2bciwS1lzUi05KIG8huEpJfHAu0IT8ZeBlOnLprSZliCM0wM5+NJDay34d3zlm3LTU3czdkWLY0ykOWF5W5IQkGD8wjIUUNoLGrG14HpQehQ4XKR2LiQ08rbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569065; c=relaxed/simple;
	bh=s7kWIPsVla+GJO6fNph/h0LGHr20xbk4Ae14KgUo5mU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bAVmU360fz3YUu1Ij7pqsQdsfXHR0Rdil7Mig+9Q1g24bG70+Zpg6aV6nYbF18yjzQM8j6QZSJEPM2GkY8BidiuVBarRPNGMurzz7NMsqHtNQME0pRmQprhmpYYooD1FYAHtXmaNr8WtOJYtz8SrclJforat9w2+3Rknz4WyGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uOXETbkc; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uOXETbkc"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93C211F2736;
	Mon,  4 Mar 2024 11:17:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s7kWIPsVla+GJO6fNph/h0LGHr20xbk4Ae14Kg
	Uo5mU=; b=uOXETbkc7IPvQyYMYIYjcSNBY0vk/g4lqm/g5XQ7c+OgTOFzRzQUKn
	4DpnhWKzcGmEeNOP0DNTGTBfTLG5Fb4CbJsWYWdNnXImRGIdfk7V+ZYqr2zqXF/Y
	K256HHARQ42AMcYSs9Qz/vgdRmyt9jCiRItiqO/ieG9l8A6G7Bc3s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BFDD1F2735;
	Mon,  4 Mar 2024 11:17:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE6C21F2734;
	Mon,  4 Mar 2024 11:17:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] builtin/clone: allow remote helpers to detect repo
In-Reply-To: <ZeVt0CAfpYFZqT2i@tanuki> (Patrick Steinhardt's message of "Mon,
	4 Mar 2024 07:44:32 +0100")
References: <cover.1709041721.git.ps@pks.im>
	<9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.im>
	<xmqqle75ppa3.fsf@gitster.g> <ZeVt0CAfpYFZqT2i@tanuki>
Date: Mon, 04 Mar 2024 08:17:33 -0800
Message-ID: <xmqqbk7urmxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B5EC97A4-DA42-11EE-8F35-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > +	 * Git commands. To do so, we:
>> > +	 *
>> > +	 *   - Create an invalid HEAD ref pointing at "refs/heads/.invalid".
>> > +	 *
>> > +	 *   - Create the "refs/" directory.
>> > +	 *
>> > +	 *   - Set up the ref storage format and repository version as
>> > +	 *     required.
>> 
>> "as required" by whom and in what way?  
>> 
>> "The code to recognize a repository requires them to be set already,
>> but they do not have to be the real value---we just assign random
>> valid values for now, let remote helper do its work and then set the
>> real values after they are done" would be a plausible interpretation
>> of the above.  Is that what is going on?
>
> Partially. While we cannot yet determine the object format, we do know
> the ref storage format as it is specified by the caller when invoking
> git-clone(1) with the `--ref-format=` switch, not by the remote repo.
> In that case, we'd have to set up the ref format accordingly and also
> set the repository version to "1".

Ah, of course.  Unlike the object format, we do not say "the other
end uses reftable, so we should do the same" and we do not have to,
thanks to some artificial limitations added to the reftable backend
not to exceed the expressiveness of the files backend.

Thanks.
