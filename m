Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA41207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbcJCUga (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:36:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:51478 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752520AbcJCUg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:36:28 -0400
Received: (qmail 17476 invoked by uid 109); 3 Oct 2016 20:36:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:36:28 +0000
Received: (qmail 29916 invoked by uid 111); 3 Oct 2016 20:36:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:36:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:36:26 -0400
Date:   Mon, 3 Oct 2016 16:36:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 18/18] alternates: use fspathcmp to detect duplicates
Message-ID: <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a case-insensitive filesystem, we should realize that
"a/objects" and "A/objects" are the same path. We already
use fspathcmp() to check against the main object directory,
but until recently we couldn't use it for comparing against
other alternates (because their paths were not
NUL-terminated strings). But now we can, so let's do so.

Note that we also need to adjust count-objects to load the
config, so that it can see the setting of core.ignorecase
(this is required by the test, but is also a general bugfix
for users of count-objects).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/count-objects.c   |  2 ++
 sha1_file.c               |  2 +-
 t/t5613-info-alternate.sh | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a700409..a04b4f2 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -97,6 +97,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	git_config(git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, opts, count_objects_usage, 0);
 	/* we do not take arguments other than flags for now */
 	if (argc)
diff --git a/sha1_file.c b/sha1_file.c
index b514167..b05ec9c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -260,7 +260,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * thing twice, or object directory itself.
 	 */
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		if (!strcmp(path->buf, alt->path))
+		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
 	if (!fspathcmp(path->buf, normalized_objdir))
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 76525a0..926fe14 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -116,4 +116,21 @@ test_expect_success 'relative duplicates are eliminated' '
 	test_cmp expect actual.alternates
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'dup finding can be case-insensitive' '
+	git init --bare insensitive.git &&
+	# the previous entry for "A" will have used uppercase
+	cat >insensitive.git/objects/info/alternates <<-\EOF &&
+	../../C/.git/objects
+	../../a/.git/objects
+	EOF
+	cat >expect <<-EOF &&
+	alternate: $(pwd)/C/.git/objects
+	alternate: $(pwd)/B/.git/objects
+	alternate: $(pwd)/A/.git/objects
+	EOF
+	git -C insensitive.git count-objects -v >actual &&
+	grep ^alternate: actual >actual.alternates &&
+	test_cmp expect actual.alternates
+'
+
 test_done
-- 
2.10.0.618.g82cc264
