Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DC27F182
	for <git@vger.kernel.org>; Wed, 14 May 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234142; cv=none; b=P332SfT3vp7dK7qYTnV6F6ISfKcWonzVl6+9CURguodpN2tIhtR47yZ56VSzMpPrelN0VovYmR3RqfjfZwFdLTRJZe2T//e1vCy2bgCQg7/HlJuffPC7EVpBWIJsrglFvDH+q8hFnNDoibCXpsFTUp4Fr3rzobYUh9ej29TgtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234142; c=relaxed/simple;
	bh=iAj4CopZ1w4a1mCBNiPjXxIGWBAVb4ZAKn40nGnnxTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C83xXBUcImbTxVasm0jmXVESnZ9cAlpGGv3g+lo3QIg5fXuVHooMfSCS+ChoClMMVEvzpTw0ciE+fFJiRpQs1fopjiEArFpu3dE6tu3m1V/HdTFmwu8Y9wLTDy3BxWsnvPsmtV+6kZgUn0tGnCT7jb+bAA3wuGv2eqqsrTwDqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=DhnTiD6i; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="DhnTiD6i"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747234137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ARa29RsbyKwU0gONGSQ00Zzdf+M9kHeYzA2THgaoHE=;
	b=DhnTiD6itajzOlJ8DnZxYYYYjfBEyf7UbRrP1OFh8orNRobWfFaI6PSn95Vwx9K/EthGEB
	xL2mEmKsnRLTrLI4wnWYW/gytWrd91Qto6UyqZdxjICe4sImhR+oSi8xCwhkbDFYsDQu+X
	ORT3jCYValDiupHo8Tk/i1RrT5+jUuc=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/17] object-store: carve out the object database
 subsystem
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
Date: Wed, 14 May 2025 16:48:47 +0200
Message-ID: <871psrjlio.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series refactors the object store subsystem to become more
> self-contained by getting rid of `the_repository`. Instead of passing in
> the repository explicitly, we start to pass in the object store itself,
> which is in contrast to many other refactorings we did, but in line with
> what we did for the ref store, as well.
>
> This series also starts to properly scope functions to the carved out
> object database subsystem, which requires a bit of shuffling. This
> allows us to have a short-and-sweet `odb_` prefix for functions and
> prepares us for a future with pluggable object backends.
>
> The series is structured as follows:
>
>   - Patches 1 to 3 rename `struct object_store` and `struct
>     object_directory` as well as the code files.
>
>   - Patches 4 to 12 refactor "odb.c" to get rid of `the_repository`.
>
>   - Patches 13 to 17 adjust the name of remaining functions so that they
>     can be clearly attributed to the ODB. I'm happy to kick these
>     patches out of this series and resend them at a later point in case
>     they create too much turmoil.
>
> This series is built on top of 6f84262c44a (The eleventh batch,
> 2025-05-05) with ps/object-store-cleanup at 8a9e27be821 (object-store:
> drop `repo_has_object_file()`, 2025-04-29) merged into it. There are a
> couple of trivial conflicts when merged with "seen", I have appended the
> merge conflict resolution as a patch at the end of this mail.
>
> Changes in v2:
>   - Fix for a copy-and-pasted commit message.
>   - Rename `struct odb_backend` to `struct odb_alternate`. I'm happy to
>     revert to the previous name if we ultimately think it's the better
>     suited one.
>   - A couple of fixes to move changes into the correct commit. `git
>     rebase -x 'meson compile -C build'` is now clean.
>   - I _didn't_ back out the rename to "odb.{c,h}". Junio has already
>     fixed the fallout, so it's probably more work for him to kick it out
>     again than to just leave it in.
>   - Link to v1: https://lore.kernel.org/r/20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im
>
> Changes in v3:
>   - Polishing for some comments and commit messages.
>   - Link to v2: https://lore.kernel.org/r/20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im
>
> Thanks!
>
> Patrick

The range-diff looks good, and I've got no further comments.

Only one small question though, what's the point of the compatibility
layer in the last 5(-ish) commits? I mean if we add temp wrappers for
other topics in flight, then when/how do we convert that new code to
stop using the wrappers? Won't we remain having issues because there's
always something in flight?

Cheers,
-- Toon
