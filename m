From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 2/2] add NORETURN_PTR for function pointers
Date: Wed, 30 Sep 2009 18:05:50 +0000
Message-ID: <1254333950-2440-2-git-send-email-kusmabite@gmail.com>
References: <1254333950-2440-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, gitster@pobox.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 20:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt3ZK-0005LM-LY
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 20:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbZI3SGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 14:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbZI3SGK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 14:06:10 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:43097 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbZI3SGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 14:06:09 -0400
Received: by mail-bw0-f210.google.com with SMTP id 6so3012031bwz.37
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ugg07+9sBZTy5/wKl2JQwx/QCDbWxd95EqokaMPvBrU=;
        b=TXOxBuBxJrR7DIkiIazQltFFVqj61w7yZC4+NhIFrXVgUc2rycLe9IgIs+vw+i5SEY
         syYsy1FCT7aGzXSHNrHuApj8LrL2amxXE+FvcxEjWEDrnuC+4ge0/hOVHL+Cwm/pK24B
         7s4dsQLLeHmoFXKfKm/hR5KKwH80bTBkFcS5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DG7sVeiox8QGecyhxCDtRylJNOilSG+zgDwDI+jKitU/X/gZ9WEBbxqP9doxSa1qYR
         5wIgqPyuUfIE+H8kSwIcm/njJ5UcdbdCuiltB0Co+WvpQtx4L3SdiEzn/+XiVAN7i9LL
         MNbDXn0GOdOehY+Y+6LS21Kw9dZNM3D1sRZbM=
Received: by 10.204.24.2 with SMTP id t2mr99780bkb.65.1254333973138;
        Wed, 30 Sep 2009 11:06:13 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 22sm200398fkq.30.2009.09.30.11.06.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 11:06:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1254333950-2440-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129347>

Some compilers (including at least MSVC and ARM RVDS) supports
NORETURN on function declarations, but not on function pointers.

This patch makes it possible to define NORETURN for these compilers,
by splitting the NORETURN macro into two - one for function
declarations and one for function pointers.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 git-compat-util.h |    4 +++-
 usage.c           |    6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 33dd4f3..ac7cc66 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -169,8 +169,10 @@ extern char *gitbasename(char *);
 
 #ifdef __GNUC__
 #define NORETURN __attribute__((__noreturn__))
+#define NORETURN_PTR __attribute__((__noreturn__))
 #else
 #define NORETURN
+#define NORETURN_PTR
 #ifndef __attribute__
 #define __attribute__(x)
 #endif
@@ -183,7 +185,7 @@ extern NORETURN void die_errno(const char *err, ...) __attribute__((format (prin
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
-extern void set_die_routine(NORETURN void (*routine)(const char *err, va_list params));
+extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
 extern time_t tm_to_time_t(const struct tm *tm);
diff --git a/usage.c b/usage.c
index 0555ce6..c488f3a 100644
--- a/usage.c
+++ b/usage.c
@@ -36,12 +36,12 @@ static void warn_builtin(const char *warn, va_list params)
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
-static NORETURN void (*usage_routine)(const char *err) = usage_builtin;
-static NORETURN void (*die_routine)(const char *err, va_list params) = die_builtin;
+static NORETURN_PTR void (*usage_routine)(const char *err) = usage_builtin;
+static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 
-void set_die_routine(NORETURN void (*routine)(const char *err, va_list params))
+void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params))
 {
 	die_routine = routine;
 }
-- 
1.6.4.msysgit.0.17.g82372.dirty
