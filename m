From: Benoit Sigoure <tsunanet@gmail.com>
Subject: [PATCH] Cleanly redefine (v)snprintf when needed.
Date: Fri, 31 Jan 2014 09:36:28 -0800
Message-ID: <1391189788-15130-1-git-send-email-tsunanet@gmail.com>
References: <xmqqy51wgiwd.fsf@gitster.dls.corp.google.com>
Cc: gitster@pobox.com, Benoit Sigoure <tsunanet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 18:37:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9I2C-0001Z7-B3
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 18:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbaAaRhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 12:37:37 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:60589 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558AbaAaRhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 12:37:31 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so7671934qcy.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Hf+K1YiVE/lcaLuJFlXst9RQAhjQfWN1cze0kvMQic=;
        b=K756WFLS8WZB1yXaVK9Lc+wH5bTTa7CkHzGAC4jQqBklk+rdXeksuJRN7a2lFJPUvG
         WUDfyp+MoAN8F8UuOeYy1yPcXJJ6rWdG79RVvIhfnzPpjwijyEfpLkbFJZns3HFMzUy8
         Skxot7exp76l/lDoqKzKTYDkNjhpPu44Qz7gAkL6jIsZI15ixXqrjGCvuD2US6eQYO7g
         X+xA+CsBPqJkpywJunaw5jU/KGXZ/D1g4Kj06u6/zGoGEsRfrACZmyqgH/NAg+XoVa0a
         kSw66WUIdClz3CutK7pDE3EWFBz41FgKBZQ5f32FlCTCCHwgsp87mTLSmlxsGoD0har0
         ePkA==
X-Received: by 10.229.193.136 with SMTP id du8mr554507qcb.11.1391189851080;
        Fri, 31 Jan 2014 09:37:31 -0800 (PST)
Received: from magrathea.tsunanet.net (magrathea.tsunanet.net. [142.4.212.106])
        by mx.google.com with ESMTPSA id u4sm28859706qai.21.2014.01.31.09.37.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 09:37:30 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <xmqqy51wgiwd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241309>

When we detect that vsnprintf / snprintf are broken, we #define them to
an alternative implementation.  On OS X, stdio.h already #define's them,
which causes a warning to be issued at the point we re-define them in
`git-compat-util.h'.

Signed-off-by: Benoit Sigoure <tsunanet@gmail.com>
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
