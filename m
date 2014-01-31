From: Benoit Sigoure <tsunanet@gmail.com>
Subject: [PATCH] Cleanly redefine (v)snprintf when needed.
Date: Thu, 30 Jan 2014 22:25:12 -0800
Message-ID: <1391149512-8705-1-git-send-email-tsunanet@gmail.com>
Cc: Benoit Sigoure <tsunanet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 07:26:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W97Yr-0003fx-Cz
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 07:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbaAaG0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 01:26:41 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:52972 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaAaG0k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 01:26:40 -0500
Received: by mail-qc0-f169.google.com with SMTP id w7so6584094qcr.0
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 22:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=A/hv3YKzOXFD52fifcQSqgodjjEFyMaue/1/UEnTCm0=;
        b=v1u6XVsAdjevN1REV5vgvKQ6SROaz7BPuirP+FTp/zjhM6jim0IDXD+BKovJxq3Kri
         usLFvRHgP6p87tky+PZeLHxbDSsFLk4AlVpoOpH+vZZrMnMz/fsaHDIKBm/oBanvaZwF
         JTzqrzkbhWpLSBxJbxxhR/6LeD2y9f+l4z8Eafv+ff6l0WYUxf7nC3rgZ0grL5CPRdY0
         2rvjBFrHE5/lilbNtuO5r1hkbEPDfYWsIih714OQLQtVmrkDsirjtMD4nnqrv355KdhO
         zscB0/kSO8ptyUE3bLNUEBb4rkDia7UpftxgV8+6J4/04ZhT96Ce8aXXg/Frrv309dzA
         FFPw==
X-Received: by 10.140.30.66 with SMTP id c60mr27054974qgc.13.1391149600295;
        Thu, 30 Jan 2014 22:26:40 -0800 (PST)
Received: from magrathea.tsunanet.net (magrathea.tsunanet.net. [142.4.212.106])
        by mx.google.com with ESMTPSA id w7sm24402288qaj.23.2014.01.30.22.26.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 22:26:39 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241293>

When we detect that vsnprintf / snprintf are broken, we #define them to
an alternative implementation.  On OS X, stdio.h already #define's them,
which causes a warning to be issued at the point we re-define them in
`git-compat-util.h'.
---
 git-compat-util.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..614a5e9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -480,9 +480,15 @@ extern FILE *git_fopen(const char*, const char*);
 #endif
 
 #ifdef SNPRINTF_RETURNS_BOGUS
+#ifdef snprintf
+#undef snprintf
+#endif
 #define snprintf git_snprintf
 extern int git_snprintf(char *str, size_t maxsize,
 			const char *format, ...);
+#ifdef vsnprintf
+#undef vsnprintf
+#endif
 #define vsnprintf git_vsnprintf
 extern int git_vsnprintf(char *str, size_t maxsize,
 			 const char *format, va_list ap);
-- 
1.9.rc1.1.g186f0be.dirty
