Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B50111D
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="chwkANaB"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4B910F6
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 19:14:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E1F313530D;
	Tue,  7 Nov 2023 22:14:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=krUTeaxotdMXmgUoYuRobYGSdp8rIa+xjt32LY
	1euvg=; b=chwkANaBRfAHm2TNc5eko87Mokysi4gTcbWr3rJFNpt6/sSrUTj8oy
	3ZpRKZ6pfYhuCmc0HVdqgGqBR5r9MjW/mm/m1y4AlPcm0bMYJ/pRcEJBwy5t5sUi
	nK1EtgAnf71m0MVov1gl6BvEmXG1RRig3Cjwz5gQp1XKq0YLXhQh4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DA0B43530C;
	Tue,  7 Nov 2023 22:14:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7766A3530B;
	Tue,  7 Nov 2023 22:14:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Victoria Dye via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 8/9] for-each-ref: add option to fully dereference tags
In-Reply-To: <cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com> (Victoria Dye's
	message of "Tue, 7 Nov 2023 17:13:52 -0800")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
	<ZUoWWo7IEKsiSx-C@tanuki>
	<cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com>
Date: Wed, 08 Nov 2023 12:14:02 +0900
Message-ID: <xmqq4jhx7x8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DF289BBE-7DE4-11EE-812C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Victoria Dye <vdye@github.com> writes:

> I think `^{}fieldname` would be a good candidate, but it's *extremely*

Gaah.  Why?  fieldname^{} I may understand, but in the prefix form?

In any case, has anybody considered that we may be better off to
declare that "*field" peeling a tag only once is a longstanding bug?

IOW, can we not add "fully peel" command line option or a new syntax
and instead just "fix" the bug to fully peel when "*field" is asked
for?

An application that cares about handling a chain of annotatetd tags
would want to be able to say "this is the outermost tag's
information; one level down, the tag was signed by this person;
another level down, the tag was signed by this person, etc."  which
would mean either

 * we have a syntax that shows the information from all levels
   (e.g., "**taggername" may say "Victoria\nPatrick\nGitster")

 * we have a syntax that allows to specify how many levels to peel,
   (e.g., "*0*taggername" may be the same as "taggername",
   "*1*taggername" may be the same as "*taggername") plus some
   programming construct like variables and loops.

but the repertoire being proposed that consists only of "peel only
once" and "peel all levels" is way too insufficient.

Note that I do not advocate for allowing inspection of each levels
separately.  Quite the contrary.  I would say that --format=<>
placeholder should not be a programming language to satisify such a
niche need.  And my conclusion from that stance is "peel once" plus
"peel all" are already one level too many, and "peel once" was a
very flawed implementation from day one, when 9f613ddd (Add
git-for-each-ref: helper for language bindings, 2006-09-15)
introduced it.


