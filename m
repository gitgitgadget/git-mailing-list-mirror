From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] mingw.h: add dummy functions for sigset_t operations
Date: Mon, 22 Sep 2014 20:24:34 +0200
Message-ID: <54206962.9070005@kdbg.org>
References: <1411059429-23868-1-git-send-email-patrick.reynolds@github.com>	<541D3E0C.4030400@kdbg.org> <xmqqwq8vlg01.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Patrick Reynolds <patrick.reynolds@github.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 20:24:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW8Hy-0006pV-RW
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 20:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbaIVSYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 14:24:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30905 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbaIVSYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 14:24:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 93AFD1300A9;
	Mon, 22 Sep 2014 20:24:35 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id ECCFE19F57D;
	Mon, 22 Sep 2014 20:24:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqwq8vlg01.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257375>

Windows does not have POSIX-like signals, and so we ignore all
operations on the non-existent signal mask machinery.

Do not turn sigemptyset into a function, but leave it a macro that
erases the code in the argument because it is used to set sa_mask
of a struct sigaction, but our dummy in mingw.h does not have that
member.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h     | 7 ++++++-
 t/t0005-signals.sh | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 0b5f2fe..0e42653 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -69,7 +69,6 @@ struct sigaction {
 	sig_handler_t sa_handler;
 	unsigned sa_flags;
 };
-#define sigemptyset(x) (void)0
 #define SA_RESTART 0
 
 struct itimerval {
@@ -116,6 +115,12 @@ static inline int fcntl(int fd, int cmd, ...)
 }
 /* bash cannot reliably detect negative return codes as failure */
 #define exit(code) exit((code) & 0xff)
+#define sigemptyset(x) (void)0
+static inline int sigaddset(sigset_t *set, int signum)
+{ return 0; }
+#define SIG_UNBLOCK 0
+static inline int sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
+{ return 0; }
 
 /*
  * simple adaptors
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 638a355..aeea50c 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -39,12 +39,12 @@ test_expect_success 'create blob' '
 	git add file
 '
 
-test_expect_success 'a constipated git dies with SIGPIPE' '
+test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
 	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 )
 	test "$OUT" -eq 141
 '
 
-test_expect_success 'a constipated git dies with SIGPIPE even if parent ignores it' '
+test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
 	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 )
 	test "$OUT" -eq 141
 '
-- 
2.0.0.12.gbcf935e
