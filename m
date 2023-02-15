Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B69C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 15:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBOPQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 10:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBOPQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 10:16:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423B3B0F2
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 07:16:22 -0800 (PST)
Received: (qmail 11698 invoked by uid 109); 15 Feb 2023 15:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Feb 2023 15:16:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14352 invoked by uid 111); 15 Feb 2023 15:16:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 10:16:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 10:16:21 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH v2 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To shorten a fully qualified ref (e.g., taking "refs/heads/foo" to just
"foo"), we munge the usual lookup rules ("refs/heads/%.*s", etc) to drop
the ".*" modifier (so "refs/heads/%s"), and then use sscanf() to match
that against the refname, pulling the "%s" content into a separate
buffer.

This has a few downsides:

  - sscanf("%s") reportedly misbehaves on macOS with some input and
    locale combinations, returning a partial or garbled string. See
    this thread:

      https://lore.kernel.org/git/CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com/

  - scanf's matching of "%s" is greedy. So the "refs/remotes/%s/HEAD"
    rule would never pull "origin" out of "refs/remotes/origin/HEAD".
    Instead it always produced "origin/HEAD", which is redundant with
    the "refs/remotes/%s" rule.

  - scanf in general is an error-prone interface. For example, scanning
    for "%s" will copy bytes into a destination string, which must have
    been correctly sized ahead of time to avoid a buffer overflow. In
    this case, the code is OK (the buffer is pessimistically sized to
    match the original string, which should give us a maximum). But in
    general, we do not want to encourage people to use scanf at all.

So instead, let's note that our lookup rules are not arbitrary format
strings, but all contain exactly one "%.*s" placeholder. We already rely
on this, both for lookup (we feed the lookup format along with exactly
one int/ptr combo to snprintf, etc) and for shortening (we munge "%.*s"
to "%s", and then insist that sscanf() finds exactly one result).

We can parse this manually by just matching the bytes that occur before
and after the "%.*s" placeholder. While we have a few extra lines of
parsing code, the result is arguably simpler, as can skip the
preprocessing step and its tricky memory management entirely.

The in-code comments should explain the parsing strategy, but there's
one subtle change here. The original code allocated a single buffer, and
then overwrote it in each loop iteration, since that's the only option
sscanf() gives us. But our parser can actually return a ptr/len combo
for the matched string, which is all we need (since we just feed it back
to the lookup rules with "%.*s"), and then copy it only when returning
to the caller.

There are a few new tests here, all using symbolic-ref (the code can be
triggered in many ways, but symrefs are convenient in that we don't need
to create a real ref, which avoids any complications from the filesystem
munging the name):

  - the first covers the real-world case which misbehaved on macOS.
    Setting LC_ALL is required to trigger the problem there (since
    otherwise our tests use LC_ALL=C), and hopefully is at worst simply
    ignored on other systems (and doesn't cause libc to complain, etc,
    on systems without that locale).

  - the second covers the "origin/HEAD" case as discussed above, which
    is now fixed

  - the remainder are for "weird" cases that work both before and after
    this patch, but would be easy to get wrong with off-by-one problems
    in the parsing (and came out of discussions and earlier iterations
    of the patch that did get them wrong).

  - absent here are tests of boring, expected-to-work cases like
    "refs/heads/foo", etc. Those are covered all over the test suite
    both explicitly (for-each-ref's refname:short) and implicitly (in
    the output of git-status, etc).

Reported-by: 孟子易 <mengziyi540841@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                  | 78 +++++++++++++++++++++++------------------
 t/t1401-symbolic-ref.sh | 34 ++++++++++++++++++
 2 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/refs.c b/refs.c
index 84f344d8af..aeae31c972 100644
--- a/refs.c
+++ b/refs.c
@@ -1310,53 +1310,62 @@ int update_ref(const char *msg, const char *refname,
 			       old_oid, flags, onerr);
 }
 
