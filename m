From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 47/48] merge-recursive: add handling for rename/rename/add-dest/add-dest
Date: Wed,  8 Jun 2011 01:31:17 -0600
Message-ID: <1307518278-23814-48-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEl-0006q0-PG
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab1FHHac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab1FHHa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:29 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=xV/ShCPexGkx7TGm8ut73U7N8JHxej0RsqirjN51l3I=;
        b=dbjwIqnqAONfSyJDtZo6RUkKHDtHaCZejt6LgBvEOjlh4zKq3Qa2woFBUfgBuFRJBh
         aJWy30q5cHb/nqUqrhNaopQjbUbDsqfexI8c9HQ7h6lLcoMRvtQRAQYH06ylqodLsrY3
         70o8fCCLmAwJSrC22DJkqILyTM/QTXQxOWqiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y5fatkhXE5/Lfeziut4L0cLny97L8h6Ib7rnzQL9plBWr7srbkqO2PR6Mz9KpS5SAG
         +y7ILAPedUOWN3VcQ0yCjLI1G3MgYoSY7ecpJ7t9zJZzwqGHVbYkSWs6zVvdsIkudL4m
         ntrXkU4K0mYjChgt2p7lwhoer8Y7mB0SkrUfs=
Received: by 10.68.10.105 with SMTP id h9mr593695pbb.108.1307518229593;
        Wed, 08 Jun 2011 00:30:29 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.27
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175324>

Each side of the rename in rename/rename(1to2) could potentially also be
involved in a rename/add conflict.  Ensure stages for such conflicts are
also recorded.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    |   21 +++++++++++++++++++--
 t/t6039-merge-rename-corner-cases.sh |    2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 93b7da5..0cfc215 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1062,6 +1062,19 @@ static void conflict_rename_delete(struct merge_options *o,
 			     "rename", "renamed");
 }
 
+static struct diff_filespec* filespec_from_entry(struct diff_filespec *target,
+						 struct stage_data *entry,
+						 int stage)
+{
+	unsigned char *sha = entry->stages[stage].sha;
+	unsigned mode = entry->stages[stage].mode;
+	if (mode == 0 || is_null_sha1(sha))
+		return NULL;
+	hashcpy(target->sha1, sha);
+	target->mode = mode;
+	return target;
+}
+
 static void conflict_rename_rename_1to2(struct merge_options *o,
 					struct rename_conflict_info *ci)
 {
@@ -1107,8 +1120,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		remove_file_from_cache(a->path);
 		remove_file_from_cache(b->path);
 	} else {
-		update_stages(a->path, NULL, a, NULL);
-		update_stages(b->path, NULL, NULL, b);
+		struct diff_filespec other;
+		update_stages(a->path, NULL,
+			      a, filespec_from_entry(&other, ci->dst_entry1, 3));
+
+		update_stages(b->path, NULL,
+			      filespec_from_entry(&other, ci->dst_entry2, 2), b);
 
 		update_file(o, 0, a->sha1, a->mode, dst_name_a);
 		update_file(o, 0, b->sha1, b->mode, dst_name_b);
diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index 86e96d0..d2d93e7 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -437,7 +437,7 @@ test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
 	git commit -m two
 '
 
-test_expect_failure 'rename/rename/add-dest merge still knows about conflicting file versions' '
+test_expect_success 'rename/rename/add-dest merge still knows about conflicting file versions' '
 	git checkout C^0 &&
 	test_must_fail git merge -s recursive B^0 &&
 
-- 
1.7.6.rc0.62.g2d69f
