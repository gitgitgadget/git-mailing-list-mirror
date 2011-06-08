From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 26/48] merge-recursive: Allow make_room_for_path() to remove D/F entries
Date: Wed,  8 Jun 2011 01:30:56 -0600
Message-ID: <1307518278-23814-27-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDN-0005pC-Kw
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab1FHH3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:49 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab1FHH3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:48 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=daTx2tfZ9MpBJLz/mHtQlYVsZLwdzmNlvkekXBjr8ss=;
        b=GFgcZNor+gRxVvs6dblr9CuD/twpw0JvvT1XTEKtM80lLF8938jJ5s+DUR7SjF4WnH
         bUkMWn9HzEDiOGnzKXITE0YGP3Oo5/iX35u9YaQ1nyIfKmh48+jCQXAPeYCAU9dxdVYH
         iTNSpQZ+OLh9FlTmwuUww71aFdNMYcg3dW4Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kFNmI3NbdsPvZzMUV5lguB4qqMstuTbei8C+LLCMJ7WefYzb6PtGfMFGy5m4ZB7BbP
         m10BZ8h0o/IBcQyTW1/IRdngsj7LKHZjDeFlMilIJHz/CiAj91rsen4mlHYQo9vW6mcS
         qIacTTquagpqDfs1myLI318gETk9dedupvSTY=
Received: by 10.68.47.196 with SMTP id f4mr634784pbn.363.1307518188223;
        Wed, 08 Jun 2011 00:29:48 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.46
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175312>

If there were several files conflicting below a directory corresponding
to a D/F conflict, and the file of that D/F conflict is in the way, we
want it to be removed.  Since files of D/F conflicts are handled last,
they can be reinstated later and possibly with a new unique name.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 |   18 +++++++++++++++---
 t/t6036-recursive-corner-cases.sh |    2 +-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d19c519..e3033f2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -651,11 +651,23 @@ static int would_lose_untracked(const char *path)
 	return !was_tracked(path) && file_exists(path);
 }
 
-static int make_room_for_path(const char *path)
+static int make_room_for_path(const struct merge_options *o, const char *path)
 {
-	int status;
+	int status, i;
 	const char *msg = "failed to create path '%s'%s";
 
+	/* Unlink any D/F conflict files that are in the way */
+	for (i = 0; i < o->df_conflict_file_set.nr; i++) {
+		const char *df_path = o->df_conflict_file_set.items[i].string;
+		size_t pathlen = strlen(path);
+		size_t df_pathlen = strlen(df_path);
+		if (df_pathlen < pathlen && strncmp(path, df_path, df_pathlen) == 0) {
+			unlink(df_path);
+			break;
+		}
+	}
+
+	/* Make sure leading directories are created */
 	status = safe_create_leading_directories_const(path);
 	if (status) {
 		if (status == -3) {
@@ -723,7 +735,7 @@ static void update_file_flags(struct merge_options *o,
 			}
 		}
 
-		if (make_room_for_path(path) < 0) {
+		if (make_room_for_path(o, path) < 0) {
 			update_wd = 0;
 			free(buf);
 			goto update_index;
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 423fb62..dea2a65 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -477,7 +477,7 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 	git tag E2
 '
 
-test_expect_failure 'git detects conflict and handles merge of D & E1 correctly' '
+test_expect_success 'git detects conflict and handles merge of D & E1 correctly' '
 	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
-- 
1.7.6.rc0.62.g2d69f
