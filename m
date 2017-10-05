Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A921920370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdJEUdD (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:33:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35599 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdJEUdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:33:00 -0400
Received: by mail-wr0-f193.google.com with SMTP id y44so5146030wry.2
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAjRX4a6f8GkaFKD+0ybRc1u+wPRNvi9FFSiTJ6oWAw=;
        b=jahwcM6ECsTR2+StQ6mIgLKTwl/BVxgqZW6j56Ibf929U9ptSBlsxCGOg7ZoPkO/Lp
         /qTWQ3+Dz/dsK7I9hlX5diYnChmKpdP8/dlhkuf7aq3gZDLW3UO+DAzKDFLZLNpuulSh
         S2lCJPwkv12OQuvfRmPrSPhC9W2hfJ52x6RP/H9oYWNML7+qpn+26nUKqJlw+RFbgtvR
         498shzZZWQJ/DF5+LBLNdHed8+gdMv78YmV5aGWhMgQDO+5r49Q1VlWt87JypSlBfYhP
         Sc59cmZkV5nz8KpoqcE0NGsoLJiwgE/nH7E5fihmJC5nMGPvcUT1024+cK9gYeyYSvlT
         dvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAjRX4a6f8GkaFKD+0ybRc1u+wPRNvi9FFSiTJ6oWAw=;
        b=Zf4XMwVv8jKOIy96mHnOG3bxu0Sstt/3OVHKQp6yKjkeyd8/oDP6wHSpfED4nDXrje
         +fTG+d9dL8++0SwcQfwzfe5Ia96iI69b7Cx8e+kVqjV6ozzHdYNBCVyQlE60MT8bbeYP
         wzQ0PrEdCIBA+g01/7lWCF48ROE8u+qtbc4B4gJcpeNcBrq8BHorjhzGYr7l7OKf7aYK
         KPG75yiwmh/owstoZ7ZtP5AJuJM7qdrl1ksRY/SP0KbI/l3CJt4gcMPNl/jkK6lFz/ya
         mVeQ7aybmEj0kDsMg2dbv7z0UM74mSLv04InjiloftxOUKh+QORdqJkOeycca83DlZ3g
         zv0w==
X-Gm-Message-State: AHPjjUg3Z07MJZWYLpnIwBufNmvQXF9V0uBRao2Ddgz7iYWGhdfZOrS6
        htAcdwez8hpqHbzO9x33JOB26EkY
X-Google-Smtp-Source: AOwi7QCtSb6fS4eS+JMfc9s07+fYJXOP67fMhTN4g6jntqhCTDDdJ7GPU9VLtNqPbTy1G+loy2jPCA==
X-Received: by 10.223.167.79 with SMTP id e15mr26220072wrd.92.1507235578606;
        Thu, 05 Oct 2017 13:32:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/12] read-cache: leave lock in right state in `write_locked_index()`
Date:   Thu,  5 Oct 2017 22:32:13 +0200
Message-Id: <b5fc950e4594fb9dec07ec8872c0df8514d149ff.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the original version of `write_locked_index()` returned with an
error, it didn't roll back the lockfile unless the error occured at the
very end, during closing/committing. See commit 03b866477 (read-cache:
new API write_locked_index instead of write_index/write_cache,
2014-06-13).

In commit 9f41c7a6b (read-cache: close index.lock in do_write_index,
2017-04-26), we learned to roll back the lock slightly earlier in the
callstack, but that was mostly a side-effect of lockfiles being
implemented using temporary files.

At that point, the behavior was still mostly the same as originally,
except 1) the file was closed (and possibly rolled back) a few
CPU-instructions earlier, and 2) the file was closed even if the caller
didn't ask us to close it. Case 2) is not very interesting since we
never had any such caller and the commit before this one removed the
possibility of asking to leave the lockfile open.

Recently, commit 076aa2cbd (tempfile: auto-allocate tempfiles on heap,
2017-09-05) introduced a subtle bug. If the lockfile is rolled back
(i.e., the temporary file is deleted), the tempfile-pointer in the
`struct lock_file` will be left dangling. Thus, an attempt to reuse the
lockfile, or even just to roll it back, will induce undefined behavior
-- most likely a crash.

Besides not crashing, we clearly want to make things consistent. But
should we roll back always on error, or never? The semantics which the
lockfile-machinery itself provides is A) if we ask to commit and it
fails, roll back, and B) if we ask to close and it fails, do _not_ roll
back.

