Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB920C488
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992058; cv=none; b=gGAOc+1kI8tu1H1/shRmg0RdASTOd00rSaQ26mB6fNh6A0edj/WG4+ET1+YzMC1qDhjWfunhfYc8HWuxOC/gN1Z6vkNT5Bqk4qU7VK7gDRf4cMrUphsoe6JZEDt+CJV+5HeSfiYnvn9jb2NFX3sfB9opUoEQmu/7pfUPfJMCTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992058; c=relaxed/simple;
	bh=fXpcJluM7X7X/6OQ8GSGVWEgF1Gt+UbZU4EFWXim5yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCglDMBdMH9Rrso8iNxRFNs4CyG5xCoR6bqgz6nVLtQ+Yvi/Fa+6P6k6jvllolN+TnNIAK4/dWELI8qRLC8ECUnSqjzV9PNCF3arQ78ZPrpmC0wrT9DnO371WwxNHZzw3np9bQ8EmXmSy8QQfQFHRrpySUS+53GdlOiDGrN1wgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3522184-ipxg00e01tokaisakaetozai.aichi.ocn.ne.jp ([122.27.91.184] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <glandium@glandium.org>)
	id 1uMajF-001FHg-0t;
	Tue, 03 Jun 2025 23:07:33 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <glandium@goemon>)
	id 1uMaj8-009kGK-2m;
	Wed, 04 Jun 2025 08:07:26 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/4] Fix use-after-free warning with GCC at -O3
Date: Wed,  4 Jun 2025 08:06:44 +0900
Message-ID: <20250603230646.2322671-2-mh@glandium.org>
X-Mailer: git-send-email 2.50.0.rc1.593.g042f21cb9b
In-Reply-To: <20250603230646.2322671-1-mh@glandium.org>
References: <20250603230646.2322671-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

```
reftable/basics.c: In function ‘parse_names’:
reftable/basics.c:233:17: error: pointer ‘names’ may be used after ‘free’ [-Werror=use-after-free]
  233 |                 reftable_free(names[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
In function ‘reftable_free’,
    inlined from ‘reftable_realloc’ at reftable/basics.c:30:3,
    inlined from ‘reftable_realloc’ at reftable/basics.c:27:7,
    inlined from ‘reftable_alloc_grow’ at reftable/basics.h:228:10,
    inlined from ‘parse_names’ at reftable/basics.c:214:8:
reftable/basics.c:44:17: note: call to ‘free’ here
   44 |                 free(p);
      |                 ^~~~~~~
```

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 reftable/basics.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 9988ebd635..de21fe6ef7 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -229,9 +229,11 @@ char **parse_names(char *buf, int size)
 	return names;
 
 err:
-	for (size_t i = 0; i < names_len; i++)
-		reftable_free(names[i]);
-	reftable_free(names);
+	if (names) {
+		for (size_t i = 0; i < names_len; i++)
+			reftable_free(names[i]);
+		reftable_free(names);
+	}
 	return NULL;
 }
 
-- 
2.50.0.rc1.593.g042f21cb9b

