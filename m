Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CC1272C2
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632181; cv=none; b=mh05hLMZR3mBlVFk9g/lo6EguB66f+m1tBx2ZzH9rUwQFEOkhJVnC9W2hOFtKoPACX/6qi5Cg2ioWn3QSmqWFq2gYNmnBNebfy3u87PP2/bGsq0xlj3DwrLH8jYs2VFW2N/Fi5YP4IW8iu95MFdphPAvltbM+Toy6BfUM41DHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632181; c=relaxed/simple;
	bh=uR/2mbD4D/j62TAMA5JJSs/ob0n2sFVzo2xbNqks54o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F4pLSYDi4IFc+ZCmLL6e6YIbUtvNaPQcT73et9Q/Di7xtVnV0yYzJ9TVtKCp+cPmERLQ6ue9SxsjDaIlfAY+NXCTTJ6Rx0LbrivyqI8vAd7bwAvFQ2wv9jW9fp1MfnV1HCEo8nqXKbedfaZhBWowDaeRR/vlPsULa176f4Mpexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZI/sl0UF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZI/sl0UF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AD80A28793;
	Tue, 30 Jan 2024 11:29:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uR/2mbD4D/j62TAMA5JJSs/ob0n2sFVzo2xbNq
	ks54o=; b=ZI/sl0UF0AHid+J5XQRvgLN+nFVNB9LziF7cgKvCgqBLLK+fBGzVhd
	J1uxCybJlAXeMbrL8j+0sFFwU0+dIxiO4PfrH1DuGU8IZxwclyWauO7VT3nwFc1k
	qv8cBLn2ZBSDpPygqSI8MTzeK+48dYsfqknWZtyz19R4i8/B/7DJk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A709D28791;
	Tue, 30 Jan 2024 11:29:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2CEB28790;
	Tue, 30 Jan 2024 11:29:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Wilfred Hughes <me@wilfred.me.uk>,  git@vger.kernel.org
Subject: Re: [PATCH] diff: handle NULL meta-info when spawning external diff
In-Reply-To: <20240130060658.GD166761@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jan 2024 01:06:58 -0500")
References: <CAFXAjY7XcL1APhLRXU8TO96z=f7957f2ieK56dHVsXUay55vpg@mail.gmail.com>
	<20240129015708.GA1762343@coredump.intra.peff.net>
	<xmqqede0htp2.fsf@gitster.g>
	<20240130060658.GD166761@coredump.intra.peff.net>
Date: Tue, 30 Jan 2024 08:29:33 -0800
Message-ID: <xmqqa5omdbte.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C0ECD27A-BF8C-11EE-821C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> The current behavior is somewhere in between, though. You get an "other"
> name passed to the external diff, but the metainfo argument makes no
> mention of a rename (it's either blank for an exact rename, or may
> contain an "index" line if there was a content change).
>
> I'm not sure anybody really cares that much either way, though. It's
> external diff, which I suspect hardly anybody uses, and those extra
> fields aren't even documented in the first place.

Oh, we probably should fix the documentation eventually, then.

But I agree that in this case, whatever stops the segfault would be
good enough.

I am surprised to learn that this 8th hidden parameter dates back to
427dcb4b ([PATCH] Diff overhaul, adding half of copy detection.,
2005-05-21), and it is more surprising that even before it happened,
the external diff interface with 7 parameters was already
documented, which happened with 03ea2802 ([PATCH 2/2] core-git
documentation update, 2005-05-08).  Before the addition of the copy
detection, the presence of the "other" was how you learned if we saw
a rename (because there was no copy, the only reason "other" is
there was due to a rename).  With copy detection added, extra bits
of information needed to be passed and we started passing the
xfrm_msg as well through the interface.  At least, by dumping it to
the end-user, an external diff driver could help the end-user tell
if that "other" came from a rename or from a copy, even if it did
not understand it itself.

And of course, after merely 6 weeks since the inception, Git did not
have the "--no-index" mode (we did not even have a unified "git
diff" frontend), so this was never a problem back then.
