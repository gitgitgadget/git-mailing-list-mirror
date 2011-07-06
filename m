From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/14] advice: Introduce error_resolve_conflict
Date: Wed,  6 Jul 2011 07:54:15 +0000
Message-ID: <1309938868-2028-2-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwP-0005pA-52
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab1GFHyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:33 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43982 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab1GFHyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:32 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3221737qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CLkTNeNiAnwNovTNIdHQjnn4V0V6PwhbWM8PHmOGAI8=;
        b=F/kErrg3vQZd4yLhu9Dr9nW8E1SzS6OuhyjloEHBq+Au+p3AeEWmzhmyPTgiFF9V+t
         BfUboAwlF9vaG6RoJwgN5QhU0zW++XOsrNj2fL0yFVJ0N5lsnoEEGMYHOojf67/xORhK
         lyHB9hlQBCXhUvTuCUf/w6ZeNyRvvvNQAHPto=
Received: by 10.229.8.138 with SMTP id h10mr5945160qch.105.1309938871945;
        Wed, 06 Jul 2011 00:54:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176648>

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
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 advice.c |   31 ++++++++++++++++++++++++-------
 advice.h |    1 +
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/advice.c b/advice.c
index 0be4b5f..a031732 100644
--- a/advice.c
+++ b/advice.c
@@ -19,6 +19,15 @@ static struct {
 	{ "detachedhead", &advice_detached_head },
 };
 
+static void advise(const char *advice, ...)
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
+		advise("Please, fix them up in the work tree,");
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
index 3244ebb..f537366 100644
--- a/advice.h
+++ b/advice.h
@@ -12,6 +12,7 @@ extern int advice_detached_head;
 
 int git_default_advice_config(const char *var, const char *value);
 
+int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
 
 #endif /* ADVICE_H */
-- 
1.7.5.GIT
