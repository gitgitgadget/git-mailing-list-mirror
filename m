Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533236126
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923067; cv=none; b=AH2tB72/e1mdd0YEc4BMziOIncVb8lsWBwapOkJ5wXRg6sr8WiDl0n09kTchpCfJ8Svu42MZZeidfSBvsSi7EOs/0Y9nM+bGL2KIr+vknoIGlBgADDlGg6dHtds1FUH/SZoFwt9ijZi9RpSTLCT6xAE8OhO8gemkJNy/79EFxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923067; c=relaxed/simple;
	bh=aaexywJqy7+QPEVcSMXGLzjqWKhFMe7snkksPFnKKx4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cwmdxfT8o2dHbhogtPnM8b8tBupDZwXJYSqPqGtv6zku5tIhbmgWVuQmCkx/uCsPB5GnoTNJ4RmaZIxzDGzEH6r/cBaBjEkx5iDmJvRW3z2R3s+JpUwJKu6YFdIyIbRLKvlNrFME0d/e3qmWiAUKZrGhPdSfUb5rGDguei4PdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45KMbaPK3899936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 22:37:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>	<20240619172421.33548-2-randall.becker@nexbridge.ca>	<xmqq8qyzv5a3.fsf@gitster.g> <xmqq34p7v4x1.fsf@gitster.g> <DS0PR17MB60311D246BF2E89FAEB3C64DF4C82@DS0PR17MB6031.namprd17.prod.outlook.com>
In-Reply-To: <DS0PR17MB60311D246BF2E89FAEB3C64DF4C82@DS0PR17MB6031.namprd17.prod.outlook.com>
Subject: RE: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
Date: Thu, 20 Jun 2024 18:37:31 -0400
Organization: Nexbridge Inc.
Message-ID: <00ea01dac362$73935e20$5aba1a60$@nexbridge.com>
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
Thread-Index: AQHawz9/8R0mygVoxk20McqKZnBxUbHQ+rV9gAAAegCAAEKqsA==
Content-Language: en-ca

On Thursday, June 20, 2024 2:48 PM, Randall Becker wrote:
>On Thursday, June 20, 2024 2:35 PM, Junio C Hamano wrote:
>>Junio C Hamano <gitster@pobox.com> writes:
>>
>>> "Randall S. Becker" <the.n.e.key@gmail.com> writes:
>>>
>>>> This change uses the OpenSSL supplied OPENSSL_VERSION_TEXT #define
>>>> supplied for this purpose by that project. If the #define is not
>>>> present, the version is not reported.
>>> ...
>>> If some unknown version of OpenSSL does define it but not as a string
>>> constant, it would break the build, e.g.,
>>>
>>> 	#define OPENSSL_VERSION_TEXT 2 plus 4 is 6
>>>
>>> We could stringify it ourselves, but that is probably not worth
>>> worrying about.
>>>
>>> Will queue.  Thanks.
>>
>>Having said that, we do link with and depend on libraries like libcURL,
>>libPCRE, libz, etc.  I wonder if they are also worth reporting, and if so
how?
>>
>>We can leave it just like any other new features, "if you have an itch
>>to see it, you can offer a patch", but I am wondering if we are going
>>to get a several more, we'd at least want to standardize the process
>>and the output (e.g., do we limit the line counts to 1 and line length to
some
>reasonably low number?).
>
>I was thinking about those also, but this was a minimalist implementation
>(opensslv.h comes in via git-compat-util.h - so I did not need to bring
anything else
>into the code). If anyone is interested, the libcurl version is in
curlver.h
>(LIBCURL_VERSION) - but I think it is more important to have the OpenSSL
version
>as this is an important compatibility indicator. zlib.h has ZLIB_VERSION
(text form). I
>don't have libPCRE, so can't tell. I can do another series for the others,
but those
>would impact help.c includes, unlike this one.

I have another patch almost ready for zlib and libcurl, but it is based on
the OpenSSL change. Would you like a re-roll or should I wait for the merge?
I do not have the PCRE - not available on my system, so someone else should
do that one.

