Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B3B207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbcJFTlM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:41:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:53614 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbcJFTlK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:41:10 -0400
Received: (qmail 32071 invoked by uid 109); 6 Oct 2016 19:41:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 19:41:10 +0000
Received: (qmail 31174 invoked by uid 111); 6 Oct 2016 19:41:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 15:41:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 15:41:08 -0400
Date:   Thu, 6 Oct 2016 15:41:08 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/2] files_read_raw_ref: avoid infinite loop on broken
 symlinks
Message-ID: <20161006194108.qy7qpg6qpodpeacx@sigill.intra.peff.net>
References: <20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net>
 <20161006164825.otms5ovz2vzanimw@sigill.intra.peff.net>
 <1c39b371-eb41-05d9-3c48-bd41764c9c9a@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c39b371-eb41-05d9-3c48-bd41764c9c9a@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 09:31:22PM +0200, Johannes Sixt wrote:

> Am 06.10.2016 um 18:48 schrieb Jeff King:
> > +test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
> > +	ln -s does-not-exist .git/broken &&
> > +	test_must_fail git rev-parse --verify broken
> 
> Hm, lower-case named refs directly in .git are frowned upon, no? If we ever
> decide to forbid them outright, this ref-parse might still fail, but for the
> wrong reason. Should you not better pick an example below ref/?

I suppose so. The test case was adapted from a real-world example, but
it fails equally well with .git/refs/heads/broken. The only restriction
is that the symlink _destination_ cannot look like "refs/heads/...".

Here's a replacement 1/2. The second patch remains unchanged.

-- >8 --
Subject: files_read_raw_ref: avoid infinite loop on broken symlinks

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
index ab27d0d..492edff 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -139,4 +139,9 @@ test_expect_success 'master@{n} for various n' '
 	test_must_fail git rev-parse --verify master@{$Np1}
 '
 
+test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
+	ln -s does-not-exist .git/refs/heads/broken &&
+	test_must_fail git rev-parse --verify broken
+'
+
 test_done
-- 
2.10.1.506.g904834d

