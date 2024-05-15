Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020A36AF2
	for <git@vger.kernel.org>; Wed, 15 May 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792949; cv=none; b=KYITCyZggMPV/do80IE0R5KI6naoggt50QRKtBbguksGpEOPrZ1mziFrDDoiTSIZUx3SaQBMJlWtf2HMFLyRjjBFUC9eI2btJaxDtTFkzArepx+g41SUnVVdSW+geq2FyLYkZTg4iIWkU+PLgtRgpN/4DiOZ04DYVxjeTnz22uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792949; c=relaxed/simple;
	bh=NDPsL95/Y4mslTMSq1lVxn8PQYo5ErA0Y3PFOMH8Wqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9qTwovFqCqeWy2mF2P9kIxo24QJcdMZipV9TSR/u2EPVmTRH6WE6xO1mI2YZXvaaPHqxokgGvl6llWaeJ7Azrht4on3/04Vz8oYP5fHuEbRNxeVDTBqb6SQriTLoL/sY+8KfFVliDQyIc7cyJpqvRbfEedrC6vCa+qlw+nZQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g4Po7TzK; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g4Po7TzK"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E97841EABC;
	Wed, 15 May 2024 13:09:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NDPsL95/Y4mslTMSq1lVxn8PQYo5ErA0Y3PFOM
	H8Wqg=; b=g4Po7TzKdTCfjhbyOoxWQrIZptZCLpB/QZKFQnVt+el722FoFYrNtE
	+zC1Y6XbqEDJleZ/LWvZpdVHQFRPH6JKcmYwEodGf1Y7i09TVCXJ8K8vfkjpxxCx
	dezszjHzbp+UPdBVmLG2+BOiLtChs6vdEVURuTR2yrgKKKWdE4Ev8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CAA651EABB;
	Wed, 15 May 2024 13:09:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 569E71EAB8;
	Wed, 15 May 2024 13:09:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
In-Reply-To: <20240515132543.851987-4-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 15 May 2024 15:25:43 +0200")
References: <20221012135114.294680-1-christian.couder@gmail.com>
	<20240515132543.851987-1-christian.couder@gmail.com>
	<20240515132543.851987-4-christian.couder@gmail.com>
Date: Wed, 15 May 2024 10:08:58 -0700
Message-ID: <xmqqv83fvw7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2B174A8-12DD-11EF-8FC6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> From: Christian Couder <chriscool@tuxfamily.org>
>
> In case some objects are missing from a server, it might still be
> useful to be able to fetch or clone from it if the client already has
> the missing objects or can get them in some way.

Be more assertive.  We do not want to add a new feature randomly
only because it _might_ be useful to somebody in a strange and
narrow use case that _might_ exist.

> For example, in case both the server and the client are using a
> separate promisor remote that contain some objects, it can be better
> if the server doesn't try to send such objects back to the client, but
> instead let the client get those objects separately from the promisor
> remote. (The client needs to have the separate promisor remote
> configured, for that to work.)

Is it "it can be better", or is it "it is always better"?  Pick an
example that you can say the latter to make your example more
convincing.

Repository S borrows from its "promisor" X, and repository C which
initially cloned from S borrows from its "promisor" S.  Even if C
wants an object in order to fill in the gap in its object graph, S
may not have it (and S itself may have no need for that object), and
in such a case, bypassing S and let C go directly to X would make
sense.

> Another example could be a server where some objects have been
> corrupted or deleted. It could still be useful for clients who could
> get those objects from another source, like perhaps a different
> client, to be able to fetch or clone from the server.
>
> To configure what a server should do if there are such missing
> objects, let's teach `git upload-pack` a new
> `uploadpack.missingAction` configuration variable.
>
> This new missing-action works in a similar way as what `git rev-list`
> and `git pack-objects` already support with their
> `--missing=<missing-action>` command line options. In fact when
> `uploadpack.missingAction` is set to something different than "error",
> `git upload-pack` will just pass the corresponding
> `--missing=<missing-action>` to `git pack-objects`.
>
> So this new missing-action has the same limitations as
> `git pack-objects --missing=<missing-action>`. Especially when not
> using promisor remotes, 'allow-any' works only for blobs.
>
> Another limitation comes from `git upload-pack` itself which requires
> setting `GIT_NO_LAZY_FETCH` to 0 since 7b70e9efb1 (upload-pack:
> disable lazy-fetching by default, 2024-04-16) for lazy fetching from
> a promisor remote to work on the server side.

I am puzzled by this new option.

It feels utterly irresponsible to give an option to set up a server
that essentially declares: I'll serve objects you ask me as best
efforts basis, the pack stream I'll give you may not have all
objects you asked for and missing some objects, and when I do so, I
am not telling you which objects I omitted.

How do you ensure that a response with an incomplete pack data would
not corrupt the repository when the sending side configures
upload-pack with this option?  How does the receiving end know which
objects it needs to ask from elsewhere?

Or is the data integrity of the receiving repository is the
responsibility of the receiving user that talks with such a server?
If that is the case, I am not sure if I want to touch such a feature
even with 10ft pole.

Is there anything the sender can do but does not do to help the
receiver locate where to fetch these missing objects to fill the
"unfilled promises"?

For example, the sending side _could_ say that "Sorry, I do not have
all objects that you asked me to---but you could try these other
repositories".
