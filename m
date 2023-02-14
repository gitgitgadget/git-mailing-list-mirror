Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18774C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 18:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjBNSl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBNSlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 13:41:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E256E2A9BB
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 10:41:53 -0800 (PST)
Received: (qmail 682 invoked by uid 109); 14 Feb 2023 18:41:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 18:41:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3728 invoked by uid 111); 14 Feb 2023 18:41:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 13:41:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 13:41:52 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To shorten a fully qualified ref (e.g., taking "refs/heads/foo" to just
"foo"), we munge the usual lookup rules ("refs/heads/%.*s", etc) to drop
the ".*" modifier (so "refs/heads/%s"), and then use sscanf() to match
that against the refname, pulling the "%s" content into a separate
buffer.

This has two downsides:

  - sscanf("%s") reportedly misbehaves on macOS with some input and
    locale combinations, returning a partial or garbled string. See
    this thread:

      https://lore.kernel.org/git/CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com/

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

Reported-by: 孟子易 <mengziyi540841@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
BTW, this diff is generated with --patience, which generates a _much_
nicer output in this case. Not important to this series, but since there
was discussion of switching the default in a nearby thread, it seemed
like an interesting example.

 refs.c | 77 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/refs.c b/refs.c
index 84f344d8af..d8ce7e9ee1 100644
--- a/refs.c
+++ b/refs.c
@@ -1310,53 +1310,61 @@ int update_ref(const char *msg, const char *refname,
 			       old_oid, flags, onerr);
 }
 
+/*
+ * Check that the string refname matches a rule of the form
+ * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
+ * "foo/%.*s/baz", and return the string "bar".
+ */
+static const char *match_parse_rule(const char *refname, const char *rule,
+				    size_t *len)
+{
+	/*
+	 * Check that rule matches refname up to the first percent
+	 * in the rule. This is basically skip_prefix(), but
+	 * ending at percent in the prefix, rather than end-of-string.
+	 */
+	do {
+		if (!*rule)
+			BUG("rev-parse rule did not have percent");
+		if (*rule == '%')
+			break;
+	} while (*refname++ == *rule++);
+
+	/*
+	 * Check that we matched all the way to the "%" placeholder,
+	 * and skip past it within the rule string. If so, "refname" at
+	 * this point is the beginning of a potential match.
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
 char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 				   const char *refname, int strict)
 {
 	int i;
-	static char **scanf_fmts;
-	char *short_name;
 	struct strbuf resolved_buf = STRBUF_INIT;
 
-	if (!scanf_fmts) {
-		/*
-		 * Pre-generate scanf formats from ref_rev_parse_rules[].
-		 * Generate a format suitable for scanf from a
-		 * ref_rev_parse_rules rule by interpolating "%s" at the
-		 * location of the "%.*s".
-		 */
-		size_t total_len = 0;
-		size_t offset = 0;
-
-		for (i = 0; i < NUM_REV_PARSE_RULES; i++)
-			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
-			total_len += strlen(ref_rev_parse_rules[i]) - 2 + 1;
-
-		scanf_fmts = xmalloc(st_add(st_mult(sizeof(char *), NUM_REV_PARSE_RULES), total_len));
-
-		offset = 0;
-		for (i = 0; i < NUM_REV_PARSE_RULES; i++) {
-			assert(offset < total_len);
-			scanf_fmts[i] = (char *)&scanf_fmts[NUM_REV_PARSE_RULES] + offset;
-			offset += xsnprintf(scanf_fmts[i], total_len - offset,
-					    ref_rev_parse_rules[i], 2, "%s") + 1;
-		}
-	}
-
-	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
-
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
@@ -1394,12 +1402,11 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
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
 
-- 
2.39.1.849.g86e176252e
