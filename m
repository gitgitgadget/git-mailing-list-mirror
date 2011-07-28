From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/18] advice: Introduce error_resolve_conflict
Date: Thu, 28 Jul 2011 22:22:14 +0530
Message-ID: <1311871951-3497-2-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTtK-00049i-U2
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab1G1Q4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:56:50 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab1G1Q4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:56:48 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so3015481iyb.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1Y+Ow/+11X8K58gVxAlVM4EcIQEKcIl0PhinAZX6CEs=;
        b=mN9NcJT3fLEiGi4pI1hRt78Vdf7lrqY+J7mV+s0L04ZeeIrOJ84vkYuoVFvyXeEXHD
         tg6jMUZHlfnTRUK822UUcUecNoGZWmUHY99OSv3RwlsMCPX0GI1yD77IyC7ndbX0jmdD
         bjSiTjUZEzzuAuCjt/Ng3EWZBg4q2THu3qN1o=
Received: by 10.42.168.5 with SMTP id u5mr138620icy.510.1311872140488;
        Thu, 28 Jul 2011 09:55:40 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.55.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:55:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178093>

Enable future callers to report a conflict and not die immediately by
introducing a new function called error_resolve_conflict.
Re-implement die_resolve_conflict as a call to error_resolve_conflict
followed by a call to die.  Consequently, the message printed by
die_resolve_conflict changes from

  fatal: 'commit' is not possible because you have unmerged files.
         Please, fix them up in the work tree ...
         ...

to

  error: 'commit' is not possible because you have unmerged files.
  hint: Fix them up in the work tree ...
  hint: ...
  fatal: Exiting because of an unresolved conflict.

Hints are printed using the same advise function introduced in
v1.7.3-rc0~26^2~3 (Introduce advise() to print hints, 2010-08-11).

Inspired-by: Christian Couder <chistian.couder@gmail.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 advice.c         |   31 ++++++++++++++++++++++++-------
 advice.h         |    3 ++-
 builtin/revert.c |    9 ---------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/advice.c b/advice.c
index 0be4b5f..e02e632 100644
--- a/advice.c
+++ b/advice.c
@@ -19,6 +19,15 @@ static struct {
 	{ "detachedhead", &advice_detached_head },
 };
 
+void advise(const char *advice, ...)
+{
+	va_list params;
+
+	va_start(params, advice);
+	vreportf("hint: ", advice, params);
+	va_end(params);
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k = skip_prefix(var, "advice.");
@@ -34,16 +43,24 @@ int git_default_advice_config(const char *var, const char *value)
 	return 0;
 }
 
-void NORETURN die_resolve_conflict(const char *me)
+int error_resolve_conflict(const char *me)
 {
-	if (advice_resolve_conflict)
+	error("'%s' is not possible because you have unmerged files.", me);
+	if (advice_resolve_conflict) {
 		/*
 		 * Message used both when 'git commit' fails and when
 		 * other commands doing a merge do.
 		 */
-		die("'%s' is not possible because you have unmerged files.\n"
-		    "Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
-		    "appropriate to mark resolution and make a commit, or use 'git commit -a'.", me);
-	else
-		die("'%s' is not possible because you have unmerged files.", me);
+		advise("Fix them up in the work tree,");
+		advise("and then use 'git add/rm <file>' as");
+		advise("appropriate to mark resolution and make a commit,");
+		advise("or use 'git commit -a'.");
+	}
+	return -1;
+}
+
+void NORETURN die_resolve_conflict(const char *me)
+{
+	error_resolve_conflict(me);
+	die("Exiting because of an unresolved conflict.");
 }
diff --git a/advice.h b/advice.h
index 3244ebb..e5d0af7 100644
--- a/advice.h
+++ b/advice.h
@@ -11,7 +11,8 @@ extern int advice_implicit_identity;
 extern int advice_detached_head;
 
 int git_default_advice_config(const char *var, const char *value);
-
+void advise(const char *advice, ...);
+int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
 
 #endif /* ADVICE_H */
diff --git a/builtin/revert.c b/builtin/revert.c
index 1f27c63..2df3f3b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -214,15 +214,6 @@ static void write_cherry_pick_head(void)
 	strbuf_release(&buf);
 }
 
-static void advise(const char *advice, ...)
-{
-	va_list params;
-
-	va_start(params, advice);
-	vreportf("hint: ", advice, params);
-	va_end(params);
-}
-
 static void print_advice(void)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
-- 
1.7.4.rc1.7.g2cf08.dirty
