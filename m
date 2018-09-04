Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8437B1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeIEEEI (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 00:04:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:39264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725726AbeIEEEI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 00:04:08 -0400
Received: (qmail 4108 invoked by uid 109); 4 Sep 2018 23:36:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Sep 2018 23:36:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11727 invoked by uid 111); 4 Sep 2018 23:36:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Sep 2018 19:36:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Sep 2018 19:36:43 -0400
Date:   Tue, 4 Sep 2018 19:36:43 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH] reopen_tempfile(): truncate opened file
Message-ID: <20180904233643.GA9156@sigill.intra.peff.net>
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
 <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net>
 <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net>
 <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
 <20180904163807.GA23572@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180904163807.GA23572@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 04, 2018 at 12:38:07PM -0400, Jeff King wrote:

> > And just to be clear I'm looking forward to a patch from Jeff to fix
> > this since he clearly put more thoughts on this than me. With commit.c
> > being the only user of reopen_lock_file() I guess it's even ok to just
> > stick O_TRUNC in there and worry about O_APPEND when a new caller
> > needs that.
> 
> That's the way I'm leaning to. The fix is obviously a one-liner, but I
> was hoping to construct a minimal test case. I just haven't gotten
> around to it yet.

It turned out not to be too bad to write a test. It feels a little like
black magic, since I empirically determined a way in which the
cache-tree happens to shrink with the current code. But that assumption
is tested with a sanity check, so we'll at least know if it becomes a
noop.

> The bug is ancient, so I don't think it's important for v2.19.

The patch below should work on master or maint. We could do a fix
directly on top of the bug, but merging-up is weird (because the buggy
code became part of a reusable module).

-- >8 --
Subject: [PATCH] reopen_tempfile(): truncate opened file

We provide a reopen_tempfile() function, which is in turn
used by reopen_lockfile().  The idea is that a caller may
want to rewrite the tempfile without letting go of the lock.
And that's what our one caller does: after running
add--interactive, "commit -p" will update the cache-tree
extension of the index and write out the result, all while
holding the lock.

However, because we open the file with only the O_WRONLY
flag, the existing index content is left in place, and we
overwrite it starting at position 0. If the new index after
updating the cache-tree is smaller than the original, those
final bytes are not overwritten and remain in the file. This
results in a corrupt index, since those cruft bytes are
interpreted as part of the trailing hash (or even as an
extension, if there are enough bytes).

This bug actually pre-dates reopen_tempfile(); the original
code from 9c4d6c0297 (cache-tree: Write updated cache-tree
after commit, 2014-07-13) has the same bug, and those lines
were eventually refactored into the tempfile module. Nobody
noticed until now for two reasons:

 - the bug can only be triggered in interactive mode
   ("commit -p" or "commit -i")

 - the size of the index must shrink after updating the
   cache-tree, which implies a non-trivial deletion. Notice
   that the included test actually has to create a 2-deep
   hierarchy. A single level is not enough to actually cause
   shrinkage.

The fix is to truncate the file before writing out the
second index. We can do that at the caller by using
ftruncate(). But we shouldn't have to do that. There is no
other place in Git where we want to open a file and
overwrite bytes, making reopen_tempfile() a confusing and
error-prone interface. Let's pass O_TRUNC there, which gives
callers the same state they had after initially opening the
file or lock.

It's possible that we could later add a caller that wants
something else (e.g., to open with O_APPEND). But this is
the only caller we've had in the history of the codebase.
Let's punt on doing anything more clever until another one
comes along.

Reported-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 lockfile.h            |  4 ++--
 t/t0090-cache-tree.sh | 18 ++++++++++++++++++
 tempfile.c            |  2 +-
 tempfile.h            |  4 ++--
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/lockfile.h b/lockfile.h
index f401c979f0..35403ccc0d 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -263,8 +263,8 @@ static inline int close_lock_file_gently(struct lock_file *lk)
  *   nobody else) to inspect the contents you wrote, while still
  *   holding the lock yourself.
  *
- * * `reopen_lock_file()` to reopen the lockfile. Make further updates
- *   to the contents.
+ * * `reopen_lock_file()` to reopen the lockfile, truncating the existing
+ *   contents. Write out the new contents.
  *
  * * `commit_lock_file()` to make the final version permanent.
  */
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 7de40141ca..94fcb4a78e 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -161,6 +161,24 @@ test_expect_success PERL 'commit --interactive gives cache-tree on partial commi
 	test_cache_tree
 '
 
+test_expect_success PERL 'commit -p with shrinking cache-tree' '
+	mkdir -p deep/subdir &&
+	echo content >deep/subdir/file &&
+	git add deep &&
+	git commit -m add &&
+	git rm -r deep &&
+
+	before=$(wc -c <.git/index) &&
+	git commit -m delete -p &&
+	after=$(wc -c <.git/index) &&
+
+	# double check that the index shrank
+	test $before -gt $after &&
+
+	# and that our index was not corrupted
+	git fsck
+'
+
 test_expect_success 'commit in child dir has cache-tree' '
 	mkdir dir &&
 	>dir/child.t &&
diff --git a/tempfile.c b/tempfile.c
index 139ecd97f8..d43ad8c191 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -279,7 +279,7 @@ int reopen_tempfile(struct tempfile *tempfile)
 		BUG("reopen_tempfile called for an inactive object");
 	if (0 <= tempfile->fd)
 		BUG("reopen_tempfile called for an open object");
-	tempfile->fd = open(tempfile->filename.buf, O_WRONLY);
+	tempfile->fd = open(tempfile->filename.buf, O_WRONLY|O_TRUNC);
 	return tempfile->fd;
 }
 
diff --git a/tempfile.h b/tempfile.h
index 36434eb6fa..61d8dc4d1b 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -236,8 +236,8 @@ extern int close_tempfile_gently(struct tempfile *tempfile);
  *   it (and nobody else) to inspect or even modify the file's
  *   contents.
  *
- * * `reopen_tempfile()` to reopen the temporary file. Make further
- *   updates to the contents.
+ * * `reopen_tempfile()` to reopen the temporary file, truncating the existing
+ *   contents. Write out the new contents.
  *
  * * `rename_tempfile()` to move the file to its permanent location.
  */
-- 
2.19.0.rc1.605.g83416793fa

