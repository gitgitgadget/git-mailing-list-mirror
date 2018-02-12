Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B14C1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 17:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeBLRXJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 12:23:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:49302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751271AbeBLRXI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 12:23:08 -0500
Received: (qmail 25231 invoked by uid 109); 12 Feb 2018 17:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Feb 2018 17:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9993 invoked by uid 111); 12 Feb 2018 17:23:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Feb 2018 12:23:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Feb 2018 12:23:06 -0500
Date:   Mon, 12 Feb 2018 12:23:06 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] describe: confirm that blobs actually exist
Message-ID: <20180212172306.GA4918@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to 644eb60bd0 (builtin/describe.c: describe a blob,
2017-11-15), we noticed and complained about missing
objects, since they were not valid commits:

  $ git describe 0000000000000000000000000000000000000000
  fatal: 0000000000000000000000000000000000000000 is not a valid 'commit' object

After that commit, we feed any non-commit to lookup_blob(),
and complain only if it returns NULL. But the lookup_*
functions do not actually look at the on-disk object
database at all. They return an entry from the in-memory
object hash if present (and if it matches the requested
type), and otherwise auto-create a "struct object" of the
requested type.

A missing object would hit that latter case: we create a
bogus blob struct, walk all of history looking for it, and
then exit successfully having produced no output.

One reason nobody may have noticed this is that some related
cases do still work OK:

  1. If we ask for a tree by sha1, then the call to
     lookup_commit_referecne_gently() would have parsed it,
     and we would have its true type in the in-memory object
     hash.

  2. If we ask for a name that doesn't exist but isn't a
     40-hex sha1, then get_oid() would complain before we
     even look at the objects at all.

We can fix this by replacing the lookup_blob() call with a
check of the true type via sha1_object_info(). This is not
quite as efficient as we could possibly make this check. We
know in most cases that the object was already parsed in the
earlier commit lookup, so we could call lookup_object(),
which does auto-create, and check the resulting struct's
type (or NULL).  However it's not worth the fragility nor
code complexity to save a single object lookup.

The new tests cover this case, as well as that of a
tree-by-sha1 (which does work as described above, but was
not explicitly tested).

Noticed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c  | 2 +-
 t/t6120-describe.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 6fe1c51281..18c68ec7a4 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -502,7 +502,7 @@ static void describe(const char *arg, int last_one)
 
 	if (cmit)
 		describe_commit(&oid, &sb);
-	else if (lookup_blob(&oid))
+	else if (sha1_object_info(oid.hash, NULL) == OBJ_BLOB)
 		describe_blob(oid, &sb);
 	else
 		die(_("%s is neither a commit nor blob"), arg);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index a5d9015024..bae78c4e89 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -378,4 +378,12 @@ check_describe tags/A --all A
 check_describe tags/c --all c
 check_describe heads/branch_A --all --match='branch_*' branch_A
 
+test_expect_success 'describe complains about tree object' '
+	test_must_fail git describe HEAD^{tree}
+'
+
+test_expect_success 'describe complains about missing object' '
+	test_must_fail git describe $_z40
+'
+
 test_done
-- 
2.16.1.464.gc4bae515b7
