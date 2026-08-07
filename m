Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233F285CAA
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127241; cv=none; b=ik72EzWxbGt61PGFLHxmeFU5FYBU0ImkavOlDR6gXIkEPAGJzThrAdpt9BtHSqLmzYdO3zDkHh+oGAqgnMZ5C9JI3LWpvfp9GHPHvv9JoWMUzScQdVYTZQLvcm6Y4S7sgDQ31rs3kCeQ1oqsy/jO2YdmtP32OvaezQUb8us6NW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127241; c=relaxed/simple;
	bh=UGGKQL6CUn3kQpGMhUPQ7wSlL3r5AXIOxrb/a67aIuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQh0uYxZX30cVF/APByfUec8I0mO0t6WvxqLjR/ZAdm/VZld2Pv+fsKNIqKBDv+ZB5TDuWPlp4hTzBEElu4Bo1KEizJulEkKa5yEcU5l5DsHgbN9HoUh0LAlWk9AKowZanBnSEAA0Ah+Dq4QjJ9NiAiCtzN5LFV/HiKtefSHKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZZmPoKTb; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZZmPoKTb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786127237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9rAXBkiyFWOEkDN0a+sauI+LiIkJfV/8QWLAlRDCU0=;
	b=ZZmPoKTb08+WbsLeNZxBMolUybeQSM4Ho9oaM1BEqJpBl9FdWRBV4xAnAPVxjqfDrmBYaj
	nxVHGL/aGmb63Z00z8sGqePOyZ0+AkEEHfdVhU3KuhjyMQEt3i5cP2MtWAXiafBZ8I2Duy
	hYZshMSRjyFuCe7WnjZjYoIx3NivpLc=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 07 Aug 2026 20:26:47 +0200
Subject: [PATCH v2 1/6] revision: move bloom keyvec precondition into
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-toon-speed-up-last-modified-v2-1-7d87bbdeaf9b@iotcl.com>
References: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
In-Reply-To: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Migadu-Flow: FLOW_OUT

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
index 526bcf3fb5..5b53902c05 100644
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

