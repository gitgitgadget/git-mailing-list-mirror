From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC 5/5] cache: Use ce_norm_sha1().
Date: Fri, 16 Apr 2010 18:10:02 +0200
Message-ID: <c68d98b384086925da0194e560ae01d83a29f80c.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 18:43:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2odu-0005I4-9B
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758576Ab0DPQna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 12:43:30 -0400
Received: from mail.roxen.com ([212.247.29.220]:60211 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758555Ab0DPQnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:43:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id EFA91628238
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id npAkF6ukdbK9 for <git@vger.kernel.org>;
	Fri, 16 Apr 2010 18:10:13 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 6692F628243
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:08 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3GGA8AW021808;
	Fri, 16 Apr 2010 18:10:08 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3GGA8ZN021807;
	Fri, 16 Apr 2010 18:10:08 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145078>

When the conversion filter for a file is changed, the file may get
listed as modified even though the user has not made any changes to it.
This patch makes the index ignore such changes. It also makes git-diff
compare with the normalized content rather than the original content.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 diff-lib.c   |    9 ++++++---
 read-cache.c |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index c9f6e05..ae6118d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -95,6 +95,7 @@ int run_diff_files(struct rev_info *revs, unsigned in=
t option)
 		struct cache_entry *ce =3D active_cache[i];
 		int changed;
 		unsigned dirty_submodule =3D 0;
+		const unsigned char *norm_sha1;
=20
 		if (DIFF_OPT_TST(&revs->diffopt, QUICK) &&
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
@@ -147,7 +148,8 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 				if (2 <=3D stage) {
 					int mode =3D nce->ce_mode;
 					num_compare_stages++;
-					hashcpy(dpath->parent[stage-2].sha1, nce->sha1);
+					hashcpy(dpath->parent[stage-2].sha1,
+						ce_norm_sha1(nce));
 					dpath->parent[stage-2].mode =3D ce_mode_from_stat(nce, mode);
 					dpath->parent[stage-2].status =3D
 						DIFF_STATUS_MODIFIED;
@@ -195,7 +197,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 			if (silent_on_removed)
 				continue;
 			diff_addremove(&revs->diffopt, '-', ce->ce_mode,
-				       ce->sha1, ce->name, 0);
+				       ce_norm_sha1(ce), ce->name, 0);
 			continue;
 		}
 		changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -207,8 +209,9 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 		}
 		oldmode =3D ce->ce_mode;
 		newmode =3D ce_mode_from_stat(ce, st.st_mode);
+		norm_sha1 =3D ce_norm_sha1(ce);
 		diff_change(&revs->diffopt, oldmode, newmode,
-			    ce->sha1, (changed ? null_sha1 : ce->sha1),
+			    norm_sha1, (changed ? null_sha1 : norm_sha1),
 			    ce->name, 0, dirty_submodule);
=20
 	}
diff --git a/read-cache.c b/read-cache.c
index 002160e..b631de9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -94,7 +94,7 @@ static int ce_compare_data(struct cache_entry *ce, st=
ruct stat *st)
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, 0, OBJ_BLOB, ce->name))
-			match =3D hashcmp(sha1, ce->sha1);
+			match =3D hashcmp(sha1, ce_norm_sha1(ce));
 		/* index_fd() closed the file descriptor already */
 	}
 	return match;
--=20
1.7.0.4.369.g81e89
