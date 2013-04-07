From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 3/6] format-patch: refactor branch name calculation
Date: Sun,  7 Apr 2013 12:46:21 -0500
Message-ID: <1365356784-24872-4-git-send-email-felipe.contreras@gmail.com>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 19:48:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOthE-0003ap-2P
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934202Ab3DGRr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:47:56 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:43595 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934156Ab3DGRrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:47:55 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so5452231oag.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=X+7r8jph2hFQfv1r4RgzOSVciqcMpZuiLafkbXJBWmo=;
        b=fl04q4ZzonjrFAbyFntAe4dlxXg7bpn24GTocw/Dbb4mVx3nlhC5IiAqjxx8gHDL4L
         /az7z1zzT/JDzLqqOzQA6b9uQd35HYSnvssKZqYF2tmqCAwPi5nGIJrJTv9t4uYnVmGs
         RlfzzSFn6vNDy6cRCqnq69jvJ1pe8SrA5I9N5V+oTwu+3T8oPIyrCcxAPsB942CI+v7B
         +p1ejMURbYTyWp4qhc2y4HYg/T/W/OrlKfWFKh5WoSUycT8I6OdcpSzjWlguudznvZay
         PI+I7FvGTqBR3KgrlPCT53ys2hfBuqhkw5v/IHI+wszyVUaiSU9hfzQDLT/tg3SSTWpn
         X8XQ==
X-Received: by 10.182.45.231 with SMTP id q7mr13291204obm.58.1365356874124;
        Sun, 07 Apr 2013 10:47:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 4sm20669362obj.7.2013.04.07.10.47.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 10:47:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220343>

By moving the part that relies on rev->pending earlier, where we are
already checking the special case where there's only one ref.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/log.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e0c8b6f..cd942ee 100644
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
