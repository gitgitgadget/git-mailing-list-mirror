Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E021B86DC
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722138865; cv=none; b=gKzyfySL75bxyDe2E1bIj0jSjlvEQgTcioxP7J1yEdAcX3QuWvLFHund1/ZbkwDMReYGdEO9uSV+Tlhu03iba924tuHG5kZ28F5QRWs7AODrZ7ySnZznC+gShbESwqFiZR0qbyUYpQZX7lcqOVrV/3YsqvuKGGiKmsc33XpMau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722138865; c=relaxed/simple;
	bh=ZECn+4h9LvG8bbciZEhvJKcJoZLvnnU696g7HEmL6Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sERJx4GrKY6v5T3Iw20r2TzT5dIYnBmS48ltPbThMZl/U2JywZHndCFtCqYGJZqFBsvq4nZ6oc5xM7jqIELR5YByxQvwx7VCOMnu2BS8YHv9eqItpvY3/4XXlzFuhTDLW4NqChzw073TLT/GUKEpdl64cT81wkyAOihX3DjE5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cSgZ+ejI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cSgZ+ejI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4760818A80;
	Sat, 27 Jul 2024 23:54:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZECn+4h9LvG8bbciZEhvJKcJoZLvnnU696g7HE
	mL6Fw=; b=cSgZ+ejIM2ggtJPHUs6TkUHc9iV+bixfGFWOeSjdGiOAaQHGZSla1R
	Et6VXUV/CQiuABM8tesFszJpwdhf3TIZz+dvkAK9S2yOZtN6ls6yhjDXMzGkHjjF
	cbCwf3CYPfA+omLdK4zKpJLOcvlUvXeRzRWF20bozIZ3DYbcYSPvs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 32A1C18A7F;
	Sat, 27 Jul 2024 23:54:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A38AB18A7E;
	Sat, 27 Jul 2024 23:54:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: Re: [2.46 regression] git ls-remote crash with import remote-helper
In-Reply-To: <20240727191917.p64ul4jybpm2a7hm@glandium.org> (Mike Hommey's
	message of "Sun, 28 Jul 2024 04:19:17 +0900")
References: <20240727191917.p64ul4jybpm2a7hm@glandium.org>
Date: Sat, 27 Jul 2024 20:54:13 -0700
Message-ID: <xmqqle1mrx22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E611E86-4C95-11EF-A5B7-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Mike Hommey <mh@glandium.org> writes:

> Running `git ls-remote $helper::$url` crashes when run outside a git
> repo and the helper uses the import feature.
>
> Here is a minimal reproducer:
> ```
> $ cat > git-remote-foo <<EOF
> #!/bin/sh
> echo import
> echo refspec '*:*'
> EOF
> $ chmod +x git-remote-foo
> $ PATH=$PWD:$PATH git ls-remote foo::bar
> ```
>
> The crash happens in parse_refspec in refspec.c, on a deref of the_hash_algo,
> because the_hash_also is not set anymore at that point since c8aed5e8da.

Thanks for a report, Mike.

Patrick, we have expected reports like this when we did c8aed5e8
(repository: stop setting SHA1 as the default object hash,
2024-05-07), so it is not very surprising.  In general, I think any
command that is designed to be usable outside a repository should
continue to fall back and use SHA-1, at least for now.  A command
like ls-remote _might_ want to do even better by waiting until it
has a chance to inspect what the other side said before setting the
hash-algo, or even better is to make it work without having any
concrete value in the hash-algo.  After all, when SHA-256
repositories become common out in the world, you should be able to
say ls-remote against them from your SHA-1 repository and the fact
that the hash-algo is read from local repository and set to SHA-1
should *not* negatively affect our ability to receive the ls-remote
response from SHA-256 repositories.  But that are all for longer
term future.  At least assuming SHA-1 like we have always done
should be better than the current situation.

Thanks.


