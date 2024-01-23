Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740665F555
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031151; cv=none; b=dPZOKPzMLEw0CCwGuHk0qR6g0dcIl2b8/MV7DEsmvdQcMYwOuq09ncQnpz9UzpRsS1Cfqxcte6iUb/GhrWrVPc8UtarxgOtJDvhGv7SpNEPYst6RfOQGLiPGxeY35jvq936fXpJCrj4GtCr+SRGGxLI8tNT6FFOM9ZBRaoVkk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031151; c=relaxed/simple;
	bh=7qiJSXnxaC1mK/2uwF2LNkD2o3pFShMkb+EcLCPezbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3++5Fa1griCnhn0aQmaqBjZ1uuLBuUpNQXXK4JFHVBKgYze8wCuGf1jXVIDvlvqnohgisWLkZna+YLcyEDc7mDvIxG9qQ7mL7U2aAQMjDoz1AifSeKrS3MycjaRo+QNyWicuxE1Tw4CotG2/n5QUQGKsyaCjt1Zb6xdsPM6AkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZeJhFiSn; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZeJhFiSn"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 96B6E1B1DB;
	Tue, 23 Jan 2024 12:32:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7qiJSXnxaC1mK/2uwF2LNkD2o3pFShMkb+EcLC
	Pezbw=; b=ZeJhFiSnbmX7RVRDFXUr3JaywKNlm20KZA8UJop/WJWh+Zb6i9/8d3
	D9uOTRpcACFnFtWQK6qyjfQKCO+sBQBVEiTDCQr92wD3De3MPemvKq+BV/zn/MuO
	vRt3T3ApN/KKGOWEti6G6sJYu8nAhtcNLV0o1RMF3zY7+EkzacPs8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F25B1B1DA;
	Tue, 23 Jan 2024 12:32:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28DB91B1D9;
	Tue, 23 Jan 2024 12:32:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust
 redundant commit handling
In-Reply-To: <CAHPHrSd8rLj_TDE11dYQW+51--8YC4rumnfT+v2bYr+K7AMQrQ@mail.gmail.com>
	(Brian Lyles's message of "Mon, 22 Jan 2024 23:23:17 -0600")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240119060721.3734775-5-brianmlyles@gmail.com>
	<06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
	<CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
	<10838549-c364-429b-a086-68a41b7369de@app.fastmail.com>
	<CAHPHrSd8rLj_TDE11dYQW+51--8YC4rumnfT+v2bYr+K7AMQrQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 23 Jan 2024 09:32:24 -0800
Message-ID: <xmqqa5owot07.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5FF1E1A8-BA15-11EE-972C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Brian Lyles <brianmlyles@gmail.com> writes:

> I do see that there are ~130 files with trailing whitespace in maint
> today, though I suspect that most of those are not intentional.

I got curious and took a look at files that has hits with "lines
that end with SP or HT":

    $ git grep -l -e '[  ]$'

There are some that can be cleaned up, but many of them are
intentional.

For example, CODE_OF_CONDUCT.md has these two (shown with $$$)
I think can be removed without breaking markdown:

    Community Impact Guidelines were inspired by $$$
    [Mozilla's code of conduct enforcement ladder][Mozilla CoC].

    For answers to common questions about this code of conduct, see the FAQ at
    [https://www.contributor-covenant.org/faq][FAQ]. Translations are available $$$
    at [https://www.contributor-covenant.org/translations][translations].

The one in Documentation/user-manual.txt is on borderline.  They
appear in a sample output from a command the user is typing (again,
$$$ shows where the SP at the end of line is):

    diff --git a/init-db.c b/init-db.c
    index 65898fa..b002dc6 100644
    --- a/init-db.c
    +++ b/init-db.c
    @@ -7,7 +7,7 @@
     $$$
     int main(int argc, char **argv)
    ...

As its purpose is to show human readers what they see in their
terminal should _look_ like, we _could_ do without the single space
on these otherwise empty lines, which denotes an empty line that
hasn't changed in the diff output.  But it would no longer match
byte-for-byte with what we are trying to illustrate.

There are many hits from the above grep in t/t[0-9][0-9][0-9][0-9]/
directories; these are canonical/expected output used in tests and
the spaces at the end of these lines are expected.
