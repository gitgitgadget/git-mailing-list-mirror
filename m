From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 46/48] merge-recursive: Have conflict_rename_delete reuse modify/delete code
Date: Wed,  8 Jun 2011 01:31:16 -0600
Message-ID: <1307518278-23814-47-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEm-0006q0-AI
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab1FHHad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:33 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1FHHa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:27 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BpeFan0i3oBSllP0GZ+xQc/bUPXxaZIKpiGQNea3lUk=;
        b=HqBLWnSXGA9j1SGpOiJmmkWr8MqTi7TIhy8uUmF9cwjn1hWUPROxHJEi+nvDB2jRxr
         DUwW88n2et1yZMoGFH75tXMAVwQBx73UHd2ZwBhDWqawGQuQfh/KLeikiVep3me/iMRV
         bCiiE2rKgAPKfyVWJUFduUEyNpqeZEELG7AeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qORG9LAubGf3TeB4qNDIVqowo7qLsEY/gehXvOU1d6d1prdSqQ0S7P6B/xMdyLERf3
         O6LO5FPaVyFMvoTliSMOMsM0GvfM6+eTSasGOl1Egb0YIiRgVsvK0DrrVPRdxqPQBGD9
         BMGt9rYBvyHIBpRW/EyIFTC0r0k7CxvT+gj9I=
Received: by 10.68.6.5 with SMTP id w5mr688590pbw.15.1307518227677;
        Wed, 08 Jun 2011 00:30:27 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.25
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175319>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   48 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e38c5b0..93b7da5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1028,24 +1028,38 @@ static void conflict_rename_delete(struct merge_options *o,
 				   const char *rename_branch,
 				   const char *other_branch)
 {
-	char *dest_name = pair->two->path;
-	int df_conflict = 0;
+	const struct diff_filespec *orig = pair->one;
+	const struct diff_filespec *dest = pair->two;
+	const char *path;
+	const unsigned char *a_sha = NULL;
+	const unsigned char *b_sha = NULL;
+	int a_mode = 0;
+	int b_mode = 0;
+
+	if (rename_branch == o->branch1) {
+		a_sha = dest->sha1;
+		a_mode = dest->mode;
+	} else {
+		b_sha = dest->sha1;
+		b_mode = dest->mode;
+	}
 
-	output(o, 1, "CONFLICT (rename/delete): Rename %s->%s in %s "
-	       "and deleted in %s",
-	       pair->one->path, pair->two->path, rename_branch,
-	       other_branch);
-	if (!o->call_depth)
-		update_stages(dest_name, NULL,
-			      rename_branch == o->branch1 ? pair->two : NULL,
-			      rename_branch == o->branch1 ? NULL : pair->two);
-	if (dir_in_way(dest_name, !o->call_depth)) {
-		dest_name = unique_path(o, dest_name, rename_branch);
-		df_conflict = 1;
+	if (o->call_depth) {
+		remove_file_from_cache(dest->path);
+		path = orig->path;
+	} else {
+		path = dest->path;
+		update_stages(dest->path, NULL,
+			      rename_branch == o->branch1 ? dest : NULL,
+			      rename_branch == o->branch1 ? NULL : dest);
 	}
-	update_file(o, 0, pair->two->sha1, pair->two->mode, dest_name);
-	if (df_conflict)
-		free(dest_name);
+
+	handle_change_delete(o,
+			     path,
+			     orig->sha1, orig->mode,
+			     a_sha, a_mode,
+			     b_sha, b_mode,
+			     "rename", "renamed");
 }
 
 static void conflict_rename_rename_1to2(struct merge_options *o,
-- 
1.7.6.rc0.62.g2d69f
