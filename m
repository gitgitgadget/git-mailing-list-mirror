Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QD5papKq"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F144A0
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 07:11:32 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D1F1F1C7A38;
	Wed, 13 Dec 2023 10:11:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e15P/OH9UUgq9q0r5r3wvnihqLebjjcT4MZIhD
	lLjDg=; b=QD5papKqP8fElDMSmVdoZW7DNR2F1uX1IpwcntPt8Dco8IFggJcq9y
	0/xaSYhvsd76CrsmNLpcLklMuagr6AWnkTQuv67v3fG6PR9vUzy8O7b9UbgAewfx
	0DvYaV+lxjfDKzN0mhz6VR7AlB4Wcndei7YuBAbF8/mgaJnMOzQ4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C92ED1C7A37;
	Wed, 13 Dec 2023 10:11:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 319631C7A36;
	Wed, 13 Dec 2023 10:11:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
In-Reply-To: <ZXlbNlG28e1sAYPU@tanuki> (Patrick Steinhardt's message of "Wed,
	13 Dec 2023 08:20:22 +0100")
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
	<xmqq8r5zrzg1.fsf@gitster.g> <ZXlbNlG28e1sAYPU@tanuki>
Date: Wed, 13 Dec 2023 07:11:28 -0800
Message-ID: <xmqqr0jqnnmn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E443D5A4-99C9-11EE-9198-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> I do not think "prefer host Git" is necessarily a good idea; falling
>> back to use host Git is perfectly fine, of course.
>
> Why is that, though?

Mostly because your "differences in features supported by just-built
one and what happens to be on $PATH can cause problems" cuts both
ways, and as a general principle to work around such issues, using
just-built one is a better discipline.  The features the build
infrastructure ("self-checks" being discussed is a part of it) of a
particular version of Git source depends on are more likely to be
found in the binary that will be built from the matching source,
than what happens to be on $PATH that may be from a year-old version.

As you said, you'd need to accomodate need for those who are
initially porting or building Git on a host without an installed
one.  If we were doing a cross build where just-built on would not
be executable on the host, whatever version on $PATH (or in
/usr/bin) may have to be used, but then in such a case you would not
be testing on host anyway.  For these two reasons, it is a given
that one of the choices has to be to use just-built one.  We can
safely give lower precedence to the host tool.

The only one-and-half practical reasons we may want to fall back to
whatever happens to be on $PATH are:

 - just-built one is so broken that even the simple use by the build
   infrastructure (like "self-checks") does not work (but then it
   becomes "if it is so broken, fix it before even thinking about
   running tests", and that is why I count it as half a reason), or

 - we are bisecting down to an ancient version, and just-built one
   from such a version may not understand the current repository.

so I do think it is an excellent workaround to fall back to a
version of Git with unknown vintage that happens to be on $PATH,
than failing and stopping by relying only on just-built one.

> We already use host Git in other parts of our build
> infra, and the options we pass to git-diff(1) have been around for ages:

It only argues for "trying host one, if available, before just-built
one does not hurt for this particular case".  But I was interested
in laying out a more general principle we can follow in similar
situations in the future.
