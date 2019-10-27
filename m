Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE401F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 04:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfJ0EVR (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 00:21:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:59518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725440AbfJ0EVR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 00:21:17 -0400
Received: (qmail 3699 invoked by uid 109); 27 Oct 2019 04:21:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Oct 2019 04:21:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23314 invoked by uid 111); 27 Oct 2019 04:24:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Oct 2019 00:24:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Oct 2019 00:21:16 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org
Subject: [BUG] commit-graph path normalization reads uninitialized bytes
Message-ID: <20191027042116.GA5801@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed an interesting bug related to 16110c9348 (commit-graph:
normalize commit-graph filenames, 2019-06-18). It calls
normalize_path_copy() on the object directory without checking the
result. That function can fail when the path can't be normalized (e.g.,
a relative path that goes above the cwd, like "../foo"). That leaves
nonsense in the destination buffer, which we then call open() on.

Try this from a git.git build:

  (cd t && GIT_DIR=../.git valgrind ./git rev-parse HEAD^)

which yields:

  ==5907== Syscall param openat(filename) points to uninitialised byte(s)
  ==5907==    at 0x4914A35: open (open64.c:48)
  ==5907==    by 0x31C58B: git_open_cloexec (sha1-file.c:1021)
  ==5907==    by 0x217BF1: open_commit_graph (commit-graph.c:107)
  ==5907==    by 0x2182BF: load_commit_graph_one (commit-graph.c:314)
  ...etc...

This is even triggered in the test suite, but we don't notice because
the exit code from that invocation is thrown away. Doing this:

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index df34c994d2..eebb49ecc5 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -222,7 +222,9 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
 	(cd super &&
 	 git submodule update --remote --force submodule &&
 	 cd submodule &&
-	 test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline)"
+	 git log -1 --oneline >expect &&
+	 GIT_DIR=../../submodule/.git git log -1 --oneline >actual &&
+	 test_cmp expect actual
 	)
 '
 

and then running t7406 with --valgrind-only=10 yields a similar error
(and a test failure). Interestingly, neither ASan nor MSan seem to catch
it. But even more interesting is that it generally does something
sensible! If I "strace -e openat" that test, I get:

  openat(AT_FDCWD, "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZB\245\245\245\245\245\245\245\10\261\v", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "../../submodule/.git/objects/info/commit-graphs/commit-graph-chain", O_RDONLY) = -1 ENOENT (No such file or directory)

Whoops. That's obviously nonsense, but the kernel tells us only ENOENT
(I suppose if there was no NUL in the uninitialized bytes, it'd perhaps
run off the buffer and return EFAULT). But either way, we decide there
is no commit-graph file and fall back to operating without it. So we
produce the correct output either way. But obviously using uninitialized
bytes is bad, and of course it could end up opening some random file
(less likely than you might think, if we reuse a heap buffer).

We could "fix" it like this (there are a few other sites, too, so this
is just illustrating the idea):

diff --git a/commit-graph.c b/commit-graph.c
index fc4a43b8d6..422092d3a9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,7 +45,10 @@ char *get_commit_graph_filename(const char *obj_dir)
 {
 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
 	char *normalized = xmalloc(strlen(filename) + 1);
-	normalize_path_copy(normalized, filename);
+	if (normalize_path_copy(normalized, filename) < 0) {
+		free(normalized);
+		return filename;
+	}
 	free(filename);
 	return normalized;
 }

But it really makes me wonder what we're trying to get out of the
normalization. If you want to compare two paths reliably, then you
really need to create an absolute path and normalize that. And then
you'd probably want to handle symlinks, too, so you'd end using
real_path().

So it's not clear to me if this is a kind of "best effort"
normalization, and the patch above is the right approach. Or if we need
to be doing it more carefully.

-Peff
