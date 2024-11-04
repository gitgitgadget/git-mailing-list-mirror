Received: from jupiter.mumble.net (jupiter.mumble.net [74.50.56.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7470816
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.56.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735444; cv=none; b=MaoorfLAFiF81pZWzpExg61KU0mib0PDOXYOTqE9AqlsVM6NGO96sdNgcT3Br9An+7TUE90jPALnUrisZJpOxmaunV2TXvIH8uNI46WYbVgq+J0U8AMYC+mja4y8bBS3EAF2BT8STyUpAIEyqo7hK5q522X7ICurpeZVrJeMkkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735444; c=relaxed/simple;
	bh=sB2yI7BDKWN2UlrfPuWuOO4K4w4ApkpOEMO5ZCD8yV8=;
	h=From:To:CC:In-reply-to:Subject:Date:MIME-Version:Content-Type:
	 Message-Id; b=d4pngn/KkILMfEvV4j6YABs974OOu03zxPXyuWCo57mGS1+sftM9z/DMilZ+NfarXva20fGlF1qw9pVAhLDBZOiiHrrqz4Ow0OgsCoRTPK0s17dZvGWsN0bmtaKhDebPhKYqjgrIgUZ7ITqZF2XocGIrCunhlj+aljFVVijl9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net; spf=pass smtp.mailfrom=mumble.net; dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b=fWNtjsPY; arc=none smtp.client-ip=74.50.56.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mumble.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b="fWNtjsPY"
Received: by jupiter.mumble.net (Postfix, from userid 1014)
	id 235E260AB3; Mon,  4 Nov 2024 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mumble.net; s=20240127;
	t=1730735441; h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=lyOWDJ8OJAgf/XwYFkveAOzJo2tE107ujIEKfI3cJfI=;
	b=fWNtjsPY7sVmTYmTeA2fo2uVn9mco4hG22xBWy7OWFKE4a8/D+1CW1qIB+xpuGiZ8VVl15
	aR8DBnkJuFjEU3dsR7hYVZCXXTr5vPHJvVQBss0d5AaF1n9mOeN5JWmMHEpQF3hZJCFjX1
	LUfRaYCDpCVeLsArGz0Juhsg0KOPTJE=
From: Taylor R Campbell <git@campbell.mumble.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
In-reply-to: <20241104-real-marmoset-of-success-9a6c8e@meerkat> (konstantin@linuxfoundation.org)
Subject: Re: Synchronous replication on push
Date: Mon, 4 Nov 2024 15:50:40 +0000
Sender: Taylor R Campbell <git@campbell.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241104155041.235E260AB3@jupiter.mumble.net>

> Date: Mon, 4 Nov 2024 09:40:06 -0500
> From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
>=20
> Alternatively, you can take a look at grokmirror, which is what kernel.org
> uses:
> https://pypi.org/project/grokmirror/
>=20
> It's pull-based instead of push-based, for several reasons:
>=20
> 1. We replicate to multiple worldwide frontends, and we expect that some =
of
>    them may be unreachable at the time when we attempt a push
> 2. This allows us to propagate repository deletes
> 3. This allows us to propagate details like descriptions and authors
>=20
> Grokmirror also has a listener daemon that can trigger a pull, so it's
> possible to have near-instantaneous replication by notifying the remote n=
ode
> that a repository has been updated and should be pulled.

Thanks, that looks useful, but it's not quite what I'm looking for.

Part of the goal is essentially the same (qualitative) types of
service guarantee that Github advertises:[*] once the user's `git
push' command has succeeded with nonzero exit status, the objects and
ref updates have been written to multiple backing stores so it would
take a failure of a quorum of those backing stores to lose the data.

In particular, a backend may reject an update, and when this happens
(in the multi-backend case, by enough backends that no quorum is
reached), the user who ran `git push' needs to know that it failed so
they don't, e.g., delete their branch, run git gc, and go on their
merry way having silently lost data.


[*] https://github.blog/engineering/infrastructure/stretching-spokes/
