Received: from mta1.migadu.com (out-105.mta1.migadu.com [95.215.58.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE704756C6
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254974; cv=none; b=RCKYK9HYRO+H5a9br7XItqT+BYjpVTS+317eJF0q85DDJvTjqi1Q29vPSM4GltZkfwWF3LyuOw8JMu5GVSunHUFSqKGiWgBzwucy1rr5ITUmxVuQZ0MQ3ZqoBaYhP0m7pGhe1EmBn9qXQ5H24oTL3KHhdK24IxODXlwlsQ+vh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254974; c=relaxed/simple;
	bh=VPEym3I14MAXqOev0dnJI1gKiOS3h4bght3Syd4vyoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqJO+IUm9f0bUntrLCVSYT0O29eJ2DsTU2y17D/ec9YA0ZDqAYYLLcZr4RnKEIWWfjslZSDWbiRjvoym0AU1jptzWGZaUVUdtjNBtVkYqpc6LguhgPpld1nAQUQB6471UhGrxOd7xyDDiWqVDStPsB8gJ8sSYK19J3c/632zgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=AKbm61qY; arc=none smtp.client-ip=95.215.58.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="AKbm61qY"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VPEym3I14MAXqOev0dnJI1gKiOS3h4bght3Syd4vyoE=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254969; v=1; x=1788859769;
 b=AKbm61qYddv7tY/r01aHDQPn50h0uhWWKrieqE8l8LQffEOmV94dhLyIwDbY0zIp8SXkP65E
 qSKn3ObaV5noM9euOXbNv6al3SgbhJO2w8qKCBIv606Ksk1i5hQSBVhpgAQfRIuzALwah0A4sM4
 MQU+2Q/W/gmonCFMIoU2xpDM=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 5071844dc9e8b02c;
	Tue, 01 Sep 2026 09:29:29 +0000
X-Mizu-Trace-ID: 5071844dc9e8b02c
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Tue, 01 Sep 2026 11:10:21 +0200
Subject: [PATCH v4 1/6] revision: move bloom keyvec precondition into
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-toon-speed-up-last-modified-v4-1-a09949800404@iotcl.com>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
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

