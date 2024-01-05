Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291C2E833
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MPzXU9TV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 42C95264BF;
	Fri,  5 Jan 2024 11:19:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KFjlfxNYJI+Gt12WIVsMNr9A6zbm16VDmYVytx
	K88qY=; b=MPzXU9TVV0iMr8VQM/cPp/wm+5Gi68rJOoKFVrYTweDYMMW5a9+gZP
	ZY64ymG0sKknM+YnYkYMb/3wvh13i0jaF4QCJkGtPEiOjDsvzIkZgI6mECTvd229
	D/kZjpwKbpR9MC9RWrE/BL0GqL1+VnY7b1Mngcehh96eKGQiEjR0Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CAF7264BE;
	Fri,  5 Jan 2024 11:19:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDEE6264B8;
	Fri,  5 Jan 2024 11:18:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sam Delmerico <delmerico@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com
Subject: Re: [PATCH] push: region_leave trace for negotiate_using_fetch
In-Reply-To: <CAHVcGPSSJr7L_NyFSKEkEywBap6hUrucga98RLpa6xuZ0k4CzA@mail.gmail.com>
	(Sam Delmerico's message of "Thu, 4 Jan 2024 17:12:15 -0800")
References: <20240103224054.1940209-1-delmerico@google.com>
	<xmqqbka27zu9.fsf@gitster.g>
	<CAHVcGPSSJr7L_NyFSKEkEywBap6hUrucga98RLpa6xuZ0k4CzA@mail.gmail.com>
Date: Fri, 05 Jan 2024 08:18:57 -0800
Message-ID: <xmqq4jfrpxce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 218A2FDE-ABE6-11EE-9000-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Sam Delmerico <delmerico@google.com> writes:

> * I don't exactly remember how I noticed it. I was doing some
> debugging around the push negotiation code and either 1) saw this
> region get entered twice in the trace output, or 2) I was just reading
> the code around here and saw two enters.
>
> * Perhaps there could be a check before the last git process ends that
> checks that all opened trace regions have been closed? I'm not sure
> how much work this would involve. It's probably also not a very
> proactive way to catch these bugs since it would only get triggered
> when a *user* hits a code path with a trace region that never exits.
>
> * There could also be a test that checks that every region_enter trace
> log has a corresponding region_leave. But I'm not sure how to ensure
> that every code path is checked.
>
> Overall, I'm not sure how much benefit there is from checking for
> this. I'm not sure that it would have a large impact if it were to
> happen again. For example, I think that it could be noticed relatively
> quickly by a person/system looking at metrics like I was (e.g. if the
> time spent in a region is infinite or zero).
>
> FWIW I didn't see any other examples of this when going through logs.

The above matches my intuition.  A test that covers this specific
case would likely be of low value as it is unlikely for us to
regress this specific one.  A CI job that runs all the tests under
tracing and inspects the log may catch some but its finding would be
limited to the code paths that are covered (but increasing the test
coverage would help here, not just for finding unbalanced region
markers, but for finding bugs in general).

Thanks.
