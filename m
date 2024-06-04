Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E01448E2
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495997; cv=none; b=ppFguJG8LiTVQM1XF5CAy57nzgXf5IKBefoQVJSLJtYqwKXwJgG0ynRzekJ6reP8MfQBSanBiXrf8vFD+ONEu3jVyZQmyAOlx0ZKdHsUtcgIt5Y0yTvqEgsyKM7TWpwUB3WdE//tBMPEOnrr64VDOjUCYWzMCWMur96jo2ANLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495997; c=relaxed/simple;
	bh=IZOFFgG3RuI7Q+u5Wwn+mpRlJQANH8yw5GLOZwmaiWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etaVIBW2wXWf+iJIzwZCfzFvvhQOVZ2Ro+uGE7zZQl5HM39C2Qp8Swi4jmuzWLdqWCf1pC5gmrSTe1gU73dotL05Pe9rbRZQTiIJq0WkJmVQB/5iaQi+yje7HQnHYFI4/7EFF/9jwXJO1i9PQLObOpWjoWX+El/6f+HB6huxNJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21475 invoked by uid 109); 4 Jun 2024 10:13:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18355 invoked by uid 111); 4 Jun 2024 10:13:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:14 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 03/13] dir.c: free strings in sparse cone pattern hashmaps
Message-ID: <20240604101314.GC1304593@coredump.intra.peff.net>
References: <20240604100814.GA1304520@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604100814.GA1304520@coredump.intra.peff.net>

The pattern_list structs used for cone-mode sparse lookups use a few
extra hashmaps. These store pattern_entry structs, each of which has its
own heap-allocated pattern string. When we clean up the hashmaps, we
free the individual pattern_entry structs, but forget to clean up the
embedded strings, causing memory leaks.

We can fix this by iterating over the hashmaps to free the extra
strings. This reduces the numbers of leaks in t7002 from 22 to 9.

One alternative here would be to make the string a FLEX_ARRAY member of
the pattern_entry. Then there's no extra free() required, and as a bonus
it would be a little more efficient. However, some of the refactoring
gets awkward, as we are often assigning strings allocated by helper
functions. So let's just fix the leak for now, and we can explore bigger
refactoring separately.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 2d83f3311a..9cc4a68fbc 100644
--- a/dir.c
+++ b/dir.c
@@ -726,6 +726,17 @@ static char *dup_and_filter_pattern(const char *pattern)
 	return result;
 }
 
+static void clear_pattern_entry_hashmap(struct hashmap *map)
+{
+	struct hashmap_iter iter;
+	struct pattern_entry *entry;
+
+	hashmap_for_each_entry(map, &iter, entry, ent) {
+		free(entry->pattern);
+	}
+	hashmap_clear_and_free(map, struct pattern_entry, ent);
+}
+
 static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern *given)
 {
 	struct pattern_entry *translated;
@@ -855,8 +866,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 clear_hashmaps:
 	warning(_("disabling cone pattern matching"));
-	hashmap_clear_and_free(&pl->parent_hashmap, struct pattern_entry, ent);
-	hashmap_clear_and_free(&pl->recursive_hashmap, struct pattern_entry, ent);
+	clear_pattern_entry_hashmap(&pl->recursive_hashmap);
+	clear_pattern_entry_hashmap(&pl->parent_hashmap);
 	pl->use_cone_patterns = 0;
 }
 
@@ -956,8 +967,8 @@ void clear_pattern_list(struct pattern_list *pl)
 		free(pl->patterns[i]);
 	free(pl->patterns);
 	free(pl->filebuf);
-	hashmap_clear_and_free(&pl->recursive_hashmap, struct pattern_entry, ent);
-	hashmap_clear_and_free(&pl->parent_hashmap, struct pattern_entry, ent);
+	clear_pattern_entry_hashmap(&pl->recursive_hashmap);
+	clear_pattern_entry_hashmap(&pl->parent_hashmap);
 
 	memset(pl, 0, sizeof(*pl));
 }
-- 
2.45.2.807.g3b5fadc4da

