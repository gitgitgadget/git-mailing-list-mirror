Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49248A3C
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705713752; cv=none; b=Cmfcsq0g9mk38zeyaAVoT96+MAg9SrryMVGeJG5DCiK61Qn5dqc8eQyKKiSHYw909OUu90ZAcdyg2Y5LBsb1L4X4HpezoLISWi3F3PzdcZK4WVUlk7gwqzQZ972cBCFhdzw4EjI0ooM214SUk//4RIptyspkX98UeQLeiBLNAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705713752; c=relaxed/simple;
	bh=Y1kL6X8dBOVXDizDBOlWiolorteXfFBM3zXQfZxJRJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uoZOIu2pf/EYeY+EyQ9tUbnAvE5tiqj2jgQd2Wc1jbq2DkU7Waf0z0b9GmRZx/diSDY0Iuh6jDBFRAhd/7FcckVF0QMKW5PAeXZPYHAjXLSKkrCW5eCTscakx+nfEm4d6W5mO6luJ6B5VMplfSk6mSyJXzE9E2aYWM63/Ys+ZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HysAA2Lt; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HysAA2Lt"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 70FFC2269E;
	Fri, 19 Jan 2024 20:22:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y1kL6X8dBOVXDizDBOlWiolorteXfFBM3zXQfZ
	xJRJE=; b=HysAA2LtcqbDjihYFjxnEjTgNb4GzZuc1MkQvIdFMUQetkCeUpLqul
	8a3HOUwxxdgpfK558s3rqXkjDmzZDJiA8xsioDWibybMh4/kAmZdmbjjkQLZjzFc
	vjNNCpXIrIrUj7QsRGMFhzxfYsGhLybkpUu3aW0ximd7VKTksMIrU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A88F2269D;
	Fri, 19 Jan 2024 20:22:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D82D72269C;
	Fri, 19 Jan 2024 20:22:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Frank Schwidom
 <schwidom@gmx.net>,  git@vger.kernel.org
Subject: Re: partial commit of file-to-directory change, was Re: Bugreport
In-Reply-To: <20240120004628.GA117170@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Jan 2024 19:46:28 -0500")
References: <20240119132551.GA31532@debian64>
	<ZasCZ0YetzmlBFvw@tapette.crustytoothpaste.net>
	<20240120004628.GA117170@coredump.intra.peff.net>
Date: Fri, 19 Jan 2024 17:22:19 -0800
Message-ID: <xmqqmst0hk8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5BA764E6-B732-11EE-B673-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> It might also be that the bug is earlier in list_paths(), where we
> should notice that "d" is gone and now we have entries under "d/".

We had a related discussion on "commit -i/-o tests" review thread,
where we noticed that "git commit -i foobar", when "foobar" does not
match any path in the index, silently ignore that unmatching
pathspec (but "commit -o foobar" does error out, saying "did not
match any file(s) known to git").  The important design decision we
made long time ago when we introduced partial commit ("commit -o
pathspec") is that we do not _add_ paths (that match the pathspec)
that are not tracked.  We require explicit "git add" for them before
you run "git commit".

So, I suspect that list_paths() that gives "d" as a thing to add is
broken.  "commit -m + ." at that point is saying "we should get the
latest contents from the working tree for all the paths in the real
index, add[*] them to the temporary index freshly read from HEAD,
and the resulting temporary index should be written out as a tree"
to create a commit, and then "the same set of contents for the paths
then should be added to the real index, so that the differences
between the tree we wrote out of the temporary index to update the
HEAD and the real index would still be the changes already in the
index before this partial commit".

    Side note: here, "add" would include removing (if the working
    tree file for the path is gone) or killing 'd' while adding
    'd/b.txt'.

So I would understand if 'd/b.txt' is listed (because in the real
index there already is d/b.txt known), but if the directory 'd'
itself is listed, that does sound like a bug.