-char *refs_shorten_unambiguous_ref(struct ref_store *refs,
-				   const char *refname, int strict)
+/*
+ * Check that the string refname matches a rule of the form
+ * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
+ * "foo/%.*s/baz", and return the string "bar".
+ */
+static const char *match_parse_rule(const char *refname, const char *rule,
+				    size_t *len)
 {
-	int i;
-	static char **scanf_fmts;
-	char *short_name;
-	struct strbuf resolved_buf = STRBUF_INIT;
-
-	if (!scanf_fmts) {
-		/*
-		 * Pre-generate scanf formats from ref_rev_parse_rules[].
-		 * Generate a format suitable for scanf from a
-		 * ref_rev_parse_rules rule by interpolating "%s" at the
-		 * location of the "%.*s".
-		 */
-		size_t total_len = 0;
-		size_t offset = 0;
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
 
-		for (i = 0; i < NUM_REV_PARSE_RULES; i++)
-			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
-			total_len += strlen(ref_rev_parse_rules[i]) - 2 + 1;
+	/*
+	 * Check that our "%" is the expected placeholder. This assumes there
+	 * are no other percents (placeholder or quoted) in the string, but
+	 * that is sufficient for our rev-parse rules.
+	 */
+	if (!skip_prefix(rule, "%.*s", &rule))
+		return NULL;
 
-		scanf_fmts = xmalloc(st_add(st_mult(sizeof(char *), NUM_REV_PARSE_RULES), total_len));
+	/*
+	 * And now check that our suffix (if any) matches.
+	 */
+	if (!strip_suffix(refname, rule, len))
+		return NULL;
 
-		offset = 0;
-		for (i = 0; i < NUM_REV_PARSE_RULES; i++) {
-			assert(offset < total_len);
-			scanf_fmts[i] = (char *)&scanf_fmts[NUM_REV_PARSE_RULES] + offset;
-			offset += xsnprintf(scanf_fmts[i], total_len - offset,
-					    ref_rev_parse_rules[i], 2, "%s") + 1;
-		}
-	}
+	return refname; /* len set by strip_suffix() */
+}
 
-	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict)
+{
+	int i;
+	struct strbuf resolved_buf = STRBUF_INIT;
 
 	/* skip first rule, it will always match */
 	for (i = NUM_REV_PARSE_RULES - 1; i > 0 ; --i) {
 		int j;
 		int rules_to_fail = i;
+		const char *short_name;
 		size_t short_name_len;
 
-		if (1 != sscanf(refname, scanf_fmts[i], short_name))
+		short_name = match_parse_rule(refname, ref_rev_parse_rules[i],
+					      &short_name_len);
+		if (!short_name)
 			continue;
 
-		short_name_len = strlen(short_name);
-
 		/*
 		 * in strict mode, all (except the matched one) rules
 		 * must fail to resolve to a valid non-ambiguous ref
@@ -1394,12 +1403,11 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 		 */
 		if (j == rules_to_fail) {
 			strbuf_release(&resolved_buf);
-			return short_name;
+			return xmemdupz(short_name, short_name_len);
 		}
 	}
 
 	strbuf_release(&resolved_buf);
-	free(short_name);
 	return xstrdup(refname);
 }
 
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index d708acdb81..be23be30c7 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -189,4 +189,38 @@ test_expect_success 'symbolic-ref pointing at another' '
 	test_cmp expect actual
 '
 
+test_expect_success 'symbolic-ref --short handles complex utf8 case' '
+	name="测试-加-增加-加-增加" &&
+	git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
+	# In the real world, we saw problems with this case only
+	# when the locale includes UTF-8. Set it here to try to make things as
+	# hard as possible for us to pass, but in practice we should do the
+	# right thing regardless (and of course some platforms may not even
+	# have this locale).
+	LC_ALL=en_US.UTF-8 git symbolic-ref --short TEST_SYMREF >actual &&
+	echo "$name" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'symbolic-ref --short handles name with suffix' '
+	git symbolic-ref TEST_SYMREF "refs/remotes/origin/HEAD" &&
+	git symbolic-ref --short TEST_SYMREF >actual &&
+	echo "origin" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'symbolic-ref --short handles almost-matching name' '
+	git symbolic-ref TEST_SYMREF "refs/headsXfoo" &&
+	git symbolic-ref --short TEST_SYMREF >actual &&
+	echo "headsXfoo" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'symbolic-ref --short handles name with percent' '
+	git symbolic-ref TEST_SYMREF "refs/heads/%foo" &&
+	git symbolic-ref --short TEST_SYMREF >actual &&
+	echo "%foo" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.2.881.gb6410a20aa
