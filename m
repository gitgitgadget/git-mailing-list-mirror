From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/18] advice: Introduce error_resolve_conflict
Date: Wed, 27 Jul 2011 08:48:58 +0530
Message-ID: <1311736755-24205-2-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QluhX-0005s7-RI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab1G0DWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:22:24 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1G0DWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:22:23 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ppmZveV72ludj0XpcX/T/MNA0+ocbzrxVj+R6bhjFcw=;
        b=R6+6Gb5RRqQNUA/x/cUy6KpUfOQRp18FWkN44hkpc9kfQP1/Ty89moOjw8TlvNre/x
         K92qyyJG3RR9WjTuIeaeP45S49FHCT1dWoT+x8Wy8AqzomLVMkA+mlvfjCF3VbFJh5Vu
         ITGgWVr0gtSiPERns4HLRDIJmnl4af1Ga1X+I=
Received: by 10.68.30.134 with SMTP id s6mr11155909pbh.364.1311736942623;
        Tue, 26 Jul 2011 20:22:22 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.22.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:22:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177905>

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
hint: Please, fix them up in the work tree ...
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
