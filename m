Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1237C9D
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PaoYavny"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F36CC
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 08:44:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9562B1CC2A8;
	Fri, 27 Oct 2023 11:44:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fIkZTkGUtSLV
	vRA5ZxJFcesHJm+8v7+eYho9RU8ORrY=; b=PaoYavny65gZ5PIETizV8CitQtsE
	ouWcpFYQZR8LkGpDGfQcOZGr06H9sEt+94ACdSlxrx6+Gptxyp97VYaLKVsKeusO
	ZhZyzYN8TEd7DAnsvwT4zNky/k1pUcx3JT9m3E7WN+2PFgm+91xZA4s2gup6KE9S
	6gkicfrrTcOF6Hk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AC301CC2A7;
	Fri, 27 Oct 2023 11:44:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC6D31CC2A6;
	Fri, 27 Oct 2023 11:44:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,  Jeff King
 <peff@peff.net>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>,
  Luben Tuikov <luben.tuikov@amd.com>,  git@vger.kernel.org,
  entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
In-Reply-To: <ZTp7xvXDw1GF-NUB@pobox.com> (Todd Zullinger's message of "Thu,
	26 Oct 2023 10:46:30 -0400")
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
	<20231020100442.an47wwsti2d4zeyx@pengutronix.de>
	<68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
	<20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
	<89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
	<20231024204318.gi6b4ygqbilm2yke@pengutronix.de>
	<20231025072104.GA2145145@coredump.intra.peff.net>
	<xmqqsf5xr1xk.fsf@gitster.g>
	<a71f2f1f-b5f0-4628-a4f3-6fd1319062a3@amd.com>
	<ZTp7xvXDw1GF-NUB@pobox.com>
Date: Sat, 28 Oct 2023 00:44:15 +0900
Message-ID: <xmqqedhgoysw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AFBB2922-74DF-11EE-AF19-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Todd Zullinger <tmz@pobox.com> writes:

> Alternately, perhaps having Email::Valid as an optional
> dependency is worth reconsidering. If it's truly important
> to validation, make it a requirement.  If it's not, then
> drop it to simplify the code and avoid these sort of issues.

Reducing the possible "valid" configurations we support is a very
tempting proposition.

> If I make the git package require it to ensure consistent
> behavior then some folks will -quite rightly- complain that
> it should not be a requirement.  If I keep it an optional
> dependency, then debugging becomes more difficult for the
> reasons we've seen in these recent (and not-so-recent)
> threads.

Very true.

> I'd lean toward dropping the dependency entirely and leave
> the more basic validation of git-send-email in place.  That
> may not catch every type of address error, but I would argue
> that what we do without Email::Valid is perfectly reasonable
> for checking basic email address syntax sanity.

Yes, it is very tempting, and given that we have to keep our
fallback codepath working for those without Email::Valid ANYWAY,
as long as the dependency is merely optional, I very much agree
with your argument here.

> On a related note, one issue=C2=B9 we had reported in Fedora
> after making Email::Valid a requirement was that it rejected
> messages where the local part was too long, per the relevant
> RFC's.  But these were generated addresses from GitLab.  The
> addresses worked in practice.  While Email::Valid was
> technically correct in rejecting such addresses, it didn't
> improve the experience of git send-email users.

I am of two minds here.  I can sympathize with both positions.

 - Trying to be strict to what we send out to the world by using
   Email::Valid that tries to be more RFC kosher matches "be strict
   in what you send out, be lenient in what you receive" mantra

 - Rejecting what works in practice and in real world tend to help
   users.

If we require Email::Valid, then sriking the balance between the
above two will entirely become the responsibility of them; any
end-user who complains "the validation is overly strict" will get
"talk to authors of Email::Valid".

If we ditch Email::Valid, it will become _our_ responsibility, which
means a bit of extra maintenance burden to this project.  But perhaps
it is worth it?  I dunno.

Having Email::Valid as an optional dependency does not place us in a
position better than either of these two, so from that point of view,
too, I like your "we should either make it required or unused, not
an optional dependency" very much.

Thanks.
