Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF836B05E
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303233; cv=none; b=ZUo3YKxy5NOw7hjjMgxhabR32GlufW8/nPHP94PD69NJ75x4Rf3ZgXtQfGrMtajmuhsX7ViP64fhSS3P7dHknQwKGrrXjqORoNH2KS1pwy3ugivnG6jbF4HeMhQ1bzf6Oe8tMvboaSKOxtwDSeKsEZgUr0qK/DaLkFw8xoXVUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303233; c=relaxed/simple;
	bh=WdP53RGbn0EQ80L+Y104mmqJb6ovBUNDCQLBnKosB58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UsIWr4uW0NFE9HUHU2pe6D1tIWjOQj62//1rxD7Yyf0r+sDjZUY/jyrrczK+r0VT5fhnpqu7RL/3KnSg3zYitJN6/T8zd0/7rUd8UtTn6i6xn3OdkDlsDqikHJyygPmSKL6ZvJ0df+0YNhn4/GaIjAPh/m+EWj1+JVA6zst89e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=cuswOf/a; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="cuswOf/a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784303229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tveoJnPZ1oODiPoNPdM0fJ3gsCFrjTjCP19jVzokxw=;
	b=cuswOf/aWLQKFf+3TEu+/9/najrfyqfeyezAS7OhXSPZzaxbDIvCF0wZMEWyUu9Fp514IA
	ZUrtQH3t+LX2QRREf9JCp867zyidI2NW1SW9FKiDOj+fHcH6DK2SMClRALUYN52x/NVtGn
	LtVPvnDqUKz0MCWZcg6hSrAEwL3+14A=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 17 Jul 2026 17:46:59 +0200
Subject: [PATCH 1/4] revision: move bloom keyvec precondition into function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-toon-speed-up-last-modified-v1-1-410418f18614@iotcl.com>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
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
index 137a86d33b..f3c9407a66 100644
--- a/revision.c
+++ b/revision.c
@@ -750,6 +750,9 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	struct bloom_filter *filter;
 	int result = 0;
 
+	if (!revs->bloom_keyvecs_nr)
+		return -1;
+
 	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 
@@ -804,7 +807,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_keyvecs_nr && !nth_parent) {
+	if (!nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
@@ -831,7 +834,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
 	if (!t1)
 		return 0;
 
-	if (!nth_parent && revs->bloom_keyvecs_nr) {
+	if (!nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 		if (!bloom_ret)
 			return 1;

-- 
2.53.0.1323.g189a785ab5

