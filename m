Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A95025A
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775077; cv=none; b=r7jEAVICdHnWmXyWx5j/fsXn2nno20mTGrbQJLjamKglm/6bAFAHW0HKyfR/KdzaMqGCkQp/lWeZZLGwLdZhW/Q3MuzGzalngv/KYvApgHmUJKkALSKTpemcv2tVSY+9w3YYewjCJ6L/csYnh78CA4WWVq0n1bT2bV20LGg8deQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775077; c=relaxed/simple;
	bh=1BsXbTaDlKvzIFO4QQuoq9BKtOXcTbpTbxBsq08BXHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rt4CKAMRBP5jw1b3drqeS/FnSJe9a3srwjHrGd/aAvq6L0Iv7skp0HHBGvdFych2fmzCS4DUwWoD0cW5MuvIlHHj6JhVEi2AsPlkr7teI8cp6r/wAiWs0Axvdu5HERwDCEkeFwShopF2Wter5KSmQPYju/MNJ/syh5eu728TIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=n5DPJMko; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="n5DPJMko"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 1CE14602E7;
	Mon, 18 Mar 2024 16:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710775070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HknJ9NjDjqfl1sLk00t/bka3r/aYktT7hZyGtAU1Pz4=;
	b=n5DPJMko9gud0MVe/veeghqeLGBot1BbJ9cYiU1g/7Pkk9p4dC0aW1Z5u18AXqAvDcYk9R
	O3rWfA4/jdjaQgUQHpTd+aSMhFvh4COCav9x9ly2zhRXbKqtoJMKDN2l0aGcZ2C6GFsKHz
	1tHQicxaDw9Y3fOsJXRyZAiVwuM6C9cGRqv6aB2TXcFtjLOAKLSugvCRmR1cWTOaWMlYP4
	y9U38z2L8kZ20r6nwk6c+c2UHpeh+yHq7UMcC8JcA3RfpDHBdUfxRvKFLqWY3Hk3AcYUR1
	paPlB2JCdVX7kAowmJ70D8rjJ/QU8fCwvlyxTc+j0omgz9HpFiFTb+uK8CjWuw==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Max Gautier <mg@max.gautier.name>
Subject: [RFC PATCH 2/5] maintenance: add fixed random delay to systemd timers
Date: Mon, 18 Mar 2024 16:07:20 +0100
Message-ID: <20240318151701.26644-4-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318151701.26644-2-mg@max.gautier.name>
References: <20240318151701.26644-2-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensures that:
- git maintenance timers have a fixed time interval between execution.
- the three timers are not executed at the same time.

This is intended to implement an alternative to the two followings
commits:
c97ec0378b (maintenance: fix systemd schedule overlaps, 2023-08-10)
daa787010c (maintenance: use random minute in systemd scheduler, 2023-08-10)

Instead of manually adding a specific minute (which is reset on each
invocation of `git maintenance start`), we use systemd timers
RandomizedDelaySec and FixedRandomDelay functionalities.

From man systemd.timer:
>FixedRandomDelay=
>  Takes a boolean argument. When enabled, the randomized offset
>  specified by RandomizedDelaySec= is reused for all firings of the
>  same timer. For a given timer unit, **the offset depends on the
>  machine ID, user identifier and timer name**, which means that it is
>  stable between restarts of the manager. This effectively creates a
>  fixed offset for an individual timer, reducing the jitter in
>  firings of this timer, while still avoiding firing at the same time
>  as other similarly configured timers.

-> which is exactly the use case for git-maintenance timers.

Signed-off-by: Max Gautier <mg@max.gautier.name>
---
 systemd/user/git-maintenance@.service | 1 +
 systemd/user/git-maintenance@.timer   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/systemd/user/git-maintenance@.service b/systemd/user/git-maintenance@.service
index 87ac0c86e6..f949e1a217 100644
--- a/systemd/user/git-maintenance@.service
+++ b/systemd/user/git-maintenance@.service
@@ -1,5 +1,6 @@
 [Unit]
 Description=Optimize Git repositories data
+Documentation=man:git-maintenance(1)
 
 [Service]
 Type=oneshot
diff --git a/systemd/user/git-maintenance@.timer b/systemd/user/git-maintenance@.timer
index 40fbc77a62..667c5998ba 100644
--- a/systemd/user/git-maintenance@.timer
+++ b/systemd/user/git-maintenance@.timer
@@ -1,9 +1,12 @@
 [Unit]
 Description=Optimize Git repositories data
+Documentation=man:git-maintenance(1)
 
 [Timer]
 OnCalendar=%i
 Persistent=true
+RandomizedDelaySec=1800
+FixedRandomDelay=true
 
 [Install]
 WantedBy=timers.target
-- 
2.44.0

