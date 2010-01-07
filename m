From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/5] Windows: simplify the pipe(2) implementation
Date: Thu,  7 Jan 2010 22:55:00 +0100
Message-ID: <7fc9ba13ae1495001ec8fbb4df9541975652dcea.1262895937.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: 3olhGSwMIB4wzM90trw.47w28E8wy9w44w1uw74A58.s42@listserv.bounces.google.com Thu Jan 07 22:57:08 2010
Return-path: <3olhGSwMIB4wzM90trw.47w28E8wy9w44w1uw74A58.s42@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0Lr-00024Y-AZ
	for gcvm-msysgit@m.gmane.org; Thu, 07 Jan 2010 22:57:07 +0100
Received: by mail-gx0-f190.google.com with SMTP id 6sf48054971gxk.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Jan 2010 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=sJYOyldyLkQ08J6qtZkBYizdEUG7+zFz0qmkvQ32n1k=;
        b=jnZEF1z5cUL7ri2SZsmtXiH2BMUIZX7NFy4PFILDevrX4xvsKRFhyEmdPViFv6eBzf
         oeZMTXUdU3WvCHcPmZH4d5jnTQQSysXTTPc40v86SEiEemIt9EwoOseIFmkuzoELjiQJ
         NqLXLveDJdFmJnHNohR2+uLcbJyOCm/JLvEbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=un4fM39T1PUceJpOn/AquF6+oYQsWkM4Ur028LagVUMPBv2Oom4N/F7WahNcr/bEEL
         6Bl3KUt/HrYcnGcWWFTtLNqQ/K3LNQXa52qCwR6+7lj6NcCAPGHmEVZK86Lz6RrphcyP
         dEWAxvgcbKzdk28DpT4H/XLpaHlYLHMDQbnJ0=
Received: by 10.101.117.9 with SMTP id u9mr5700anm.45.1262901410294;
        Thu, 07 Jan 2010 13:56:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.16.73 with SMTP id n9ls301491bka.3.p; Thu, 07 Jan 2010 
	13:56:49 -0800 (PST)
Received: by 10.204.23.208 with SMTP id s16mr848648bkb.16.1262901409001;
        Thu, 07 Jan 2010 13:56:49 -0800 (PST)
Received: by 10.204.23.208 with SMTP id s16mr848647bkb.16.1262901408971;
        Thu, 07 Jan 2010 13:56:48 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 12si2322673bwz.14.2010.01.07.13.56.48;
        Thu, 07 Jan 2010 13:56:48 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 872082C400C;
	Thu,  7 Jan 2010 22:56:48 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 16D4019F610;
	Thu,  7 Jan 2010 22:56:01 +0100 (CET)
X-Mailer: git-send-email 1.6.6.115.gd1ab3
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/89026b66486ea92e
X-Message-Url: http://groups.google.com/group/msysgit/msg/ed3c7c826069afa1
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136393>

Our implementation of pipe() must create non-inheritable handles for the
reason that when a child process is started, there is no opportunity to
close the unneeded pipe ends in the child (on POSIX this is done between
fork() and exec()).

Previously, we used the _pipe() function provided by Microsoft's C runtime
(which creates inheritable handles) and then turned the handles into
non-inheritable handles using the DuplicateHandle() API.

Simplify the procedure by using the CreatePipe() API, which can create
non-inheritable handles right from the beginning.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c |   37 ++++++++-----------------------------
 1 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index dfb1f05..9f4fab3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -299,46 +299,25 @@ int gettimeofday(struct timeval *tv, void *tz)
 
 int pipe(int filedes[2])
 {
-	int fd;
-	HANDLE h[2], parent;
-
-	if (_pipe(filedes, 8192, 0) < 0)
-		return -1;
+	HANDLE h[2];
 
-	parent = GetCurrentProcess();
-
-	if (!DuplicateHandle (parent, (HANDLE)_get_osfhandle(filedes[0]),
-			parent, &h[0], 0, FALSE, DUPLICATE_SAME_ACCESS)) {
-		close(filedes[0]);
-		close(filedes[1]);
-		return -1;
-	}
-	if (!DuplicateHandle (parent, (HANDLE)_get_osfhandle(filedes[1]),
-			parent, &h[1], 0, FALSE, DUPLICATE_SAME_ACCESS)) {
-		close(filedes[0]);
-		close(filedes[1]);
-		CloseHandle(h[0]);
+	/* this creates non-inheritable handles */
+	if (!CreatePipe(&h[0], &h[1], NULL, 8192)) {
+		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
-	fd = _open_osfhandle((int)h[0], O_NOINHERIT);
-	if (fd < 0) {
-		close(filedes[0]);
-		close(filedes[1]);
+	filedes[0] = _open_osfhandle((int)h[0], O_NOINHERIT);
+	if (filedes[0] < 0) {
 		CloseHandle(h[0]);
 		CloseHandle(h[1]);
 		return -1;
 	}
-	close(filedes[0]);
-	filedes[0] = fd;
-	fd = _open_osfhandle((int)h[1], O_NOINHERIT);
-	if (fd < 0) {
+	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
+	if (filedes[0] < 0) {
 		close(filedes[0]);
-		close(filedes[1]);
 		CloseHandle(h[1]);
 		return -1;
 	}
-	close(filedes[1]);
-	filedes[1] = fd;
 	return 0;
 }
 
-- 
1.6.6.115.gd1ab3
