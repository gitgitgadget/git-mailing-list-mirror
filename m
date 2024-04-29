Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D82171A2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378911; cv=none; b=mP3vzKHQGxfJ7zO2j/TsuEvfgGV5r7eaO1ZPkIKXZgmhcNUq6E0RojAqXXLWcYotz5xf7zJQFnCho0Ipqqs5fHUfqFKt+YdJXnGR4iWA69JNtsMRnjRXJYim3H2fi4kEZWafqsMg+4z31T9sCKDcgH43yMVQT4Em7E4VzwbW7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378911; c=relaxed/simple;
	bh=0CjM4DdunfZIHn57I+E1dQQWziZfXl/U4F0mRel6jxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VL4botwSDOW6903ybREmGvtFrxADEFUMNqxoCBSU5H3+esqcryzsQCfp29gqNTHkX2IU32lJiQ9E6cv+CmoeIODU4Kgoi6kPcuYsDFOaUje0nFdbJAFt9trHvLBkhGsHJV6XO8ZoYb4O8f3kqMJiSLgmvbuzHD0gbHKSA01XhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20198 invoked by uid 109); 29 Apr 2024 08:21:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:21:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26841 invoked by uid 111); 29 Apr 2024 08:21:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:21:53 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:21:48 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/8] refs: move is_pseudoref_syntax() definition earlier
Message-ID: <20240429082148.GB233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

We have a static local function is_pseudoref_syntax(), used by
is_pseudoref(). The difference being that the former checks only syntax,
whereas the latter actually looks at the on-disk refs.

There are a few other places in the file where we care about the
pseudoref syntax and could make use of this function. Let's move it
earlier in the file, so it can be used more extensively without having
to forward declare it.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 55d2e0b2cb..d3d21ecd43 100644
--- a/refs.c
+++ b/refs.c
@@ -164,6 +164,22 @@ void update_ref_namespace(enum ref_namespace namespace, char *ref)
 	info->ref_updated = 1;
 }
 
+static int is_pseudoref_syntax(const char *refname)
+{
+	const char *c;
+
+	for (c = refname; *c; c++) {
+		if (!isupper(*c) && *c != '-' && *c != '_')
+			return 0;
+	}
+
+	/*
+	 * HEAD is not a pseudoref, but it certainly uses the
+	 * pseudoref syntax.
+	 */
+	return 1;
+}
+
 /*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
@@ -844,22 +860,6 @@ int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
 
-static int is_pseudoref_syntax(const char *refname)
-{
-	const char *c;
-
-	for (c = refname; *c; c++) {
-		if (!isupper(*c) && *c != '-' && *c != '_')
-			return 0;
-	}
-
-	/*
-	 * HEAD is not a pseudoref, but it certainly uses the
-	 * pseudoref syntax.
-	 */
-	return 1;
-}
-
 int is_pseudoref(struct ref_store *refs, const char *refname)
 {
 	static const char *const irregular_pseudorefs[] = {
-- 
2.45.0.rc1.416.gbe2a76c799

