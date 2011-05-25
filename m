From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/10] advice: Introduce error_resolve_conflict
Date: Wed, 25 May 2011 14:16:56 +0000
Message-ID: <1306333025-29893-2-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEtr-0003Uq-PS
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380Ab1EYORP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:15 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36798 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973Ab1EYORK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:10 -0400
Received: by mail-qy0-f174.google.com with SMTP id 7so2121342qyk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=/uspFwYO1R6qphHkD4iAtIFRAPHg4RI9Xb3IX/0nB0c=;
        b=Spakq12ikzzuyYBrEtZcsFz9CILV4qKn9cbuRDY6AqDyMNbrvagLu7pRzY3u6as3+9
         qQjEPxqsQv9ACp1/U2Kjvl4RWwyJPOvfKu1bz5N9ml/ycpCO1Po0o3NTUW2VWmrGbeRz
         3ZAqt6QVeT04sneBudpg8FXdmNOGUXuss8hGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g/7RnBn2NU5+2hezSjObdvkfGj/20whJU6lhJMeUpRV7lgI5rmwrH3mdKVkoacGKZ6
         +n+uOpB66UutopL6n7XMCLaGRxaPY/nMScq8am9JR1yG5ymR4aHtZNYFNG8TOMornPMR
         8xJqrqkzJO8KgQ9im3z4y00hU7YMz0pcJpoFE=
Received: by 10.224.216.6 with SMTP id hg6mr3976090qab.186.1306333029919;
        Wed, 25 May 2011 07:17:09 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174394>

Introduce error_resolve_conflict corresponding to
die_resolve_conflict, and implement the latter function in terms of
the former.

Based-on-patch-by: Christian Couder <chistian.couder@gmail.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 advice.c |   17 +++++++++++------
 advice.h |    1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index 0be4b5f..80aaa14 100644
--- a/advice.c
+++ b/advice.c
@@ -34,16 +34,21 @@ int git_default_advice_config(const char *var, const char *value)
 	return 0;
 }
 
-void NORETURN die_resolve_conflict(const char *me)
+int error_resolve_conflict(const char *me)
 {
 	if (advice_resolve_conflict)
 		/*
 		 * Message used both when 'git commit' fails and when
 		 * other commands doing a merge do.
 		 */
-		die("'%s' is not possible because you have unmerged files.\n"
-		    "Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
-		    "appropriate to mark resolution and make a commit, or use 'git commit -a'.", me);
-	else
-		die("'%s' is not possible because you have unmerged files.", me);
+		return error("'%s' is not possible because you have unmerged files.\n"
+			"Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
+			"appropriate to mark resolution and make a commit, or use 'git commit -a'.", me);
+	return error("'%s' is not possible because you have unmerged files.", me);
+}
+
+void NORETURN die_resolve_conflict(const char *me)
+{
+	error_resolve_conflict(me);
+	exit(128);
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
