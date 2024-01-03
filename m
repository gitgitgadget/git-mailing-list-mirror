Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0551C2A6
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcjMr8dy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 552FD2AF02;
	Wed,  3 Jan 2024 12:59:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PcdI1yzfNcESKFsatoWpCWxyC0+fw1Vej0LlPy
	lE8oI=; b=fcjMr8dyObAEBByl3a2Jz8/+uboYuvhzTBrM65yT2gw7aaam1HH40N
	t1Itw+AozOSKQrACAaD8D2tEOcwBbg/YFddL0qAs5hG+vjPAz5BByBQomstuQcIk
	JsXEIfxTa3xH2qCP7yBxCB9Q0PelhhJfHqR3n59xClUlg+CyHeAkk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D5512AF01;
	Wed,  3 Jan 2024 12:59:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F09F92AEFF;
	Wed,  3 Jan 2024 12:59:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
In-Reply-To: <ZZWbMekL2URby0qV@tanuki> (Patrick Steinhardt's message of "Wed,
	3 Jan 2024 18:36:49 +0100")
References: <xmqqsf3oj3u8.fsf@gitster.g>
	<CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
	<ZZRaOhK869S1Sg1h@nand.local> <ZZUgUUlB8A-rhep5@tanuki>
	<CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
	<xmqqwmsqbhyt.fsf@gitster.g> <ZZWCXFghtql4i4YE@tanuki>
	<xmqqsf3ebe1l.fsf@gitster.g> <ZZWIlx-9D2r9AfDW@tanuki>
	<xmqqil4a9vue.fsf@gitster.g> <ZZWbMekL2URby0qV@tanuki>
Date: Wed, 03 Jan 2024 09:59:13 -0800
Message-ID: <xmqqedey9u32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CE9D0182-AA61-11EE-BDA0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> I think we should tighten things up over time.  First by teaching
>> the ref backend that anything that is not a pseudoref, HEAD or a
>> proper ref (one item of whose definition is "lives under refs/
>> hierarchy) should not resolve_ref() successfully.  That should
>> correctly fail things like
>> 
>>     $ git rev-parse worktrees/$name/bisect/bad
>>     $ git update-ref foo/bar HEAD
> ...
> Yeah, agreed, that's something we should do. I do wonder whether this
> will break existing usecases, but in any case I'd rather consider it an
> accident that it is possible to write (and read) such refs in the first
> place.

Unfortunately, the worktrees/$name/refs/bisect/bad and its friends
are documented in "git worktree" and the refs.c layer is aware of
the "main-worktree/" and "worktrees/" hierarchy, so while I still
think it is a good long-term direction to make it impossible to
create random refs like "foo/bar" and "resf/heads/master" via the
commands like "git update-ref", we cannot limit ourselves only to
"refs/" hierarchy.
