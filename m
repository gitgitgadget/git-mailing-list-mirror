Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6D21FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 06:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbcHSG11 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 02:27:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:53144 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbcHSG10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 02:27:26 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LiWzQ-1b29qE1kK4-00cfBj; Thu, 18 Aug 2016 16:51:18
 +0200
Date:   Thu, 18 Aug 2016 16:51:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Ben Wijen <ben@wijen.net>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/2] mingw: ensure temporary file handles are not inherited
 by child processes
In-Reply-To: <cover.1471531799.git.johannes.schindelin@gmx.de>
Message-ID: <2e95aae054fd40d9127b9faa0d3d2525428dd70b.1471531799.git.johannes.schindelin@gmx.de>
References: <cover.1471437637.git.johannes.schindelin@gmx.de> <cover.1471531799.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wlRZGlWzAdCAdf0tf6FGtuvx14OR4eay0uFMCImyei78h42VJVK
 C3JflltsE9mb5kOmsari3vE1xRY3GO02TVgKyOGxHaOIGKaNmpegyb5PdWDTfOY3JQ1FnNt
 9EE0ASHQ5U5B89GWuhozixrm8p+H4dWF8cNd3gnvyow2APFlLWXokPQotnp0ldvJ9LlgQv5
 sLk2+IOGs8SwRP5JAr/EQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sW0OFH6drlM=:BT/Zcf1FTzZIh4FzbByCvD
 MiMXgn6UOHta/oRfDsbyVeW2gh+TurKWJ95BmccmKusPfsX6OY8LCQdzIN/WCpmCH5H6kiSDo
 wDIwja8z3eLHB6cAxj27A6Vwy+qn+npEFWaXhzuzdKP/mRw7635A6mIqWGoN57JxTi7Yomy8F
 RxaLzMqfYuTZ5r4KXP5HIt+7qHNwiCBN8VkACpFy4DOuRiAHpssqlCAzjGn244Z6TMWtrD+YE
 1q7wwdON6PnanJqn+im+c7DEN4HCJnRzblUPxpNnkSBfDd7TshUTNl+2TQ9vOo4fZtELzUprX
 xPk2O7ZxTE/9y1pVXRXO/1CQufMO4DeBT6W9ujtDCgcuOx/Qcmz1zEPazvz3Wufm5VT5HMj5S
 1AOh+kgm7A2Agu/0tNMtbLftXPUaCdtTE88vB0I3M+NIziruL1ZMB0oCqHMEEuN7aCbwR3ao6
 gTuN+17t54Io7t1psMxb8AH7Zf/mN3RlmkiuViRM0gbAZpTthY+XOCaN2Shp47wH8w5yusSXH
 52nQBWWTgaYp2BZ3JfL17EG3uCH3Xh2IXgBTVStTdGPbtZY+0NmWyoFASeCKFIqVJib52o/88
 uijXfytBB9r2t8ONgK0AJLcMtUccelIAYx36O5DmkqTbQ4De8jDMJyJt0SuCFe+JjXfM1RuQ6
 AJcvqTtUxP0id8lDoYQzT6G2nvMHhxhwMnHJ8guC+mtbD0DOvtgIX3xSrcLxvT5u73PyLINrv
 UgqD7iJullMHnJ0kK0js/PKkrmfhXzYZUKPt5TaPKCYk6fjtrZACTlIDOSCvsrHQQchDfwZ+X
 LnAiN8H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Wijen <ben@wijen.net>

When the index is locked and child processes inherit the handle to
said lock and the parent process wants to remove the lock before the
child process exits, on Windows there is a problem: it won't work
because files cannot be deleted if a process holds a handle on them.
The symptom:

    Rename from 'xxx/.git/index.lock' to 'xxx/.git/index' failed.
    Should I try again? (y/n)

Spawning child processes with bInheritHandles==FALSE would not work
because no file handles would be inherited, not even the hStdXxx
handles in STARTUPINFO (stdin/stdout/stderr).

Opening every file with O_NOINHERIT does not work, either, as e.g.
git-upload-pack expects inherited file handles.

This leaves us with the only way out: creating temp files with the
O_NOINHERIT flag. This flag is Windows-specific, however. For our
purposes, it is equivalent to O_CLOEXEC (which does not exist on
Windows), so let's just open temporary files with the O_CLOEXEC flag and
map that flag to O_NOINHERIT on Windows.

This fixes the test that we just introduced to demonstrate the problem.

Signed-off-by: Ben Wijen <ben@wijen.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h        | 4 ++++
 lockfile.h            | 4 ++++
 t/t6026-merge-attr.sh | 2 +-
 tempfile.c            | 2 +-
 tempfile.h            | 4 ++++
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 95e128f..753e641 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -67,6 +67,10 @@ typedef int pid_t;
 #define F_SETFD 2
 #define FD_CLOEXEC 0x1
 
+#if !defined O_CLOEXEC && defined O_NOINHERIT
+#define O_CLOEXEC	O_NOINHERIT
+#endif
+
 #ifndef EAFNOSUPPORT
 #define EAFNOSUPPORT WSAEAFNOSUPPORT
 #endif
diff --git a/lockfile.h b/lockfile.h
index 3d30193..d26ad27 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -55,6 +55,10 @@
  *   * calling `fdopen_lock_file()` to get a `FILE` pointer for the
  *     open file and writing to the file using stdio.
  *
+ *   Note that the file descriptor returned by hold_lock_file_for_update()
+ *   is marked O_CLOEXEC, so the new contents must be written by the
+ *   current process, not a spawned one.
+ *
  * When finished writing, the caller can:
  *
  * * Close the file descriptor and rename the lockfile to its final
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 3d28c78..dd8f88d 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -181,7 +181,7 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	)
 '
 
-test_expect_success !MINGW 'custom merge does not lock index' '
+test_expect_success 'custom merge does not lock index' '
 	git reset --hard anchor &&
 	write_script sleep-one-second.sh <<-\EOF &&
 		sleep 1 &
diff --git a/tempfile.c b/tempfile.c
index 0af7ebf..db3981d 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -120,7 +120,7 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 	prepare_tempfile_object(tempfile);
 
 	strbuf_add_absolute_path(&tempfile->filename, path);
-	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, 0666);
 	if (tempfile->fd < 0) {
 		strbuf_reset(&tempfile->filename);
 		return -1;
diff --git a/tempfile.h b/tempfile.h
index 4219fe4..2f0038d 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -33,6 +33,10 @@
  *   * calling `fdopen_tempfile()` to get a `FILE` pointer for the
  *     open file and writing to the file using stdio.
  *
+ *   Note that the file descriptor returned by create_tempfile()
+ *   is marked O_CLOEXEC, so the new contents must be written by
+ *   the current process, not any spawned one.
+ *
  * When finished writing, the caller can:
  *
  * * Close the file descriptor and remove the temporary file by
-- 
2.9.2.691.g78954f3
