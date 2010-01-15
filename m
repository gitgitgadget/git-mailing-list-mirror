From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 05/14] mingw: support waitpid with pid > 0 and WNOHANG
Date: Fri, 15 Jan 2010 22:30:24 +0100
Message-ID: <1263591033-4992-6-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jan 15 22:31:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtlM-0005cC-AQ
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758379Ab0AOVbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758377Ab0AOVbW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:31:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:26410 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758375Ab0AOVbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:31:21 -0500
Received: by ey-out-2122.google.com with SMTP id d26so192529eyd.19
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 13:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RBiFuVaGv6MCdIalDxlwRMtyg1f8ts0mHknS3gF+GV0=;
        b=b04VBQuiPm/zJIJdJa6ryRFaQEdHpdcCxd12hYo2R/nhjY62kzbivlmCVZeXmbu6IQ
         FzDcqGI9sJ4EA1uRk1KhcuQwypzeGOaOI4/MrDE7XZlJhFlcStFvORGuzHivTW6TRLmo
         Fh40yc7iVdTGy/ATrGa9MZC6+8iFLdXMEYZiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R1zlOrD3NAASMOE+pVmGcMUmiKCEZuDUrlogLWSF2BkQz6WV3XfX7LpZGYO7x6587E
         nz6vfP0o/7Vid4gCCTS8nezgOjK2vk0CthtIiVqq8rjJk5Z16ZSKrnDYmqknDe8gp/XQ
         MvH3foL+S6zizGT97sdzq8oOJzC9CHSuEwqXw=
Received: by 10.213.42.6 with SMTP id q6mr232563ebe.10.1263591079125;
        Fri, 15 Jan 2010 13:31:19 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 16sm1805638ewy.10.2010.01.15.13.31.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:18 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137122>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index d934e56..3005472 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -134,8 +134,15 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
+#define WNOHANG 1
 static inline int waitpid(pid_t pid, int *status, unsigned options)
 {
+	if (pid > 0 && options & WNOHANG) {
+		if (WAIT_OBJECT_0 != WaitForSingleObject((HANDLE)pid, 0))
+			return 0;
+		options &= ~WNOHANG;
+	}
+
 	if (options == 0)
 		return _cwait(status, pid, 0);
 	errno = EINVAL;
-- 
1.6.6.211.g26720
