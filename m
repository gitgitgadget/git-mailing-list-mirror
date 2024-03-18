Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53405024E
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775076; cv=none; b=srJGrh0zrw7vtYHyPX+kS9+cNC+nqSEjwk+feZOrDZ9a5LdUE85sU5/fy98DAXjMWfv4NGQZArUjDcp5tTK14GxHIO7skX/xQAbSZIsjoI3DPOcRKVfeaq9oscm+DJk1n8D/kgOya7xLOKi9E9yPhZt1uIXGxLwkBP4eh2tMI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775076; c=relaxed/simple;
	bh=YNa6/k7ZI5WNv6bn3Vn1eDEwJr4Juxh99rN1NMD1zO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tEfsdPVeh2C/+c4U8FvMd0NLji8UVcm0Ro58I51XufsAJG68iVeBmhZ81UDl41vM4ca4sf5HWWk6nb2mXK9oE0IlgSsOtXsJw5gUpG69GpamUnCMQZYMi/JhWiU3zr5vQI3Kyinqo/vV1Hhyqmd7acXuHHxQlGBeaLa5wyOByJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=cK43c1EA; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="cK43c1EA"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 2EDD460193;
	Mon, 18 Mar 2024 16:17:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710775069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gbNYzTr4/INQGIq/LLSVl4lEmYQWbki8fldTICdMCV0=;
	b=cK43c1EA1iSypD8CD5tpuNMegqDD8C7LU/hMs6Kt9cYknSuWs0tyMNkU3Ts3vx1FCsKU7u
	2kNUrHFtTg1tTY0g/8/f9KEv41J831Tug8Wmi58VCW2Ssxrd4W5YmYd/iZ29St1yLLPrdM
	GtQhL+ae5AFVN5KULr7KtySPy1oJDJG0f9NJUAccdR0q4Wk+QC9HRqTOZibGcmKY7id1mA
	2ynBC69J/nbbZnG9b+OXUeq5/RYwUx6HGHd66R/lY85Gr3Inrl5NqWgbp8ruvfj1hbsM7n
	QTFDNvCstSl3MllgtVgEbKKBY39Yk8u8gMdPERvase+Ev5D9yI1fByl6IiBqyQ==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: 
Date: Mon, 18 Mar 2024 16:07:18 +0100
Message-ID: <20240318151701.26644-2-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Lénaïc Huard <lenaic@lhuard.fr>, Derrick Stolee <stolee@gmail.com>
Bcc: 
Reply-To: 
Subject: [RFC PATCH 0/5] maintenance: use packaged systemd units
In-Reply-To: 

Hello,

This is a proposal to distribute the timers of the systemd scheduler of
git-maintenance directly, rather than inlining them into the code and
writing them on demand.
IMO, this is better than using the user $XDG_CONFIG_HOME, and allows
that user to override them if they so wish. It's also less code.

We also move away from using the random minute, and instead rely on
systemd features to achieve the same goal (see patch 2). This allows us
to go back to using unit templating for the timers.
(Not that even if we really more specific OnCalendar= settings for each
timer, we should still do it that way, but instead distribute override
alongside the template, i.e

/usr/lib/systemd-user/git-maintenance@daily.timer.d/override.conf:
[Timer]
OnCalendar=<specific calender spec for daily>

The cleanup code for the units written in $XDG_CONFIG_HOME is adapted,
and takes care of not removing legitimate user overrides, by checking
the file start.

Patch 5 removes the cleanup code, it should not be applied right away,
but once enough time has passed and we can be reasonably sure that no
one still has the old units laying around.

Testing:
Best way to approximate having the systemd units in /usr/lib would be to
either :
- sudo cp systemd/user/git-maintenance* /etc/systemd/user/
- sudo systemctl link --global systemd/user/git-maintenance* -> it's not
  exactly the same when enabling the you'll have a link in
  $XDG_CONFIG_HOME to your git source directory, so if you re-run `git
  start maintenance with the previous code, it will change your source.
  IMO the first method is less confusing.

Unresolved (reasons why it's still an RFC):
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
