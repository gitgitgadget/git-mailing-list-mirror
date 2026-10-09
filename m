Received: from smtp92.iad3b.emailsrvr.com (smtp92.iad3b.emailsrvr.com [146.20.161.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7643CB54D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574235; cv=none; b=JkOC5yOIu0Dd07IFLEBag9cTLgguokJkKKB00Lub0mHBmXjlhIUkfWxkQ4ejQEm/Q4DPaiXcWdNaCdyCEfFA5ieqracsox7dg16r6AIlbOV/8CKWL6WvwMYXycVP2R/HAelzpwHZm9H8SaJIopiX7aF3nu8gawvoR5fr60ThphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574235; c=relaxed/simple;
	bh=4MkxXEBU+GOd1BGLa9V3cB2Ekk80Gjfzf3Oaqh9GXLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/tzUw4YvNks+TYnaT84BHx0hD2zG9AKrKy06iQYJ2n3R4yfRQHiDagqboJRPsA0DrkKYRImMXweSb7uMltbwMqJ+niRELM5HSRZ7rwRgs4RDSqIFS/l1NRQgFseSIqFLcO5WiZfQIBkD0p2O7y5S/xeV4+kI/v3aKiC3u72N+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=KP1x66GX; arc=none smtp.client-ip=146.20.161.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="KP1x66GX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574221;
	bh=4MkxXEBU+GOd1BGLa9V3cB2Ekk80Gjfzf3Oaqh9GXLY=;
	h=From:To:Subject:Date:From;
	b=KP1x66GXjuJ7/aWgDcQ60mW/GNQULS76mmurp4l1EDb3EiPnxiXJnTmS5Gie+1ngI
	 15KWX65/SuFqtnOqnyiKjPLTF0vQmWXxYH3gUnzragZMlESm7oI/DowM7DiQEPMVJU
	 G0WIvcNgrulM6R1xRHVJFJA2hjS3fFvgYZcxqmBw=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 7CB572038F;
	Fri,  9 Oct 2026 15:30:21 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 06/15] remote: use strmap for check_push_refs()
Date: Fri,  9 Oct 2026 15:29:44 -0400
Message-ID: <20261009192953.81794-7-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-7-1

Optimize check_push_refs() by replacing a linear traversal of all
local refs with strmap lookups.

Before this change, matching R explicit refspecs against N local refs
in check_push_refs() entails O(R * N) calls to refname_match().

After this change, we build a strmap of local refs O(N) and use it
for O(R * rules) lookups of the refspecs.

The new count_refspec_match_in_map() is equivalent to the previous
count_refspec_match():

 - count_refspec_match() for 'pattern' iterates every local ref,
   adding a match for each 'refname_match(pattern, refname)',
   which searches against the six ref_rev_parse_rules.

 - count_refspec_match_in_map() for 'pattern' generates the six
   possible matches with expand_ref_prefix(), and then issues
   one strmap lookup for each one.

match_explicit() still works on the ref list, so temporarily introduce
match_explicit_lhs_map() alongside match_explicit_lhs().  These two
functions are recombined in a subsequent commit that converts
match_explicit().

Timings show benefit for the case where the client has many local refs
and specifies multiple refspecs:

  Test                           HEAD~1            HEAD
  -----------------------------------------------------------------------
  5516.3: empty:refspecs:1       0.14(0.07+0.11)   0.13(0.07+0.10) -7.1%
  5516.5: empty:refspecs:10      0.16(0.10+0.10)   0.16(0.10+0.10) +0.0%
  5516.7: empty:refspecs:100     0.47(0.41+0.10)   0.47(0.41+0.10) +0.0%
  5516.9: mirror:refspecs:1      0.16(0.09+0.11)   0.16(0.10+0.11) +0.0%
  5516.11: mirror:refspecs:10    0.26(0.19+0.11)   0.22(0.16+0.11) -15.4%
  5516.13: mirror:refspecs:100   1.19(1.13+0.10)   0.82(0.75+0.11) -31.1%

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 remote.c | 186 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 129 insertions(+), 57 deletions(-)

diff --git a/remote.c b/remote.c
index 114d4d983c..91d35b37fe 100644
--- a/remote.c
+++ b/remote.c
@@ -21,6 +21,7 @@
 #include "dir.h"
 #include "setup.h"
 #include "string-list.h"
+#include "strmap.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "advice.h"
@@ -1056,60 +1057,95 @@ void free_refs(struct ref *ref)
 	}
 }
 
