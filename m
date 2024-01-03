Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA271DA26
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IAnGB37b"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 134211DFB27;
	Wed,  3 Jan 2024 17:10:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qtU/b8CZzeK8kwhufXE5VUugogFmCmUgC9O1QW
	5sKp0=; b=IAnGB37bV0faqGLdNy43WDpr7rBj+D35/OsTr3hLuHSxWcnm7B7xLT
	gWw2BNkpeLQy9NqNqsz6Kc/3NahtF6AshlNZuK9dO/eKWhFwnM8WLajiG39f1pM8
	kZglUirX5Hmqd2Uyk5Z85BJ+/bMi+aGf2frwml4Kim02Nt1aBaPt8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B52A1DFB26;
	Wed,  3 Jan 2024 17:10:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76B911DFB25;
	Wed,  3 Jan 2024 17:10:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>,  Stefan Haller <lists@haller-berlin.de>,
  git@vger.kernel.org
Subject: Re: Concurrent fetch commands
In-Reply-To: <ZZWOBObBmLW9Nid6@nand.local> (Taylor Blau's message of "Wed, 3
	Jan 2024 11:40:36 -0500")
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
	<xmqqy1daffk8.fsf@gitster.g> <ZZUNxNciNb_xZveY@tanuki>
	<ZZUWmy3rTjpBsH-w@tanuki> <ZZU1TCyQdLqoLxPw@ugly>
	<ZZU5s4LKQF1NLgnC@tanuki> <ZZWOBObBmLW9Nid6@nand.local>
Date: Wed, 03 Jan 2024 14:10:56 -0800
Message-ID: <xmqqwmsq83v3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F867D3C0-AA84-11EE-9E03-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> ... I suppose the answer is that they expect
> concurrent fetches to be tolerated, but that the contents of FETCH_HEAD
> (and of course the remote references) are consistent at the end of all
> of the fetches.

What does it mean to be "consistent" in this case, though?  For the
controlled form of multiple fetches performed by "git fetch --all",
the answer is probably "as if we fetched sequentially from these
remotes, one by one, and concatenated what these individual fetch
invocations left in FETCH_HEAD".  But for an uncontrolled background
fetch IDE and others perform behind user's back, it is unclear what
it means, or for that matter, it is dubious if there is a reasonable
definition for the word.

Folks who invented "git maintenance" designed their "prefetch" task
to perform the best practice, without interfering any foreground
fetches by not touching FETCH_HEAD and the remote-tracking branches.

Nobody brought up the latter so far on this discussion thread, but
mucking with the remote-tracking branches behind user's back means
completely breaking the end-user expectation that --force-with-lease
would do something useful even when it is not given the commit the
user expects to see at the remote.  Perhaps those third-party tools
that want to run "git fetch" in the background can learn from how
"prefetch" task works to avoid the breakage they are inflicting on
their users?



