Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752B8120E
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145644; cv=none; b=D8n0sbQJs9NalKksNblZuz+SDUDF8yI2lhzcMgPWFDijviGHl9NR9h8PAUTO4gFu1UWs+HZJSfP47q5nSuI2zjdxmVdXbdeiJZcYL+pEPGgcGWYhkhJh5jhdA+U0QQrk/bm0RIQhpCWNr/05E/FTZup5bR2/O/eipE2Uc+OOeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145644; c=relaxed/simple;
	bh=mZDNx1YpihJvbF9/FEOK+0J+5A/N+K87BSBAlQtMSDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKgvtmpk/jKtn1mBOsI0gP/TvV+MXARqlGMYjU7+hddM7vntkh9U7UnWIH2K9n/iNWz9PGJX9gUInLUUn9hDmqQm/byzS+zCC11o76e3OFEZM33uyZ+BEU1DIAZdL+mCYOMB4IMjrIAmp0+/IGDgiczCk6OAGY5iw6m7w4cbSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=2zZ3HKD1; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="2zZ3HKD1"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 9666E60376;
	Fri, 22 Mar 2024 23:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711145632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryqLr0HTl7YMwDFg/wJRO0sm6UFSpKeIS3W7ikvntbQ=;
	b=2zZ3HKD1QwITeK4eUi6liqMc0z0jD6AfmcCa5aB/EyfdOygMgNLTtjC6H7IFE8lDMlVC9n
	8FaBOxbWsoplntMfh+ME6xdt7VSKjfAMHMjzpRDNf4EksINUKemT7IXEpBw551l/zcCTwy
	A3Z4X/Z4IZ+Fdf5cTcfzEPf/N1fLYYM2Up4WCMtJBJr6/6KiPx8HWMNEVSOheEYNLwFcmA
	3k9epcDEWk5rfzqqRZH+e9RxbgH1U/8PldfyYsXV4/h7BW4pNn20fGjDEEi65xCcIDZsjc
	k+C2tgIjDbVAG6qWt0tpZsCYEQUSK9VtdvfIbXtkOcmZ/AXIA+r7njLoNSZr1Q==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>,
	=?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] maintenance: use packaged systemd units
Date: Fri, 22 Mar 2024 23:11:05 +0100
Message-ID: <20240322221327.12204-1-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318153257.27451-1-mg@max.gautier.name>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Distribute the systemd timers used by the `git maintenance start` with
  the systemd scheduler as part of git, rather than writing them in
  $XDG_CONFIG_HOME.

This allows users to override the units if they wish, and is more
in-line with the usual practices of distribution for systemd units.

We also move away from using the random minute, and instead rely on
systemd features to achieve the same goal (see patch 2). This allows us
to go back to using unit templating for the timers. This is also a
prerequisite to have static unit files.

Note that even if we really need more specific OnCalendar= settings for
each timer, we should still do it that way, but instead distribute
override alongside the template, for instance for weekly:

/usr/lib/systemd-user/git-maintenance@daily.timer.d/override.conf:
[Timer]
OnCalendar=<daily specific calendar spec>

The cleanup code for the units written in $XDG_CONFIG_HOME is adapted,
and takes care of not removing legitimate user overrides, by checking
the file start.

Testing:
The simplest way to simulate having the units in /usr/lib is probably to
copy them in /etc/systemd/user.

Changes since v1:
- Reorganization of the commits and their messages to try to address
  review comments
- Dropped the DON'T APPLY PATCH, added a TODO to the cleanup code
  instead
- Updated the git-maintenance tests to work with the new logic.
- Conditional installation of the units files
- Fixing some style/consistency issues
- template the systemd service file to use $(bindir)

Max Gautier (6):
  maintenance: use systemd timers builtin randomization
  maintenance: use packaged systemd units
  maintenance: simplify systemctl calls
  maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
  maintenance: update systemd scheduler docs
  maintenance: update tests for systemd scheduler

 Documentation/git-maintenance.txt        |  33 ++-
 Makefile                                 |   5 +
 builtin/gc.c                             | 298 ++++-------------------
 config.mak.uname                         |  10 +
 systemd/user/git-maintenance@.service.in |  17 ++
 systemd/user/git-maintenance@.timer      |  12 +
 t/t7900-maintenance.sh                   |  50 ++--
 7 files changed, 126 insertions(+), 299 deletions(-)
 create mode 100644 systemd/user/git-maintenance@.service.in
 create mode 100644 systemd/user/git-maintenance@.timer

Range-diff against v1:
1:  ea54a6e50e < -:  ---------- maintenance: package systemd units
2:  b29dbb9fdd < -:  ---------- maintenance: use packaged systemd units
3:  47bd6712b8 < -:  ---------- maintenance: add fixed random delay to systemd timers
-:  ---------- > 1:  42d88c7f81 maintenance: use systemd timers builtin randomization
-:  ---------- > 2:  18d51b1dd1 maintenance: use packaged systemd units
-:  ---------- > 3:  3aa7446e95 maintenance: simplify systemctl calls
-:  ---------- > 4:  daff7b4d60 maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
4:  fac57db55e ! 5:  5f6a8e141f maintenance: update systemd scheduler docs
    @@ Metadata
      ## Commit message ##
         maintenance: update systemd scheduler docs
     
    +    The `git maintenance` systemd scheduler no longer writes units in
    +    $XDG_CONFIG_HOME.
    +
    +    Describe the new behavior.
    +    Instead of explaining manual ways to modify the timer, suggest the
    +    systemd standard tool: `systemctl edit`.
    +
         Signed-off-by: Max Gautier <mg@max.gautier.name>
     
      ## Documentation/git-maintenance.txt ##
5:  d888fbd0c3 < -:  ---------- DON'T APPLY YET: maintenance: remove cleanup code
-:  ---------- > 6:  4d4bcd6233 maintenance: update tests for systemd scheduler
-- 
2.44.0

