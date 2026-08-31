Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682D46AEEA
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189552; cv=none; b=T1VK5Sn7FNVyHlA/K1eKeTv/vjuv8AF+EY/2tqYFyfqoM0Pwg5qF229e0Et8BK3LgINr71ADcI1sF3ivQF6050JXS/beroKxzs/MKu7u+15hI2VuG4lCKVBdN4kHGyDuYTMy8uHvULlrNTLd5Z5Pfdeg3qhH0Ix4WM/RMExP6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189552; c=relaxed/simple;
	bh=VPEym3I14MAXqOev0dnJI1gKiOS3h4bght3Syd4vyoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LuYxEiL4mfOPRARXgfPhkWR6DYnCZBBm7mh80S6iTBfguOl//yITYIEvUpjlF34e9E6AjUFBjxYF0nfWK+LCOXISBmI5pQKokQQuCAMtynJZKWkYm7/1JOWiIboF2UIrvdpJamW/8le4t/uEmHfdnGK9ng8mzfOAIuJMuBpK0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Yh7t35QY; arc=none smtp.client-ip=91.218.175.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Yh7t35QY"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VPEym3I14MAXqOev0dnJI1gKiOS3h4bght3Syd4vyoE=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788189545; v=1; x=1788794345;
 b=Yh7t35QY9C6nrQCJLRSDxGtOEFRUqPGL6YsEZmNXC/UgkQFh0b2ywccckgMG6DzAFXmocTWe
 tjy74bzPU7T6CXy6E0UeFqXhEPHBfYgzBNmcFXbowYwZ6fQaJH5COHenig/Bctzodl6X+IlieFF
 oB+cmGcNxFfe/QxIDNm3YHXM=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id c5e5da93f6de26d9;
	Mon, 31 Aug 2026 15:19:05 +0000
X-Mizu-Trace-ID: c5e5da93f6de26d9
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Mon, 31 Aug 2026 17:18:41 +0200
Subject: [PATCH v3 1/6] revision: move bloom keyvec precondition into
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-toon-speed-up-last-modified-v3-1-2bbb864acf93@iotcl.com>
References: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
In-Reply-To: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.16-dev-9febb

There are currently two callsites calling
check_maybe_different_in_bloom_filter(). They both check if
revs->bloom_keyvecs_nr is not zero before they call that function.

Move bloom_keyvecs_nr precondition into
check_maybe_different_in_bloom_filter() to simplify the code.

Note that this changes `bloom_ret` to become -1 when there are no Bloom
key vectors, which results in `count_bloom_filter_false_positive` not
being incremented. This is unobservable, as the Bloom statistics are
only reported when key vectors were set up.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 revision.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 50dc8b1991..6a6a1b6fa0 100644
--- a/revision.c
+++ b/revision.c
@@ -752,6 +752,9 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	struct bloom_filter *filter;
 	int result = 0;
 
+	if (!revs->bloom_keyvecs_nr)
+		return -1;
+
 	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 
@@ -806,7 +809,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_keyvecs_nr && !nth_parent) {
+	if (!nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
@@ -833,7 +836,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
 	if (!t1)
 		return 0;
 
-	if (!nth_parent && revs->bloom_keyvecs_nr) {
+	if (!nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 		if (!bloom_ret)
 			return 1;

-- 
2.55.0.679.g6767b8d81c

