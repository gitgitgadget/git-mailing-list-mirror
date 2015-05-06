From: Stephen Robin <stephen.robin@gmail.com>
Subject: [PATCH 2/6] merge: move error message given when a merge needs committing to advice.c
Date: Wed,  6 May 2015 01:00:49 +0100
Message-ID: <1430870453-5408-3-git-send-email-stephen.robin@gmail.com>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
 <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Cc: git@vger.kernel.org
To: pyokagan@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 02:01:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypmlu-0004Wn-3d
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 02:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993AbbEFAA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 20:00:56 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34161 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbbEFAAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 20:00:53 -0400
Received: by wicmx19 with SMTP id mx19so112945643wic.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hX+GvMH2Ggkel5IIMenZFTCpjEbux8dv501giZL0yHI=;
        b=Ju0ThzwLQteTRkZBjmzypJCQV7goH/Jr4p5uPYpm0JCDhWlRlvFtjLMh0f/UasXd66
         yExXlUkugMP6EWN4A1pJ8xKXpTlewkqfM1jm8nDRTousbBBkAJR7hTphxmmZONl15OUR
         gyz1WDRcw+mXki6tjszXP0o3s1R+owyzOgBRxML7Sc06NzohcEQ+Lj6jE8eWPkBkBF2f
         3tXnk8/34n0gZocCIOgW0AhM66YSJpF5znB2u8cjMAw7obToJ47lrJFT8tS1CmezFPGR
         fo3ch7QTtFZ8gqPHagp0djyRAyhdtcvd/VPMpyTM9jw52tYeWwMCqj4Vde7pZZmJ+/j4
         JXHg==
X-Received: by 10.194.81.169 with SMTP id b9mr54806565wjy.126.1430870451968;
        Tue, 05 May 2015 17:00:51 -0700 (PDT)
Received: from localhost ([141.0.152.225])
        by mx.google.com with ESMTPSA id e10sm419308wij.11.2015.05.05.17.00.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 17:00:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.7.gf20f26f
In-Reply-To: <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268434>

THIS PATCH SERIES IS NOT CODE-COMPLETE OR FULLY TESTED.
See code comments beginning TODO for work remaining.

This will allow the message to be re-used in other places.

Signed-off-by: Stephen Robin <stephen.robin@gmail.com>
---
 advice.c        | 9 +++++++++
 advice.h        | 1 +
 builtin/merge.c | 6 +-----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/advice.c b/advice.c
index 575bec2..747792e 100644
--- a/advice.c
+++ b/advice.c
@@ -96,6 +96,15 @@ void NORETURN die_resolve_conflict(const char *me)
 	die("Exiting because of an unresolved conflict.");
 }
 
+void NORETURN die_merge_in_progress()
+{
+	if (advice_resolve_conflict)
+		die(_("You have not concluded your merge (MERGE_HEAD exists).\n"
+		"Please, commit your changes before you merge."));
+	else
+		die(_("You have not concluded your merge (MERGE_HEAD exists)."));
+}
+
 void detach_advice(const char *new_name)
 {
 	const char fmt[] =
diff --git a/advice.h b/advice.h
index 5ecc6c1..75c261a 100644
--- a/advice.h
+++ b/advice.h
@@ -24,6 +24,7 @@ __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
+extern void NORETURN die_merge_in_progress();
 void detach_advice(const char *new_name);
 
 #endif /* ADVICE_H */
diff --git a/builtin/merge.c b/builtin/merge.c
index d6b0579..45d93bb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1134,11 +1134,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * There is no unmerged entry, don't advise 'git
 		 * add/rm <file>', just 'git commit'.
 		 */
-		if (advice_resolve_conflict)
-			die(_("You have not concluded your merge (MERGE_HEAD exists).\n"
-				  "Please, commit your changes before you merge."));
-		else
-			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
+		die_merge_in_progress();
 	}
 	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		if (advice_resolve_conflict)
-- 
2.4.0.7.gf20f26f
