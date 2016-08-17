Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0655F2018E
	for <e@80x24.org>; Wed, 17 Aug 2016 12:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbcHQMmM (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 08:42:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:51174 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbcHQMmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 08:42:11 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LkgAG-1azqWi1X08-00aSWK; Wed, 17 Aug 2016 14:41:20
 +0200
Date:	Wed, 17 Aug 2016 14:41:19 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Ben Wijen <ben@wijen.net>, Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 2/2] mingw: ensure temporary file handles are not inherited
 by child processes
In-Reply-To: <cover.1471437637.git.johannes.schindelin@gmx.de>
Message-ID: <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5vVT07RjDQWHjjQtU+RTAm19RNWXIxHrRgsoth9RcQQiWVs1cBj
 k/T10RE+Dg1chX82DVYfY7lXWuCKJ2nup1A8HU/g7IG/o2kLPj8OrtMKVnbsDeZItaASj9L
 cWShnJCHWGrGfkpUOT4II75ridkfCrf4ub09hodnIIFvu2I4Lt4c1RzfGemLmhJlKW5dmju
 agwYJdPEuzgDzraoz5a8Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:FYccX101iKQ=:XCZuA+O38AmSB6y3UWXhqs
 spMZ9YHGo/vYE8/w8kPinD7EjPgckr+2ULkDplUozzQ+e/3bPU+LaROBaG9D8QX42PyEvSVvX
 u4F3rhmGKgveHZw+8DfZZv2HPpBU0xS7W2aRfek0lqJDvBni5CBrGaB/nSyFwmMI6my2npcvP
 OreoVXec3/LvHpPfQhTP0f+0GxxmI6L6veYjG2o1UnsGIp8czpUHb5vmlUqnmCaCsTkdnhTyM
 58HYy4ufKOeeO+tGNpyHK7Gv9bJKufdNAAb0aHllVFz3Ti8rGJUZGuqIA5Zy0Ny1Yk6I5SjtR
 mYV/Er3EnQENoAVprvGTh8LPaMBnn/m6hKwUfXEk2nAf79h4Wjx61nRoIVzTqAM/6q7mJQmag
 IujahQhQH8vCILwZGp0fDwDQgC54T98ibpvJkQ8u9zs2LYQHZLtFhPoCbn55TTxiMAG91+39g
 igmelUh9DOHjTrVFTbntfX5LsWx00FgMnFFjYWOqOLDMPmiXNhHoGwQIbSR8aj2MI8EBvzckM
 84fS0DpQNHTh8wEWiQESdY/MSxrr4ZPNBTZWdgybB7206wWs3UpIm08QexJeyAeXEF+6yEt2o
 Erq/DsDnV+YFp1nS5c0B/htoor019wV+HNoGPQ7YSvm419L9dKy2CuGFgb0vTxVIijbUjHqZ/
 R/L/O2mJi7z/RAehPdjp4UYiuH6diQX7hvVb1ahzpfkkaICNrfL4fehsKOxp5DBLPpHVI6GfO
 GNqckAIQGQ41LJ1oe7hMnF8Klyvc3p6KLJRtC49Ow/w4K0Pw/MPBmuW2SQ1X2zTRZk8do82NB
 /L+BFEa
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
purposes, it is equivalent our purposes) to O_CLOEXEC (which does not
exist on Windows), so let's just open temporary files with the
O_CLOEXEC flag and map that flag to O_NOINHERIT on Windows.

This fixes the test that we just introduced to demonstrate the problem.

Signed-off-by: Ben Wijen <ben@wijen.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h        | 4 ++++
 t/t6026-merge-attr.sh | 2 +-
 tempfile.c            | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

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
-- 
2.9.2.691.g78954f3
