From: Dmitry Potapov <dpotapov@gmail.com>
Subject: RFC: [PATCH] ignore SIGINT&QUIT while waiting for external command
Date: Tue, 19 Oct 2010 15:59:43 +0400
Message-ID: <20101019115943.GA8065@dpotapov.dyndns.org>
References: <20101019045300.GA18043@gnu.kitenet.net>
 <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Joey Hess <joey@kitenet.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 13:59:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ArC-0003Ko-Vh
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 13:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758340Ab0JSL7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 07:59:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56408 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758037Ab0JSL7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 07:59:48 -0400
Received: by ewy20 with SMTP id 20so3270613ewy.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=A7wnllpkz36nwk45+c+BWIwJifT+oBCnGh6vwhX6mWI=;
        b=J+uGdIX7BTmMnc9TqfSEm54MerPmoZExWMbdHbYWoXLykbBBRR5PVIyI4MeilbaGaI
         XsqfkZKW440elI7lvodxsvqi16xf3B2gBw2w9Xc6EcFwxxQCdezBfyit2WXMj2sRjCa7
         yJPByynAO9PWKo38wdZYwFuH/Xv9VwrL87moI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=orTsTtt1GZHBeaAjVmalXZSPVmy11WZ/pL32NdBp5Np2SZroM4WBMSCHLmloLkk77c
         g2NxYP3gY/VOd6N6bTVkKPXQ5A7D/i0tU8sOZ4/axoIcQ5SsEpltVDuKiR5QUmb91irc
         eqR3MpLCK2CxpqJ4jggKgbnxGCjA9G7upC5Zc=
Received: by 10.213.4.142 with SMTP id 14mr4174423ebr.34.1287489587235;
        Tue, 19 Oct 2010 04:59:47 -0700 (PDT)
Received: from localhost (ppp91-76-16-175.pppoe.mtu-net.ru [91.76.16.175])
        by mx.google.com with ESMTPS id v56sm8435361eeh.14.2010.10.19.04.59.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 04:59:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159323>

Before git 1.6.4, we used execvp to run external git dashed commands,
thus git did not return until this command is finished. With switching to
run_command (which was necessary to fix a pager issue; see d8e96fd86d4),
CTRL-C could cause that git returned before than the git dashed command is
finished.

The solution is to disable SIGINT and SIGQUIT as it is normally done by
system(). Disabling these signals is done only when silent_exec_failure
is set, which means that the current process is used as a proxy to run
another command.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 run-command.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2a1041e..14af035 100644
--- a/run-command.c
+++ b/run-command.c
@@ -93,6 +93,10 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
+#ifndef WIN32
+static sighandler_t sigint, sigquit;
+#endif
+
 static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 {
 	int status, code = -1;
@@ -102,6 +106,13 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
 		;	/* nothing */
 
+#ifndef WIN32
+	if (silent_exec_failure) {
+		/* Restore signal handlers */
+		signal(SIGINT, sigint);
+		signal(SIGQUIT, sigquit);
+	}
+#endif
 	if (waiting < 0) {
 		failed_errno = errno;
 		error("waitpid for %s failed: %s", argv0, strerror(errno));
@@ -202,8 +213,16 @@ fail_pipe:
 		notify_pipe[0] = notify_pipe[1] = -1;
 
 	fflush(NULL);
+	if (cmd->silent_exec_failure) {
+		sigint = signal(SIGINT, SIG_IGN);
+		sigquit = signal(SIGQUIT, SIG_IGN);
+	}
 	cmd->pid = fork();
 	if (!cmd->pid) {
+		if (cmd->silent_exec_failure) {
+			signal(SIGINT, sigint);
+			signal(SIGQUIT, sigquit);
+		}
 		/*
 		 * Redirect the channel to write syscall error messages to
 		 * before redirecting the process's stderr so that all die()
-- 
1.7.3.1
