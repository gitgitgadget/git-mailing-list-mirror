Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D692E7622
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765194380; cv=none; b=MdGHND9+XUJmbUUrDn+qMn5OiI2RFIku8KOTXrHrQfy5DOM3fxWZzD6YObrGxwJf/hRqzow9uzbuwrnnmGbJtSgtojpxHyS6PId4on//5TXeYX93buSdFPfA/iQfeH60zVzDvs0NpOE5WirYP76IIEeb4zPup2n/GCn5hdGO7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765194380; c=relaxed/simple;
	bh=5aEaJ08V9TkMLfRW81tqgbNsAgK8ze/ny48hoBsVmDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=F1YcvbhCrA424lgkgBx9DFIeShunwtQll1cqmjK3P1nnUsrNqOZbrikjy3CO0Qk/s4L0sLsbbyVQ/3ebE3KEjJtHc9Xng1JsK7ipThHbBnQdidc61sknawWnW+zJFk0JmMJapU5OSChmTCOlTl0qZJ+kL+j2+tMoXZaA7k1oqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yWoXwuio; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yWoXwuio"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765194374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLcfC2i8d5AHDLEfcrD06/xyQB7fTxFDoH2NiBxD+w4=;
	b=yWoXwuioGHANrlUAxMMR3KV0JixxEYojAUwjmez+AQTDQh1hKtCNti24cFUpC4OQlVsR4k
	udxWq7Qh+W+Lh+0eehhx6oy7rOkIDjtMuG9ZivbeolmNuTQ+xKZTZIOoZxXklksBzHrfXL
	XwACFNy5Jn1rEWskpTudptHRb4tiKT0=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 08 Dec 2025 12:46:05 +0100
Subject: [PATCH v2] last-modified: fix use of uninitialized memory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-toon-big-endian-ci-v2-1-76b46763a597@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAHy6NmkC/22NQQrCMBBFr1Jm7UgnamxdeQ/pIk2n7YAmkoSil
 NzdWHDn8j34768QOQhHuFQrBF4kincF1K4COxs3McpQGFStTkRKY/LeYS8TshvEOLSCI2vV9wd
 N7fkIZfgMPMpri966wrPE5MN7+1joa3+55l9uISRs6sHUo1atJb6KT/a+t/4BXc75AzS7Iu60A
 AAA
X-Change-ID: 20251126-toon-big-endian-ci-fe62bb361974
In-Reply-To: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Anders Kaseorg <andersk@MIT.EDU>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

git-last-modified(1) uses a scratch bitmap to keep track of paths that
have been changed between commits. To avoid reallocating a bitmap on
each call of process_parent(), the scratch bitmap is kept and reused.
Although, between loops, the memory allocated for the 'scratch' bitmap
isn't correctly wiped.

`struct bitmap` uses `eword_t` to for internal storage. This type is
typedef'd to uint64_t. To fully zero the memory used by the bitmap, the
length (saved in `struct bitmap::word_alloc`) should be multiplied by
the size of a single item. To simplify zeroing an array, a macro
MEMZERO_ARRAY() is defined and used.

Reported-by: Anders Kaseorg <andersk@mit.edu>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
It was reported [1] the tests in t8020 fail on s390x. After some
research, it seems it was related to s390x being big-endian. Well,
actually, not really. Using big-endian simply uncovered the problem in
test.

[1]: https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu/
---
Changes in v2:
- Defined and used MEMZERO_ARRAY() macro.
- Fixed up title which used unexisting word
- Link to v1: https://lore.kernel.org/r/20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com
---
 builtin/last-modified.c | 2 +-
 git-compat-util.h       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index b0ecbdc540..ac5387e861 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -327,7 +327,7 @@ static void process_parent(struct last_modified *lm,
 	if (!(parent->object.flags & PARENT1))
 		active_paths_free(lm, parent);
 
-	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
+	MEMZERO_ARRAY(lm->scratch->words, lm->scratch->word_alloc);
 	diff_queue_clear(&diff_queued_diff);
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 398e0fac4f..2b8192fd2e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -726,6 +726,7 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
+#define MEMZERO_ARRAY(x, alloc) memset((x), 0x0, st_mult(sizeof(*(x)), (alloc)))
 
 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
 	BARF_UNLESS_COPYABLE((dst), (src)))

---
base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
change-id: 20251126-toon-big-endian-ci-fe62bb361974