+struct refspec_match {
+	struct ref *matched_weak;
+	struct ref *matched;
+	int weak_match;
+	int match;
+};
+
+static void add_refspec_match(struct refspec_match *m, const char *pattern,
+			      struct ref *ref)
+{
+	size_t patlen = strlen(pattern);
+	size_t namelen = strlen(ref->name);
+
+	/* A match is "weak" if it is with refs outside
+	 * heads or tags, and did not specify the pattern
+	 * in full (e.g. "refs/remotes/origin/master") or at
+	 * least from the toplevel (e.g. "remotes/origin/master");
+	 * otherwise "git push $URL master" would result in
+	 * ambiguity between remotes/origin/master and heads/master
+	 * at the remote site.
+	 */
+	if (namelen != patlen &&
+	    patlen != namelen - 5 &&
+	    !starts_with(ref->name, "refs/heads/") &&
+	    !starts_with(ref->name, "refs/tags/")) {
+		/* We want to catch the case where only weak
+		 * matches are found and there are multiple
+		 * matches, and where more than one strong
+		 * matches are found, as ambiguous.  One
+		 * strong match with zero or more weak matches
+		 * are acceptable as a unique match.
+		 */
+		m->matched_weak = ref;
+		m->weak_match++;
+	} else {
+		m->matched = ref;
+		m->match++;
+	}
+}
+
+static int finish_refspec_match(const struct refspec_match *m,
+				struct ref **matched_ref)
+{
+	if (!m->matched) {
+		if (matched_ref)
+			*matched_ref = m->matched_weak;
+		return m->weak_match;
+	}
+	if (matched_ref)
+		*matched_ref = m->matched;
+	return m->match;
+}
+
 int count_refspec_match(const char *pattern,
 			struct ref *refs,
 			struct ref **matched_ref)
 {
-	int patlen = strlen(pattern);
-	struct ref *matched_weak = NULL;
-	struct ref *matched = NULL;
-	int weak_match = 0;
-	int match = 0;
+	struct refspec_match m = { 0 };
 
-	for (weak_match = match = 0; refs; refs = refs->next) {
-		char *name = refs->name;
-		int namelen = strlen(name);
+	for (; refs; refs = refs->next) {
+		if (refname_match(pattern, refs->name))
+			add_refspec_match(&m, pattern, refs);
+	}
+	return finish_refspec_match(&m, matched_ref);
+}
 
-		if (!refname_match(pattern, name))
-			continue;
+static void ref_map_init(struct strmap *map, struct ref *refs)
+{
+	strmap_init_with_options(map, NULL, 0);
+	for (; refs; refs = refs->next)
+		strmap_put(map, refs->name, refs);
+}
 
-		/* A match is "weak" if it is with refs outside
-		 * heads or tags, and did not specify the pattern
-		 * in full (e.g. "refs/remotes/origin/master") or at
-		 * least from the toplevel (e.g. "remotes/origin/master");
-		 * otherwise "git push $URL master" would result in
-		 * ambiguity between remotes/origin/master and heads/master
-		 * at the remote site.
-		 */
-		if (namelen != patlen &&
-		    patlen != namelen - 5 &&
-		    !starts_with(name, "refs/heads/") &&
-		    !starts_with(name, "refs/tags/")) {
-			/* We want to catch the case where only weak
-			 * matches are found and there are multiple
-			 * matches, and where more than one strong
-			 * matches are found, as ambiguous.  One
-			 * strong match with zero or more weak matches
-			 * are acceptable as a unique match.
-			 */
-			matched_weak = refs;
-			weak_match++;
-		}
-		else {
-			matched = refs;
-			match++;
-		}
-	}
-	if (!matched) {
-		if (matched_ref)
-			*matched_ref = matched_weak;
-		return weak_match;
-	}
-	else {
-		if (matched_ref)
-			*matched_ref = matched;
-		return match;
+static int count_refspec_match_in_map(const char *pattern,
+				      struct strmap *refs,
+				      struct ref **matched_ref)
+{
+	struct refspec_match m = { 0 };
+	struct strvec names = STRVEC_INIT;
+	size_t i;
+
+	expand_ref_prefix(&names, pattern);
+	for (i = 0; i < names.nr; i++) {
+		struct ref *ref = strmap_get(refs, names.v[i]);
+		if (ref)
+			add_refspec_match(&m, pattern, ref);
 	}
+	strvec_clear(&names);
+	return finish_refspec_match(&m, matched_ref);
 }
 
 void tail_link_ref(struct ref *ref, struct ref ***tail)
@@ -1178,12 +1214,12 @@ static char *guess_ref(const char *name, struct ref *peer)
 	return strbuf_detach(&buf, NULL);
 }
 
