Received: from smtp90.iad3b.emailsrvr.com (smtp90.iad3b.emailsrvr.com [146.20.161.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5944F56D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574660; cv=none; b=DmNuLufoGUimPwF0fX8GCQt5yeoE7g342XPd32LpditLP/PqvEboOAHC5Gv3l/LwhbDRtYDx3YbBG58EhFo991GxNq7tlFiJSgvvILOP3XiK7Ixfl0XjqrVJnNG5bn4nTrnUQFed1u7E4w/Djzw0qTnpnlHyIcQKX+b0b1+KtEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574660; c=relaxed/simple;
	bh=74NNomjLJpIvVjF+B0qJSF/TwoliFjMjWlHWH+YyiFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kO91Af/pNehzPNkiHZIoHsmuPsG/lymeQolJ4GQxBHby6e/I+Y02GVLCrj1SsUgWZ6kfn8UkOOtpjxyIAGk3O5duSTDRtUNPTGzmEpveKoZf6awNQ5lpAsP5culWRIPr8aR/HClLa+Xro4MUHIRtpOUnOj2dX14D4XY+Nzbmbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=G9qug/02; arc=none smtp.client-ip=146.20.161.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="G9qug/02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574221;
	bh=74NNomjLJpIvVjF+B0qJSF/TwoliFjMjWlHWH+YyiFQ=;
	h=From:To:Subject:Date:From;
	b=G9qug/02QMsUbpoODd39jNLxPQ4jO/r2Ys5Ul9W+RCxWoQw7EJEx35TuRXdJxf+0Q
	 vGbGAZpEzMWSsBj1qWJab1fKX+S72WmGdAqQSgrnhOn01h45sHcYqd70R7PRSZRf3m
	 71NdZb7a3RaVfOgCuctLU3xQSL41+Y9xk41spsgg=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 2389A2038E;
	Fri,  9 Oct 2026 15:30:21 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 05/15] refs: stop using mkpath() in refname_match()
Date: Fri,  9 Oct 2026 15:29:43 -0400
Message-ID: <20261009192953.81794-6-jon@jonsimons.org>
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
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-6-1

refname_match() formats every ref_rev_parse_rules entry through mkpath()
to then strcmp() with its given full_name.  It turns out this formatting
function dominates the client-side cost of matching explicit refspecs
against a remote that advertises lots of refs.

Reuse match_parse_rule() instead to efficiently compare each rule
against its given full_name.  With this change we avoid mkpath()'s
strbuf_vaddf(), and each match is now a direct prefix + suffix
comparison, length check, and memcmp of the refname at hand.

Timings from the test added in the previous commit:

  Test                           HEAD~1            HEAD
  -----------------------------------------------------------------------
  5516.3: empty:refspecs:1       0.15(0.09+0.11)   0.14(0.07+0.11) -6.7%
  5516.5: empty:refspecs:10      0.38(0.32+0.11)   0.17(0.11+0.11) -55.3%
  5516.7: empty:refspecs:100     2.50(2.43+0.11)   0.49(0.42+0.11) -80.4%
  5516.9: mirror:refspecs:1      0.21(0.15+0.11)   0.16(0.09+0.11) -23.8%
  5516.11: mirror:refspecs:10    0.80(0.73+0.11)   0.26(0.19+0.11) -67.5%
  5516.13: mirror:refspecs:100   6.68(6.59+0.13)   1.18(1.11+0.11) -82.3%

Notes on a change in behavior:

 - mkpath() runs cleanup_path(), which strips leading "./".  So,
   "./refs/heads/foo" previously matched "refs/heads/foo" through the
   "%.*s" rule.  As of this commit, this is no longer true.

 - It's considered a bug that "./"-prefixed strings previously could
   have been matched with refnames in this way:

   - cleanup_path() dates back to 26c8a533af (Add "mkpath()" helper
     function, 2005-07-08), and is intended to be used for filepaths,
     not refnames.  The leading-"./" strip itself comes from f17a1b1bec
     (Fix up path-cleanup in git_path() properly, 2005-07-05).

   - refname_match() has used mkpath() in its matching loop since its
     inception with 79803322c1 (add refname_match(), 2007-11-11).

   - 6cd4a8982d (avoid using mksnpath for refs, 2017-03-28) previously
     removed other cleanup_path() spots reachable from mksnpath() and
     notes they were "questionable when dealing with refnames, as we
     could silently canonicalize a syntactically bogus refname into a
     valid one."

Tests in t5510 and t5516 that cover the aliasing behavior are toggled
to test_expect_success.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 refs.c                | 88 +++++++++++++++++++++++--------------------
 t/t5510-fetch.sh      |  4 +-
 t/t5516-fetch-push.sh |  2 +-
 3 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/refs.c b/refs.c
index 951db56113..9bf3bc8153 100644
--- a/refs.c
+++ b/refs.c
@@ -652,6 +652,44 @@ static const char *ref_rev_parse_rules[] = {
 
 #define NUM_REV_PARSE_RULES (ARRAY_SIZE(ref_rev_parse_rules) - 1)
 
+/*
+ * Check that the string refname matches a rule of the form
+ * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
+ * "foo/%.*s/baz", and return the string "bar".
+ */
+static const char *match_parse_rule(const char *refname, const char *rule,
+				    size_t *len)
+{
+	/*
+	 * Check that rule matches refname up to the first percent in the rule.
+	 * We can bail immediately if not, but otherwise we leave "rule" at the
+	 * %-placeholder, and "refname" at the start of the potential matched
+	 * name.
+	 */
+	while (*rule != '%') {
+		if (!*rule)
+			BUG("rev-parse rule did not have percent");
+		if (*refname++ != *rule++)
+			return NULL;
+	}
+
+	/*
+	 * Check that our "%" is the expected placeholder. This assumes there
+	 * are no other percents (placeholder or quoted) in the string, but
+	 * that is sufficient for our rev-parse rules.
+	 */
+	if (!skip_prefix(rule, "%.*s", &rule))
+		return NULL;
+
+	/*
+	 * And now check that our suffix (if any) matches.
+	 */
+	if (!strip_suffix(refname, rule, len))
+		return NULL;
+
+	return refname; /* len set by strip_suffix() */
+}
+
 /*
  * Is it possible that the caller meant full_name with abbrev_name?
  * If so return a non-zero value to signal "yes"; the magnitude of
@@ -662,12 +700,18 @@ static const char *ref_rev_parse_rules[] = {
 int refname_match(const char *abbrev_name, const char *full_name)
 {
 	const char **p;
-	const int abbrev_name_len = strlen(abbrev_name);
+	const size_t abbrev_name_len = strlen(abbrev_name);
 	const int num_rules = NUM_REV_PARSE_RULES;
 
-	for (p = ref_rev_parse_rules; *p; p++)
-		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name)))
+	for (p = ref_rev_parse_rules; *p; p++) {
+		size_t short_name_len;
+		const char *short_name = match_parse_rule(full_name, *p,
+							  &short_name_len);
+
+		if (short_name && short_name_len == abbrev_name_len &&
+		    !memcmp(short_name, abbrev_name, abbrev_name_len))
 			return &ref_rev_parse_rules[num_rules] - p;
+	}
 
 	return 0;
 }
@@ -1615,44 +1659,6 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	return 0;
 }
 
-/*
- * Check that the string refname matches a rule of the form
- * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
- * "foo/%.*s/baz", and return the string "bar".
- */
-static const char *match_parse_rule(const char *refname, const char *rule,
-				    size_t *len)
-{
-	/*
-	 * Check that rule matches refname up to the first percent in the rule.
-	 * We can bail immediately if not, but otherwise we leave "rule" at the
-	 * %-placeholder, and "refname" at the start of the potential matched
-	 * name.
-	 */
-	while (*rule != '%') {
-		if (!*rule)
-			BUG("rev-parse rule did not have percent");
-		if (*refname++ != *rule++)
-			return NULL;
-	}
-
-	/*
-	 * Check that our "%" is the expected placeholder. This assumes there
-	 * are no other percents (placeholder or quoted) in the string, but
-	 * that is sufficient for our rev-parse rules.
-	 */
-	if (!skip_prefix(rule, "%.*s", &rule))
-		return NULL;
-
-	/*
-	 * And now check that our suffix (if any) matches.
-	 */
-	if (!strip_suffix(refname, rule, len))
-		return NULL;
-
-	return refname; /* len set by strip_suffix() */
-}
-
 char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 				   const char *refname, int strict)
 {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0303784b1f..941213f36a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1074,7 +1074,7 @@ test_expect_success 'LHS of refspec follows ref disambiguation rules' '
 	)
 '
 
-test_expect_failure 'fetch with "./"-prefixed branch.<name>.merge does not mark any ref for merge' '
+test_expect_success 'fetch with "./"-prefixed branch.<name>.merge does not mark any ref for merge' '
 	mkdir dotslash-merge-default-refspec &&
 	(
 		cd dotslash-merge-default-refspec &&
@@ -1096,7 +1096,7 @@ test_expect_failure 'fetch with "./"-prefixed branch.<name>.merge does not mark
 	)
 '
 
-test_expect_failure 'fetch protocol v0 with "./"-prefixed branch.<name>.merge does not match any remote ref' '
+test_expect_success 'fetch protocol v0 with "./"-prefixed branch.<name>.merge does not match any remote ref' '
 	mkdir dotslash-merge-fetch-protocol-v0 &&
 	(
 		cd dotslash-merge-fetch-protocol-v0 &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index aaeb251e2f..81ad6cd52f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -433,7 +433,7 @@ test_expect_success 'push with onelevel ref' '
 	test_must_fail git push testrepo HEAD:refs/onelevel
 '
 
-test_expect_failure 'push with "./"-prefixed src does not match any ref' '
+test_expect_success 'push with "./"-prefixed src does not match any ref' '
 	mk_test testrepo heads/main &&
 	test_must_fail git push testrepo ./refs/heads/main:refs/heads/frotz 2>err &&
 	test_grep "src refspec ./refs/heads/main does not match any" err
-- 
2.55.0

