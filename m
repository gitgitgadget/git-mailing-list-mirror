Received: from smtp94.iad3b.emailsrvr.com (smtp94.iad3b.emailsrvr.com [146.20.161.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AC4F472E
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574638; cv=none; b=jIkPpTWRzz3xO+B9Sg/ISNE/3mAQf18duEGS7e8M/6ZDxneF5pdl3TM638z0LbwCNiXeYUiVJw9UJkAeilu3FjR9pogqEIgyD1E5Hgil7zXxVAKDnEr+Pc/CJW1Cor1UJ/N+p/+PD86Q356ogMik0EZ/iHWaC4lpWQ8nJcqKjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574638; c=relaxed/simple;
	bh=C5i+S61XCn/thlavQwzbdE0tF3ffuL+Mb4JuI0CNDUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPB/PlzVVVrNU0P7s3LVqVj3xAdjsEYWTz6aEZTXiYSgt9Rgj/daJe+x/ricTUJQ19vPReP5PdJa8HfpFjWOwh5iViPhf/ZYIos5NqzlNsETbF/edaUATl1vFoWEw6PTALIGxNSQd0ZyjoGfdtlnMYV2A+0OF1XP+xp5K0WU4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=TtFSFN6H; arc=none smtp.client-ip=146.20.161.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="TtFSFN6H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574223;
	bh=C5i+S61XCn/thlavQwzbdE0tF3ffuL+Mb4JuI0CNDUA=;
	h=From:To:Subject:Date:From;
	b=TtFSFN6HqcpoJA3Tlh2aVK7soKgNrni+M0XeUhhnUpH2614GKFL72jklBoKL9tb6I
	 yAKe/EGQhIY3ng0Yts1/TuIcN8uKKG2VRR7KuLTo/36Q7e9a1V1+V0lECzD/nN1vfy
	 24iD4cE1XJy3iaf5zfYQVQja9Xaqs+GiOrR7pgu0=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 80F6820395;
	Fri,  9 Oct 2026 15:30:23 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 12/15] remote: use strmap for match_explicit_refs()
Date: Fri,  9 Oct 2026 15:29:50 -0400
Message-ID: <20261009192953.81794-13-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009192953.81794-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-13-1

Optimize match_explicit_refs() by replacing two linear refs traversals
with strmap lookups.

Before this change, matching R explicit refspecs against N local refs
and M remote refs in match_explicit() entails O(R * N) and O(R * M)
calls to refname_match() for sources and destinations respectively.

After this change, we build a strmap for local refs O(N), a strmap for
remote refs O(M), and use them for O(R * rules) lookups of the refspecs.

Refspecs are resolved using count_refspec_match_in_map() introduced
earlier in the series, which issues one strmap lookup for each candidate
rules pattern generated with expand_ref_prefix().

The match_explicit_lhs_map() function introduced in a previous commit
has now been recombined into match_explicit_lhs(): all call sites are
now using the new strmap variation.

Timings show benefit where one or both of the client and remote have
many refs, and multiple refspecs are specified:

  Test                           HEAD~1            HEAD
  -----------------------------------------------------------------------
  5516.3: empty:refspecs:1       0.13(0.07+0.10)   0.14(0.07+0.10) +7.7%
  5516.5: empty:refspecs:10      0.17(0.10+0.11)   0.14(0.07+0.11) -17.6%
  5516.7: empty:refspecs:100     0.47(0.41+0.10)   0.15(0.08+0.10) -68.1%
  5516.9: mirror:refspecs:1      0.17(0.10+0.11)   0.17(0.10+0.11) +0.0%
  5516.11: mirror:refspecs:10    0.23(0.16+0.11)   0.17(0.10+0.11) -26.1%
  5516.13: mirror:refspecs:100   0.87(0.80+0.11)   0.18(0.11+0.11) -79.3%

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 remote.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/remote.c b/remote.c
index f4cf63b756..8074750601 100644
--- a/remote.c
+++ b/remote.c
@@ -1214,12 +1214,12 @@ static char *guess_ref(const char *name, struct ref *peer)
 	return strbuf_detach(&buf, NULL);
 }
 
