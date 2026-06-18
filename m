Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC117D6
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781756502; cv=none; b=KHtZE+jbhUFuK1bdGqYjq7gHIXDzMws3eWO4W/PoxDo0T+GHxcj0GQAFDl4eTy4EV9PGgw3twxGpjWQp+w9ZsPrbik7EtKKU7lqj3dZnz8ZdrPWQkHeE8mo87z9trLLabch2TcRJKHXqkZvylbKyRMWNIyijt61p+xBMPGoteTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781756502; c=relaxed/simple;
	bh=ZuuTOvhh9u7pmUB4gt6Y4+WCcTwyoMsNoA74DvdkD8U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=MaBeNQUvecpHDMoiKJmv9Z0N1HeTrIl4YQeF95S9mir28+UBlX7vVNwZ0v+z6NI6CR49/ynXBDiUFUpZssLZT3GHLYyqwzinAyWyuHmjuTU3f4caZqsp5e1bq3AU8eh1anIPpCvzubkuhkdWy2Bor6nJuSYyHeah1gYpuw623+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=CYETq+NC; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="CYETq+NC"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 1A49B60041;
	Thu, 18 Jun 2026 04:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781756494; bh=ZuuTOvhh9u7pmUB4gt6Y4+WCcTwyoMsNoA74DvdkD8U=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=CYETq+NCBb1taKYihZg8vJuDFLs+akLTScFgBFAdaGt5gIVU3i2AzfrUafQDiJkdr
	 TvV8QL16bS+RC10osGlpOXfEows93obtXkX7VF/7mv2oP8Kcubr2YIESW09rNeIJzP
	 CmledoOiyTPJvZ8h9Oz+MF1gGljmA/lSrJkk496M=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 00:21:33 -0400
Message-Id: <DJBVYP58YNTU.LQ7VXFIQE84H@lfurio.us>
Cc: <git@vger.kernel.org>, "Bence Ferdinandy" <bence@ferdinandy.com>, "Jeff
 King" <peff@peff.net>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH v2 0/7] Introduce fetch.followRemoteHEAD config variable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260616222606.1003521-1-m@lfurio.us> <xmqqh5n213bw.fsf@gitster.g>
 <xmqqcxxp1j2t.fsf@gitster.g>
In-Reply-To: <xmqqcxxp1j2t.fsf@gitster.g>

On Wed Jun 17, 2026 at 7:51 AM EDT, Junio C Hamano wrote:
>>
>> Ideally,
>>
>>  (1) If the "fetch" operation ends up with not needing to consult
>>      the value of fetch.followRemoteHEAD at all (e.g., it is a
>>      one-shot fetch that updates no remote-tracking hierarchy, or it
>>      has a more specific per-remote setting that this variable is
>>      meant to serve as a mere fallback), any bogus or unknown value
>>      will not get any warning.
>>
>>  (2) If fetch.followRemoteHEAD ends up being _used_, and if it has
>>      an unknown value, we should at least warn "we do not understand
>>      what you wrote, 'awlays', and we ignore it", or die "we do not
>>      understand 'reset', perhaps it is from a future version of Git?".

This explanation makes much more sense to me than what you said in your
response to the first iteration.  I believe I understand your vision
better here.

>>
>> I do not think customization based on git_config() callback like the
>> above can easily implement such an ideal semantics.
>>
>> And I suspect that the existing per-remote configuration that this
>> variable is meant to serve as a fallback definition would not work
>> in such an ideal way (i.e., even if we are doing one-shot fetch that
>> does not touch any remote-tracking hierarchies, "git fetch" may warn
>> if the value is not understood, and when we do need the value, the
>> code would only warn and does not die), ...

Right.  It seems like the design of the config callback mechanism
doesn't work well for the dynamic behavior described in your ideal case.

I've tried to test out a few ideas to make it work, and each one so far
ends up feeling hacky very quickly.

>
> Having said all that, I do not think it is a blocker for this series
> that it does not take us into the more ideal direction and still
> makes a syntax check on a value that will not be used and complains
> to the user.  We may want an in-code NEEDSWORK comment to hint
> future developers that they may want to revamp both of the code
> paths for fetch.followRemoteHEAD and remote.*.followremotehead not
> to complain when the values are unneeded and die when the unrecognized
> value is needed to continue, though.

Personally, even in the case where we can disregard any and all
followRemoteHEAD settings on a one-shot fetch, I don't think die()-ing
on an unrecognized value should be the course of action.

As you pointed out in your last response to this topic, a future git
release may implement additional choices for followRemoteHEAD.  If a
user opts in to this new functionality, but finds themself using an
older version of git (for whatever reason), I would still expect the
fetch operation to continue, just using different semantics for
followRemoteHEAD.

In fact, the better behavior might be to fall to "never" if the user
asks to do something we don't understand.  In this case, we just emit
the warning, continue with fetch, but followRemoteHEAD does nothing -
not even create a missing ref.

>
> Other than that, this looks excellent.  Thanks.

Thanks for the great feedback and consideration!

If you like, I can apply the appropriate NEEDSWORK comment, possibly add
a warning to 'fetch.followRemoteHEAD' parsing (matching the 'remote'
side), and we can call this good to go for now.
