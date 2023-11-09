Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D45110E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jEZd09ZX"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E8268E
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 16:30:17 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E4761C80C;
	Wed,  8 Nov 2023 19:30:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3LZ++oGTAaGO8MkAP4bTGHjxT7sE9D+Ch6nMaO
	RN83M=; b=jEZd09ZXVPpW2JLyjd77uOQ5s0ISPoAZ7BNGe9r2VeKhhhtKcslDwK
	WtyzvLst7IEWg32DOX0Ln1UDMZYC09kN6J8vQwgILwM2mhs3EbYHwIcvzGjXrbXg
	ysJ4y0yKHDkGUiyBudbtW0XCOqWaaOg/RWA3+EsJxAOb2Ikd4Hv90=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 16BC71C80B;
	Wed,  8 Nov 2023 19:30:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4CE81C808;
	Wed,  8 Nov 2023 19:30:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] t/lib-httpd: dynamically detect httpd and
 modules path
In-Reply-To: <20231108165426.GB1028115@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 8 Nov 2023 11:54:26 -0500")
References: <cover.1699428122.git.ps@pks.im> <cover.1699455383.git.ps@pks.im>
	<cee8fbebf84422f73c38d55b5730053121b74e0f.1699455383.git.ps@pks.im>
	<20231108165426.GB1028115@coredump.intra.peff.net>
Date: Thu, 09 Nov 2023 09:30:11 +0900
Message-ID: <xmqqsf5f4vl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 255A7A96-7E97-11EE-B224-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Nov 08, 2023 at 03:57:19PM +0100, Patrick Steinhardt wrote:
>
>> While it is possible to specify these paths via `LIB_HTTPD_PATH` and
>> `LIB_HTTPD_MODULE_PATH`, it is not a nice experience for the developer
>> to figure out how to set those up. And in fact we can do better by
>> dynamically detecting both httpd and its module path at runtime:
>> 
>>     - The httpd binary can be located via PATH.
>> 
>>     - The module directory can (in many cases) be derived via the
>>       `HTTPD_ROOT` compile-time variable.
>> 
>> Amend the code to do so. The new runtime-detected paths will only be
>> used in case none of the hardcoded paths are usable.
>
> If these improve detection on your platform, I think that is a good
> thing and they are worth doing. But as a generic mechanism, I have two
> comments:
>
>> -for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
>> +for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2' "$(command -v httpd)"
>>  do
>>  	if test -x "$DEFAULT_HTTPD_PATH"
>>  	then
>
> The binary goes under the name "httpd", but also "apache2". But the PATH
> search only looks for "httpd". Should we check "command -v apache2" as
> well?

Interesting.  If $() were on the right hand side of an assignment,
the command that fails may also something to watch for, but I think
$? from $(command -v no-such-httpd) would be discarded, so it would
be fine in this case.  A trivia I found out today: dash exits with 127
and bash exits with 1 when doing 

    $shell -c 'command -v no-such-httpd'

> This also means we may run "test -x" on an empty string, but that is
> probably OK in practice (we could guard it with "test -n", though).

Good thinking.  We are not worried about exotic or misbehaving
shells in this thread, so hopefully shell built-in 'test' would say
"no" when asked if "" is executable (in other words, "" is not
mistaken as ".").  But an explicit "test -n" would save the readers
by removing the worry.

> ... So without a system config file to act as a template for our custom
> config, I think we are stuck with guessing where the installer might
> have put them.

Right.  Thanks for a careful analysis.
