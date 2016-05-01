From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH jk/push-client-deadlock-fix] Windows: add pthread_sigmask()
 that does nothing
Date: Sun, 1 May 2016 21:08:21 +0200
Message-ID: <57265425.9050205@kdbg.org>
References: <CACsJy8BrKsasiXZcc3=mm9Pq=qz_h6pi8edzpmT_7mKxwjnAqQ@mail.gmail.com>
 <20160501174535.GB17321@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	git-for-windows <git-for-windows@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 21:08:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awwjI-0006Ek-SR
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 21:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbcEATI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 15:08:26 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:28058 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbcEATI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 15:08:26 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3qycQv16bgz5tl9;
	Sun,  1 May 2016 21:08:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 431445281;
	Sun,  1 May 2016 21:08:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160501174535.GB17321@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293208>

A previous change introduced a call to pthread_sigmask() in order to block
SIGPIPE in a thread. Since there are no signal facilities on Windows that
are similar to POSIX signals, just ignore the request to block the signal.
In the particular case, the effect of blocking SIGPIPE on POSIX is that
write() calls return EPIPE when the reader closes the pipe. This is how
write() behaves on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h         | 1 +
 compat/win32/pthread.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index a950ae2..0f272fd 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -142,6 +142,7 @@ static inline int fcntl(int fd, int cmd, ...)
 #define sigemptyset(x) (void)0
 static inline int sigaddset(sigset_t *set, int signum)
 { return 0; }
+#define SIG_BLOCK 0
 #define SIG_UNBLOCK 0
 static inline int sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
 { return 0; }
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index b6ed9e7..d336451 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -104,4 +104,9 @@ static inline void *pthread_getspecific(pthread_key_t key)
 	return TlsGetValue(key);
 }
 
+static inline int pthread_sigmask(int how, const sigset_t *set, sigset_t *oset)
+{
+	return 0;
+}
+
 #endif /* PTHREAD_H */
-- 
2.7.0.118.g90056ae
