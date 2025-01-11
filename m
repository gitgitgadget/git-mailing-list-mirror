Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A31854
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736557285; cv=none; b=i6VORTnDf9WTb2Tz7MZlRuEtXtJtLv4iR0cXOYxK3tawWQtNAks0gtAYvenfdSEAHu1RR+R5BLwtEk96S0kh4AaVS3qNU3HQhY4iITkqABscsgY9NjTTrNgtsQH4DhU39WBvAQt77GVlBCUYQLUjHmUDv6gL4QuRZhaxNGfKBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736557285; c=relaxed/simple;
	bh=wfPdZ6h33s9NF/4cZZpEXPK2SrovzBGOIvURARGwja4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=UTsCKp8UFh8fmMDGPe5Hs7NMzXTTRTe7NqwO52m+jvrTR2a0XwxUfZSS/kSifulL/5Nq34SewTQIhw6Drbz3tlODUoWFpbzSbj/T9/cl7F/4/eg5bSENf1XFSmloxFdSjk00sEiRkfzauRa4EAW1lPRNlYSyoXHnFOqitFewDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50B11BZf2341450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 01:01:12 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc: "'M Hickford'" <mirth.hickford@gmail.com>, <git@vger.kernel.org>,
        <derrickstolee@github.com>, <stolee@gmail.com>
References: <20250110210500.675629-1-mirth.hickford@gmail.com>	<xmqqh6665p8j.fsf@gitster.g>	<Z4GZ0oiZCC2Wl3bN@tapette.crustytoothpaste.net>	<xmqqa5by5lm2.fsf@gitster.g>	<Z4G2Ze8S5PKfKjmI@tapette.crustytoothpaste.net> <xmqqv7umb2lf.fsf@gitster.g>
In-Reply-To: <xmqqv7umb2lf.fsf@gitster.g>
Subject: RE: transfer.credentialsInUrl should warn about personal access tokens in user field #leftoverbits
Date: Fri, 10 Jan 2025 20:01:06 -0500
Organization: Nexbridge Inc.
Message-ID: <01e501db63c4$4ef1a240$ecd4e6c0$@nexbridge.com>
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
Thread-Index: AQHSQkeJdJwayZiGd7YmQhUjFFLawgKT1uCzAXOweWACzNKF8wDqZKG2AcGfy52y1wCcQA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250110-6, 1/10/2025), Outbound message
X-Antivirus-Status: Clean

On January 10, 2025 7:45 PM, Junio C Hamano wrote:
>"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>>> When the former is true and the latter is false, it is an indication
>>> that for that site with the username-or-token, there wasn't anything
>>> necessary to authenticate and the access was authorized.  Which is
>>> what the original poster wants us to warn against.
>>
>> No, I don't think that will work in the general case.  Here's why.  If
>> I do `git push
>> https://bmc@git.crustytoothpaste.net/git/bmc/xyzzy.git`,
>> that uses Kerberos (Negotiate).  There's a username there to make
>> libcurl enable auth, but it's never used and a credential helper is
>> never invoked, so case 1 is true and case 2 is false.
>>
>> Now, we _could_ do that only for Basic auth, which would catch the
>> GitHub case.  However, it's _also_ possible to use TLS client
>> certificate auth (and I think Bitbucket does support that) and use the
>> username only for choosing the account (because, say, your work
>> account uses a client certificate and your personal account uses
>> something else).  There might be Basic auth sent (say, if you'd set
>> `http.proactiveAuth`), but the server would ignore it since you were
>> already authenticated via the TLS cert.  That would also make case 1
>> be true and case 2 be false.

If the use case is like mine, where someone wants to use something similar
to a PAT for creating a Pull Request, then GitHub, BitBucket, GitLab, and
AzureGit all behave in a very similar way. The PAT structure is different,
but
there is conceptual equivalence.

--Randall

>>
>> Perhaps that latter case is not worth worrying about, but it is a
>> possibility and I'm sure some people will hit it.  Maybe with a config
>> option for the advice that's okay, though.
>
>Thanks, so in short, if we really want to do this "warning", it has to look
at the
>"username" string and "guess" that it is something the user does not want
to have
>as a value to remote.*.url field X-<.
>
>So "should warn" in the title is not really #leftoverbits (i.e. we clearly
know it is a
>good idea, we just didn't have bandwidth to do it, anybody is welcome to
fill the
>void) at this point.
>
>Thanks.

