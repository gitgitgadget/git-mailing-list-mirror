From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/4] format-patch: refactor branch name calculation
Date: Sun,  7 Apr 2013 01:10:29 -0600
Message-ID: <1365318630-11882-4-git-send-email-felipe.contreras@gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:11:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOjlO-0000Ky-U9
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868Ab3DGHLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:11:39 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:42292 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab3DGHLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:11:38 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so5303406oag.36
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=PRNowMYr/HL3xgG76mZzQ4Xn0KBG43mz+GzPh+0ldis=;
        b=HlCEYefEyDh+BYmwYifphvU4lhO9TDHePlOHwBQ2f6QPb+2fHQ11efnnO3fEwTdjJJ
         TXCs7ifvtrVNJbXtF/F2RljlEfvb3cLNLxT33BHaGVuYlty66GsvsvfoBBYPZJOfDy9J
         WJ5Iswh8EhQnQ6A3buWFL9XUMBSfQdvTRiLVYfnBHKV+XQulAm4AdlO+Yu+hgYNknQCX
         TNtC/y7xFzds+oAmLv39oNjfcE4/emVwoUgHoCLJiECelTA6yW0AsE1k7wgHcurETdzP
         uiH4xJlq2KYkdbfKrvYZEFC/2o6IIfI/WLry7lcVHi9B8kP2j5mNu5a0DkGKjMO3jvWj
         mpRw==
X-Received: by 10.182.106.102 with SMTP id gt6mr12286089obb.37.1365318697858;
        Sun, 07 Apr 2013 00:11:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id qj8sm1774736oeb.2.2013.04.07.00.11.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:11:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220285>

By moving the part that relies on rev->pending earlier, where we are
already checking the special case where there's only one ref.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/log.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6c78d7f..e4fb3c8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1049,15 +1049,6 @@ static char *find_branch_name(struct rev_info *rev)
 	if (0 <= positive) {
 		ref = rev->cmdline.rev[positive].name;
 		tip_sha1 = rev->cmdline.rev[positive].item->sha1;
-	} else if (!rev->cmdline.nr && rev->pending.nr == 1 &&
-		   !strcmp(rev->pending.objects[0].name, "HEAD")) {
-		/*
-		 * No actual ref from command line, but "HEAD" from
-		 * rev->def was added in setup_revisions()
-		 * e.g. format-patch --cover-letter -12
-		 */
-		ref = "HEAD";
-		tip_sha1 = rev->pending.objects[0].item->sha1;
 	} else {
 		return NULL;
 	}
@@ -1288,28 +1279,36 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (rev.pending.nr == 1) {
+		int check_head = 0;
+
 		if (rev.max_count < 0 && !rev.show_root_diff) {
 			/*
 			 * This is traditional behaviour of "git format-patch
 			 * origin" that prepares what the origin side still
 			 * does not have.
 			 */
-			unsigned char sha1[20];
-			const char *ref;
-
 			rev.pending.objects[0].item->flags |= UNINTERESTING;
 			add_head_to_pending(&rev);
-			ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
-			if (ref && !prefixcmp(ref, "refs/heads/"))
-				branch_name = xstrdup(ref + strlen("refs/heads/"));
-			else
-				branch_name = xstrdup(""); /* no branch */
+			check_head = 1;
 		}
 		/*
 		 * Otherwise, it is "format-patch -22 HEAD", and/or
 		 * "format-patch --root HEAD".  The user wants
 		 * get_revision() to do the usual traversal.
 		 */
+
+		if (!strcmp(rev.pending.objects[0].name, "HEAD"))
+			check_head = 1;
+
+		if (check_head) {
+			unsigned char sha1[20];
+			const char *ref;
+			ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			if (ref && !prefixcmp(ref, "refs/heads/"))
+				branch_name = xstrdup(ref + strlen("refs/heads/"));
+			else
+				branch_name = xstrdup(""); /* no branch */
+		}
 	}
 
 	/*
-- 
1.8.2
