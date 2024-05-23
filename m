Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC031F934
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484410; cv=none; b=RZfiQEfTMROi42Qs+OQMXZSbastJ3WFmnXmMZ9NAsZwL0ivQ8vXzTNUQp2zjxXh1AxpvjcVANyfQMlYqr+OOBFGCEz1pqJOZihvlf3T5mXiNab4c7Sg2gJ9MCZbmK6Xz6pifO2SMRH3q3Lh7IltZ8zncpJvb8g/ymX4NHzr+K3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484410; c=relaxed/simple;
	bh=DxbRY11/aWR/nbVsZo3NUyv51FO5vxQxk9Pa4FJdWSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fayER8DqC5XF6nMDXO1411VDr72F72Bv4ppiT9JXZGwqv4sinq+jPC8ny1B32njHERyW/YouNVb8LKWcg833fttk0qTCZ2hyM+OVcEQTeJ22YegMlr3xE6R27uivK+Lm3YIfJbo0QrZJv0WzY9SU4AEcfLCvFGebGh4n6LiJiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TowSsXJb; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TowSsXJb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 00AB32145D;
	Thu, 23 May 2024 13:13:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DxbRY11/aWR/
	nbVsZo3NUyv51FO5vxQxk9Pa4FJdWSs=; b=TowSsXJbnmfQmjd6angtVL9H4qUJ
	3ZPv3eK/nOaXxZgTA/5wVjgCSljgMNP7/YuiBLR3+d+uq9Tucrh/ePSBdE0fWyuu
	N9DZKjLfDm7xMlmnBhWqna9q1ff4GszrRqjde49YJZxhznrGOkoUh0r7fOGufFyH
	wSVzIiVJDfX59mk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ED2002145C;
	Thu, 23 May 2024 13:13:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92E5D2145B;
	Thu, 23 May 2024 13:13:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/20] config: plug various memory leaks
In-Reply-To: <b2f8878b55564c4bf4848642e419c44c1a9d9005.1716465556.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 23 May 2024 14:26:09 +0200")
References: <cover.1716465556.git.ps@pks.im>
	<b2f8878b55564c4bf4848642e419c44c1a9d9005.1716465556.git.ps@pks.im>
Date: Thu, 23 May 2024 10:13:24 -0700
Message-ID: <xmqq7cfkv4cr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C4198CB4-1927-11EF-A2B8-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

There seems to be a bit of problem with "git mailinfo" with this
patch.  No need to resend this series, as I think I can cope, but to
solicit help from folks diagnosing and fixing the issue with the
"git am" pipeline.

> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index 75216f19ce..7120030b5c 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
> =20
>  test_description=3D'test log with i18n features'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./lib-gettext.sh
> =20
>  # two forms of =C3=A9

You've been sending your patches as "multipart/signed" (which by the
way was cumbersome enough for me but that is primarily the problem
with Emacs/GNUS and we should handle multipart/signed well), whose
header reads like so:

Content-Type: multipart/signed; micalg=3Dpgp-sha512;
	protocol=3D"application/pgp-signature"; boundary=3D"ovDSRLSkA00eIgbN"

The "message" part in it says that it is encoded in iso-8859-1:

    --ovDSRLSkA00eIgbN
    Content-Type: text/plain; charset=3Diso-8859-1
    Content-Disposition: inline
    Content-Transfer-Encoding: quoted-printable

    ...
    diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
    index 75216f19ce..7120030b5c 100755
    --- a/t/t4210-log-i18n.sh
    +++ b/t/t4210-log-i18n.sh
    @@ -1,6 +1,8 @@
     #!/bin/sh
    =3D20
     test_description=3D3D'test log with i18n features'
    +
    +TEST_PASSES_SANITIZE_LEAK=3D3Dtrue
     . ./lib-gettext.sh
    =3D20
     # two forms of =3DE9

But the source in t/t4210-log-i18n.sh actually is written in UTF-8.
The thing is, the "-u" option (recode into utf-8" is supposed to be
the default for "git am", and it is passed down to the underlying
mailinfo machinery in builtin/am.c:parse_mail().

But apparently that is not working correctly.  I see in the patch an
unrecoded byte E9 in the resulting patch file that is fed to the
underlying "git apply" machinery, failing the application.

ANyway...
