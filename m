Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204901EA64
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LE+d/r4A"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3FCCA
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:55:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B210231944;
	Fri, 20 Oct 2023 12:55:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7YySdh4AIWVmBA4b9LWia9Nz0ISwcDLiiHgXGR
	3fZms=; b=LE+d/r4A+H8ciZWPX4hvchl/lpUgp5s38++MaN5oshGwWv/Dbiiv9h
	Us5EvI2mHfIezBpuLvPR59Cqg5csaE9pFo562zeU7pUvaJF/qsfVDvK3sgU9ci8W
	yz8hNTECxhBchM4jQfm2EWA+8M1tOYf3PENEbpDEp29nw/jniJ9HE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AB0AB31943;
	Fri, 20 Oct 2023 12:55:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40E1631941;
	Fri, 20 Oct 2023 12:55:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  "Eric W. Biederman" <ebiederm@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/7] bulk-checkin: extract abstract
 `bulk_checkin_source`
In-Reply-To: <20231020073500.GE1642714@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Oct 2023 03:35:00 -0400")
References: <cover.1697736516.git.me@ttaylorr.com>
	<97bb6e9f59e5092f0519c7d1141d0673313fdc33.1697736516.git.me@ttaylorr.com>
	<20231020073500.GE1642714@coredump.intra.peff.net>
Date: Fri, 20 Oct 2023 09:55:44 -0700
Message-ID: <xmqqlebxs06n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83753964-6F69-11EE-8BBA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Oct 19, 2023 at 01:28:42PM -0400, Taylor Blau wrote:
>
>> +struct bulk_checkin_source {
>> +	enum { SOURCE_FILE } type;
>> +
>> +	/* SOURCE_FILE fields */
>> +	int fd;
>> +
>> +	/* common fields */
>> +	size_t size;
>> +	const char *path;
>> +};
>
> This is a pretty minor nit, but we may find that "SOURCE_FILE" is not
> sufficiently name-spaced. Enum tags are in the global namespace, so
> the compiler will barf if there are any conflicts.

A very good point.  This was one of the reasons why I suggested
avoiding the switch() based on a new enum altogether and use a
vtable based approach instead.  But it may do while this one is
private to the file and never exposed to other subsystems.

> It might be OK here, since this is local to a single C file (so we at
> least are not hurting other code), but we may be in trouble if code in a
> header file is less careful. There is already a near-miss here with
> GREP_SOURCE_FILE, but fortunately grep.h is indeed careful. :)
>
> (I notice that ref-filter.c similarly uses SOURCE_* for an internal
> enum).

Thanks.
