From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/10] advice: Introduce error_resolve_conflict
Date: Thu, 26 May 2011 15:53:44 +0000
Message-ID: <1306425233-504-2-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcsv-0001Db-8B
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab1EZPyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:54:00 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62865 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab1EZPx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:53:59 -0400
Received: by qwk3 with SMTP id 3so441172qwk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=/uspFwYO1R6qphHkD4iAtIFRAPHg4RI9Xb3IX/0nB0c=;
        b=mF4+McKqFy0DkpCAwX4Ir0loVdfQilhNtdximcg4dcTe4s4D0ZH4fEBdzdRWd964og
         gwKpl3UfhK1WEGr65Kq4K54F6dIMp7GeBQZy3LVXx0ELiDG+twLfhd86pOnPATajKHtz
         ZXH2j4JRJ+alObuCfBSKV/5euwXRTHCSV3wcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bU+OWBG0xcGqkwzjG86PYTSVkLSEf4f6P2i6Te7j2E0b2qcmxdS03dPgJVoiuxSa5G
         9MOl22X418R5s0ukORkBZvajwkaC3JDqNjN17VHxr3UYDV9pRpY7La6R4HngUjgpRerr
         GB4NKIv/Jkor4JKt8LeAh6bmAmGp5Xh54Rwb8=
Received: by 10.224.197.132 with SMTP id ek4mr672509qab.382.1306425238502;
        Thu, 26 May 2011 08:53:58 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.53.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:53:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174527>

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
