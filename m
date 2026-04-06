Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE47382F2A
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486123; cv=none; b=i8oVgtOrHrPTF/zIB5XNwBF+mGcM30N97UKPnO3QAGWYqoQw8f+7NlaxMtgMmURpkX245MqM/4putirfBKwroC/vWEm8vHtQ2K+mQ7UNJddmg8z/NW217BmdboPKZzXSfgz2BNThP5WiJhHimVcChPMTTtVSxGZ0GSjpDSPSC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486123; c=relaxed/simple;
	bh=o0HMf9gUpoH5WB1hmOkn5GDYz2EURw2Nkce2XLDH7iY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0oW71K2eWsJAgtT1KOfjBq2472+7EgPSzbYWxhX5MyxA2zu2mhLDE3VshTGz6VFvqjZGzKsUO0SNXF/Rrq7GkCoKrmtf6UMn+OQFWzTLvnuRdKdHplx0IDdsE//Eg44RVUGrRUOeADex/mk6KtUrhyxf3X7DpF0B3LNzm69dNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 636EZFd42552391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Apr 2026 14:35:16 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>
Cc: "'Beat Bolli'" <dev+git@drbeat.li>, <git@vger.kernel.org>
References: <029f01dcc52f$2c8b8c70$85a2a550$@nexbridge.com> <47629c96-8764-45f1-b36d-d944d6282cb1@web.de>
In-Reply-To: <47629c96-8764-45f1-b36d-d944d6282cb1@web.de>
Subject: RE: Git 2.54.0-rc0 Breaks on OpenSSL 3.0
Date: Mon, 6 Apr 2026 10:35:07 -0400
Organization: Nexbridge Inc.
Message-ID: <004301dcc5d2$942a5ac0$bc7f1040$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHZ+tM89uERPfJcEzRj5+2wQOj2HgGUkSdQtcsKhBA=
X-Antivirus: Norton (VPS 260406-2, 4/6/2026), Outbound message
X-Antivirus-Status: Clean

On April 6, 2026 3:07 AM, Ren=C3=A9 Scharfe wrote:
>On 4/5/26 9:05 PM, rsbecker@nexbridge.com wrote:
>> Sadly, OpenSSL 3.0 is still out in the wild for those who have =
extended
>> support contracts with OpenSSL.
>
>https://openssl-library.org/policies/releasestrat/index.html says
>"Version 3.0 will be supported until 2026-09-07 (LTS)".
>
>> The following errors happen using OpenSSL
>> 3.0 when built with c99:
>>
>> "/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/imap-send.c", =
line 274:
>> error(252):
>>           argument of type "const X509_NAME_ENTRY *" is incompatible =
with
>>           parameter of type "X509_NAME_ENTRY *" (aka "struct
>> X509_name_entry_st
>>           *")
>
>This line contains:
>
>	    (cname =3D X509_NAME_ENTRY_get_data(cname_entry)) =3D=3D NULL)
>
>https://docs.openssl.org/3.0/man3/X509_NAME_ENTRY_get_object/ gives its
>prototype as:
>
>ASN1_STRING *X509_NAME_ENTRY_get_data(const X509_NAME_ENTRY *ne);
>
>This has been matching the code since OpenSSL commit 9f5466b9b8
>(Constify some X509_NAME, ASN1 printing code, 2016-07-07).  git =
describe
>calls this commit OpenSSL_1_1_0-pre6-232-g9f5466b9b8.
>
>>                                      ASN1_STRING_get0_data(cname),
>> hostname);
>>                                      ^
>> "/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/imap-send.c", =
line 279:
>> error(114):
>>           identifier "ASN1_STRING_get0_data" is undefined
>
>https://docs.openssl.org/3.0/man3/ASN1_STRING_length/ gives its
>prototype as:
>
>const unsigned char *ASN1_STRING_get0_data(const ASN1_STRING *x);
>
>It was added by OpenSSL commit 17ebf85abd (Add ASN1_STRING_get0_data(),
>deprecate ASN1_STRING_data()., 2016-08-16).  git describe calls this
>commit OpenSSL_1_1_0-pre6-119-g17ebf85abd.
>
>Are you sure you use OpenSSL 3.0?  The errors suggest it's a rather
>older version (before 1.1.1).

Thanks Rene. Operator (me) error here. This was on the 1.0.2w build. We =
are disabling that
build now so that it will not get reported again.

Regards and thanks,
Randall

