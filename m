From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/6] Pass t5530 on Windows
Date: Sat,  6 Mar 2010 16:40:37 +0100
Message-ID: <cover.1267889072.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:27:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15r-0004YU-TF
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144Ab0CFPmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:42:39 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47637 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750944Ab0CFPmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:42:38 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4C7F710021;
	Sat,  6 Mar 2010 16:42:34 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3B84A19F703;
	Sat,  6 Mar 2010 16:40:53 +0100 (CET)
X-Mailer: git-send-email 1.7.0.rc2.65.g7b13a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The goal of this series is to fix async procedures to the extent that
t5530-upload-pack-error.sh passes on Windows.

The problem is that on Windows async procedures are run in threads (due
to the lack of fork()), and a die() call from an async procedure tears
down the whole process while on POSIX only the async procedure is
terminated.

The approach taken is to use a custom die routine that exits only the
thread when it detects that it is not called from the main procedure.

As a bonus, the threaded async infrastructure now uses pthreads instead
of Windows specific API, and can be enabled on POSIX as well through a
new compile-time option.

Quite frankly, I don't quite know what to do with this series. On the
one hand, it is a clean-up, but in practice it is not relevant whether
die() kills only the async thread or the whole process because all
callers of async die() themselves anyway when the async procedure died.
On the other hand, it does enable threaded async procedures on POSIX...

Johannes Sixt (6):
  Modernize t5530-upload-pack-error.
  Make report() from usage.c public as vreportf() and use it.
  Fix signature of fcntl() compatibility dummy
  Windows: more pthreads functions
  Reimplement async procedures using pthreads
  Dying in an async procedure should only exit the thread, not the
    process.

 Makefile                     |    5 +++
 compat/mingw.h               |    2 +-
 compat/win32/pthread.c       |    8 ++++
 compat/win32/pthread.h       |   25 ++++++++++++++
 fast-import.c                |    8 ++---
 git-compat-util.h            |    1 +
 http-backend.c               |    5 +--
 run-command.c                |   75 ++++++++++++++++++++++++++++++++----------
 run-command.h                |    8 +++-
 t/t5530-upload-pack-error.sh |   18 +++++-----
 usage.c                      |   10 +++---
 11 files changed, 121 insertions(+), 44 deletions(-)