We should note that commit 83a3069a3 (lockfile: do not rollback lock on
failed close, 2017-09-05) recently changed the behavior for B -- we used
to roll back. We might worry that our callers rely on us rolling back in
case of B. But we only did so for some errors, we never documented
anything, and all our in-tree callers (they are not many) `die()` in
case of an error. This is our opportunity for establishing a consistent
and predictable behavior going forward, so let's enforce the same
semantics that 83a3069a3 introduced to the lockfile-machinery itself.

Similarly, let's ensure that when we are asked to commit, that we always
either commit or roll back. Right now, we have some early return paths
which fail to roll back the lock.

So: Do not delete the temporary file in `do_write_index()`. One of its
callers, `write_locked_index()` will thereby avoid rolling back the
lock. The other caller, `write_shared_index()`, will delete its
temporary file anyway. Both of these callers will avoid undefined
behavior (crashing).

Teach `write_locked_index(..., COMMIT_LOCK)` to roll back the lock
before returning. If we have already succeeded and committed, it will be
a noop. Simplify the existing callers where we now have a superfluous
call to `rollback_lockfile()`. This should keep future readers from
wondering why the callers are inconsistent.

We still close the lock as we close the temporary file. This is what is
referred to as "1)" above. It does feel a bit unfortunate that we simply
"happen" to close the lock by way of an implementation-detail of
lockfiles. But note that we need to close the temporary file before
`stat`-ing it, at least on Windows. See 9f41c7a6b (read-cache: close
index.lock in do_write_index, 2017-04-26).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: Except for the slightly different documentation in cache.h, this is
a squash of the last two patches of v1. I hope the commit message is
better.

 builtin/difftool.c |  1 -
 cache.h            |  4 ++++
 merge.c            |  4 +---
 read-cache.c       | 14 ++++++++------
 sequencer.c        |  1 -
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index b2d3ba753..bcc79d188 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -616,7 +616,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
 				ret = error("could not write %s", buf.buf);
-				rollback_lock_file(&lock);
 				goto finish;
 			}
 			changed_files(&wt_modified, buf.buf, workdir);
diff --git a/cache.h b/cache.h
index 21a6856c5..0e26224b9 100644
--- a/cache.h
+++ b/cache.h
@@ -616,6 +616,10 @@ extern int read_index_unmerged(struct index_state *);
  * split index to the lockfile. If the temporary file for the shared
  * index cannot be created, fall back to the behavior described in
  * the previous paragraph.
+ *
+ * With `COMMIT_LOCK`, the lock is always committed or rolled back.
+ * Without it, the lock is closed, but neither committed nor rolled
+ * back.
  */
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 
diff --git a/merge.c b/merge.c
index a18a452b5..e5d796c9f 100644
--- a/merge.c
+++ b/merge.c
@@ -91,9 +91,7 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK)) {
-		rollback_lock_file(&lock_file);
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
-	}
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
index 1c917eba9..0090ab886 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2182,9 +2182,8 @@ static int has_racy_timestamp(struct index_state *istate)
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
-	    verify_index(istate) &&
-	    write_locked_index(istate, lockfile, COMMIT_LOCK))
-		rollback_lock_file(lockfile);
+	    verify_index(istate))
+		write_locked_index(istate, lockfile, COMMIT_LOCK);
 }
 
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
@@ -2314,7 +2313,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return -1;
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), tempfile->filename.buf);
-		delete_tempfile(&tempfile);
 		return -1;
 	}
 	if (stat(tempfile->filename.buf, &st))
@@ -2498,7 +2496,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			hashclr(si->base_sha1);
-		return do_write_locked_index(istate, lock, flags);
+		ret = do_write_locked_index(istate, lock, flags);
+		goto out;
 	}
 
 	if (getenv("GIT_TEST_SPLIT_INDEX")) {
@@ -2514,7 +2513,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (new_shared_index) {
 		ret = write_shared_index(istate, lock, flags);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = write_split_index(istate, lock, flags);
@@ -2523,6 +2522,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (!ret && !new_shared_index)
 		freshen_shared_index(sha1_to_hex(si->base_sha1), 1);
 
+out:
+	if (flags & COMMIT_LOCK)
+		rollback_lock_file(lock);
 	return ret;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 60636ce54..d56c38081 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1183,7 +1183,6 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed && index_fd >= 0) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
-			rollback_lock_file(&index_lock);
 			return error(_("git %s: failed to refresh the index"),
 				_(action_name(opts)));
 		}
-- 
2.14.2.666.gea220ee40

