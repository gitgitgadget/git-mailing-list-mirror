Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB07130495
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923994; cv=none; b=LAmk5p6r2+CX1VfmKn7uckBryxYIAgqRqZvn4c/N1YeMw7LMjnGyQfmvT2N76e7yYqBUSgpJRz78s9QDpEryMqlUroS29yRLHmQJFIJgLoWJuBwUErHfh4Ec8tqeK1T+EoDkI++nflWUPGWcehVQ5DllwEM5xic7Pfu1STn/FQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923994; c=relaxed/simple;
	bh=gontoa4bmp+ewbBGtc/f8Xwy0VRZviWOD3yk4GeDJcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbhtxKVvr1K3MUS8BxrRfPDmq4eKz6wnxOWhA3GSsORsYgCx6fuEwV/anjTiLz7HghWsI3Nsi6a8gkNh8fusXaSK4Vu0bQl6erniStA6qD3fLPf6vDo0ijZuhzxtpe8qxfyfW/g4/KpF13rcJA8gb4sdJAPNxFoibqwe1NO3Jrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32256 invoked by uid 109); 9 Sep 2024 23:19:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:19:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24983 invoked by uid 111); 9 Sep 2024 23:19:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:19:52 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:19:51 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 8/9] ref-filter: fix leak when formatting %(push:remoteref)
Message-ID: <20240909231951.GH921834@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909230758.GA921697@coredump.intra.peff.net>

When we expand the %(upstream) or %(push) placeholders, we rely on
remote.c's remote_ref_for_branch() to fill in the ":refname" argument.
But that function has confusing memory ownership semantics: it may or
may not return an allocated string, depending on whether we are in
"upstream" mode or "push" mode. The caller in ref-filter.c always
duplicates the result, meaning that we leak the original in the case of
%(push:refname).

To solve this, let's make the return value from remote_ref_for_branch()
consistent, by always returning an allocated pointer. Note that the
switch to returning a non-const pointer has a ripple effect inside the
function, too. We were storing the "dst" result as a const pointer, too,
even though it is always allocated! It is the return value from
apply_refspecs(), which is always a non-const allocated string.

And then on the caller side in ref-filter.c (and this is the only caller
at all), we just need to avoid the extra duplication when the return
value is non-NULL.

This clears up one case that LSan finds in t6300, but there are more.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 remote.c     | 8 ++++----
 remote.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 370cc5b44a..0f51095bbd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2237,7 +2237,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		const char *merge;
 
 		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push);
-		*s = xstrdup(merge ? merge : "");
+		*s = merge ? merge : xstrdup("");
 	} else
 		BUG("unhandled RR_* enum");
 }
diff --git a/remote.c b/remote.c
index 8f3dee1318..539e5ceae3 100644
--- a/remote.c
+++ b/remote.c
@@ -632,19 +632,19 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 static struct remote *remotes_remote_get(struct remote_state *remote_state,
 					 const char *name);
 
-const char *remote_ref_for_branch(struct branch *branch, int for_push)
+char *remote_ref_for_branch(struct branch *branch, int for_push)
 {
 	read_config(the_repository, 0);
 	die_on_missing_branch(the_repository, branch);
 
 	if (branch) {
 		if (!for_push) {
 			if (branch->merge_nr) {
-				return branch->merge_name[0];
+				return xstrdup(branch->merge_name[0]);
 			}
 		} else {
-			const char *dst,
-				*remote_name = remotes_pushremote_for_branch(
+			char *dst;
+			const char *remote_name = remotes_pushremote_for_branch(
 					the_repository->remote_state, branch,
 					NULL);
 			struct remote *remote = remotes_remote_get(
diff --git a/remote.h b/remote.h
index b901b56746..a58713f20a 100644
--- a/remote.h
+++ b/remote.h
@@ -329,7 +329,7 @@ struct branch {
 struct branch *branch_get(const char *name);
 const char *remote_for_branch(struct branch *branch, int *explicit);
 const char *pushremote_for_branch(struct branch *branch, int *explicit);
-const char *remote_ref_for_branch(struct branch *branch, int for_push);
+char *remote_ref_for_branch(struct branch *branch, int for_push);
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
-- 
2.46.0.867.gf99b2b8e0f

