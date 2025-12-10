Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4903254A5
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372412; cv=none; b=G/2YHAHlxo7/Dck2jFFMgNEQYW1stwOrWwbssAfAZARwU864MZZyyah8MNz7Jvx/jc3kDDvb5lvTT6PsGVLEX+3KWspN5hj+TWjktI7hLZ+jCvh1OCuycQWV1OwKl9l01lOCfiZkeRqimNbq6husXYfH36NSpUAVNYmKuSJW3bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372412; c=relaxed/simple;
	bh=p3OQcLx4NFICMzq/bOl8B2p0xDGtbT7gUwtPQzQqofU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YnOFDY5BYl73si2r4+v3jStoKBXQdbu9HnzPAJTBRrsfbVhylkF6KYRee6jAjZx+akEa5KvQeXeNBkyrwlKHTK1dYdcyS9dX8F1/aNMg+P4GeofjTx51P0aPONL/IEI2UVwMWCwI15JbFAClxPOFDEMAEmu7kAQJpBMLw8dFikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=zLdjqP8+; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="zLdjqP8+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765372406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZmOjb6zaZ8jD2NzFsZ3BPOLRgnZGrsEbMlQLoSADCkM=;
	b=zLdjqP8+h0qZea4CEInz39pcbfYB8XFLGxojz3JJq4x/L557HcwtEhEUdnpEn+dvKfcaC7
	WWEtTfZGeWxeqwnN47hlU1vBKieS8C3V1AV9VsmU5iZVKCR5I58cKifviq+stFOQJNTDtU
	JM8r3e5z4gd6XGeaBv2IS1vxFrwKQVw=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/2] Add MEMZERO_ARRAY() macro and use it in coccinelle
Date: Wed, 10 Dec 2025 14:13:00 +0100
Message-Id: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANxxOWkC/x3MMQqAMAxA0atIZgNtURGvIg4ao2awkVZElN7d4
 viG/1+IHIQjdMULgS+Joj7DlgXQNvqVUeZscMbV1lmDp6pHUiLBnfeHg6KbGtvWbNqRKsjhEXi
 R+5/2Q0ofMVLD6WQAAAA=
X-Change-ID: 20251210-toon-cocci-memzero-2b6185e08ac4
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

A bug was found[1] in git-last-modified(1), caused by uninitialized
memory. While the bug is fixed, in the discussion after that[2] the
suggestion was made to introduce a macro that simplifies zeroing a
dynamically allocated array.

In the first patch I'm addressing the outcome of the discussion on the
patch, and in the second patch I'm fixing an edge-case I've encountered
while using coccinelle.

There's one /oddball/ in add-patch.c that doesn't get caught by the
coccinelle rules, around line 960:

    memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));

Because there's some quirky pointer math going on, it think it's better
to keep it like it is.

There were some mixed opinions about naming it either CLEAR_ARRAY() or
MEMZERO_ARRAY(). I choose the latter because I wanted to avoid confusion
that "clear" would shrink the array to zero elements.

[1]: <4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu>
[2]: <20251208201501.GA216526@coredump.intra.peff.net>

Signed-off-by: Toon Claes <toon@iotcl.com>
---
Toon Claes (2):
      git-compat-util: introduce MEMZERO_ARRAY() macro
      contrib/coccinelle: pass include paths to spatch(1)

 Makefile                       |  2 +-
 builtin/last-modified.c        |  2 +-
 compat/simple-ipc/ipc-win32.c  |  2 +-
 contrib/coccinelle/array.cocci | 20 ++++++++++++++++++++
 contrib/coccinelle/meson.build |  6 ++++++
 diff-delta.c                   |  2 +-
 ewah/bitmap.c                  |  7 +++----
 git-compat-util.h              |  1 +
 hashmap.c                      |  2 +-
 pack-revindex.c                |  2 +-
 10 files changed, 36 insertions(+), 10 deletions(-)



---
base-commit: 011ce54c26318d725db1d8971d157656eb965d88
change-id: 20251210-toon-cocci-memzero-2b6185e08ac4

