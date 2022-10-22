Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8DC3A59D
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJVAWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJVAWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:22:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4693A2B415B
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:21:59 -0700 (PDT)
Received: (qmail 15249 invoked by uid 109); 22 Oct 2022 00:21:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:21:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18993 invoked by uid 111); 22 Oct 2022 00:21:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:21:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:21:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] repack: drop remove_temporary_files()
Message-ID: <Y1M3pjuA2po83LU7@coredump.intra.peff.net>
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we've successfully finished the repack, we call
remove_temporary_files(), which looks for and removes any files matching
".tmp-$$-pack-*", where $$ is the pid of the current process. But this
is pointless. If we make it this far in the process, we've already
renamed these tempfiles into place, and there is nothing left to delete.

Nor is there a point in trying to call it to clean up when we _aren't_
successful. It's not safe for using in a signal handler, and the
previous commit already handed that job over to the tempfile API.

It might seem like it would be useful to clean up stray .tmp files left
by other invocations of git-repack. But it won't clean those files; it
only matches ones with its pid, and leaves the rest. Fortunately, those
are cleaned up naturally by successive calls to git-repack; we'll
consider .tmp-*.pack the same as normal packfiles, so "repack -ad", etc,
will roll up their contents and eventually delete them.

The one case that could matter is if pack-objects generates an extension
we don't know about, like ".tmp-pack-$$-$hash.some-new-ext". The current
code will quietly delete such a file, while after this patch we'd leave
it in place. In practice this doesn't happen, and would be indicative of
a bug. Leaving the file as cruft is arguably a better behavior, as it
means somebody is more likely to eventually notice and fix the bug.  If
we really wanted to be paranoid, we could scan for and warn about such
files, but that seems like overkill.

There's nothing to test with regard to the removal of this function. It
was doing nothing, so the behavior should be the same.  However, we can
verify (and protect) our assumption that "repack -ad" will eventually
remove stray files by adding a test for that.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c  | 32 --------------------------------
 t/t7700-repack.sh |  8 ++++++++
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 39f03c3a1d..cd338b161f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -91,37 +91,6 @@ static int repack_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-/*
- * Remove temporary $GIT_OBJECT_DIRECTORY/pack/.tmp-$$-pack-* files.
- */
-static void remove_temporary_files(void)
-{
-	struct strbuf buf = STRBUF_INIT;
-	size_t dirlen, prefixlen;
-	DIR *dir;
-	struct dirent *e;
-
-	dir = opendir(packdir);
-	if (!dir)
-		return;
-
-	/* Point at the slash at the end of ".../objects/pack/" */
-	dirlen = strlen(packdir) + 1;
-	strbuf_addstr(&buf, packtmp);
-	/* Hold the length of  ".tmp-%d-pack-" */
-	prefixlen = buf.len - dirlen;
-
-	while ((e = readdir(dir))) {
-		if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
-			continue;
-		strbuf_setlen(&buf, dirlen);
-		strbuf_addstr(&buf, e->d_name);
-		unlink(buf.buf);
-	}
-	closedir(dir);
-	strbuf_release(&buf);
-}
-
 /*
  * Adds all packs hex strings to either fname_nonkept_list or
  * fname_kept_list based on whether each pack has a corresponding
@@ -1106,7 +1075,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (run_update_server_info)
 		update_server_info(0);
-	remove_temporary_files();
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
 		unsigned flags = 0;
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 592016f64a..edcda849b9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -440,6 +440,14 @@ test_expect_success 'clean up .tmp-* packs on error' '
 	test_must_be_empty tmpfiles
 '
 
+test_expect_success 'repack -ad cleans up old .tmp-* packs' '
+	git rev-parse HEAD >input &&
+	git pack-objects $objdir/pack/.tmp-1234 <input &&
+	git repack -ad &&
+	find $objdir/pack -name '.tmp-*' >tmpfiles &&
+	test_must_be_empty tmpfiles
+'
+
 test_expect_success 'setup for update-server-info' '
 	git init update-server-info &&
 	test_commit -C update-server-info message
-- 
2.38.1.496.ga614b0e9bd
