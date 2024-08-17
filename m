Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5320E6
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879792; cv=none; b=Mu9kJ5N2F4xBuGghEJO1smoZXtX/XjJEDZiu50wImC31pH3Br7RfGtq1A/z+ZPCd8pf66Bk+FBBRkC+z2py5qyMEKiH+N9lKO/okatEbqdKLPNMXb3i9VWmWVur5P8yBxfX4zuXp9aoVOQdZKlcLeN3DJN0KATT9OXShf+YdXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879792; c=relaxed/simple;
	bh=QVyOqMyKfpPRd+QSd9S5mN16dqcv2GPfEcsCpTDQwVE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnT727F+AuA9NmG+Bf10fnVdG0b9wSOOw8X7sK0P81mXec4sSR8H/Eg4Rt4lJEPU90O+IvduMwPKPC0xUd6OfeK7WGDKhtJMVKFLnX58Kc32CDe5raqmBJSKxcIH8XI/vlW7Hnh4z53XKX5n+klDLcIemGUHQipQ+zPqIGDz+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23594 invoked by uid 109); 17 Aug 2024 07:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 07:29:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27582 invoked by uid 111); 17 Aug 2024 07:29:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 03:29:54 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 03:29:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 5/5] diff-lib: drop unused index argument from get_stat_data()
Message-ID: <20240817072949.GE1535915@coredump.intra.peff.net>
References: <20240817072621.GA1535666@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817072621.GA1535666@coredump.intra.peff.net>

The "struct index_state" parameter passed to get_stat_data() has been
unused since we stopped passing it to check_removed() in 6a044a2048
(diff-lib: fix check_removed when fsmonitor is on, 2023-09-11). We can
just drop it, which in turns lets us simplify our callers a bit.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 7a1eb63757..a680768ee7 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -308,8 +308,7 @@ static void diff_index_show_file(struct rev_info *revs,
 		       oid, oid_valid, ce->name, dirty_submodule);
 }
 
-static int get_stat_data(const struct index_state *istate,
-			 const struct cache_entry *ce,
+static int get_stat_data(const struct cache_entry *ce,
 			 const struct object_id **oidp,
 			 unsigned int *modep,
 			 int cached, int match_missing,
@@ -352,7 +351,6 @@ static void show_new_file(struct rev_info *revs,
 	const struct object_id *oid;
 	unsigned int mode;
 	unsigned dirty_submodule = 0;
-	struct index_state *istate = revs->diffopt.repo->index;
 
 	if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
 		diff_tree_oid(NULL, &new_file->oid, new_file->name, &revs->diffopt);
@@ -363,7 +361,7 @@ static void show_new_file(struct rev_info *revs,
 	 * New file in the index: it might actually be different in
 	 * the working tree.
 	 */
-	if (get_stat_data(istate, new_file, &oid, &mode, cached, match_missing,
+	if (get_stat_data(new_file, &oid, &mode, cached, match_missing,
 	    &dirty_submodule, &revs->diffopt) < 0)
 		return;
 
@@ -379,7 +377,6 @@ static int show_modified(struct rev_info *revs,
 	unsigned int mode, oldmode;
 	const struct object_id *oid;
 	unsigned dirty_submodule = 0;
-	struct index_state *istate = revs->diffopt.repo->index;
 
 	assert(S_ISSPARSEDIR(old_entry->ce_mode) ==
 	       S_ISSPARSEDIR(new_entry->ce_mode));
@@ -395,7 +392,7 @@ static int show_modified(struct rev_info *revs,
 		return 0;
 	}
 
-	if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
+	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old_entry,
-- 
2.46.0.585.gd6679c16d8
