Received: from zulu.geekplace.eu (zulu.geekplace.eu [5.45.100.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF1181BAD
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.45.100.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405700; cv=none; b=XP7AYZfio2IR/B94muwX4aoNwebXuchVwJsttFgTiE4wOSIhHZ5U1cA8S40IYkPNKjhV5PW1epq5WzIyUJizOYX6KO9JgeM6SiY9BvaGAWeKUu5wi9awD6ekGagW63JbxNSuXItsTdOnz5ZNRxPXFY+Daek6eFUVVVZ9S+Rjga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405700; c=relaxed/simple;
	bh=t5jZs9qJrsCFHzEUVTH3ckypjR5FQ1LSmlheiOFSBgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+rPhiXuM6sRqfagMB5yyEPVWceih3RL4oukQWN+c/KJM3qnKg0Z+EXHAcMh4lYiv4akMxYGYUtBGwo+xCQHrnp4BgTvFWa2nyP3jNZHZxP1mcFxIVTN3CC1MMWg6SlirAg7ZzeIOQ/7FLANeAazoCPeUhPUcrWY4Ce3jSzAaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu; spf=pass smtp.mailfrom=geekplace.eu; arc=none smtp.client-ip=5.45.100.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geekplace.eu
Received: from neo-pc.sch (unknown [IPv6:2001:4091:a242:8321:34fb:50ff:feac:591b])
	by zulu.geekplace.eu (Postfix) with ESMTPA id CCE624A008B;
	Wed, 26 Jun 2024 14:33:38 +0200 (CEST)
From: Florian Schmaus <flo@geekplace.eu>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH 0/1] support GIT_IGNORE_INSECURE_OWNER environment variable
Date: Wed, 26 Jun 2024 14:33:30 +0200
Message-ID: <20240626123330.420227-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I could imagine that the safe-directory check was deliberately not
made controllable via an environment variable. However, git versions
with the safe-directory check gained adoption and we can now see that
there is some fallout caused by the check.

A prominent example is that git-daemon cannot export repos when
running under nobody (see https://bugs.gentoo.org/932091). Since the
'nobody' user typically has no home directory, the suggested fix

        git config --global --add safe.directory xxx.git

does not work. Likewise, adding it to /etc/gitconfig is also not
ideal, as it applies to every user.

In Gentoo, the safe-directory check can be completely disabled via a
USE-flag (i.e., Gentoo's mechanism for compile-time package
customization). However, I recently suggested to Gentoo's git-package
maintainers the following patch, introducing the
GIT_IGNORE_INSECURE_OWNER environment variable, as an alternative.

Being able to disable the safe directory check via an environment
variable allows for more flexibility, solves the issue described
above, and does *not* statically and globally disable the
safe-directory check. This was received with a positive response and
the patch will likely be applied by Gentoo.

But downstream patchery is always the second-best option. Therefore,
I hereby propose the patch to upstream.

Florian Schmaus (1):
  setup: support GIT_IGNORE_INSECURE_OWNER environment variable

 setup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.44.2

