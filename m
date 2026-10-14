Received: from smtp113.iad3a.emailsrvr.com (smtp113.iad3a.emailsrvr.com [173.203.187.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A43AFCFD
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948106; cv=none; b=JNYhG70eOLvieA9SnvVSYhE8mb0Y7K/crlMBvGfyBAnIFtNEY92zBFdeJ5GECQ35qWhs0kwJNq6g4TGhA1gdXo8CLsR5JeK+IJtkqkgoVCtDvioosvr3C1wy2DyPwp5WIvs/QJHiph0MhHmQvy5f46zQFsuLENIp/KTUooJqpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948106; c=relaxed/simple;
	bh=riq5w9+vnw5uLO00pkkfas/9oSXvuBhx5Jf+M9MGyBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+haCevruBNd1CIR+Gq0Bzi1ggqAQbaecHOyfNSSqGWcDKWw6AT4zVfAzAKD8OQQmWLPWF+Qr53ZWx25oVhl1oZ4KaBBGK32HvuGrFFbBILw13Q4w8eO3rB9jlYtK595svg4VUNxIBV37mqAh5DV1tWYts/kru+kpqcqX+Pxzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=g0+iM1yH; arc=none smtp.client-ip=173.203.187.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="g0+iM1yH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947661;
	bh=riq5w9+vnw5uLO00pkkfas/9oSXvuBhx5Jf+M9MGyBw=;
	h=From:To:Subject:Date:From;
	b=g0+iM1yHGitIEtTFBLYyk39nQtFMgUdAuXJ7L2e0bOLwdnhv7zTKASteK7FZp77t8
	 wVOugdw1E8rfVq0CwESfAYMwiEuRo2OMEZ4AkrRzHvh7X6jCqDvqAUGeuzm3ALAJ6y
	 rU2H4iH9rV5Rq2MyEybYKvt89AiSNZr0I/svBo+w=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 374A72535B;
	Tue, 13 Oct 2026 23:14:21 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 11/12] remote: restructure apply_push_cas() loops
Date: Tue, 13 Oct 2026 23:13:46 -0400
Message-ID: <20261014031347.50433-12-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014031347.50433-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
 <20261014031347.50433-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-12-1

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

