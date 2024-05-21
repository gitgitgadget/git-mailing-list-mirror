Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C31DA53
	for <git@vger.kernel.org>; Tue, 21 May 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278067; cv=none; b=IDi/AkSIFVpCPLTAabNNA2U+yp92WEvUiRH0cR9tpoOsVGOvoN8M8V5qeJzf9Rr0xjJQHvQ7IpnAgU9iOQZTfGcEiojJOigS/8VDmqXXCFqePwwoy3TfgKPUH9N+angFJ+dLr2wmrE0cdUGFetbZDx3sMfqK9gQZJxh+ESHIhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278067; c=relaxed/simple;
	bh=6EqyvZwoV2J5F7o6M6M6IZioPOqsXHVBnRP8gmoxVgg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RZ4T5D7Pp5BU64BkA1vnSIwhEfmFkpNg2H/Clv8RiAl4SixIR0J3gk9kdIa/DuXetc6VACb3ysbBAZ0Lr/Ao0QiOOa0fwQ4fqhisUgcE5vjLvUhnAq7K4Smb4qlWG9O0QTe4eQhiD06HMyWezOYCnarYQYk8quJ917DE76amr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=EKKwFaRY; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="EKKwFaRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716278056; x=1716537256;
	bh=epHGgD+8tAF4+BHLk0US9AXz7/vB5lx2iTmLdZ9OZgU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EKKwFaRYvGb3UmyMMCaCQ6uKnZcbBvL2VDccN09kKiVQyQBzRCEl/33oG29PcDseY
	 1jGYs0+JH2Qd4ZPZn7Kll9tsdo7nHSzq59U+sKyQnU5au4/aAs7HVDUp1ab7S3xPUd
	 +vAcYQa1+LjX3apZ0BJhX0qRVbDYnvkyW537VhGXsbDe7LKcSSSPYtVciv23vmI99p
	 PvQ7COIpPvdFCFV9FmoHdCZyd0RgWY9DqtUsoxA/vuLRUsQfGSrWGwEOhSSPcPuIAc
	 P5A22PSBpnSg7JBH3oReUuQ3JvHNavTkJ5fHcNiuhsAJcTaIHd2vWwsCGpWUVhAUHP
	 Vvz6fzL330j0g==
Date: Tue, 21 May 2024 07:54:11 +0000
To: git@vger.kernel.org
From: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: ps@pks.im
Subject: git init BUG when gitconfig has includeIf
Message-ID: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
Feedback-ID: 1233518:user:proton
X-Pm-Message-ID: 9805230f72fa7ecfdb9c54a394d17412b24fc39c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello everybody

Yesterday I stumble upon a bug when doing git init. I didn't
find any references to it, so I don't know if is a known problem
or not.

Steps to reproduce:
# git init .
BUG: refs.c:2123: reference backend is unknown

I'm able to reproduce this on multiple systems where the git
version is newer than v2.44.0. This happens only when I have
an "includeIf" in the ~/.gitconfig . Bellow [1] I have a
minimal configuration for reproducing the bug. With same
gitconfig but versions lower than v2.43.4 the error is
no longer happening.

So I went and did a git bisection and the error appeared with
173761e21b setup: start tracking ref storage format
Previous commit ("0fcc285c5e") is working fine.

I cc'ed Patrick Steinhardt since the error appeared from his
commit.

Best regards,
Razvan

--

1:
content of ~/.gitconfig
```
[user]
        email =3D some_email@test.net
        name =3D test
[includeIf "onbranch:upstream*"]
        path=3D~/.gitconfig_upstream
```

content of ~/.gitconfig_upstream
```
[user]
        name =3D test test
```

