Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9038820
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994810; cv=none; b=Y+l635zPDbtgRZyGH0zVPWJshKajXOtrqRupJpOoBdp9WGADWSt0iasWAczDxvqCf8PYK963CG5BvyqnKIs66C5jIRyURiill1ABsXegUjL5EFm3BhpahqsySEKW2TTImZACwmyGcc7liUlJlh+jkprXE/WXuSBei2ZxKeZNLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994810; c=relaxed/simple;
	bh=AmbUttAEQrAB8bZ4gPEF70S7RYoiGsAq26u9gjlgPAU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=L3T1J/bF7VcdSw9bl0ajKfWZKYUvEONpzTsj/KKUinO4CeWw4Bm3AvG6A2dVMSHpTHKelnEHA4sdYFzF1UoX+/d2OLGJ5TMfFyr91e4OZGtVRJkymHljTGrF97PubP6nDwhSdK5ROwpp5PFhUsF0JVdCfm2wvl/3ApcSbQYD3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45LIXJtD4091923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 18:33:20 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>
Cc: <git@vger.kernel.org>, "'Randall S. Becker'" <randall.becker@nexbridge.ca>
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>	<20240621154552.62038-2-randall.becker@nexbridge.ca> <xmqqmsnekvir.fsf@gitster.g>
In-Reply-To: <xmqqmsnekvir.fsf@gitster.g>
Subject: RE: [PATCH v0 1/1] Teach git version --build-options about zlib+libcurl
Date: Fri, 21 Jun 2024 14:33:14 -0400
Organization: Nexbridge Inc.
Message-ID: <016501dac409$7dd5bc00$79813400$@nexbridge.com>
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
Thread-Index: AQHq0XJehhOvdAHgpxm5+qQ6Ucb/ggE1bx9aAneMcGSxlQdgYA==
Content-Language: en-ca

On Friday, June 21, 2024 2:20 PM, Junio C Hamano wrote:
>"Randall S. Becker" <the.n.e.key@gmail.com> writes:
>
>> This change uses the zlib supplied ZLIB_VERSION #define supplied text
>> macro and the libcurl LIBCURL_VERSION #define text macro. No
>> stringification is required for either variable's use. If either of
>> the #define is not present, that version is not reported.
>
>"the zlib supplied ZLIB_VERSION #define supplied text macro" is quite a
mouthful.
>Something like
>
>    version: --build-options reports zlib and libcurl version information
>
>    Use ZLIB_VERSION and LIBCURL_VERSION to show them, if defined, in
>    "git version --build-options" output.
>
>should be sufficient.

Do you want me to reissue the merge? This looks fine to me.

>We will assume that
>
> (1) LIBFROTZ_VERSION, if defined, will always be of the same type
>     (luckily, all three we are dealing with use a C-string so
>     "strbuf_addf(buf, "%s", LIBFROTZ_VERSION)" is good), and that
>
> (2) no random origin other than the frotz project will define the
>     CPP macro LIBFROTZ_VERSION to confuse us.
>
>Both are sensible assumptions that would allow us to trust a hardcoded
>strbuf_addf() invocation per each library is sufficient If a library uses
>LIBFROTZ_MAJOR and LIBFROTZ_MINOR we may have to do "strbuf_addf(buf,
>"%s.%s" LIBFROTZ_MAJOR, LIBFROTZ_MINOR)" that is different from others, but
>the point is the version identification scheme would be constant across
different
>versions of the same library.
>
>The actual code to report versions should be trivial, once we get the
mechanism to
>make necessary CPP macros available (when present) right, but the latter
needs a
>bit more work than this patch shows.
>
>Here is the first change your patch does:
>
>>  #include "git-compat-util.h"
>> +#include "git-curl-compat.h"
>
>The file <git-curl-compat.h> begins like so:
>
>        #ifndef GIT_CURL_COMPAT_H
>        #define GIT_CURL_COMPAT_H
>        #include <curl/curl.h>
>	...
>

In this case, I was modelling the include after http.c, and remote-curl.c,
which would have the same problem. I was going for consistency. Would not
all three have to be fixed in a separate patch?

>If you do not have any <curl/curl.h> anywhere on your system, I suspect
this will
>break the build, instead of silently leaving LIBCURL_VERSION undefined.
>
>>  #include "config.h"
>>  #include "builtin.h"
>>  #include "exec-cmd.h"
>> @@ -757,6 +758,12 @@ void get_version_info(struct strbuf *buf, int
>> show_build_options)
>>
>>  		if (fsmonitor_ipc__is_supported())
>>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
>> +#if defined LIBCURL_VERSION
>> +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION); #endif
#if
>> +defined ZLIB_VERSION
>> +		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION); #endif
>
>FYI, in the merged result, I would prefer to order these entries
semi-alphabetically,
>e.g. perhaps stripping possible "lib" prefix or suffix and comparing the
rest to result
>in curl < openssl < z or something like that.  Then we know where to add a
new one,
>whose name we do not know yet, in the future.

I think that is logical. Do you need this redone? Although the OpenSSL
inclusion is already merged from what I can see.

>Thanks.

