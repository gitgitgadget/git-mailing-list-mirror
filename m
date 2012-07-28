From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] do not write null sha1s to on-disk index
Date: Sat, 28 Jul 2012 11:05:24 -0400
Message-ID: <20120728150524.GB25269@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 17:05:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv8aD-0002YZ-S9
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 17:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab2G1PF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 11:05:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40022 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2G1PF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 11:05:28 -0400
Received: (qmail 31338 invoked by uid 107); 28 Jul 2012 15:05:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Jul 2012 11:05:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2012 11:05:24 -0400
Content-Disposition: inline
In-Reply-To: <20120728150132.GA25042@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202442>

We should never need to write the null sha1 into an index
entry (short of the 1 in 2^160 chance that somebody actually
has content that hashes to it). If we attempt to do so, it
is much more likely that it is a bug, since we use the null
sha1 as a sentinel value to mean "not valid".

The presence of null sha1s in the index (which can come
from, among other things, "update-index --cacheinfo", or by
reading a corrupted tree) can cause problems for later
readers, because they cannot distinguish the literal null
sha1 from its use a sentinel value.  For example, "git
diff-files" on such an entry would make it appear as if it
is stat-dirty, and until recently, the diff code assumed
such an entry meant that we should be diffing a working tree
file rather than a blob.

Ideally, we would stop such entries from entering even our
in-core index. However, we do sometimes legitimately add
entries with null sha1s in order to represent these sentinel
situations; simply forbidding them in add_index_entry breaks
a lot of the existing code. However, we can at least make
sure that our in-core sentinel representation never makes it
to disk.

To be thorough, we will test an attempt to add both a blob
and a submodule entry. In the former case, we might run into
problems anyway because we will be missing the blob object.
But in the latter case, we do not enforce connectivity
across gitlink entries, making this our only point of
enforcement. The current implementation does not care which
type of entry we are seeing, but testing both cases helps
future-proof the test suite in case that changes.

Signed-off-by: Jeff King <peff@peff.net>
---
I confess to not being clear on all of the instances in which a null
sha1 might enter the in-core index. I did try modifying add_index_entry,
but the breakage was pretty severe. I traced through a few instances,
and it seemed to be mostly related to unmerged entries.

 read-cache.c                  |  2 ++
 t/t2107-update-index-basic.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 2f8159f..d2be78e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1800,6 +1800,8 @@ int write_index(struct index_state *istate, int newfd)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
+		if (is_null_sha1(ce->sha1))
+			return error("cache entry has null sha1: %s", ce->name);
 		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
 			return -1;
 	}
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 809fafe..0dbbb00 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -29,4 +29,23 @@ test_expect_success 'update-index -h with corrupt index' '
 	grep "[Uu]sage: git update-index" broken/usage
 '
 
+test_expect_success '--cacheinfo does not accept blob null sha1' '
+	echo content >file &&
+	git add file &&
+	git rev-parse :file >expect &&
+	test_must_fail git update-index --cacheinfo 100644 $_z40 file &&
+	git rev-parse :file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--cacheinfo does not accept gitlink null sha1' '
+	git init submodule &&
+	(cd submodule && test_commit foo) &&
+	git add submodule &&
+	git rev-parse :submodule >expect &&
+	test_must_fail git update-index --cacheinfo 160000 $_z40 submodule &&
+	git rev-parse :submodule >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.11.3.42.g90758bf
