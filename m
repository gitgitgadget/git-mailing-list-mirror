From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 06/16] mingw: support waitpid with pid > 0 and WNOHANG
Date: Thu,  4 Nov 2010 02:35:14 +0100
Message-ID: <1288834524-2400-7-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:36:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDoku-0001ds-1I
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab0KDBf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:56 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57379 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab0KDBfk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:40 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so738633ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1aBUNC2vxtLN/sVkaXDLnlNvTxIQbtn0Judiswf1n2k=;
        b=gl4aHbgYavTnY9LQ7smXijUyp4VfImp86Q5DoYZJi86iCE4wwQTxxoTdk4hHX3WqBq
         7AnudTZdTkefiwN7E/bKu8sfhzp2j8vUZzUnoODJuUm/ZZI1Wb76UwlP83bILjmFIIYz
         5FOM2G72E0MLf9hf0AeUGPkkVbjSYx8nL1ZhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=avpfCT+G8pRCWPPxGSSI76a+qvj1ckuRkS6PQ8ZX1PEGzJ/zh2ly+daV3sAkMvuKO3
         CgCdhRMBAOLRhUeHR+BbNfO5q3ozI/iNFQtK7MVr+bBzCrBqiFb+6N7qH4VoxZaF/xT0
         gDlyvjSMuM7ifyIlCTUR3UCKOJXMuSzl9MMcs=
Received: by 10.14.47.78 with SMTP id s54mr40415eeb.19.1288834539417;
        Wed, 03 Nov 2010 18:35:39 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm7188017eeh.0.2010.11.03.18.35.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160673>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    8 ++++++++
 compat/mingw.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 736d03f..47a0e88 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1554,6 +1554,14 @@ pid_t waitpid(pid_t pid, int *status, unsigned options)
 		return -1;
 	}
 
+	if (pid > 0 && options & WNOHANG) {
+		if (WAIT_OBJECT_0 != WaitForSingleObject(h, 0)) {
+			CloseHandle(h);
+			return 0;
+		}
+		options &= ~WNOHANG;
+	}
+
 	if (options == 0) {
 		struct pinfo_t **ppinfo;
 		if (WaitForSingleObject(h, INFINITE) != WAIT_OBJECT_0) {
diff --git a/compat/mingw.h b/compat/mingw.h
index 7c4eeea..379d7bf 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -140,6 +140,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
+#define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
 #ifndef NO_OPENSSL
-- 
1.7.3.2.162.g09d37
