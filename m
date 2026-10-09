Received: from smtp90.iad3b.emailsrvr.com (smtp90.iad3b.emailsrvr.com [146.20.161.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E044F5DF5
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574667; cv=none; b=AEPeY36Jr0YxQdYs4KaHOVV6/HoNrSPNL9I261hhZxFNtjkE4gqCtlSG7YNfQS/kBCeE0fpqlIc21zOfuGAFCJQcZFUS0aTyPQXRe7a8P8bbSnOloChbb8xI+kTzXIr6u8jN+C5mP7gX2TdhH4T67hGj/rdojyAhjmecijmsHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574667; c=relaxed/simple;
	bh=riq5w9+vnw5uLO00pkkfas/9oSXvuBhx5Jf+M9MGyBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es8EjcZjf3PV28VO9I/jaGLaIPzzsQ8pUBpDncfobmAygxa8M9EZ7wbhPZK7lRc3ZwzR6KgNLUGgj06JH4y0q6ysMktMYWRKkxENH4HwMMGIg4cPfRk6hqmqL4SwBqnTbubS3NPikVHGBIMGvDWd1QTw2eIkZzV9LmX+z5i7DVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=CtzNRCLH; arc=none smtp.client-ip=146.20.161.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="CtzNRCLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574224;
	bh=riq5w9+vnw5uLO00pkkfas/9oSXvuBhx5Jf+M9MGyBw=;
	h=From:To:Subject:Date:From;
	b=CtzNRCLHwXQDhzin0cVjuAUiIo1IQ3OeBRPR8++Lv3/t6tdYGNpEHR3wpUZz85rpV
	 nAtvHR3L7inHqJPniFPMF+c0dK7EWOADxY39zgmO/tuylSlvXBUrivYQWQRvAk2mxy
	 eWly29y66Np/TONwEq5kx90pyYgZ/vMWzc82FPB8=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 28F8020397;
	Fri,  9 Oct 2026 15:30:24 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 14/15] remote: restructure apply_push_cas() loops
Date: Fri,  9 Oct 2026 15:29:52 -0400
Message-ID: <20261009192953.81794-15-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-15-1

Restructure the apply_push_cas() loops to prepare for replacing
a linear remote_refs traversal with a strmap lookup.

Before this change, apply_push_cas() loops:

    for each advertised remote ref,
      apply_cas(ref):
        for each explicit lease entry until first match,
          refname_match(entry, ref)
        else if use_tracking_for_rest,
          stamp from tracking

After this change the loops are inverted and apply_cas() is split
into apply_one_cas() (one explicit entry, stamp every matching
still-free ref) and apply_cas_tracking() (shared by the explicit
use_tracking path and use_tracking_for_rest):

    for each explicit lease entry,
      apply_one_cas(entry):
        for each advertised remote ref not yet stamped,
          refname_match(entry, ref)

    if use_tracking_for_rest,
      apply_cas_tracking() on remaining refs

In the next commit, apply_one_cas() is updated to use a strmap.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 remote.c | 66 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/remote.c b/remote.c
index 8074750601..8dd163038d 100644
--- a/remote.c
+++ b/remote.c
@@ -2978,33 +2978,10 @@ static void check_if_includes_upstream(struct ref *remote)
 	free_one_ref(local);
 }
 
-static void apply_cas(struct push_cas_option *cas,
-		      struct remote *remote,
-		      struct ref *ref)
+static void apply_cas_tracking(struct push_cas_option *cas,
+			       struct remote *remote,
+			       struct ref *ref)
 {
-	int i;
-
-	/* Find an explicit --<option>=<name>[:<value>] entry */
-	for (i = 0; i < cas->nr; i++) {
-		struct push_cas *entry = &cas->entry[i];
-		if (!refname_match(entry->refname, ref->name))
-			continue;
-		ref->expect_old_sha1 = 1;
-		if (!entry->use_tracking)
-			oidcpy(&ref->old_oid_expect, &entry->expect);
-		else if (remote_tracking(remote, ref->name,
-					 &ref->old_oid_expect,
-					 &ref->tracking_ref))
-			oidclr(&ref->old_oid_expect, the_repository->hash_algo);
-		else
-			ref->check_reachable = cas->use_force_if_includes;
-		return;
-	}
-
-	/* Are we using "--<option>" to cover all? */
-	if (!cas->use_tracking_for_rest)
-		return;
-
 	ref->expect_old_sha1 = 1;
 	if (remote_tracking(remote, ref->name,
 			    &ref->old_oid_expect,
@@ -3014,14 +2991,47 @@ static void apply_cas(struct push_cas_option *cas,
 		ref->check_reachable = cas->use_force_if_includes;
 }
 
+static void apply_one_cas(struct ref *remote_refs,
+			  struct remote *remote,
+			  struct push_cas_option *cas,
+			  struct push_cas *entry)
+{
+	struct ref *ref;
+
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (ref->expect_old_sha1)
+			continue;
+		if (!refname_match(entry->refname, ref->name))
+			continue;
+		if (entry->use_tracking) {
+			apply_cas_tracking(cas, remote, ref);
+		} else {
+			ref->expect_old_sha1 = 1;
+			oidcpy(&ref->old_oid_expect, &entry->expect);
+		}
+	}
+}
+
 void apply_push_cas(struct push_cas_option *cas,
 		    struct remote *remote,
 		    struct ref *remote_refs)
 {
 	struct ref *ref;
-	for (ref = remote_refs; ref; ref = ref->next) {
-		apply_cas(cas, remote, ref);
 
+	/* Apply each explicit --<option>=<name>[:<value>] entry */
+	for (size_t i = 0; i < cas->nr; i++)
+		apply_one_cas(remote_refs, remote, cas, &cas->entry[i]);
+
+	/* Are we using "--<option>" to cover all? */
+	if (cas->use_tracking_for_rest) {
+		for (ref = remote_refs; ref; ref = ref->next) {
+			if (ref->expect_old_sha1)
+				continue;
+			apply_cas_tracking(cas, remote, ref);
+		}
+	}
+
+	for (ref = remote_refs; ref; ref = ref->next) {
 		/*
 		 * If "compare-and-swap" is in "use_tracking[_for_rest]"
 		 * mode, and if "--force-if-includes" was specified, run
-- 
2.55.0

