Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD571A700
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AgMK78AG"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF9C1
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:24:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1364D1F54A;
	Mon, 30 Oct 2023 19:24:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C0O5DmaT1uc8zBpIdfs/Zsd4nQfLbSWSXoz5CQ
	ZVGYU=; b=AgMK78AG9/KNxwNn7mlorSjnv/J+AijqAzs1im7QlI+xcQ+LELSYfm
	c3/KngWZIUqlRTxRf+IZ8Wketb4I3SqCqGmFjeV1HleMkxa52vDqenuMrdsKeyeo
	Cu2YKiYUqEC5Co7l7rVn2wYCRCK8vO15/oM91OLYXNWs37sGz5tv0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C0661F549;
	Mon, 30 Oct 2023 19:24:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9831A1F548;
	Mon, 30 Oct 2023 19:24:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH] reflog: fix expire --single-worktree
In-Reply-To: <ZT/mN9RouiqzL9aT@nand.local> (Taylor Blau's message of "Mon, 30
	Oct 2023 13:21:59 -0400")
References: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de>
	<xmqqa5s1hxhh.fsf@gitster.g> <ZT/mN9RouiqzL9aT@nand.local>
Date: Tue, 31 Oct 2023 08:24:53 +0900
Message-ID: <xmqqa5rzbsmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 884B8910-777B-11EE-B9C5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> This makes sense to me, but obviously won't catch non-tested cases.

True, but I think we can practically ignore non-tested cases.

The parse_options_check() is used to validate the whole options[]
array that is passed to parse_options() family of API functions, and
its validation is not limited to the options that are given from the
command line in an invocation.  A non-tested case would happen when
a developer prepares and populates "struct option options[];" array
for a (possibly new) git subcommand *and* never uses that array to
call parse_options() in their implementation of that subcommand.
The compiler would catch the unused variable options[] in such a
case, and mark 1 eyeball would notice that none of the options
defined in that array are actually understood by the command, no?
