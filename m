Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769E3E46A
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gNZcc3EX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 448AA38A16;
	Tue,  9 Jan 2024 17:32:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KI3R17kUQ/0J
	GwwC2shJ3+C5G/eyRZT/cCHRiPNhOzI=; b=gNZcc3EXIO+OAl7wdgyRSzO++csj
	cu6Q8tuDwI6C7j8SJf+vrG5NQh3nxauLloNDGsIRXuHb/LgrPolX+Xq6bbr3nyoi
	Kq5k16Eh7aq0h5S838bb3hGs9i180E6Ru69Q58M7FhH/IuhFOF2yLM4KZTHnVMw8
	3WWc6jbW8Vti4U4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CE9338A15;
	Tue,  9 Jan 2024 17:32:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D50738A13;
	Tue,  9 Jan 2024 17:32:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <ZZ2QafUf/JxXYZU/@nand.local> (Taylor Blau's message of "Tue, 9
	Jan 2024 13:28:57 -0500")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<ZZ2QafUf/JxXYZU/@nand.local>
Date: Tue, 09 Jan 2024 14:32:20 -0800
Message-ID: <xmqq8r4yf897.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F44D383E-AF3E-11EE-AFB9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jan 09, 2024 at 04:25:32PM +0100, Rub=C3=A9n Justo wrote:
>> Using advise_if_enabled() to display an advice will automatically
>> include instructions on how to disable the advice, along with the main
>> advice:
>>
>> 	hint: use --reapply-cherry-picks to include skipped commits
>> 	hint: Disable this message with "git config advice.skippedCherryPicks=
 false"
>>
>> This may become distracting or "noisy" over time, while the user may
>> still want to receive the main advice.
>>
>> Let's have a switch to allow disabling this automatic advice.
>
> I reviewed this and had a couple of notes, mostly focused on what to
> call the new configuration option, and if we should be modifying the
> test-tool helpers to accept arbitrary configuration via command-line
> options.
>
> I think that we could reasonably drop the first two patches by
> imitating the existing style of t0018 more closely, but I don't feel al=
l
> that strongly about it.

Even though I do not have a fundamental objection against test-tool
learning "-c key=3Dval", I do not see a strong need for the first two
steps, either.

I actually have more problems with the primary change of this series
(in addition to that configuration knob is probably misnamed, as you
pointed out).  How to disable the advice is an integral part of the
end-user experience about the conditional advice system.  The idea
is to show it repeatedly, perhaps loud enough to be called "noisy",
so that the user learns to follow the suggestion given by the hint.
Until then, the user is expected to gradually learn to follow the
suggestion more and more, seeing the advice message less and less
often.  If we rob the "how to disable THIS PARTICULAR message" and
gave only this line:

>> 	hint: use --reapply-cherry-picks to include skipped commits

it would become impossible to find how to disable it, once the user
get comfortable enough to pass --reapply-cherry-picks when it is
appropriate to do so.  I do not think there is no quick way other
than grepping in the source to find that the user needs to disable
the skippedCherryPicks message (no, you can look at the output from
"git config --help" and find "skippedCherryPicks" if you know that
is the symbol to be found, but there is nothing to link the above
hint message to that particular help page entry).

I would understand if the proposed change were to change the
"advice.<key>" configuration variable from a Boolean to a tristate
(yes =3D default, no =3D disabled, always =3D give advice without
instruction), though.  IOW, the message might look like so:

    hint: use --reapply-cherry-picks to include skipped commits
    hint: setting advice.skippedCherryPicks to 'false' disables this mess=
age
    hint: and setting it to 'always' removes this additional instruction.

Then, those who find the hint always useful (because the particular
mistake the hint is given against is something the user commits very
rarely and the convenience of being reminded when it happens, which
is rare, outweigh the burden of learning what is suggested) may want
to set it to 'always' to accept that new choice.

But not the way the new feature is proposed.

Thanks.
