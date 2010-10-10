From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 06/14] mingw: support waitpid with pid > 0 and WNOHANG
Date: Sun, 10 Oct 2010 15:20:46 +0200
Message-ID: <1286716854-5744-7-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vr4-0004u7-6d
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757688Ab0JJNWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:22:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab0JJNWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:22:15 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NsKoJ4OxDQzXWjiWT6ee+wq97IwXbA0LVGcAOUZW9fI=;
        b=AyRnrkuzLYG1PlaSmvWvlrxVicT9Vuz79fgzlG8jnJEoDhpNgtPohUs/d8KVlpWMCU
         WmnfRlShbWae/yB1BPak7UBKjEM56nE6Z8SwSe5PsdTRkk4WhwunpuUQoW1wXu+etbBh
         E0Ktm8O/FLml3/FkStYGB86lN1WilOL00oEx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XfYfX6ySs/7GtGR+9Ke4hDKQlNQYWMOqhXqxp1mBcNnOGbvAPJD07XwKSh+zW6JJQA
         CaRfsJRSm/vBQohj3VbEUCEgWJZolzAxFo6oOgCbBGNKabsfvDhkvC7HIf0+2Vyh96vp
         a6oC9ax47XDTi/LyDYAksfY1TptGLg72QsNj4=
Received: by 10.213.27.142 with SMTP id i14mr2705346ebc.1.1286716934926;
        Sun, 10 Oct 2010 06:22:14 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q54sm5194744eeh.12.2010.10.10.06.22.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:22:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158664>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    6 ++++++
 compat/mingw.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4582345..55ea250 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1609,6 +1609,12 @@ pid_t waitpid(pid_t pid, int *status, unsigned options)
 		return -1;
 	}
 
+	if (pid > 0 && options & WNOHANG) {
+		if (WAIT_OBJECT_0 != WaitForSingleObject((HANDLE)pid, 0))
+			return 0;
+		options &= ~WNOHANG;
+	}
+
 	if (options == 0) {
 		int i;
 		if (WaitForSingleObject(h, INFINITE) != WAIT_OBJECT_0) {
diff --git a/compat/mingw.h b/compat/mingw.h
index 96ed931..6d7a3f6 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -153,6 +153,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
+#define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
 #ifndef NO_OPENSSL
-- 
1.7.3.1.51.ge462f.dirty
