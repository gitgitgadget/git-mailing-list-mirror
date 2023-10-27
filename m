Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990CE347D3
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XPKSJ3Bz"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A9E1AA
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 16:12:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9025D1AA6C;
	Fri, 27 Oct 2023 19:12:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AxchPA57R57N0Rm7I8xvX5uVNG2pYy0mEXiLE1
	qUhI4=; b=XPKSJ3BzXRCiI8mESzhSpO0uMljzy0I9CcDI+f4g7vpEV4o8h9jpwT
	YBeOJXx+ORXFlVZBqExZaPIWqw7nwi7VseEGeswvItzAI9GfGVPaUxspwz+jg/H3
	aZICzKa5xsQ8Rel9Ev7gFIRswWk9H0jMLdLAfsP/wCg2WcbeAiSbI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 891901AA6B;
	Fri, 27 Oct 2023 19:12:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2CCD81AA66;
	Fri, 27 Oct 2023 19:12:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  "Eric W. Biederman" <ebiederm@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 1/5] bulk-checkin: extract abstract
 `bulk_checkin_source`
In-Reply-To: <20231025073736.GB2145145@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 25 Oct 2023 03:37:36 -0400")
References: <cover.1697736516.git.me@ttaylorr.com>
	<cover.1698101088.git.me@ttaylorr.com>
	<696aa027e46ddec310812fad2d4b12082447d925.1698101088.git.me@ttaylorr.com>
	<20231025073736.GB2145145@coredump.intra.peff.net>
Date: Sat, 28 Oct 2023 08:12:20 +0900
Message-ID: <xmqqpm0zoe23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4890EDE2-751E-11EE-B2DB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Alternatively, I think some of our other OO code just leaves room for
> a type-specific void pointer, like:
>
>   struct bulk_checkin_source {
> 	...the usual stuff...
>
> 	void *magic_type_data;
>   };
>
> and then the init_bulk_checkin_source_from_fd() function allocates its
> own heap struct for the magic_type_data field and sticks the int in
> there.

Yup.  All the pros-and-cons makes sense.  I earlier said I found
this a good place to stop, exactly because the full OO with 

    struct specific_subclass {
	struct vtbl *vtbl;
	struct base_class common_data_specific_to_instance;
	... other instance specific data members here ...;
    }

would require us to add too many supporting infrastructure struct
types; with only a few subclasses in use, it is a bit too much to
justify.