-static int match_explicit_lhs_count(const int count,
-				    struct refspec_item *rs,
-				    struct ref **match,
-				    int *allocated_match)
+static int match_explicit_lhs(struct strmap *src,
+			      struct refspec_item *rs,
+			      struct ref **match,
+			      int *allocated_match)
 {
-	switch (count) {
+	switch (count_refspec_match_in_map(rs->src, src, match)) {
 	case 1:
 		if (allocated_match)
 			*allocated_match = 0;
@@ -1239,24 +1239,6 @@ static int match_explicit_lhs_count(const int count,
 	}
 }
 
-static int match_explicit_lhs(struct ref *src,
-			      struct refspec_item *rs,
-			      struct ref **match,
-			      int *allocated_match)
-{
-	return match_explicit_lhs_count(count_refspec_match(rs->src, src, match),
-					rs, match, allocated_match);
-}
-
-static int match_explicit_lhs_map(struct strmap *src,
-				  struct refspec_item *rs,
-				  struct ref **match,
-				  int *allocated_match)
-{
-	return match_explicit_lhs_count(count_refspec_match_in_map(rs->src, src, match),
-					rs, match, allocated_match);
-}
-
 static void show_push_unqualified_ref_name_error(const char *dst_value,
 						 const char *matched_src_name)
 {
@@ -1333,7 +1315,7 @@ static bool any_refspec_item_is_explicit(const struct refspec *rs)
 	return false;
 }
 
-static int match_explicit(struct ref *src, struct ref *dst,
+static int match_explicit(struct strmap *src, struct strmap *dst,
 			  struct ref ***dst_tail,
 			  struct refspec_item *rs)
 {
@@ -1367,7 +1349,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			    matched_src->name);
 	}
 
-	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
+	switch (count_refspec_match_in_map(dst_value, dst, &matched_dst)) {
 	case 1:
 		break;
 	case 0:
@@ -1383,6 +1365,9 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			show_push_unqualified_ref_name_error(dst_value,
 							     matched_src->name);
 		}
+		/* later refspecs must see the ref we just added to dst */
+		if (matched_dst)
+			strmap_put(dst, matched_dst->name, matched_dst);
 		break;
 	default:
 		matched_dst = NULL;
@@ -1416,12 +1401,23 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	return ret;
 }
 
-static int match_explicit_refs(struct ref *src, struct ref **dst,
+static int match_explicit_refs(struct ref *src, struct ref *dst,
 			       struct ref ***dst_tail, struct refspec *rs)
 {
 	int i, errs;
+	struct strmap src_map, dst_map;
+
+	if (!any_refspec_item_is_explicit(rs))
+		return 0;
+
+	ref_map_init(&src_map, src);
+	ref_map_init(&dst_map, dst);
 	for (i = errs = 0; i < rs->nr; i++)
-		errs += match_explicit(src, *dst, dst_tail, &rs->items[i]);
+		errs += match_explicit(&src_map, &dst_map, dst_tail,
+				       &rs->items[i]);
+	strmap_clear(&dst_map, 0);
+	strmap_clear(&src_map, 0);
+
 	return errs;
 }
 
@@ -1644,7 +1640,7 @@ int check_push_refs(struct ref *src, struct refspec *rs)
 		if (!refspec_item_is_explicit(item))
 			continue;
 
-		ret |= match_explicit_lhs_map(&src_map, item, NULL, NULL);
+		ret |= match_explicit_lhs(&src_map, item, NULL, NULL);
 	}
 	strmap_clear(&src_map, 0);
 
@@ -1673,7 +1669,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	if (!rs->nr)
 		refspec_append(rs, ":");
 
-	errs = match_explicit_refs(src, dst, &dst_tail, rs);
+	errs = match_explicit_refs(src, *dst, &dst_tail, rs);
 
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
-- 
2.55.0

