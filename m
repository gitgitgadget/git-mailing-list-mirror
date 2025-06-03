Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A641E411C
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992057; cv=none; b=tJ3gfKCFeJKxmh4JcKoA3/39mBo5lqTIBMIo7m2F16VooG2neqgYl2urp8AJ5QSBd5ZQxjg1bcjqCf/9EW1f3oh0v1uwR7M/bfgiaF8/qnn5loCWB7Fsxz4f8r1b6DmVh3ka2h6/elym1U9QtkNbnU5sQMw9/TH8fMjAGzoIlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992057; c=relaxed/simple;
	bh=qR/8/tr9g6/FwUMOeXq0AZHXWQ48MctEbmFY8KYzm44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKvhJ+TPOEZ0oDX15hryW+slFAyVgW1QIJ6DZellL6JYp1VTQM/1Vi39ktNEk125nOje8kIx8grR96KJxR4I5dGdcpKtgGn+BRVkMzjUchWg5LSCUahlE7pWjKyCURfneCB67K1Aq4gL3urWMsYy/T1SDRVwFArVjnPRlLWymkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3522184-ipxg00e01tokaisakaetozai.aichi.ocn.ne.jp ([122.27.91.184] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <glandium@glandium.org>)
	id 1uMajF-001FHe-1S;
	Tue, 03 Jun 2025 23:07:33 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <glandium@goemon>)
	id 1uMaj8-009kGQ-2u;
	Wed, 04 Jun 2025 08:07:26 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH 4/4] Fix unreachable-code warning with clang on Windows
Date: Wed,  4 Jun 2025 08:06:46 +0900
Message-ID: <20250603230646.2322671-4-mh@glandium.org>
X-Mailer: git-send-email 2.50.0.rc1.593.g042f21cb9b
In-Reply-To: <20250603230646.2322671-1-mh@glandium.org>
References: <20250603230646.2322671-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

```
refs/files-backend.c:3187:5: error: code will never be executed [-Werror,-Wunreachable-code]
   3187 |                                 continue;
        |                                 ^~~~~~~~
  1 error generated.
```

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf6f89b1d1..af21eb80a9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3183,7 +3183,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		 * next update. If not, we try and create a regular symref.
 		 */
 		if (update->new_target && refs->prefer_symlink_refs)
-			if (!create_ref_symlink(lock, update->new_target))
+			if (NOT_CONSTANT(!create_ref_symlink(lock, update->new_target)))
 				continue;
 
 		if (update->flags & REF_NEEDS_COMMIT) {
-- 
2.50.0.rc1.593.g042f21cb9b

