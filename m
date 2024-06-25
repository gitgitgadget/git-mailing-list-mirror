Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01E17C7CA
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343754; cv=none; b=n+S2BUV85xjbGuxLYInC8fV1hnSOXD7iD1uQTCbvTY/3WJx2mWwIe63CXWP+itzLNHpF2DrItSuXeGqGEeUCWCzLykQnrLxEYoJbM6zwB8SHSJMwdDT7eYzPd7NEZXcBBnwttpMmYBDKDkZvVK0hBgbeAUm6iVQ2udVt/dJogQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343754; c=relaxed/simple;
	bh=j5ocJPGPBRTlDCW3YLMhVnh4JU5z0JTxirTkgxUSP6M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uHRwm84hZfP7arr7AMF8OX+bYl4GMKAda/Hp2F5vuUjSEDD5eB5uthwILf2uZd1/cgiScBqq2s/c9O3vCdo84jpEMiJdpx91bJfI94gF8PGTn93x/YrCX0ws9jhsy7TD7sg2FTSiCldGt54DokkZCYz/01CWq5Y17F/VZh60+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45PJT8GD731795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 19:29:09 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>	<20240621154552.62038-2-randall.becker@nexbridge.ca>	<xmqqmsnekvir.fsf@gitster.g>	<016501dac409$7dd5bc00$79813400$@nexbridge.com>	<xmqqwmmijf6f.fsf@gitster.g> <xmqqplsaje6z.fsf@gitster.g> <xmqqtthlimtr.fsf@gitster.g>
In-Reply-To: <xmqqtthlimtr.fsf@gitster.g>
Subject: RE: [PATCH v0 1/1] Teach git version --build-options about zlib+libcurl
Date: Tue, 25 Jun 2024 15:29:03 -0400
Organization: Nexbridge Inc.
Message-ID: <03ef01dac735$f3496ac0$d9dc4040$@nexbridge.com>
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
Thread-Index: AQHq0XJehhOvdAHgpxm5+qQ6Ucb/ggE1bx9aAneMcGQCRemapwGCRHksAmkbpREC22/9irFS+rRw
Content-Language: en-ca

On Saturday, June 22, 2024 1:11 AM, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> Unfortunately, we cannot use the same trick, i.e. "Makefile knows not
>> to even compile when NO_CURL is set", as this change is to help.c and
>> we cannot say "if you do not have libcURL, you do not get any help"
>> ;-)
>>
>>         #ifndef NO_CURL
>>         #include "git-curl-compat.h"
>>         #endif
>>
>> may be a simplest workaround, as Makefile does this:
>>
>>         ifdef NO_CURL
>>                 BASIC_CFLAGS += -DNO_CURL
>> 		...
>
>So, the version I queued looks like so:
>
>        diff --git a/help.c b/help.c
>        index ce55aaa2c0..92bfef140b 100644
>        --- a/help.c
>        +++ b/help.c
>        @@ -15,6 +15,10 @@
>         #include "prompt.h"
>         #include "fsmonitor-ipc.h"
>
>        +#ifndef NO_CURL
>        +#include "git-curl-compat.h" /* For LIBCURL_VERSION only */
>        +#endif
>        +
>         struct category_description {
>                uint32_t category;
>                const char *desc;
>        @@ -757,6 +761,9 @@ void get_version_info(struct strbuf ...
>
>                        if (fsmonitor_ipc__is_supported())
>                                strbuf_addstr(buf, "feature:
fsmonitor--daemon\n");
>        +#if defined LIBCURL_VERSION
>        +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
>        +#endif
>         #if defined OPENSSL_VERSION_TEXT
>                        strbuf_addf(buf, "OpenSSL: %s\n",
OPENSSL_VERSION_TEXT);
>         #endif
>
>but then there are a few "side builds" at GitHub CI, one of which is
"minimum
>fuzzer" build.  It compiles bunch of object files without giving much build
options
>but the final target of the build is not "git" but something else [*].  And
because the
>job is not interesting in building a working "git", the environment does
not install
>libcURL, leading to a failed build.
>
>I sent a separate patch to address this build failure, which is found at
>https://lore.kernel.org/git/xmqqwmmhimxx.fsf@gitster.g/

My take on the separate patches and discussion about reporting run-time
values of libcurl, zlib, and OpenSSL, is that these are being added to
--build-options not --runtime-options (does not exist yet). I think that
grabbing run-time values could be confusing to users who expect the
--build-options even if comparing the two values.
--Randall

