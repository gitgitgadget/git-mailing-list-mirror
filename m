Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6624BC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJVAWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJVAWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:22:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18052A56A0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:21:55 -0700 (PDT)
Received: (qmail 15237 invoked by uid 109); 22 Oct 2022 00:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:21:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18987 invoked by uid 111); 22 Oct 2022 00:21:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:21:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:21:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] repack: use tempfiles for signal cleanup
Message-ID: <Y1M3oie5dPrRaOni@coredump.intra.peff.net>
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git-repack exits due to a signal, it tries to clean up by calling
its remove_temporary_files() function, which walks through the packs dir
looking for ".tmp-$$-pack-*" files to delete (where "$$" is the pid of
the current process).

The biggest problem here is that remove_temporary_files() is not safe to
call in a signal handler. It uses opendir(), which isn't on the POSIX
async-signal-safe list. The details will be platform-specific, but a
likely issue is that it needs to allocate memory; if we receive a signal
while inside malloc(), etc, we'll conflict on the allocator lock and
deadlock with ourselves.

We can fix this by just cleaning up the files directly, without walking
the directory. We already know the complete list of .tmp-* files that
were generated, because we recorded them via populate_pack_exts(). When
we find files there, we can use register_tempfile() to record the
filenames. If we receive a signal, then the tempfile API will clean them
up for us, and it's async-safe and pretty battle-tested.

Note that this is slightly racier than the existing scheme. We don't
record the filenames until pack-objects tells us the hash over stdout.
So during the period between it generating the file and reporting the
hash, we'd fail to clean up. However, that period is very small. During
most of the pack generation process pack-objects is using its own
internal tempfiles. It's only at the very end that it moves them into
the names git-repack expects, and then it immediately reports the name
to us. Given that cleanup like this is best effort (after all, we may
get SIGKILL), this level of race is acceptable.

When we register the tempfiles, we'll record them locally and use the
result to call rename_tempfile(), rather than renaming by hand.  This
isn't strictly necessary, as once we've renamed the files they're gone,
and the tempfile API's cleanup unlink() would simply become a pointless
noop. But managing the lifetimes of the tempfile objects is the cleanest
thing to do, and the tempfile pointers naturally fill the same role as
the old booleans.

This patch also fixes another small problem. We only hook signals, and
don't set up an atexit handler. So if we see an error that causes us to
die(), we'll leave the .tmp-* files in place. But since the tempfile API
handles this for us, this is now fixed for free. The new test covers
this by stimulating a failure of pack-objects when generating a cruft
pack. Before this patch, the .tmp-* file for the main pack would have
been left, but now we correctly clean it up.

Two small subtleties on the implementation:

  - in the renaming loop, we can stop re-constructing fname_old; we only
    use it when we have a tempfile to rename, so we can just ask the
    tempfile for its path (which, barring bugs, should be identical)

  - when renaming fails, our error message mentions fname_old. But since
    a failed rename_tempfile() invalidates the tempfile struct, we'll
    lose access to that string. Instead, let's mention the destination
    filename, which is what most other callers do.

Reported-by: Jan Pokorný <poki@fnusa.cz>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c  | 26 ++++++++------------------
 t/t7700-repack.sh |  8 ++++++++
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d1929bb3db..39f03c3a1d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -122,13 +122,6 @@ static void remove_temporary_files(void)
 	strbuf_release(&buf);
 }
 
-static void remove_pack_on_signal(int signo)
-{
-	remove_temporary_files();
-	sigchain_pop(signo);
-	raise(signo);
-}
-
 /*
  * Adds all packs hex strings to either fname_nonkept_list or
  * fname_kept_list based on whether each pack has a corresponding
@@ -248,7 +241,7 @@ static struct {
 };
 
 struct generated_pack_data {
-	char exts[ARRAY_SIZE(exts)];
+	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
 };
 
 static struct generated_pack_data *populate_pack_exts(const char *name)
@@ -265,7 +258,7 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 		if (stat(path.buf, &statbuf))
 			continue;
 
-		data->exts[i] = 1;
+		data->tempfiles[i] = register_tempfile(path.buf);
 	}
 
 	strbuf_release(&path);
@@ -867,8 +860,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		split_pack_geometry(geometry, geometric_factor);
 	}
 
-	sigchain_push_common(remove_pack_on_signal);
-
 	prepare_pack_objects(&cmd, &po_args);
 
 	show_progress = !po_args.quiet && isatty(2);
@@ -1013,30 +1004,29 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		struct generated_pack_data *data = item->util;
 
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
-			char *fname, *fname_old;
+			char *fname;
 
 			fname = mkpathdup("%s/pack-%s%s",
 					packdir, item->string, exts[ext].name);
-			fname_old = mkpathdup("%s-%s%s",
-					packtmp, item->string, exts[ext].name);
 
-			if (data->exts[ext]) {
+			if (data->tempfiles[ext]) {
+				const char *fname_old = get_tempfile_path(data->tempfiles[ext]);
 				struct stat statbuffer;
+
 				if (!stat(fname_old, &statbuffer)) {
 					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
 					chmod(fname_old, statbuffer.st_mode);
 				}
 
-				if (rename(fname_old, fname))
-					die_errno(_("renaming '%s' failed"), fname_old);
+				if (rename_tempfile(&data->tempfiles[ext], fname))
+					die_errno(_("renaming pack to '%s' failed"), fname);
 			} else if (!exts[ext].optional)
 				die(_("pack-objects did not write a '%s' file for pack %s-%s"),
 				    exts[ext].name, packtmp, item->string);
 			else if (unlink(fname) < 0 && errno != ENOENT)
 				die_errno(_("could not unlink: %s"), fname);
 
 			free(fname);
-			free(fname_old);
 		}
 	}
 	/* End of pack replacement. */
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index ca45c4cd2c..592016f64a 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -432,6 +432,14 @@ test_expect_success TTY '--quiet disables progress' '
 	test_must_be_empty stderr
 '
 
+test_expect_success 'clean up .tmp-* packs on error' '
+	test_must_fail git \
+		-c repack.cruftwindow=bogus \
+		repack -ad --cruft &&
+	find $objdir/pack -name '.tmp-*' >tmpfiles &&
+	test_must_be_empty tmpfiles
+'
+
 test_expect_success 'setup for update-server-info' '
 	git init update-server-info &&
 	test_commit -C update-server-info message
-- 
2.38.1.496.ga614b0e9bd

