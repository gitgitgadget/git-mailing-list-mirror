From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 20/40] Windows: A rudimentary poll() emulation.
Date: Wed, 27 Feb 2008 19:54:43 +0100
Message-ID: <1204138503-6126-21-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVW-00022R-SO
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661AbYB0S4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700AbYB0S4J
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:09 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40450 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbYB0SzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 8F2C3974E8;
	Wed, 27 Feb 2008 19:55:07 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75279>

This emulation of poll() is by far not general. It assumes that the
fds that are to be waited for are connected to pipes. The pipes are
polled in a loop until data becomes available in at least one of them.
If only a single fd is waited for, the implementation actually does
not wait at all, but assumes that a subsequent read() will block.

In order not to needlessly burn CPU time, the CPU is yielded to other
processes before the next round in the poll loop using Sleep(0). Note that
any sleep timeout greater than zero will reduce the efficiency by a
magnitude.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fe6f6ce..837d741 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -102,6 +102,61 @@ int pipe(int filedes[2])
 
 int poll(struct pollfd *ufds, unsigned int nfds, int timeout)
 {
+	int i, pending;
+
+	if (timeout != -1)
+		return errno = EINVAL, error("poll timeout not supported");
+
+	/* When there is only one fd to wait for, then we pretend that
+	 * input is available and let the actual wait happen when the
+	 * caller invokes read().
+	 */
+	if (nfds == 1) {
+		if (!(ufds[0].events & POLLIN))
+			return errno = EINVAL, error("POLLIN not set");
+		ufds[0].revents = POLLIN;
+		return 0;
+	}
+
+repeat:
+	pending = 0;
+	for (i = 0; i < nfds; i++) {
+		DWORD avail = 0;
+		HANDLE h = (HANDLE) _get_osfhandle(ufds[i].fd);
+		if (h == INVALID_HANDLE_VALUE)
+			return -1;	/* errno was set */
+
+		if (!(ufds[i].events & POLLIN))
+			return errno = EINVAL, error("POLLIN not set");
+
+		/* this emulation works only for pipes */
+		if (!PeekNamedPipe(h, NULL, 0, NULL, &avail, NULL)) {
+			int err = GetLastError();
+			if (err == ERROR_BROKEN_PIPE) {
+				ufds[i].revents = POLLHUP;
+				pending++;
+			} else {
+				errno = EINVAL;
+				return error("PeekNamedPipe failed,"
+					" GetLastError: %u", err);
+			}
+		} else if (avail) {
+			ufds[i].revents = POLLIN;
+			pending++;
+		} else
+			ufds[i].revents = 0;
+	}
+	if (!pending) {
+		/* The only times that we spin here is when the process
+		 * that is connected through the pipes is waiting for
+		 * its own input data to become available. But since
+		 * the process (pack-objects) is itself CPU intensive,
+		 * it will happily pick up the time slice that we are
+		 * relinguishing here.
+		 */
+		Sleep(0);
+		goto repeat;
+	}
 	return 0;
 }
 
-- 
1.5.4.1.126.ge5a7d
