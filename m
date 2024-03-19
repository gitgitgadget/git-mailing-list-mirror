Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E14E405FF
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885835; cv=none; b=jlZXHFHmy9wkqLVU4KTgK7j6K0J3LWy+9bS5A2mc1vDZRbfZOg0yUd9WubB0EpfgI15ihg558y6c0HRTkGY4o93JyKSgrG765CW+F6/ww6xw8BvlC7hk7J+u0rvmpQ4Hcsqmj62Ng94O47+h9H0Z5r6bfq+UpJyQN4rsGXXzmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885835; c=relaxed/simple;
	bh=pdW8XZDnYhVo2AZNi2WBBdskBMZVeAU0yinfq0PI8C8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eh7sLMTe6VBZFEtyXKdqQfCUtaWS0p99DX0WDQou623oeuKEpDAugGJJZUjeFspi7YPw37+AZpeQ+R1C2LwyP54sw8qap1KUAtmwWK+c+jIrFlaojfQMZewbqwlx1e/oEIX4hbAFDEsmgKTShYA/+5KxjOqpcv3CoyoA214TfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42JM3BP33089513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:03:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dirk Gouders'" <dirk@gouders.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Ignacio Encinas'" <ignacio@iencinas.com>, <git@vger.kernel.org>,
        "'Jeff King'" <peff@peff.net>, "'Taylor Blau'" <me@ttaylorr.com>
References: <20240309181828.45496-1-ignacio@iencinas.com>	<20240319183722.211300-1-ignacio@iencinas.com>	<CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>	<xmqqa5mulycz.fsf@gitster.g> <ghv85hj446.fsf@gouders.net>
In-Reply-To: <ghv85hj446.fsf@gouders.net>
Subject: RE: [PATCH v3 0/2] Add hostname condition to includeIf
Date: Tue, 19 Mar 2024 18:03:05 -0400
Organization: Nexbridge Inc.
Message-ID: <02d601da7a49$3bbf1230$b33d3690$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGtFbHTdn1kVN5iPDvVZmFFSAj7tAJ4RnKbAdcT/EoCkKsPPAKng2iXsU4pSlA=

On Tuesday, March 19, 2024 5:37 PM, Dirk Gouders wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> Peff felt that adding `git config --show-hostname-for-includes` was
>>> probably overkill, but I'd argue that it is necessary to enable users
>>> to deterministically figure out the value to use in their
>>> configuration rather than having to grope around in the dark via
>>> guesswork and trial-and-error to figure out exactly what works.
>>>
>>> And the option name doesn't necessarily have to be so verbose; a
>>> shorter name, such as `git config --show-hostname` may be good enough.
>>> Implementing this option would also obviate the need to implement
>>> `test-tool xgethostname` (though, I agree with Junio that `test-tool
>>> gethostname` would have been a better, less implementation-revealing
>>> name).
>>
>> Yeah, I like that show-hostname thing (which I do not know if "config"
>> is a good home for, though).
>
>A thought when I was reading this: wouldn't it be enough to document that
`uname -n` can be used to get the hostname that should
>be used?
>
>As far as I know this should be POSIX-compliant and uses gethostname(2).

As previously pointed out, uname -n and gethostname(2) are not equivalent.
uname -n does not (depending on implementation) go to DNS while
gethostname(2) goes to DNS first (although apparently glibc may not). This
is particularly important in a multi-home situation where more than one IP
adapter has a different IP address on the same host, and where DNS does not
consider the different addresses to be equivalent (which otherwise could
cause problems for reverse lookups).
--Randall

