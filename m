Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E03264E7
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943869; cv=none; b=pFwDzd4tD03xuBJKSLndXkYc+/6IGGfe38Lx3sTI7RJjTQjfoVum9Ue6ZAciMOmtcOABN0m5X91LiV3xp4M9YgtYCooEqGOIxRv4x4RFd7QqnamVghMXdHy5xC8Kh5n8S+IuVjKyiwZgE6uoInLGS07gEG95vstFNg+dGQyHXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943869; c=relaxed/simple;
	bh=Ri3QY9zDIMN13FlwSUb1PJ8BmRq70B2ILakQQ/1u5tE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G3HUlUI+EfeCvR2ZlaUXJxjkMN6nN77DLZgQ4iQmleQ8uzX9ymQdU97KwgrKEmEKjakBj1BOFRP4+Z+/+ZLJ/W411dsOlqw8ia5tKt9HGZk7PQNv9YnOS6tz0w5mbFR7Pmcu7LrKH5HN4+3JWudEUhJTOluv6+NIw/6HpqzjG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mVRgMLKd; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mVRgMLKd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1780943863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4SASK+3R3PxYXzC1yTRvqqnj9Ecqj876aquaJfQMudo=;
	b=mVRgMLKdHIw3xJ9pw+OId8rN9mMCnkK4iTXsU94RbykDGq37o2zuHGaO89Pu0ggtEfNRae
	g0XtYsmXDKzmsn+NS9augKXlhr3HAjL64iwmHklWCL/6NZzAjPMC7x6kytahWw8//7h+o6
	dQkVX/lEpCiIAPO/XOu4mjKxkjK3hPg=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/3] Teach git-replay(1) to linearize merge commits
Date: Mon, 08 Jun 2026 20:37:18 +0200
Message-Id: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAwAwK9UnrFkCpTCVyqG0LjBCJLIDghU9
 e8EGG+5GYxV2ODYzKD8FJMUK9arBsaLi4FRfDW01HbU0RZLShGDFFTON/dGrynjnTWwYU/7yRH
 1fnPYQR2y8iSv3z6c/rbH+cpj+ZawLB/cDQ9GfwAAAA==
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

As an alternative to dscho's patch series to replay merges[1], add
option to git-replay(1) to linearize merges. This mimics wath
git-rebase(1) does too with --no-rebase-merges (the default).

The first two patches do some refactoring. The third patch implements
the actual change. I was kindly helped by dscho to implement this
change.

The --linearize option is only added to git-replay(1) and not to
git-history(1) because in my opinion doesn't make much sense to do so,
but I'm happy to hear if anyone disagrees.

This series might conflict with Kristoffer's series to make
documentation changes[2], but should be trivial to resolve. And I don't
think there's a conflict with Patrick's series on adding "drop" to
git-history(1)[3].

dscho's series to replay merges[1] need a bit of rework to fit on top of
this, but I'm happy to help figuring that out.

[1]: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
[2]: <V2_CV_doc_replay_config.767@msgid.xyz>
[3]: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>

Signed-off-by: Toon Claes <toon@iotcl.com>
---
Johannes Schindelin (1):
      replay: offer an option to linearize the commit topology

Toon Claes (2):
      replay: refactor enum replay_mode into a bool
      replay: add helper to put entry into mapped_commits

 Documentation/git-replay.adoc |   5 ++
 builtin/replay.c              |   4 ++
 replay.c                      | 109 +++++++++++++++++++++++-------------------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      |  22 +++++++++
 5 files changed, 97 insertions(+), 48 deletions(-)



---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

