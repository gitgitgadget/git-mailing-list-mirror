Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B02207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 16:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbcJFQtB (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 12:49:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:53483 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751645AbcJFQs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 12:48:58 -0400
Received: (qmail 22398 invoked by uid 109); 6 Oct 2016 16:48:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 16:48:27 +0000
Received: (qmail 29529 invoked by uid 111); 6 Oct 2016 16:48:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 12:48:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 12:48:25 -0400
Date:   Thu, 6 Oct 2016 12:48:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] files_read_raw_ref: avoid infinite loop on broken
 symlinks
Message-ID: <20161006164825.otms5ovz2vzanimw@sigill.intra.peff.net>
References: <20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our ref resolution first runs lstat() on any path we try to
look up, because we want to treat symlinks specially (by
resolving them manually and considering them symrefs). But
if the results of `readlink` do _not_ look like a ref, we
fall through to treating it like a normal file, and just
read the contents of the linked path.

Since fcb7c76 (resolve_ref_unsafe(): close race condition
reading loose refs, 2013-06-19), that "normal file" code
path will stat() the file and if we see ENOENT, will jump
back to the lstat(), thinking we've seen inconsistent
results between the two calls. But for a symbolic ref, this
isn't a race: the lstat() found the symlink, and the stat()
is looking at the path it points to. We end up in an
infinite loop calling lstat() and stat().

We can fix this by avoiding the retry-on-inconsistent jump
when we know that we found a symlink. While we're at it,
let's add a comment explaining why the symlink case gets to
this code in the first place; without that, it is not
obvious that the correct solution isn't to avoid the stat()
code path entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c        | 7 ++++++-
 t/t1503-rev-parse-verify.sh | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0709f60..d826557 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1403,6 +1403,11 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 			ret = 0;
 			goto out;
 		}
+		/*
+		 * It doesn't look like a refname; fall through to just
+		 * treating it like a non-symlink, and reading whatever it
+		 * points to.
+		 */
 	}
 
 	/* Is it a directory? */
@@ -1426,7 +1431,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	 */
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (errno == ENOENT)
+		if (errno == ENOENT && !S_ISLNK(st.st_mode))
 			/* inconsistent with lstat; retry */
 			goto stat_ref;
 		else
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index ab27d0d..69d5135 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -139,4 +139,9 @@ test_expect_success 'master@{n} for various n' '
 	test_must_fail git rev-parse --verify master@{$Np1}
 '
 
+test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
+	ln -s does-not-exist .git/broken &&
+	test_must_fail git rev-parse --verify broken
+'
+
 test_done
-- 
2.10.1.506.g904834d

