Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93752D2386
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532081; cv=none; b=Ijv2qOfVYmQQbwEShLjf/N/TRwiY0w/rOVJMQxW+7QWx3PsovEfRA9kHmopBXzmABudSQiGSFW29Wv6p6VebyfxBKF5b6OLHMqMgJCVnXBuC4TxwvxwCZLvQaF2JWFSTSjwDbSVv6JUiQxxWrF4pUjl0Efd00oDKrEP/b0iA/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532081; c=relaxed/simple;
	bh=xZujRXNUqejLAk4y2plKmajBU6UXiwiEnW4mhoP4tS0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Zs7XzImAFCy/DplzYtKWncI/D510RcHUpuNrBQsrEnNqmEIT5S6XVOyJgtzazlnZQcIsGabTvEGoN/dj4myBpC/sV6rY/HOhf2xTN1ovL/loXwGOQZV/v9w91p/LqKhggcGKvHJK0mZLZ5dGt5rBChk7gYkEmJaU3DijdG/QP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bXqx12J1Xz9tR4;
	Thu,  3 Jul 2025 10:41:09 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Jul 2025 10:41:06 +0200
Message-Id: <DB2AARC4OKR3.48T4CC70KBUC@buenzli.dev>
Cc: "Martin von Zweigbergk" <martinvonz@google.com>, "Patrick Steinhardt"
 <ps@pks.im>, "Andy Koppe" <andy.koppe@gmail.com>
Subject: Re: [PATCH] pretty: add X-Change-ID to mail formats
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Drew DeVault" <drew@ddevault.org>, <git@vger.kernel.org>
References: <20250703074952.20737-1-drew@ddevault.org>
In-Reply-To: <20250703074952.20737-1-drew@ddevault.org>

Hi Drew,

Thank you, this is exciting!

On Thu Jul 3, 2025 at 9:45 AM CEST, Drew DeVault wrote:
> I have refrained from implementing the git-am part of this work for now,
> on the basis that I'm not sure how downstream tools like Jujutsu would
> feel if git wrote the change-id header to new commits. Would that
> conflict with some internal deterministic process for coming up with the
> change-id that could come up with a different answer, leading to
> conflicts?

This would be no problem at all. Jujutsu would very much welcome if Git
preserved the change-id header, including for patches sent by email.
Jujutsu generates the initial change-id randomly and since any part of
the commit can change while the change-id remains stable, there is no
deterministic process that could be interfered with if Git wrote the
change-id header to new commits. So, there are no objections from my
side to implementing the git-am part as well. :-)

This can kind of be tested already. Because Jujutsu already writes the
change-id header and sends it via git push, it must also be able to
import those headers from commits it hasn't seen before. Possible steps
to verify this behavior:

* Create a repo with Jujutsu, make some commits, push them to a remote.
  (can be one on the local file system)

* Clone this repo via Git.

* (optional) Confirm with `git cat-file -p @` that the change-id header
  was preserved.

* Run `jj git init --colocate .` to upgrade the git repo to a jj repo.

* Run `jj log` and observe that Jujutsu correctly imported the change-id
  headers of existing commits it didn't know about previously.

Best regards,
Remo
