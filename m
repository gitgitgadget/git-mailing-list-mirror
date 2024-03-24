Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C97F9
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711275403; cv=none; b=F3bgaqnHMUN00skjirlibvyBaiq5b2Nv5443YtamZxkI+BHGHVmKg8VzqBIDzc/qDF/Gz06N+w+Y16ztem/7sCCfQ4xl9xP13TPfMMLw3/1NgoaWIPr88pMtG6H/wt9iXSzK5eQE9jguO0jICdg70PsLxeCceD4E9rcra0S9Y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711275403; c=relaxed/simple;
	bh=d34MWHyRzNAGNKdfgZY58bEN/U2d7/8FyvFS7i97HIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0h6AVV4RfKPiK8xipERWHRa/tzUkmxy42jwpRwUiYg4s0dwYMTRPEPbS5aOBSxPApcdxJjrQscXKKU2bueLthFBOT6si9jNXHrxyPvqulvNYnQ96ScvLW2vBu8c8HIPDk1dJWrZWlnazU8NZXeIK6X8t/ADMKHmdYPCBNyKhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=p6tkl/fi; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="p6tkl/fi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1711275397;
	bh=G/gd5AOJHBALctz/moTEwKPklC0LzdlEmZSQ1RzPKT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p6tkl/filTeF40Rz1tLjnkjd0x+Dtc/Q5UFb28a8GcNQsmEZ3RYtWtbtKIIB1OjBm
	 APM9rHj6shMUoLnxcPwzzf8/qQbu94HoTkYnDIi/OUTOb15Bf9S/YFl81hDccaHOXf
	 xmt6ZUUtP184OD9XbJ9zDO6FEduOrbpR3xLropaMchROeYtsTnDYPIgXtXRdKnV8R+
	 xfhuEjz8eEbQ8+EW0x7+HAiCtytsQDYYxoRQDbmzOkC+XQ0b0t936T0w0vIBZAAg12
	 MyrBPmkijtcJsSDaZa0bt8PWJKof4cfrPFPOugQpsIsCz2N4JCu0DB+fTQCdJbY0yS
	 YSl7qAST3yhXQ==
Received: from [192.168.42.22] (29-99-142-46.pool.kielnet.net [46.142.99.29])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 3FA483C177F;
	Sun, 24 Mar 2024 11:16:37 +0100 (CET)
Message-ID: <e896da79-c87b-4475-9890-10051d8ddf76@haller-berlin.de>
Date: Sun, 24 Mar 2024 11:16:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow git bisect to auto-skip
Content-Language: de-DE, en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, git@vger.kernel.org
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
 <xmqqwmptzyny.fsf@gitster.g>
 <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
 <xmqqle68x008.fsf@gitster.g>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqle68x008.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 23.03.24 19:43, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>> On 22.03.24 23:31, Junio C Hamano wrote:
>>> It often is discovered that a commit
>>> breaks bisection after the fact and it is not feasible to rebase
>>> all the history after the commit.
>>
>> This reminds me of a similar problem with git blame, for which we have
>> the blame.ignoreRevsFile config to work around it. Couldn't there be a
>> similar mechanism for bisect, e.g. bisect.skipRevsFile?
> 
> A Very good point.  If a breakage of a commit is "this does not even
> build" kind of breakage, such a mechanism would be an excellent fit.
> 
> But if a breakage is "only this particular test fails and we know
> the reason why it fails has nothing to do with the bug we are
> chasing", then compiling such a fixed list of commits, or pointing
> at such a list with a configuration variable, would not work very
> well, I am afraid.

That's true, but the same can be said about blame.ignoreRevsFile. There
may be commits that contain both uninteresting whitespace changes and
real changes (not in a well-maintained project of course :-), so it
wouldn't be a good idea to add those to blame.ignoreRevsFile. But that's
not a reason not to offer the feature at all.

-Stefan
