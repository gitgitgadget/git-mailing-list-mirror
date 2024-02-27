Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD58161
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708992758; cv=none; b=csgEnOu8uiSgq5YKzJnkrT1p0G44jLncgY11+BF/b69SM3jPjm63IfiKNvHkaIjmgzQL5nvA0QmlSEgoDJx3dGDLUsQDHIBT4GN9ghWYX/4LStPAzRsTdSu3+EO5wq9aI9EXr1/YxrJA7QJxddHISzeiXjJ/eHxp9DBCJLj/BrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708992758; c=relaxed/simple;
	bh=vPjMR2TOyW4CAyTl+lWzjrNZNiDSP8PCt8RjdW77WIw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nhjdEG3Uy+IUXMn0T0mW3p4b+1I8Evr4mA3TmThBWTZrNA/sGkAtj45vvRbOk04yg4iyyN5uTPsrDXNO6mpe2nyxJ1/01rks+ZYitWlaQd2HkJiVRKgZZNtmSIxHuh1d2OxT48tu55OOYYXtS/+HKGATArOmgj+hzfu0h4VTw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41R0CT9k2242632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 00:12:29 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>, <git@vger.kernel.org>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>	<20240226220539.3494-2-randall.becker@nexbridge.ca>	<Zd0S7aUIG1bhGkaX@nand.local>	<026b01da6906$4d96f530$e8c4df90$@nexbridge.com> <xmqqa5nmkcuz.fsf@gitster.g>
In-Reply-To: <xmqqa5nmkcuz.fsf@gitster.g>
Subject: RE: [PATCH v1 1/4] builtin/index-pack.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 19:12:24 -0500
Organization: Nexbridge Inc.
Message-ID: <027001da6911$a727b9d0$f5772d70$@nexbridge.com>
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
Thread-Index: AQFCEXZVVjijNd8r2UxZXOALnJerBgHno3IKAhKWxEIA4b1XvAJWtuGWshRqe8A=

On Monday, February 26, 2024 6:47 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>The code above loops while input_len is non-zero, and correctly
>>>decrements it by the number of bytes written by xwrite() after each
>>>iteration.
>>>
>>>Assuming that xwrite()/write(2) works how I think it does on NonStop,
>>>I'm not sure I understand why this change is necessary.
>>
>> NonStop has a limited SSIZE_MAX. xwrite only handles that much so
>> anything beyond that gets dropped (not in the above code but in other
>> builtins)
>
>xwrite() caps a single write attempt to MAX_IO_SIZE and can return a
short-write, so anything beyound MAX_IO_SIZE will not even be
>sent to the underlying write(2).  There is a heuristic based on the value
of SSIZE_MAX to define MAX_IO_SIZE in <git-compat-util.h>,
>and if the value given by that heuristics is too large for your platform,
you can tweak your own MAX_IO_SIZE (see the comments in
>that header file).
>
>The caller of xwrite() must be prepared to see a write return with value
less than the length it used to call the function, either because
>of this MAX_IO_SIZE cut-off, or because of the underlying
>write(2) returning after a short write.  As long as the caller is prepared,
like Taylor pointed out, I am not sure why you'd need to change
>it.

I understand. I was involved in xwrite() a few years ago. The problem is
that users of xwrite() did not account for that and t7704.9 failed as a
result. These changes did fix the issue. I am not sure how to proceed based
on the above, however. Continue or recode the callers (which is part of what
this does)?

