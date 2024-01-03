Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046A1A599
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ko9ZunAz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BA81298D0;
	Wed,  3 Jan 2024 09:38:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RdCKyyICdoMn+zz6Vmb8BkEjp6ZJXsrf1c7+KZ
	xbWw8=; b=Ko9ZunAz9TVrdxHS9kN6EPU5ozD6wiZuk29PMti+CLQxMcnG2B6iPw
	N9Z53HzCPT8RoXtwn6TMQOWECuYT+M53jeXWww0SiS0KdB2jweeFh9zh+3xEqVqx
	KbKgz+am4yTRhZENCfFpuNrjQpnphYCVCsnobnWB1WKw2t4WAoeak=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 73A03298CF;
	Wed,  3 Jan 2024 09:38:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DFFCA298CE;
	Wed,  3 Jan 2024 09:38:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
In-Reply-To: <CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 3 Jan 2024 02:22:47 -0800")
References: <20231221170715.110565-1-karthik.188@gmail.com>
	<20231221170715.110565-3-karthik.188@gmail.com>
	<xmqqzfy3l270.fsf@gitster.g>
	<CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
	<xmqqsf3oj3u8.fsf@gitster.g>
	<CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
	<ZZRaOhK869S1Sg1h@nand.local> <ZZUgUUlB8A-rhep5@tanuki>
	<CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
Date: Wed, 03 Jan 2024 06:38:02 -0800
Message-ID: <xmqqwmsqbhyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3B2032A-AA45-11EE-95C7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> The confusion was that I thought Junio was referring to using
>
>     $ git for-each-ref ""
>
> to print all refs under $GIT_DIR, while he was actually talking about
> "$GIT_DIR/refs/" directory.

I do not think you misunderstood me here, though.  

When you have your master branch (refs/heads/master), your v1.0 tag
(refs/tags/v1.0), and the usual pseudorefs, giving "refs" to "git
for-each-ref" would yield refs/heads/master and refs/tags/v1.0 but
not HEAD and others, simply because the pattern "refs" in

    $ git for-each-ref "refs"

works as a hierarchy prefix match.  You give "refs/heads" and you
get only your master branch but not tags or HEAD in such a
repository.  As a natural extension to that behaviour, an empty
string as a hierarchy prefix that matches everything would work
well: you'd get HEAD, refs/heads/master, and refs/tags/v1.0 as an
empty prefix would cover all of the hiearchies these three refs (and
pseudorefs if you had ORIG_HEAD and MERGE_HEAD there) live in.

In any case, it is not a very much interesting to define the syntax
to tell for-each-ref not to limit itself under "refs/".  My point
was that you do not need a special option for that, as shown above.

What is more interesting is what to do with refs that are specific
to other worktrees, e.g.

    $ git rev-parse "worktrees/$name/refs/bisect/bad"

would currently let you peek into (and worse yet, muck with, if you
really wanted to, with something like "git update-ref") refs that
should be only visible in another worktree.  Should for-each-ref and
friends learn a way to iterate over them?  I have no answer to that
question.

