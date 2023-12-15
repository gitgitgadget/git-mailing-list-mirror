Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351346556
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lR/Dk8qe"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CA3C28143;
	Fri, 15 Dec 2023 16:21:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=p0lkbi91EfoLuA2Q6FNaGC7c1lOp8Z4Ksju14G
	JsDeU=; b=lR/Dk8qegbxMS6e0FJDl5KGXYWkS1JrqvqWCGwLPDx5t9Vj3+Frcbc
	VIV/DNf7hBJKrfT5SE4GjwP8h5+miSzPrHccxh5F2qV0RFhy23QZnuJ9KB1LnNtD
	LuGmFYGHsnQ62dF9F05Q99tjF6UD81D05iinmBVZEvl8Cpgsa9FW8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 54F6128142;
	Fri, 15 Dec 2023 16:21:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EFE3928141;
	Fri, 15 Dec 2023 16:21:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/5] make room for "special ref"
In-Reply-To: <20231215203245.3622299-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Fri, 15 Dec 2023 12:32:40 -0800")
References: <20231215203245.3622299-1-gitster@pobox.com>
Date: Fri, 15 Dec 2023 13:21:10 -0800
Message-ID: <xmqq5y0zkvqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DF0EB7DA-9B8F-11EE-A8BB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> ...  For example, FETCH_HEAD currently stores not
> just a single object name, but can and is used to store multiple
> object names, each with annotations to record where they came from.
> There indeed may be a need to introduce a new term to refer to such
> "special refs".

The "may be" here vaguely hints another possibility.  If we manage
to get rid of the "special refs", we do not even have to mention
"special refs", and more importantly, we do not need extra code to
deal with them.

For FETCH_HEAD, for example, I wonder if an update along this line
is possible:

 * Teach "git fetch" to store what it writes to FETCH_HEAD to a
   different file, under a distinctly different filename (e.g.,
   $GIT_DIR/fetched-tips).  Demote FETCH_HEAD to a pseudoref, and
   store the first object name in that "fetched-tips" file to it.

 * Teach "git pull" to learn what it used to learn from FETCH_HEAD
   (i.e., list of fetched tips, each annotated with what ref at what
   repository it came from and if it is to be merged) from the new
   "fetched-tips" file.

The "special" ness of FETCH_HEAD is really an implementation detail
of how "git pull" works and how the findings of "git fetch" are
communicated to "git pull".  The general refs API should not have to
worry about it, and the refs backends should not have to worry about
storing more than just an object name (or if it is a symbolic ref,
the target refname).

An end-user command like "git log ORIG_HEAD..FETCH_HEAD" would not
be affected by changes along the above line, because the current
FETCH_HEAD, when used as a revision, will work as if it stores the
single object name that is listed first in the file.

If somebody is reading FETCH_HEAD and acting on its contents (rather
than merely consuming it as a ref of the first object), perhaps
feeding it to "git fmt-merge-msg", they will be broken by such a
change (indeed, our own "git pull" will be broken by the change to
"git fetch", and the second bullet point above is about fixing the
exact fallout from it), but I am not sure if that is a use case worth
worrying about.

Hmm?
