Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443005820E
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934640; cv=none; b=TrJ69+c6zJJ5fwSeOaBBELg2hXPesKLHZ8yuFxhsGzFjHF2fqLLtBsNHXfJKV2Bgivd8cRO3jBuC2K1TT79lcxj8jyXDi6QIWcKFrx2h/WgBIDW5GwVRwJuYqlfJOsySO65JgcxIX/u05EN0Bhv0hBwgGldU9SzlW1ia7R2QH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934640; c=relaxed/simple;
	bh=pjWM+yH66PaTyEfspgBWSMlyFV3cDCNF0HmyiGsCxL4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=F4TvwGz+5/ArDW7RiosR8ZaVcfA7VMq6WAeru30IQ27pSKAh44KQ5oAoCtnt4dAdTKnkLNKsz8u6x+3vk0XYw0MCGBOfnzxwS07S4gVKq9zWb+pNO8hQFMkiKJQQGyAiSu4LSsp1cCtLk4nArnVus7u/RznMRHhtTE/oeB2f+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45L1oYNd3928540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 01:50:35 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>	<20240619172421.33548-2-randall.becker@nexbridge.ca>	<xmqq8qyzv5a3.fsf@gitster.g> <xmqq34p7v4x1.fsf@gitster.g>	<DS0PR17MB60311D246BF2E89FAEB3C64DF4C82@DS0PR17MB6031.namprd17.prod.outlook.com>	<00ea01dac362$73935e20$5aba1a60$@nexbridge.com> <xmqqv823p3tz.fsf@gitster.g>
In-Reply-To: <xmqqv823p3tz.fsf@gitster.g>
Subject: RE: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
Date: Thu, 20 Jun 2024 21:50:29 -0400
Organization: Nexbridge Inc.
Message-ID: <010201dac37d$68a96070$39fc2150$@nexbridge.com>
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
Thread-Index: AQHJzf2VYEwm4hh0XSc8aIHjA1bZKAIHfOa7AYuV3x4A2CtUcgIcwEvRAlfMlBQCCuJjNbGcCQnQ
Content-Language: en-ca

On Thursday, June 20, 2024 7:55 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> I have another patch almost ready for zlib and libcurl, but it is
>> based on the OpenSSL change. Would you like a re-roll or should I wait
for the
>merge?
>> I do not have the PCRE - not available on my system, so someone else
>> should do that one.
>
>A two-patch series for zlib and libcURL that builds on top of 8b731b8d
(version: --
>build-options reports OpenSSL version information, 2024-06-19), which has
>already hit 'next', would be OK, but most likely, these three are
independent "for X
>in (cURL, zlib, OpenSSL), append X if X is there", and when the three
changes are
>merged together, it would result in
>
>    #if defined CURL_something
>	strbuf_add*(...libcurl thing...);
>    #endif
>    #if defined OPENSSL_something
>	strbuf_add*(...openssl thing...);
>    #endif
>    #if defined libz_something
>	strbuf_add*(...zlib thing...);
>    #endif
>
>with possible permutation of different ordering of them.  And in such a
case, three
>parallel topics that build on the same base (i.e. some recent tip of
'master') would
>be just fine, even though they _surely_ will introduce trivial textual
conflicts.
>
>If you introduced a helper function or CPP macro to make it easy to add the
>OpenSSL version string in your OpenSSL patch, and the other two patches
took
>advantage of the helper or CPP macro while adding the zlib or libcURL
version
>string, then it would be a different story.  A two-patch series for zlib
and libcURL that
>builds on top of the OpenSSL patch would become the best (and the only
practical)
>approach in such a case, but there is nothing in the OpenSSL patch we have
>reviewed that these other two would want to depend on, so...

I think I would rather let each one stand. Embedding an #if defined inside a
macro makes me nervous, considering it is compiler version dependent. Would
putting each one in its own commit work for you?
--Randall

