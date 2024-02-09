Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D07B3EE
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498601; cv=none; b=pWY6xo/rc4IW0jA6fQJmiZbyXvGd55BCwfon7ZHYrnQxv4DWw9CH4XVLEgBMT4jHgifdsw7Ub6FAwNYcNw4541B6cPzPOLTt1R1iTh4Zxutk540HTmQjymcULuH0K329KjJkqmCdXHb68RJ/eEh4kKJk2utbY0QaW5uOV03nkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498601; c=relaxed/simple;
	bh=XebOG82bx84nEX2XWsl+rOeLdqRnNk3vrLT7S4RkqUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NRRGo853wTeicgar/yG7mUi/a+E3/ut2YHbZUgkH747JuqmSaT7SaN6N58BmiyzQ45soaQOh/43hgwi3tV8lqt1mbbQcTRdo2ue8lI84Eh03XDMTIyH53R5w3MVZ2GpGvlIwfiqPzSG2bQAg/DKcvfYNRhGaGCMVfMw4PKGUVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hTB3V+kR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTB3V+kR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 73C851EA27;
	Fri,  9 Feb 2024 12:09:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XebOG82bx84nEX2XWsl+rOeLdqRnNk3vrLT7S4
	RkqUA=; b=hTB3V+kRjWLQrQpsScNAcIksVx5E25ogW6lTnddeN3keBXSkgcWGvB
	ueRLBWx1JhN5WL4PTNWCmewCD9H7JL2MTn6phJGkAmxUqaztBZGd2Q1IniZNE4dp
	MLYUAYZ7ld71WEPTKrj1FGyMlz6zlt7Ipy6HSiFd+h0dhGt0HcFDM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C6E71EA26;
	Fri,  9 Feb 2024 12:09:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87D111EA25;
	Fri,  9 Feb 2024 12:09:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: libification: how to avoid symbol collisions?
In-Reply-To: <CAO_smVji5aGjx1V-EGbumRRpOuGY0SkXZUn9g4LxKmMO3aw=Sg@mail.gmail.com>
	(Kyle Lippincott's message of "Thu, 8 Feb 2024 18:30:22 -0800")
References: <CAO_smVji5aGjx1V-EGbumRRpOuGY0SkXZUn9g4LxKmMO3aw=Sg@mail.gmail.com>
Date: Fri, 09 Feb 2024 09:09:53 -0800
Message-ID: <xmqqil2ximxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0C8959FE-C76E-11EE-ABFB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> If I'm right that this is an issue, does this imply that we'd need to
> rename every non-static function in the git codebase that's part of a
> library to have a `git_` prefix, even if it won't be used outside of
> the git project's own .c files? Is there a solution that doesn't
> involve making it so that we have to type `git_` a billion times a day
> that's also maintainable? We could try to guess at how likely a name
> collision would be and only do this for ones where it's obviously
> going to collide, but if we get it wrong, I'm concerned that we'll run
> into subtle ODR violations that *at best* erode confidence in our
> library, and can actually cause outages, data corruption, and
> security/privacy issues.

If you end up with a helper function name "foo" that is defined in
our X.c and used by our Y.c but is not part of the published "git
library API", we may want to rename it so that such a common name
can be used by programs that link with the "git library".  We may
choose to rename it to "GitLib_foo".

Do we want to keep the source of our library code, which defines the
helper function "foo" in X.c and calls it in Y.c, intact so that the
helper is still named "foo" as far as we are concerned?  Or do we
"bite the bullet" and bulk modify both the callers and the callee?

I'd imagine that we would rather avoid such a churn at all cost [*].
After all, "foo" is *not* supposed to be callable by any human
written code, and that is why we rename it to a name "GitLib_foo"
that is unlikely to overlap with any sane human would use.

	Side note: if a public API function that we want our library
	clients to call is misnamed, we want to rename it so that we
	would both internally and externally use the same public
	name, I would imagine.

The mechanics to rename should be a solved problem, I think, as we
are obviously not the first project that wants to build a library.

If the names are all simple, we could do this in CPP, i.e. invent a
header file that has bunch of such renames like

    #define foo GitLib_foo

and include it in both X.c and Y.c.  But "foo" may also appear as
the name of a type, a member in a structure, etc., where we may not
want to touch, so in a project larger than toy scale, this approach
may not work well.

"objcopy --redefine-sym" would probably be a better way.  I haven't
written a linker script, but I heard rumors that there is RENAME()
to rename symbols, and using that might be another avenue.


