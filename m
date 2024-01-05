Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5682F39AC5
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QXqbMhFt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 18F9B1B96DF;
	Fri,  5 Jan 2024 13:52:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1aPkPqtkRW43
	MHiCIVbJ44XghRK1D9e6Wg6fZ5K19lg=; b=QXqbMhFttqOByGWPy1Z9y3VsdTBP
	6NfGtoxSXoBzFPzUZQl92GsUGBshfM03aEmOdAT1vHIJfDo4HcuesjbkLOPTW6XT
	YxPW2zuEyPvqZqWKHdh1V3HbUVf0IxvRMLe2loM8tvLdkoxeGGsBTQ7CJBUQAlkN
	EaJrN3sHRgMAM88=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 10EC81B96DE;
	Fri,  5 Jan 2024 13:52:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F81C1B96DD;
	Fri,  5 Jan 2024 13:52:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [BUG] mv: can trigger assertion failure with three parameters
 (builtin/mv.c:481)
In-Reply-To: <d1f739fe-b28e-451f-9e01-3d2e24a0fe0d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 05 Jan 2024 18:41:35 +0100")
References: <d1f739fe-b28e-451f-9e01-3d2e24a0fe0d@app.fastmail.com>
Date: Fri, 05 Jan 2024 10:52:35 -0800
Message-ID: <xmqqil47obnw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 97AA54F4-ABFB-11EE-8FBA-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> You can trigger an assertion by giving these arguments to `git mv`:
>
>     <dir>/file <dir> <other dir>
> ...
>> What did you expect to happen? (Expected behavior)
>
> A normal error message if the command is nonsensical (I don=E2=80=99t k=
now; that=E2=80=99s
> not the point). Also `.git/index.lock` to be cleaned up.

Good find.

Not just that, but when the command fails in the middle like this,
it leaves the working tree in a half-updated state, i.e.

> ./bin-wrappers/git -C $dir mv $dir/a/a.txt $dir/a $dir/b

will first move a/a.txt to b/a.txt, then try to move a (actually,
all contents of it, including a/a.txt) to b/a and finds that "the
command is nonsensical" and aborts, and by that time, there is no
a/a.txt (i.e. the working tree has been modified).  The failure
should be made atomic, just like "git switch" to another branch may
stop _without_ touching anything in the working tree when it may
have to fail (e.g., due to a file being dirty).

Thanks for reporting, Kristoffer.

Any takers?

$ git shortlog --since=3D3.years -s -n -e --no-merges v2.43.0 builtin/mv.=
c
    15	Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
    10	Elijah Newren <newren@gmail.com>
     5	=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
     2	Junio C Hamano <gitster@pobox.com>
     1	Andrzej Hunt <ajrhunt@google.com>
     1	Calvin Wan <calvinwan@google.com>
     1	Derrick Stolee <stolee@gmail.com>
     1	Sebastian Thiel <sebastian.thiel@icloud.com>
     1	Torsten B=C3=B6gershausen <tboegi@web.de>
