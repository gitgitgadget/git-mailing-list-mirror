Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4491843
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710614986; cv=none; b=Qvx/v+CAScRCl+/CNAm/J2kS2CVdvQ32zV3tDa6wARrsDwIapROPTAnhZRzUV4AY9NN21BrPHIpJfmCReiQl6KR+E0o6VIjsFDoqzakXJ8Tn3IbUaElj2G8j+XopL9q5B9J3K6s+xNi/6JRJxjuPRLi1PD40dhYDbR8bJqa4JVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710614986; c=relaxed/simple;
	bh=xbEQiEOPKmVGnm10RbgwzXPlMi9MW3RqpGQjISKanl4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=elqTCGefTcLtw1QSUKqfRePhCIQVgmikIlJlr8pvKo/hWrGeHVU7M3iMkzV7HEFScqO9wm+1gQ9w1863iJF+LCmP7gUJbLC3WU0N4aEY58TocnfSs+OhCK1F1fVaDhp9UQZbGrAl62t7YroiBD8gtuexQOBgpcTLliWOSPjHX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42GInVqF2383282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Mar 2024 18:49:31 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ignacio Encinas Rubio'" <ignacio@iencinas.com>
Cc: <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
References: <20240307205006.467443-1-ignacio@iencinas.com> <20240309181828.45496-1-ignacio@iencinas.com> <20240309181828.45496-2-ignacio@iencinas.com> <20240316065737.GA544929@coredump.intra.peff.net> <xmqqo7bem7o8.fsf@gitster.g> <006c01da77c9$298b2e50$7ca18af0$@nexbridge.com> <ea07fbc2-8937-486b-87c2-e2abe9856d26@iencinas.com>
In-Reply-To: <ea07fbc2-8937-486b-87c2-e2abe9856d26@iencinas.com>
Subject: RE: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Date: Sat, 16 Mar 2024 14:49:25 -0400
Organization: Nexbridge Inc.
Message-ID: <006d01da77d2$ae4361e0$0aca25a0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJVKjLHunLfVEMKSyBF1vvEJDqbigGtFbHTAifsU7wBfblwPQHvv9//AgLKp5cBEvzs3a/yi/tA

On Saturday, March 16, 2024 2:06 PM, Ignacio Encinas Rubio wrote:
>On 16/3/24 18:41, rsbecker@nexbridge.com wrote:
>> On Saturday, March 16, 2024 1:03 PM, Junio C Hamano wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> Do we need to define "hostname" in more detail here? Specifically,
>>>> I'm wondering whether the result will be a FQDN or not (i.e., the
>>>> output of "hostname" vs "hostname -f"). Looking at the code I think
>>>> it will just be the short name returned. That's probably OK, but it
>>>> may be worth documenting.
>>>
>>> That was my first reaction but there are places where "hostname"
>>> already gives a name that is not "short" at all, without being
>>> invoked with
>> "-f".
>>>
>>> For example, the (virtual) workstation I am typing this message on
>>> sits in
>> a $WORK datacenter, where "hostname" gives the same
>>> string as "hostname -f", which looks like "git.c.xxxxxx.tld" ("git"
>>> is the
>> only part I picked myself for it, "c" is shared by those employee
>>> workstations hosted at datacenters, "xxxxxx.tld" is redacted to
>>> conceal the
>> real domain name to protect the culprits ;-).
>>>
>>> I think the most honest answer we can give in the documentation is
>>> that we
>> use what gethostname() [*] gives.
>>
>> I think this is probably a good idea and but value should not be
>> cached. My dev box has a multi-home, multi-cpu IP stack. It makes
>> things really weird sometimes. For example, hostname replies with:
>>
>> ztc0.xxxxxxxx.local
>>
>> and includes the current default IP stack, which is known to DNS,
>> while uname -n, which I prefer to use when deciding what system I am
>> on during tests, reports:
>>
>> xxxxxxxx
>>
>> I am not sure how meaningful hostname is; however, "hostname -f" is
>> not portable. However, includeif depending on whatever gethostname()
>> returns is reasonable, in my opinion, also. I think the series should
>> include a $(uname
>> -n) option in some form for completeness.
>
>Correct me if I'm wrong, but gethostname() seems to be equivalent to =
$(uname -n)

Glibc definitely uses uname, according to its man page, but that is the =
exception, not the rule. Evidence from my experimentation on various =
platforms says that the two values may sometimes be the same but the =
host configuration may be different, particularly if two stacks are on =
the same machine with different IP addresses. uname does not go to DNS. =
gethostname() generally (Windows, S/390, NonStop, Linux where glibc is =
not used), uses DNS as its first attempt to resolve the name.

