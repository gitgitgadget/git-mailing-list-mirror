Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47947209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 11:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030407AbcIZL7o (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 07:59:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:48015 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934585AbcIZL7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 07:59:43 -0400
Received: (qmail 18598 invoked by uid 109); 26 Sep 2016 11:59:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 11:59:43 +0000
Received: (qmail 4335 invoked by uid 111); 26 Sep 2016 11:59:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 07:59:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 07:59:41 -0400
Date:   Mon, 26 Sep 2016 07:59:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 03/10] get_sha1: propagate flags to child functions
Message-ID: <20160926115940.yyedwgz4duxerm4i@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_sha1() function is actually implementation by many
sub-functions, but we do not always pass our flags around to
all of those functions. As a result, we may forget that our
caller asked us to resolve with GET_SHA1_QUIETLY and output
messages. The two triggerable cases are:

  1. Resolving treeish:path will resolve the "treeish"
     portion using GET_SHA1_TREEISH, dropping all other
     flags.

  2. The peel_onion() function did not take flags at all
     but recurses to get_sha1_1(), which does.

The solution for both is to bitwise-OR their new flags with
the existing ones (after dropping any mutually exclusive
disambiguation flags).

This bug can trigger with "git rev-parse --quiet", which
asks for quiet resolution. But it can also happen in a more
vanilla code path when we do a follow-up ONLY_TO_DIE
invocation of get_sha1(), and that's what the tests check.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c                         | 18 ++++++++++++------
 t/t1512-rev-parse-disambiguation.sh | 14 +++++++++++++-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index fe05ba0..38e51d9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -686,12 +686,12 @@ struct object *peel_to_type(const char *name, int namelen,
 	}
 }
 
-static int peel_onion(const char *name, int len, unsigned char *sha1)
+static int peel_onion(const char *name, int len, unsigned char *sha1,
+		      unsigned lookup_flags)
 {
 	unsigned char outer[20];
 	const char *sp;
 	unsigned int expected_type = 0;
-	unsigned lookup_flags = 0;
 	struct object *o;
 
 	/*
@@ -731,10 +731,11 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	else
 		return -1;
 
+	lookup_flags &= ~GET_SHA1_DISAMBIGUATORS;
 	if (expected_type == OBJ_COMMIT)
-		lookup_flags = GET_SHA1_COMMITTISH;
+		lookup_flags |= GET_SHA1_COMMITTISH;
 	else if (expected_type == OBJ_TREE)
-		lookup_flags = GET_SHA1_TREEISH;
+		lookup_flags |= GET_SHA1_TREEISH;
 
 	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
 		return -1;
@@ -835,7 +836,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 		return get_nth_ancestor(name, len1, sha1, num);
 	}
 
-	ret = peel_onion(name, len, sha1);
+	ret = peel_onion(name, len, sha1, lookup_flags);
 	if (!ret)
 		return 0;
 
@@ -1470,7 +1471,12 @@ static int get_sha1_with_context_1(const char *name,
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
 		int len = cp - name;
-		if (!get_sha1_1(name, len, tree_sha1, GET_SHA1_TREEISH)) {
+		unsigned sub_flags = flags;
+
+		sub_flags &= ~GET_SHA1_DISAMBIGUATORS;
+		sub_flags |= GET_SHA1_TREEISH;
+
+		if (!get_sha1_1(name, len, tree_sha1, sub_flags)) {
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 16f9709..30e0b80 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -291,10 +291,22 @@ test_expect_success 'ambiguous short sha1 ref' '
 	grep "refname.*${REF}.*ambiguous" err
 '
 
-test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated' '
+test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated (raw)' '
 	test_must_fail git rev-parse 00000 2>stderr &&
 	grep "is ambiguous" stderr >errors &&
 	test_line_count = 1 errors
 '
 
+test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated (treeish)' '
+	test_must_fail git rev-parse 00000:foo 2>stderr &&
+	grep "is ambiguous" stderr >errors &&
+	test_line_count = 1 errors
+'
+
+test_expect_success C_LOCALE_OUTPUT 'ambiguity errors are not repeated (peel)' '
+	test_must_fail git rev-parse 00000^{commit} 2>stderr &&
+	grep "is ambiguous" stderr >errors &&
+	test_line_count = 1 errors
+'
+
 test_done
-- 
2.10.0.492.g14f803f

