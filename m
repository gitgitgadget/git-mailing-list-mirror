Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A4430314
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377828; cv=none; b=pveeW/I+Oa/zzt64XUUc51QBVBSMySHoFc1N7yiFNsR9ohqAE2+5dUKZh4lEgJHmGhIL/8+cMPCkO5lLm8F/t/aC+pFsxnV0S7XtaxCOR0IC6DbQtn9Tu93Xnu0st/tp01sE15vjUBhhT4atTVpyylataKTo40+fXzcRdU86K88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377828; c=relaxed/simple;
	bh=cafCLDqsHF4AucRI/zfi1JqZdBQdM/kk9ryOe2xdry4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9zWRS54IxNEZdwSN5hY7Dy1sxwkb4Z95nZGF5u+wydGzUrzridh9JlYHZsICdc4kRZkQYRXZogYDFtPxb1nq9O9bx4Mia5j/ZLZyXJzukEsKUcBLKncjLzpQsVxsiqa0LPe0vvfFBUkWSl8z56Eacv2tGn1Nuk9RjScHzasCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1x62i2-002qlP-0c
	for git@vger.kernel.org;
	Mon, 14 Sep 2026 11:10:44 +0200
Received: from [10.20.10.53] (port=30308 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.99.4)
	(envelope-from <dev+git@drbeat.li>)
	id 1x62hy-00000002DEl-2OeC;
	Mon, 14 Sep 2026 11:10:37 +0200
Message-ID: <872286d0-7786-46cc-b26f-16f6d487e608@drbeat.li>
Date: Mon, 14 Sep 2026 11:10:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] imap-send: prepare for OpenSSL 4.1
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Oswald Buddenhagen <ossi@kde.org>
References: <20260907211210.2621693-1-dev+git@drbeat.li>
 <20260907211210.2621693-2-dev+git@drbeat.li> <ap_GvB8Lonkn0nEy@pks.im>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <ap_GvB8Lonkn0nEy@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Hi Patrick

On 08.09.2026 10:26, Patrick Steinhardt wrote:
> On Mon, Sep 07, 2026 at 11:12:08PM +0200, Beat Bolli wrote:
>> OpenSSL master (to be v4.1 after the release) renamed the function
>> ASN1_STRING_length() to ASN1_STRING_get_length(). Map the new name to
>> the old one if we're compiling with a pre-4.1 version.
> 
> I can see [1] that the new functions indeed exist now. But it doesn't
> say anything about the old functions, they still exist and don't seem to
> be deprecated. So why do we even have to switch to the new function?
> 

The very page you give below contains this text:

---- 8< ----
The following functions have been deprecated since OpenSSL 4.1, and can 
be hidden entirely by defining OPENSSL_API_COMPAT with a suitable 
version value, see openssl_user_macros(7):

int ASN1_STRING_set(ASN1_STRING *str, const void *data, int len);
int ASN1_STRING_length(ASN1_STRING *x);
---- 8< ----

We also don't define any compatibility macros for OpenSSL, and the build 
failed because of the deprecation warning that was turned into an error 
because of DEVELOPER=1.

So I still think this patch is needed.

Beat

> [1]: https://docs.openssl.org/master/man3/ASN1_STRING_length/

