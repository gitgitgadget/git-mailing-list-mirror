Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820974A02
	for <git@vger.kernel.org>; Sat, 25 May 2024 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716597306; cv=none; b=XHI7ITWPQlnUjOxOZHMLkAOMaeICeU+SKmIdLOnTute5BlVZ2ehQ0fnEMrk23SsK39BsPMF3oQZIBzbOYicyDMIMZDjOmJ57i5GgHds0GkfFCF3FRPyNM2Od/2OiAwsOuBkUdzjb6hvAvLwzwzPc5Eu0v4UG57lf89NxsGjttrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716597306; c=relaxed/simple;
	bh=vtEKMnNt/fiS4DC6asL4NmQszwle2oPwULIjvvkABNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSM6GUfPDZ/Rsooit70fI8WMkWWfYWc4bf0CA4s8zFPHi7DwW/kgAMhwE66OclsjyCamQgBeynhiqHiehX3zqxVS4/RqZXD2PUL2T916ix87FV+/Zrw6+YNCiJ6vtyLeTIveVLEvu6kMj5Xk5kAaJm8k7KcQOP+9jNrTN7t6y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PLeQ5Bb2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PLeQ5Bb2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F219E2D0DF;
	Fri, 24 May 2024 20:34:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vtEKMnNt/fiS4DC6asL4NmQszwle2oPwULIjvv
	kABNg=; b=PLeQ5Bb2fTrIWqsoMok4WrdomxpjBJBAOvwoP7fPQHXwTeLDbs2Vke
	Od0tcv+9NJjo23qS4qlrqdrK56FpYItbFjG+GPDPFDPevMebB/bPpN+7P2+zobi4
	2eBOJchG2X9zB/iblNWxVnGKjiSeXSTYsye8qpkznJIplC3yr7Jtg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB0732D0DE;
	Fri, 24 May 2024 20:34:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C0572D0DD;
	Fri, 24 May 2024 20:34:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] alias: pass --help through to shell alias
In-Reply-To: <20240524070623.1344636-2-iwienand@redhat.com> (Ian Wienand's
	message of "Fri, 24 May 2024 17:04:14 +1000")
References: <20240524070623.1344636-2-iwienand@redhat.com>
Date: Fri, 24 May 2024 17:34:55 -0700
Message-ID: <xmqq8qzyk9u8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C3E7472-1A2E-11EF-9522-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> In trying to make some aliases more consistent in an internal tool, I
> implemented both -h/--help in the underlying command for a shell
> alias, and was a bit surprised when "git <alias> -h" worked but "git
> <alias> --help" didn't.

Yeah, with

    alias.lg=log --oneline
    alias.lgm=!sh -c 'GIT_NOTES_REF=refs/notes/amlog git log "$@" || :' -

"git lg -h" reports the alias, "git lg --help" does the same as "git
log --help", "git lgm -h" reports the alias, but "git lgm --help"
refrains from doing 

    sh -c 'GIT_NOTES_REF=refs/notes/amlog git log "$@" || :' - --help

and instead does the same as "git lgm -h" to report the alias.

This is a safe behaviour because the underlying command may not be
prepared to see "--help" and ignore it silently in the best case,
e.g.

    sh -c 'false "$@" || :' - --help

that would confuse users by being totally silent, or 

    sh -c 'awk "$@" || :' - --help

that gives "awk: not an option: --help" (which is less useful than
the report of alias), or even worse yet, if the underlying command
does not understand "--help" and considers it something different,
who knows what havoc it would wreak.

For the above reason ...

> I would propose that "--help" to a shell alias is passed through to
> the underlying command.  This way you can write aliases that act more
> like the other git commands.

... this is a dangerous thing to do unconditionally.

I wonder if we can come up with a notation to annotate aliases that
do support the "--help" option that wouldn't have been used by
mistake for existing aliases?
