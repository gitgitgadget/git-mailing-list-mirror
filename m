Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E2A207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbcJCUgW (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:36:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:51471 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbcJCUgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:36:21 -0400
Received: (qmail 17456 invoked by uid 109); 3 Oct 2016 20:36:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:36:21 +0000
Received: (qmail 29882 invoked by uid 111); 3 Oct 2016 20:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:36:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:36:18 -0400
Date:   Mon, 3 Oct 2016 16:36:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 16/18] count-objects: report alternates via verbose mode
Message-ID: <20161003203618.m6kxd3b6h74jbmqz@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no way to get the list of alternates that git
computes internally; our tests only infer it based on which
objects are available. In addition to testing, knowing this
list may be helpful for somebody debugging their alternates
setup.

Let's add it to the "count-objects -v" output. We could give
it a separate flag, but there's not really any need.
"count-objects -v" is already a debugging catch-all for the
object database, its output is easily extensible to new data
items, and printing the alternates is not expensive (we
already had to find them to count the objects).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-count-objects.txt |  5 +++++
 builtin/count-objects.c             | 10 ++++++++++
 t/t5613-info-alternate.sh           | 10 ++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 2ff3568..cb9b4d2 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -38,6 +38,11 @@ objects nor valid packs
 +
 size-garbage: disk space consumed by garbage files, in KiB (unless -H is
 specified)
++
+alternate: absolute path of alternate object databases; may appear
+multiple times, one line per path. Note that if the path contains
+non-printable characters, it may be surrounded by double-quotes and
+contain C-style backslashed escape sequences.
 
 -H::
 --human-readable::
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ba92919..a700409 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -8,6 +8,7 @@
 #include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "quote.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
@@ -73,6 +74,14 @@ static int count_cruft(const char *basename, const char *path, void *data)
 	return 0;
 }
 
+static int print_alternate(struct alternate_object_database *alt, void *data)
+{
+	printf("alternate: ");
+	quote_c_style(alt->path, NULL, stdout, 0);
+	putchar('\n');
+	return 0;
+}
+
 static char const * const count_objects_usage[] = {
 	N_("git count-objects [-v] [-H | --human-readable]"),
 	NULL
@@ -140,6 +149,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 		printf("size-garbage: %s\n", garbage_buf.buf);
+		foreach_alt_odb(print_alternate, NULL);
 		strbuf_release(&loose_buf);
 		strbuf_release(&pack_buf);
 		strbuf_release(&garbage_buf);
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index b393613..74f6770 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -39,6 +39,16 @@ test_expect_success 'preparing third repository' '
 	)
 '
 
+test_expect_success 'count-objects shows the alternates' '
+	cat >expect <<-EOF &&
+	alternate: $(pwd)/B/.git/objects
+	alternate: $(pwd)/A/.git/objects
+	EOF
+	git -C C count-objects -v >actual &&
+	grep ^alternate: actual >actual.alternates &&
+	test_cmp expect actual.alternates
+'
+
 # Note: These tests depend on the hard-coded value of 5 as "too deep". We start
 # the depth at 0 and count links, not repositories, so in a chain like:
 #
-- 
2.10.0.618.g82cc264

