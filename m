Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60814F8D
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vvmn3BYf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E1992E954;
	Tue,  2 Jan 2024 11:49:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MB6Ljcz0aFbDQDY5dq66gvcfMtdSP8TcVDC9pX
	2lx0o=; b=Vvmn3BYfzP2DTh8dowRN5rR01M9ZWsFLmTHeC6F6bMtCpH0Gc1N2Ej
	9lclxfJjGyx3xDsXdYOyU8iEUiSGKFC2y4y7/8wk0a55Jiy9UcLzxmtMUGO+PbfN
	hxUMDZz1zXxsvQgz+jv8aEe/lwh9Xfng1M2k3T8rAevyTeh+IOU0Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 060EB2E953;
	Tue,  2 Jan 2024 11:49:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC5782E951;
	Tue,  2 Jan 2024 11:49:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
In-Reply-To: <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 2 Jan 2024 07:18:48 -0800")
References: <20231221170715.110565-1-karthik.188@gmail.com>
	<20231221170715.110565-3-karthik.188@gmail.com>
	<xmqqzfy3l270.fsf@gitster.g>
	<CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
	<xmqqsf3oj3u8.fsf@gitster.g>
	<CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
Date: Tue, 02 Jan 2024 08:49:51 -0800
Message-ID: <xmqq4jfvfzo0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F372387A-A98E-11EE-9C18-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> As "git for-each-ref" takes pattern that is prefix match, e.g.,
>>
>>     $ git for-each-ref refs/remotes/
>>
>> shows everything like refs/remotes/origin/main that begins with
>> refs/remotes/, I wonder if
>>
>>     $ git for-each-ref ""
>>
>> should mean what you are asking for.  After all, "git for-each-ref"
>> does *not* take "--branches" and others like "git log" family to
>> limit its operation to subhierarchy of "refs/" to begin with.
>
> But I don't think using an empty pattern is the best way to go forward.
> This would break the pattern matching feature. For instance, what if the
> user wanted to print all refs, but pattern match "*_HEAD"?
>
> Would that be
>
>       $ git for-each-ref "" "*_HEAD"

Because you do not omit the leading hierarchy when using globs:

    $ git for-each-ref v2.4\?.\* ;# nothing
    $ git for-each-ref tags/v2.4\?.\* ;# nothing
    $ git for-each-ref refs/tags/v2.4\?.\* ;# gives tags in v2.40 and onwards

I would expect that it would be more like

	$ git for-each-ref "*_HEAD"

And because you can have two or more patterns, e.g.,

    $ git for-each-ref refs/tags/v2.4\?.\* refs/heads/m\*

to get those recent tags and branches whose name begins with 'm', I
would expect your

    $ git for-each-ref "" "*_HEAD"

would probably be equivalent to

    $ git for-each-ref ""

