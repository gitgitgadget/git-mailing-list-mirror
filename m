Received: from smtp94.iad3b.emailsrvr.com (smtp94.iad3b.emailsrvr.com [146.20.161.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038F45DF4A
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574234; cv=none; b=EuVdiyFOH5zu7z3XafRpa0Zmx4rSuKG1G5qVlXRsR/nzqi9vreHrsySFBjKLgmrnFbuzUdnHP7m0flef4EeIqbNQhvLWD3ie0gHxCbYHjrYe7T9e1+8ZczOTuFB4+1jTWy1TardMPQ7doC0q8+Dyn+FLmbBwUeeCQHTR5AaVSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574234; c=relaxed/simple;
	bh=bhwXdTXqKiibPegCCe6J0ssUrSwH1tDhXLzg9XzxUEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfFPCop6rV6EndxYHxxBBDaiu6N1UuLa/xVRgBk0Otkz4vUfbtrr/nX3nR4SZbQ0t4YZvkT+F5jWH+3806sAnmYpfpd0XqVn7UiQTbUQkrLzffMKOE9O5HtULip+Dm8OBbFnPqUuBy7LbhesvKTht1YhuyHgcEizPKTNvFwaB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=gO9NUdPe; arc=none smtp.client-ip=146.20.161.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="gO9NUdPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574224;
	bh=bhwXdTXqKiibPegCCe6J0ssUrSwH1tDhXLzg9XzxUEc=;
	h=From:To:Subject:Date:From;
	b=gO9NUdPe2foqSd9915jEZK29JB5Vh4nx4310W/zLvPqA3rRXFe0she3knN5T5nJSR
	 vDbYd3RD7ikmYOi/NyI6Vzjjx9CzJVMKdIVU7wRfYKq0DMXXT0CFyEISwHJ6/pHul7
	 RAhV2JZGiQePtHs1mwTHMJ0eMYi82ueyCMd1kkpc=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 7C30F20398;
	Fri,  9 Oct 2026 15:30:24 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 15/15] remote: use strmap for apply_push_cas()
Date: Fri,  9 Oct 2026 15:29:53 -0400
Message-ID: <20261009192953.81794-16-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-16-1

Optimize apply_push_cas() by replacing a linear traversal of all
advertised remote refs with strmap lookups.

Before this change, applying N explicit --force-with-lease entries
to M remote advertised refs entails O(N * M) calls to refname_match()
in apply_one_cas().

After this change, we build a strmap of remote refs O(M), and use it
for O(N * rules) lookups of the lease entry refnames.

The refnames are resolved by issuing one strmap lookup for each
candidate rules pattern generated with expand_ref_prefix(), as
with earlier strmap conversions.

p5516 timings show the speedup:

  Test                        HEAD~1            HEAD
  --------------------------------------------------------------------
  5516.16: empty:lease:1      0.13(0.07+0.10)   0.14(0.08+0.11) +7.7%
  5516.19: empty:lease:10     0.16(0.10+0.10)   0.14(0.08+0.11) -12.5%
  5516.22: empty:lease:100    0.45(0.39+0.10)   0.16(0.09+0.11) -64.4%
  5516.25: mirror:lease:1     0.16(0.09+0.11)   0.17(0.10+0.12) +6.3%
  5516.28: mirror:lease:10    0.19(0.12+0.10)   0.17(0.10+0.11) -10.5%
  5516.31: mirror:lease:100   0.49(0.42+0.12)   0.19(0.11+0.12) -61.2%

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 remote.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 8dd163038d..c16f1a2b82 100644
--- a/remote.c
+++ b/remote.c
@@ -2991,17 +2991,17 @@ static void apply_cas_tracking(struct push_cas_option *cas,
 		ref->check_reachable = cas->use_force_if_includes;
 }
 
-static void apply_one_cas(struct ref *remote_refs,
+static void apply_one_cas(struct strmap *ref_map,
 			  struct remote *remote,
 			  struct push_cas_option *cas,
 			  struct push_cas *entry)
 {
-	struct ref *ref;
+	struct strvec names = STRVEC_INIT;
 
-	for (ref = remote_refs; ref; ref = ref->next) {
-		if (ref->expect_old_sha1)
-			continue;
-		if (!refname_match(entry->refname, ref->name))
+	expand_ref_prefix(&names, entry->refname);
+	for (size_t i = 0; i < names.nr; i++) {
+		struct ref *ref = strmap_get(ref_map, names.v[i]);
+		if (!ref || ref->expect_old_sha1)
 			continue;
 		if (entry->use_tracking) {
 			apply_cas_tracking(cas, remote, ref);
@@ -3010,6 +3010,7 @@ static void apply_one_cas(struct ref *remote_refs,
 			oidcpy(&ref->old_oid_expect, &entry->expect);
 		}
 	}
+	strvec_clear(&names);
 }
 
 void apply_push_cas(struct push_cas_option *cas,
@@ -3019,8 +3020,14 @@ void apply_push_cas(struct push_cas_option *cas,
 	struct ref *ref;
 
 	/* Apply each explicit --<option>=<name>[:<value>] entry */
-	for (size_t i = 0; i < cas->nr; i++)
-		apply_one_cas(remote_refs, remote, cas, &cas->entry[i]);
+	if (cas->nr) {
+		struct strmap ref_map;
+
+		ref_map_init(&ref_map, remote_refs);
+		for (size_t i = 0; i < cas->nr; i++)
+			apply_one_cas(&ref_map, remote, cas, &cas->entry[i]);
+		strmap_clear(&ref_map, 0);
+	}
 
 	/* Are we using "--<option>" to cover all? */
 	if (cas->use_tracking_for_rest) {
-- 
2.55.0

