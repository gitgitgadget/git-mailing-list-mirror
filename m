From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 27/48] merge-recursive: Consolidate different update_stages functions
Date: Wed,  8 Jun 2011 01:30:57 -0600
Message-ID: <1307518278-23814-28-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDO-0005pC-69
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073Ab1FHH34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab1FHH3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:50 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OyFQna3hPgTWiuttqyphTZoQx9Hxy8u8ihxuhlPLTyQ=;
        b=K5pg1hQQyaIBJ0Krn3y8oGJvbZvs0yff5LgMJsHbdQ8boW2r7RWOtsQi/ntdO5kUju
         vhXg06a2AGzXV6jPTKYCWBd7ZENL8ZFrpzpfUAscFmfygvAz3ho7fjBFsoRhonCPd8kE
         GWhXlTKfNchXGWb8eSei+xWslniKRiTSgSijA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pHf8F9WLPBrWBAEuFI3EgbzeK6ixT71fOp3Hgzch08/N9Ra7YZHfoG/WK3le0YCNxl
         Sjv+vAcyzhG7Jkr7u/Jngu+YhfZBLpWl+vC5DYvMtMMj+QwTM8uVZCpXpYSeMizkRSYp
         NWAcvHmT7bReiYkIOgwdG5h1Grx/1EfFi+2Bo=
Received: by 10.68.37.65 with SMTP id w1mr564881pbj.341.1307518190191;
        Wed, 08 Jun 2011 00:29:50 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.48
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175308>

We are only calling update_stages_options() one way really, so we can
consolidate the slightly different variants into one and remove some
parameters whose values are always the same.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e3033f2..b4baa35 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -495,11 +495,12 @@ static struct string_list *get_renames(struct merge_options *o,
 	return renames;
 }
 
-static int update_stages_options(const char *path, const struct diff_filespec *o,
-				 const struct diff_filespec *a,
-				 const struct diff_filespec *b,
-				 int clear, int options)
+static int update_stages(const char *path, const struct diff_filespec *o,
+			 const struct diff_filespec *a,
+			 const struct diff_filespec *b)
 {
+	int clear = 1;
+	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 	if (clear)
 		if (remove_file_from_cache(path))
 			return -1;
@@ -515,14 +516,6 @@ static int update_stages_options(const char *path, const struct diff_filespec *o
 	return 0;
 }
 
-static int update_stages(const char *path, struct diff_filespec *o,
-			 struct diff_filespec *a, struct diff_filespec *b,
-			 int clear)
-{
-	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
-	return update_stages_options(path, o, a, b, clear, options);
-}
-
 static int update_stages_and_entry(const char *path,
 				   struct stage_data *entry,
 				   struct diff_filespec *o,
@@ -539,8 +532,7 @@ static int update_stages_and_entry(const char *path,
 	hashcpy(entry->stages[1].sha, o->sha1);
 	hashcpy(entry->stages[2].sha, a->sha1);
 	hashcpy(entry->stages[3].sha, b->sha1);
-	options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
-	return update_stages_options(path, o, a, b, clear, options);
+	return update_stages(path, o, a, b);
 }
 
 static int remove_file(struct merge_options *o, int clean,
@@ -936,8 +928,7 @@ static void conflict_rename_delete(struct merge_options *o,
 	if (!o->call_depth)
 		update_stages(dest_name, NULL,
 			      rename_branch == o->branch1 ? pair->two : NULL,
-			      rename_branch == o->branch1 ? NULL : pair->two,
-			      1);
+			      rename_branch == o->branch1 ? NULL : pair->two);
 	if (dir_in_way(dest_name, !o->call_depth)) {
 		dest_name = unique_path(o, dest_name, rename_branch);
 		df_conflict = 1;
@@ -980,8 +971,8 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
 		 */
 	} else {
-		update_stages(ren1_dst, NULL, pair1->two, NULL, 1);
-		update_stages(ren2_dst, NULL, NULL, pair2->two, 1);
+		update_stages(ren1_dst, NULL, pair1->two, NULL);
+		update_stages(ren2_dst, NULL, NULL, pair2->two);
 
 		update_file(o, 0, pair1->two->sha1, pair1->two->mode, dst_name1);
 		update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
-- 
1.7.6.rc0.62.g2d69f
