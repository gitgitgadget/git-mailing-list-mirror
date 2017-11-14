Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74EA1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 16:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbdKNQR4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 11:17:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65013 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752799AbdKNQRy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 11:17:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCF0DB4E6B;
        Tue, 14 Nov 2017 11:17:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to; s=sasl; bh=wWlSXqK3oLvZt3I
        Zx9L0Hqcn8uI=; b=MG0X6BfSTB8Z+Qm8HoM7dfHzgPAjeCCBkOLQRUZ8wA/VVb4
        te8WxF3sUA/zpaNH2LRXiF9t6ny3r7co5xz/g9HlEIsHua1OmtGw57WWa/NaSb/4
        dKMlkplduQkTCVkz4TdrcmonymWPaz0ZQah9/94zYtPDOeJmGCxVrEchilWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to; q=dns; s=sasl; b=KIx8Uds2D
        jhMk0Pe7z8IHK1VXjUOnsT4cevamJia4jpcHfz+FBdKkxDxlbMSsUJIl7d4Kcig2
        RJXKBiqxXhX+1gdkkwg8arWu81XWH4o7jwKMwwX87YhmoxyGViKRqF9+6NvG4qTm
        K0Er+39EDhegCIoL5CFHih2lK15HEOSv5I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4304B4E69;
        Tue, 14 Nov 2017 11:17:53 -0500 (EST)
Received: from morphine.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C4C3B4E67;
        Tue, 14 Nov 2017 11:17:53 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     Johan Herland <johan@herland.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: [PATCH] notes: send "Automatic notes merge failed" messages to stderr
Date:   Tue, 14 Nov 2017 11:17:52 -0500
Message-Id: <20171114161752.13204-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <CALKQrgc427=JNkkH+k+EohgKYuJSBPbDNR3uUcmGuf_ZyQ0X4Q@mail.gmail.com>
X-Pobox-Relay-ID: 5DFF41B6-C957-11E7-B0B8-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All other error messages from notes use stderr.  Do the same when
alerting users of an unresolved notes merge.

Fix the output redirection in t3310 and t3320 as well.  Previously, the
tests directed output to a file, but stderr was either not captured or
not sent to the file due to the order of the redirection operators.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Johan Herland wrote:
> ACK :-)
> 
> Error messages should go to stderr, and redirection in the tests
> should be fixed.

Excellent, thanks Johan!

Here's what I came up with.  Hopefully I caught all the tests that need
adjustment.  The test suite passes for me, but it's always possible that I've
missed something.

Style-wise, I'm not sure about the re-wrapping of the error message text.  If
that should be avoided to make the patch's change from printf to fprintf
clearer or should be wrapped differently, let me know.

 builtin/notes.c                       | 8 ++++----
 t/t3310-notes-merge-manual-resolve.sh | 8 ++++----
 t/t3320-notes-merge-worktrees.sh      | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 12afdf1907..4468adaf29 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -865,10 +865,10 @@ static int merge(int argc, const char **argv, const char *prefix)
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die(_("failed to store link to current notes ref (%s)"),
 			    default_notes_ref());
-		printf(_("Automatic notes merge failed. Fix conflicts in %s and "
-			 "commit the result with 'git notes merge --commit', or "
-			 "abort the merge with 'git notes merge --abort'.\n"),
-		       git_path(NOTES_MERGE_WORKTREE));
+		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
+				  "and commit the result with 'git notes merge --commit', "
+				  "or abort the merge with 'git notes merge --abort'.\n"),
+			git_path(NOTES_MERGE_WORKTREE));
 	}
 
 	free_notes(t);
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index baef2d6924..9c1bf6eb3d 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -176,7 +176,7 @@ git rev-parse refs/notes/z > pre_merge_z
 test_expect_success 'merge z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
 	git update-ref refs/notes/m refs/notes/y &&
 	git config core.notesRef refs/notes/m &&
-	test_must_fail git notes merge z >output &&
+	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should point to where to resolve conflicts
 	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
@@ -379,7 +379,7 @@ git rev-parse refs/notes/z > pre_merge_z
 test_expect_success 'redo merge of z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
 	git update-ref refs/notes/m refs/notes/y &&
 	git config core.notesRef refs/notes/m &&
-	test_must_fail git notes merge z >output &&
+	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should point to where to resolve conflicts
 	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
@@ -413,7 +413,7 @@ git rev-parse refs/notes/y > pre_merge_y
 git rev-parse refs/notes/z > pre_merge_z
 
 test_expect_success 'redo merge of z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
-	test_must_fail git notes merge z >output &&
+	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should point to where to resolve conflicts
 	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
@@ -494,7 +494,7 @@ cp expect_log_y expect_log_m
 
 test_expect_success 'redo merge of z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
 	git update-ref refs/notes/m refs/notes/y &&
-	test_must_fail git notes merge z >output &&
+	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should point to where to resolve conflicts
 	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index b9c3bc2487..10bfc8b947 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -61,7 +61,7 @@ test_expect_success 'merge z into x while mid-merge on y succeeds' '
 	(
 		cd worktree2 &&
 		git config core.notesRef refs/notes/x &&
-		test_must_fail git notes merge z 2>&1 >out &&
+		test_must_fail git notes merge z >out 2>&1 &&
 		test_i18ngrep "Automatic notes merge failed" out &&
 		grep -v "A notes merge into refs/notes/x is already in-progress in" out
 	) &&
-- 
2.15.0

