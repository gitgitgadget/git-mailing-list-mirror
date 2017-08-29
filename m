Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A1A1F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 18:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbdH2S6x (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 14:58:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:52230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751186AbdH2S6w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 14:58:52 -0400
Received: (qmail 1740 invoked by uid 109); 29 Aug 2017 18:58:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 18:58:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13265 invoked by uid 111); 29 Aug 2017 18:59:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 14:59:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 14:58:50 -0400
Date:   Tue, 29 Aug 2017 14:58:50 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: [PATCH] config: use a static lock_file struct
Message-ID: <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 02:53:41PM -0400, Jeff King wrote:

> It looks like the config code has a minor-ish leak. Patch to follow.

Here it is.

-- >8 --
Subject: [PATCH] config: use a static lock_file struct

When modifying git config, we xcalloc() a struct lock_file
but never free it. This is necessary because the tempfile
code (upon which the locking code is built) requires that
the resulting struct remain valid through the life of the
program. However, it also confuses leak-checkers like
valgrind because only the inner "struct tempfile" is still
reachable; no pointer to the outer lock_file is kept.

Other code paths solve this by using a single static lock
struct. We can do the same here, because we know that we'll
only lock and modify one config file at a time (and
assertions within the lockfile code will ensure that this
remains the case).

That removes a real leak (when we fail to free the struct
after locking fails) as well as removes the valgrind false
positive. It also means that doing N sequential
config-writes will use a constant amount of memory, rather
than leaving stale lock_files for each.

Note that since "lock" is no longer a pointer, it can't be
NULL anymore. But that's OK. We used that feature only to
avoid calling rollback_lock_file() on an already-committed
lock. Since the lockfile code keeps its own "active" flag,
it's a noop to rollback an inactive lock, and we don't have
to worry about this ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
In the long run we may want to drop the "tempfiles must remain forever"
rule. This is certainly not the first time it has caused confusion or
leaks. And I don't think it's a fundamental issue, just the way the code
is written. But in the interim, this fix is probably worth doing.

 config.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/config.c b/config.c
index d0d8ce823a..1603f96e40 100644
--- a/config.c
+++ b/config.c
@@ -2450,7 +2450,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 {
 	int fd = -1, in_fd = -1;
 	int ret;
-	struct lock_file *lock = NULL;
+	static struct lock_file lock;
 	char *filename_buf = NULL;
 	char *contents = NULL;
 	size_t contents_sz;
@@ -2469,8 +2469,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	lock = xcalloc(1, sizeof(struct lock_file));
-	fd = hold_lock_file_for_update(lock, config_filename, 0);
+	fd = hold_lock_file_for_update(&lock, config_filename, 0);
 	if (fd < 0) {
 		error_errno("could not lock config file %s", config_filename);
 		free(store.key);
@@ -2583,8 +2582,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		close(in_fd);
 		in_fd = -1;
 
-		if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
-			error_errno("chmod on %s failed", get_lock_file_path(lock));
+		if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
+			error_errno("chmod on %s failed", get_lock_file_path(&lock));
 			ret = CONFIG_NO_WRITE;
 			goto out_free;
 		}
@@ -2639,28 +2638,19 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		contents = NULL;
 	}
 
-	if (commit_lock_file(lock) < 0) {
+	if (commit_lock_file(&lock) < 0) {
 		error_errno("could not write config file %s", config_filename);
 		ret = CONFIG_NO_WRITE;
-		lock = NULL;
 		goto out_free;
 	}
 
-	/*
-	 * lock is committed, so don't try to roll it back below.
-	 * NOTE: Since lockfile.c keeps a linked list of all created
-	 * lock_file structures, it isn't safe to free(lock).  It's
-	 * better to just leave it hanging around.
-	 */
-	lock = NULL;
 	ret = 0;
 
 	/* Invalidate the config cache */
 	git_config_clear();
 
 out_free:
-	if (lock)
-		rollback_lock_file(lock);
+	rollback_lock_file(&lock);
 	free(filename_buf);
 	if (contents)
 		munmap(contents, contents_sz);
@@ -2669,7 +2659,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	return ret;
 
 write_err_out:
-	ret = write_error(get_lock_file_path(lock));
+	ret = write_error(get_lock_file_path(&lock));
 	goto out_free;
 
 }
-- 
2.14.1.721.gc5bc1565f1