-static int match_explicit_lhs(struct ref *src,
-			      struct refspec_item *rs,
-			      struct ref **match,
-			      int *allocated_match)
+static int match_explicit_lhs_count(const int count,
+				    struct refspec_item *rs,
+				    struct ref **match,
+				    int *allocated_match)
 {
-	switch (count_refspec_match(rs->src, src, match)) {
+	switch (count) {
 	case 1:
 		if (allocated_match)
 			*allocated_match = 0;
@@ -1203,6 +1239,24 @@ static int match_explicit_lhs(struct ref *src,
 	}
 }
 
+static int match_explicit_lhs(struct ref *src,
+			      struct refspec_item *rs,
+			      struct ref **match,
+			      int *allocated_match)
+{
+	return match_explicit_lhs_count(count_refspec_match(rs->src, src, match),
+					rs, match, allocated_match);
+}
+
+static int match_explicit_lhs_map(struct strmap *src,
+				  struct refspec_item *rs,
+				  struct ref **match,
+				  int *allocated_match)
+{
+	return match_explicit_lhs_count(count_refspec_match_in_map(rs->src, src, match),
+					rs, match, allocated_match);
+}
+
 static void show_push_unqualified_ref_name_error(const char *dst_value,
 						 const char *matched_src_name)
 {
@@ -1265,6 +1319,20 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 	}
 }
 
+static bool refspec_item_is_explicit(const struct refspec_item *item)
+{
+	return !item->pattern && !item->matching && !item->negative;
+}
+
+static bool any_refspec_item_is_explicit(const struct refspec *rs)
+{
+	for (int i = 0; i < rs->nr; i++) {
+		if (refspec_item_is_explicit(&rs->items[i]))
+			return true;
+	}
+	return false;
+}
+
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec_item *rs)
@@ -1275,7 +1343,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	const char *dst_value = rs->dst;
 	char *dst_guess;
 
-	if (rs->pattern || rs->matching || rs->negative) {
+	if (!refspec_item_is_explicit(rs)) {
 		ret = 0;
 		goto out;
 	}
@@ -1564,17 +1632,21 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
  */
 int check_push_refs(struct ref *src, struct refspec *rs)
 {
+	struct strmap src_map;
 	int ret = 0;
-	int i;
 
-	for (i = 0; i < rs->nr; i++) {
-		struct refspec_item *item = &rs->items[i];
+	if (!any_refspec_item_is_explicit(rs))
+		return 0;
 
-		if (item->pattern || item->matching || item->negative)
+	ref_map_init(&src_map, src);
+	for (int i = 0; i < rs->nr; i++) {
+		struct refspec_item *item = &rs->items[i];
+		if (!refspec_item_is_explicit(item))
 			continue;
 
-		ret |= match_explicit_lhs(src, item, NULL, NULL);
+		ret |= match_explicit_lhs_map(&src_map, item, NULL, NULL);
 	}
+	strmap_clear(&src_map, 0);
 
 	return ret;
 }
-- 
2.55.0

