Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1D2115
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jx+Srd7e"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C597918F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:53:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 05B4D3191E;
	Fri, 20 Oct 2023 12:53:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mvsXWkZUs1i2tbtOPZ4IqF6APfI3UWxgzUox/5
	Vv9OA=; b=Jx+Srd7ed0sNyROY6grabxM5upcoqQixPERRKXUzVCW9GbRT8zyYey
	d/sozcXvFPLRXTxwtI6bAFmfuYYu04FuyrUxlD4D4rOEi6IvJkwQ1buoatSxlkVj
	U29ZOxpkQfvA8XxfKplA0lmgLI7JaY4xdLwlhHyxwOZCdtFLQ59ck=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F20A93191D;
	Fri, 20 Oct 2023 12:53:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85D4E3191A;
	Fri, 20 Oct 2023 12:53:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  "Eric W. Biederman" <ebiederm@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/7] merge-ort: implement support for packing objects
 together
In-Reply-To: <20231020072941.GD1642714@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Oct 2023 03:29:41 -0400")
References: <cover.1697736516.git.me@ttaylorr.com>
	<20231020072941.GD1642714@coredump.intra.peff.net>
Date: Fri, 20 Oct 2023 09:53:43 -0700
Message-ID: <xmqqpm19s0a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3AE8E538-6F69-11EE-97D3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

>   - Having not worked with the bulk-checkin code much before, I thought
>     it only put in one blob per pack, and thus you'd have to teach it to
>     handle multiple objects, too. But fortunately I was wrong, and it
>     handles this case already. (I mention this mainly because we had
>     talked about it off-list a few weeks ago, and some of my confusion
>     may have seeped into my comments then).

You probably had it mixed up with a real limitation, i.e., "unlike
fast-import that considers the immediate previous object could be a
good delta base, this code does not even attempt any deltification"
;-)

>   - I did briefly wonder if we need this SOURCE abstraction at all. The
>     file source assumes we can seek() and read(), so it must be a
>     regular file. We could probably just mmap() it and treat it as
>     in-core, too (this is what index_fd() and index_path() do under the
>     hood!).

Ahhhh, I've never thought of that one.  I actually was hoping that
we can add an abstraction layer that can be reused elsewhere and
everywhere (not limited to the bulk-checkin codepath for its source
material), which might help folks who want to refactor Git enough to
allow them plug $CORP specific goodies like virtual filesystem layer
;-).

>     But it would probably be a disservice to any platforms that
>     do not support mmap, as the fallback is to read into a full buffer
>     (and the whole point of the bulk checkin code is to avoid that).

Yes.  The result was a pleasant read.

Thanks, both.
