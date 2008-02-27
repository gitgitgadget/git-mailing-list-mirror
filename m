From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 17/40] Windows: A pipe() replacement whose ends are not inherited to children.
Date: Wed, 27 Feb 2008 19:54:40 +0100
Message-ID: <1204138503-6126-18-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVR-00022R-1O
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853AbYB0Szt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbYB0Szs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:48 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40447 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbYB0SzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 000379725F;
	Wed, 27 Feb 2008 19:55:06 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75274>

On Unix the idiom to use a pipe is as follows:

    pipe(fd);
    pid = fork();
    if (!pid) {
        dup2(fd[1], 1);
        close(fd[1]);
        close(fd[0]);
        ...
     }
     close(fd[1]);

i.e. the child process closes the both pipe ends after duplicating one
to the file descriptors where they are needed.

On Windows, which does not have fork(), we never have an opportunity to
(1) duplicate a pipe end in the child, (2) close unused pipe ends. Instead,
we must use this idiom:

    save1 = dup(1);
    pipe(fd);
    dup2(fd[1], 1);
    spawn(...);
    dup2(save1, 1);
    close(fd[1]);

i.e. save away the descriptor at the destination slot, replace by the pipe
end, spawn process, restore the saved file.

But there is a problem: Notice that the child did not only inherit the
dup2()ed descriptor, but also *both* original pipe ends. Although the one
end that was dup()ed could be closed before the spawn(), we cannot close
the other end - the child inherits it, no matter what.

The solution is to generate non-inheritable pipes. At the first glance,
this looks strange: The purpose of pipes is usually to be inherited to
child processes. But notice that in the course of actions as outlined
above, the pipe descriptor that we want to inherit to the child is
dup2()ed, and as it so happens, Windows's dup2() creates inheritable
duplicates.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |   45 +++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    5 +----
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9d03ea5..fe6f6ce 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -55,6 +55,51 @@ int gettimeofday(struct timeval *tv, void *tz)
 	return 0;
 }
 
+int pipe(int filedes[2])
+{
+	int fd;
+	HANDLE h[2], parent;
+
+	if (_pipe(filedes, 8192, 0) < 0)
+		return -1;
+
+	parent = GetCurrentProcess();
+
+	if (!DuplicateHandle (parent, (HANDLE)_get_osfhandle(filedes[0]),
+			parent, &h[0], 0, FALSE, DUPLICATE_SAME_ACCESS)) {
+		close(filedes[0]);
+		close(filedes[1]);
+		return -1;
+	}
+	if (!DuplicateHandle (parent, (HANDLE)_get_osfhandle(filedes[1]),
+			parent, &h[1], 0, FALSE, DUPLICATE_SAME_ACCESS)) {
+		close(filedes[0]);
+		close(filedes[1]);
+		CloseHandle(h[0]);
+		return -1;
+	}
+	fd = _open_osfhandle((int)h[0], O_NOINHERIT);
+	if (fd < 0) {
+		close(filedes[0]);
+		close(filedes[1]);
+		CloseHandle(h[0]);
+		CloseHandle(h[1]);
+		return -1;
+	}
+	close(filedes[0]);
+	filedes[0] = fd;
+	fd = _open_osfhandle((int)h[1], O_NOINHERIT);
+	if (fd < 0) {
+		close(filedes[0]);
+		close(filedes[1]);
+		CloseHandle(h[1]);
+		return -1;
+	}
+	close(filedes[1]);
+	filedes[1] = fd;
+	return 0;
+}
+
 int poll(struct pollfd *ufds, unsigned int nfds, int timeout)
 {
 	return 0;
diff --git a/git-compat-util.h b/git-compat-util.h
index e191a46..170c279 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -571,14 +571,11 @@ static inline int waitpid(pid_t pid, unsigned *status, unsigned options)
 	return -1;
 }
 
-
-static inline int pipe(int filedes[2])
-{ return _pipe(filedes, 8192, 0); }
-
 /*
  * implementations of missing functions
  */
 
+int pipe(int filedes[2]);
 unsigned int sleep (unsigned int seconds);
 int gettimeofday(struct timeval *tv, void *tz);
 int poll(struct pollfd *ufds, unsigned int nfds, int timeout);
-- 
1.5.4.1.126.ge5a7d
