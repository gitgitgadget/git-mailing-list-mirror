Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC0524A0
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775999; cv=none; b=OtVZrZypD/Cyoa3ts/6Gv1/erkTRitHYyDuF4Yqq+7zVsqJeeJUfyV/npsLllONGbbLthdsprdtX6JdIk5OHAoQyiNRawf3mR/DCabvJd63xCCRzFkueQpdopZnY7qpPJNYekLAiPrP8FsxRbB8+8ipabtmS44/4nTwwA5AkC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775999; c=relaxed/simple;
	bh=Aeba/vV8H9mObL9qMyriYJRCmVjKqIcrKBXdwB5M2vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qugQu8rEZQgRNHziZLk4hZCWZ/pSErecXqhQ0OnDIyROnv0nDhXoSRntYv6sjgS1+pjCrvdkkUJM+V24ESbyqnK/JniwCsANpy+EYr2SXMfAZPhJ1P5HDvt5B7pFarEivsQnqZjOmhYx3TxhaDXI2Nix9JCyHsP/RSOxNjppFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=FHkrYA2N; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="FHkrYA2N"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 6365860318;
	Mon, 18 Mar 2024 16:33:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710775995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TK8rnnvXURzd6wH95liJNWaVghzAkFbechuZIdlRrks=;
	b=FHkrYA2NRdT2NE8mmotn0AZ7k4lnrkpLwWk/DMrfPUtfmnPwgEYWhgBuD+zGFOTkDevsTo
	HPIkn5QOmqmYNTjgQ7alC4+w3DFuwaLT+enA8RwS9JgkQ66XsKHCIrU+Z7dJb0jYRyUYlb
	9+zugMUbY+0uk8EK3nzpt09peu0vGAOck3SMfAxet+eR51y70UmY8AVVYDf+nmHY0KC1YS
	eumViR2wN1RzViiIuEKm4Tp/TqRhoUX661KF/UyG3RdhsZNzPEWuda2yi1413vcTnPFY7l
	Hw3M9RnDcnscxtpFQyGpPBfdZLm6KCNUDcV/R1TbhUvqo4FLwJGqVqio4qLKsA==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>,
	Max Gautier <mg@max.gautier.name>
Subject: [RFC PATCH 0/5] maintenance: use packaged systemd units
Date: Mon, 18 Mar 2024 16:31:14 +0100
Message-ID: <20240318153257.27451-1-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please ignore the previous series, I messed up the cover letter and Cc
with git-send-email somehow...

-----

Hello,

This is a proposal to distribute the timers of the systemd scheduler of
git-maintenance directly, rather than inlining them into the code and
writing them on demand.
IMO, this is better than using the user $XDG_CONFIG_HOME, and allows
that user to override them if they so wish.

We also move away from using the random minute, and instead rely on
systemd features to achieve the same goal (see patch 2). This allows us
to go back to using unit templating for the timers.
(Not that even if we really more specific OnCalendar= settings for each
timer, we should still do it that way, but instead distribute override
alongside the template, i.e

/usr/lib/systemd-user/git-maintenance@daily.timer.d/override.conf:
[Timer]
OnCalendar=<daily specific calendar spec>

The cleanup code for the units written in $XDG_CONFIG_HOME is adapted,
and takes care of not removing legitimate user overrides, by checking
the file start.
Patch 5 removes the cleanup code, it should not be applied right away,
but once enough time has passed and we can be reasonably sure that no
one still has the old units laying around.

Testing:
The simplest way to simulate having the units in /usr/lib is probably to
copy them in /etc/systemd/user.

Unresolved (reason why it's still an RFC):
- Should I implement conditional install of systemd units (if systemd is
  available) ? I've avoided digging too deep in the Makefile, but that's
  doable, I think.


---
 Documentation/git-maintenance.txt     |  33 ++--
 Makefile                              |   4 +
 builtin/gc.c                          | 279 ++--------------------------------
 systemd/user/git-maintenance@.service |  17 +++
 systemd/user/git-maintenance@.timer   |  12 ++
 5 files changed, 63 insertions(+), 282 deletions(-)

