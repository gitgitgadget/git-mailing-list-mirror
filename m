From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/17] advice: Introduce error_resolve_conflict
Date: Mon, 11 Jul 2011 14:53:52 +0000
Message-ID: <1310396048-24925-2-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHsJ-000517-Iz
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757737Ab1GKOyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:15 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46637 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab1GKOyO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:14 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so2716724vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DtJrs2IYHgMJIAqsFplSwLKalz4W2kLeVIpHwHZPce8=;
        b=hUBre2s4IJKzz+XyUapFvc2eWvMWy/a61bSl6pzRTaIf4Q1yN1BQUCmz+THm2R4uCy
         h7MmdDyIUIN0k8HV+mP6TNdZt+kV8551QxOQNJZCQMfOfiKRKRGfLqTY9SlKpql4jOUE
         eozVVXGA2hWEek/+qFvn2yWKLrNmqCK52/S8M=
Received: by 10.52.117.235 with SMTP id kh11mr2372718vdb.423.1310396053956;
        Mon, 11 Jul 2011 07:54:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176843>

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
index 0be4b5f..a6b3fc2 100644
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
1.7.5.GIT
