From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 1/2] usage: Introduce error_errno corresponding to die_errno
Date: Sun,  8 May 2011 13:00:50 +0530
Message-ID: <1304839851-6477-2-git-send-email-artagnon@gmail.com>
References: <7vr58b22ny.fsf@alter.siamese.dyndns.org>
 <1304839851-6477-1-git-send-email-artagnon@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 09:31:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIySY-0003lW-AP
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 09:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab1EHHbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 03:31:17 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17570 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1EHHbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 03:31:00 -0400
X-IronPort-AV: E=Sophos;i="4.64,334,1301875200"; 
   d="scan'208";a="430224119"
Received: from smtp-in-0102.sea3.amazon.com ([10.224.19.46])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2011 07:30:59 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0102.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p487Uvce000419;
	Sun, 8 May 2011 07:30:57 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id A948875481F; Sun,  8 May 2011 13:00:51 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1304839851-6477-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173075>

The error function always returns the constant value -1, and this does
not convey enough information about the nature of the error.  This
patch introduces a new function error_errno that functions exactly
like the error function, except that it returns `errorno` instead of a
constant value.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Is "-errno" correct? This will determine how error-handling will be
 in a more libified version of Git, and I think it's important to get
 this right.

 git-compat-util.h |    1 +
 usage.c           |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 40498b3..7b82038 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -241,6 +241,7 @@ extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf,
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
diff --git a/usage.c b/usage.c
index b5e67e3..c89efcc 100644
--- a/usage.c
+++ b/usage.c
@@ -107,6 +107,16 @@ int error(const char *err, ...)
 	return -1;
 }
 
+int error_errno(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	error_routine(err, params);
+	va_end(params);
+	return -errno;
+}
+
 void warning(const char *warn, ...)
 {
 	va_list params;
-- 
1.7.5.GIT
