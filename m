Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE131F859
	for <e@80x24.org>; Mon, 22 Aug 2016 12:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbcHVMsv (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 08:48:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:63326 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbcHVMsu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 08:48:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MFLmC-1bPf110z9I-00EIsz; Mon, 22 Aug 2016 14:47:59
 +0200
Date:   Mon, 22 Aug 2016 14:47:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Ben Wijen <ben@wijen.net>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v3 2/2] mingw: ensure temporary file handles are not inherited
 by child processes
In-Reply-To: <cover.1471869985.git.johannes.schindelin@gmx.de>
Message-ID: <b31d13befa305e46bd51f8c168f42071ce2dc663.1471869985.git.johannes.schindelin@gmx.de>
References: <cover.1471531799.git.johannes.schindelin@gmx.de> <cover.1471869985.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:k5jE/21P5dn67VvROb16eAvCXAy/+saCFsQuEqYaxikokR+zLpZ
 Yo9MmwWGp75vdJbvV8Uc+ej/FX4E0KWOSlwguTNtFNnoLZ7Avxkk6SkVkQzNBnDYeCpifu9
 +hOC21xSdEKIjsMJyFKj8oV1u8oeEv8H8jelTg9DbXxvKWjh6zUtnnzX3RiMENya9xqbaGP
 vnX26On9cWH1d3O27PAnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qKBAwFjr5kU=:uiBeWU+Oe9hNOzHhGc7yIL
 qsAC0GO76ChFrsDDnGMTnyMkevUmg5yytq03QUO9kCjr5IkKOPdqpSfn3hAV8a2VvvyFaMDMq
 jPxTTCkCTeu0M77ANT/ZErqeIt+tTIfk6WioPVQBt3uVH2kaf2C/aVFoRPZHlUZUmnWK6I+Lm
 IfS9txyt9AlMto7vW7SIIEgeakFHaDAJ7rN1HIZEtl4pf/vtaM5pFsAkYPnCHcAeGO0PTZvc0
 Cn6KCitIQ0mTBlSlrZokQUPHxfnnsPta4dkVzpf/fBNtqdXwrhwt0MrdGqqccDtsGBTvYo0lB
 LeTUy0MRMUU4I280amPocEIGE1jcKfxsS8MgqmHsz+vj7PWj02vySFzPI96FJZVeZLpnMuypB
 DGWUKeU9HLCXJg2Gzop8c4WLSpw3fpe9AP+3JPvhiBkMRK8XprMlfbI3suuOitry+gWCkvELE
 UHgryGQSSdyqsnWR4QjHziP3xYlqGBTHX9L8TSlzjQMaJlrAouNWjzEVlzO8S5nj78IgtNEFm
 7I+pYjjuAD1J1rIavO6tjHZF7hEL+RIgeyKhL2109hEWIVIj99hwKYfPnvM0ut8qIQVE9VWtM
 sXchGhrZ3tJxO8baPY8t99vRo3dCkrEO1F22gfi5XpbIZZIF0+3/Dp42MDlBN2K2DTSZad8vg
 3ycj/D7ofuWi9892OXknDpbao44f8+Fds0Q0fj08nn3Gqq+3X2hNbBYQrvwFtOIf6OaYbGXxV
 QdlkbVPSap9PAqr7StkGvFrYWjBwv2zN+6J+w8zgYZD0n/BLVaj7ahZs7pAv2Kwu58pr3Vuc9
 UA2EcFt
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

As Eric Wong pointed out, we need to be careful to handle the case where
the Linux headers used to compile Git support O_CLOEXEC but the Linux
kernel used to run Git does not: it returns an EINVAL.

This fixes the test that we just introduced to demonstrate the problem.

Signed-off-by: Ben Wijen <ben@wijen.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h        | 4 ++++
 git-compat-util.h     | 4 ++++
 lockfile.h            | 4 ++++
 t/t6026-merge-attr.sh | 2 +-
 tempfile.c            | 7 ++++++-
 tempfile.h            | 4 ++++
 6 files changed, 23 insertions(+), 2 deletions(-)

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
diff --git a/git-compat-util.h b/git-compat-util.h
index f52e00b..db89ba7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -667,6 +667,10 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
 #define getpagesize() sysconf(_SC_PAGESIZE)
 #endif
 
+#ifndef O_CLOEXEC
+#define O_CLOEXEC 0
+#endif
+
 #ifdef FREAD_READS_DIRECTORIES
 #ifdef fopen
 #undef fopen
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
index 0af7ebf..2990c92 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -120,7 +120,12 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 	prepare_tempfile_object(tempfile);
 
 	strbuf_add_absolute_path(&tempfile->filename, path);
-	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+	tempfile->fd = open(tempfile->filename.buf,
+			    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, 0666);
+	if (O_CLOEXEC && tempfile->fd < 0 && errno == EINVAL)
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		tempfile->fd = open(tempfile->filename.buf,
+				    O_RDWR | O_CREAT | O_EXCL, 0666);
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
2.10.0.rc0.115.ged054c0
