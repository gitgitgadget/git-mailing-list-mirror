From: dturner@twopensource.com
Subject: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Tue,  6 May 2014 15:59:04 -0700
Message-ID: <1399417144-24864-2-git-send-email-dturner@twopensource.com>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
 <1399417144-24864-1-git-send-email-dturner@twopensource.com>
Cc: gitster@pobox.com, David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 01:00:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhoLc-0005ws-Cb
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 01:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbaEFXAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 19:00:22 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:39908 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaEFXAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 19:00:20 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so215446qcy.3
        for <git@vger.kernel.org>; Tue, 06 May 2014 16:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MuYdsarM1XfIIwarH28OaPXQXWwtB10f/XcSMC0EXfk=;
        b=KECw5oedAziQYqQzxlx6J6NkvSp3JK3ypDW46Chhinu2dc1NrpcGctOdz3Yl14eLQp
         R4TbhPaszNOszO9F9PhUOmgr+BWeQhmgmi8Pmt6c++Q3zY/7Px5+kwF3lRPfemttUYeS
         MS3nGPkA5/iAfoaXOrFXosF6Qs6JCrp/dFC0lXcdikhywTZjH7gcddGjzJu/U8Er24cx
         pkZ2QaTiK2IK5S3Yp1nhMnYAXqb5+tZ7G3eD1725qtnFJbMXX01eveeUu4BKQWX/o9VP
         pXNHHgHFkpO7ZoUGbTyYrBDXhDeVsTYIGz9LGun/UdW+cc1cW5mzeGYLM7J1Tq42WTIO
         dxtQ==
X-Gm-Message-State: ALoCoQmAuNRWlT5vgidmaGyYxfUNpiz6gEjbYY74wQEih7iUSG/88fI3g4eu7uIoDr9PdmpcZiC9
X-Received: by 10.140.95.80 with SMTP id h74mr55240754qge.2.1399417219180;
        Tue, 06 May 2014 16:00:19 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id b17sm26150040qaq.25.2014.05.06.16.00.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 16:00:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.33.g27630aa
In-Reply-To: <1399417144-24864-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248268>

From: David Turner <dturner@twitter.com>

Make it possible to change the case of a filename on a
case-insensitive filesystem using git mv.  Change git mv to allow
moves where the destination file exists if either the destination file
has the same inode as the source file (for Mac) or the same name
ignoring case (for Win).

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/mv.c                | 18 ++++++++++--------
 t/t6039-merge-ignorecase.sh |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 45e57f3..8cead13 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -74,7 +74,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
-	struct stat st;
+	struct stat src_st,dst_st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 
 	gitmodules_config();
@@ -102,8 +102,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
 		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
-	else if (!lstat(dest_path[0], &st) &&
-			S_ISDIR(st.st_mode)) {
+	else if (!lstat(dest_path[0], &dst_st) &&
+			S_ISDIR(dst_st.st_mode)) {
 		dest_path[0] = add_slash(dest_path[0]);
 		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	} else {
@@ -122,13 +122,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
 
 		length = strlen(src);
-		if (lstat(src, &st) < 0)
+		if (lstat(src, &src_st) < 0)
 			bad = _("bad source");
 		else if (!strncmp(src, dst, length) &&
 				(dst[length] == 0 || dst[length] == '/')) {
 			bad = _("can not move directory into itself");
-		} else if ((src_is_dir = S_ISDIR(st.st_mode))
-				&& lstat(dst, &st) == 0)
+		} else if ((src_is_dir = S_ISDIR(src_st.st_mode))
+				&& lstat(dst, &dst_st) == 0)
 			bad = _("cannot move directory over file");
 		else if (src_is_dir) {
 			int first = cache_name_pos(src, length);
@@ -202,14 +202,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			}
 		} else if (cache_name_pos(src, length) < 0)
 			bad = _("not under version control");
-		else if (lstat(dst, &st) == 0) {
+		else if (lstat(dst, &dst_st) == 0 &&
+			 (src_st.st_ino != dst_st.st_ino ||
+			  (src_st.st_ino == 0 && strcasecmp(src, dst)))) {
 			bad = _("destination exists");
 			if (force) {
 				/*
 				 * only files can overwrite each other:
 				 * check both source and destination
 				 */
-				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
+				if (S_ISREG(dst_st.st_mode) || S_ISLNK(dst_st.st_mode)) {
 					if (verbose)
 						warning(_("overwriting '%s'"), dst);
 					bad = NULL;
diff --git a/t/t6039-merge-ignorecase.sh b/t/t6039-merge-ignorecase.sh
index ad06752..28cfb49 100755
--- a/t/t6039-merge-ignorecase.sh
+++ b/t/t6039-merge-ignorecase.sh
@@ -35,7 +35,7 @@ test_expect_success 'merge with case-changing rename on both sides' '
 	git reset --hard baseline &&
 	git branch -D with-camel &&
 	git checkout -b with-camel &&
-	git mv --force TestCase testcase &&
+	git mv TestCase testcase &&
 	git commit -m "recase on branch" &&
 	> foo &&
 	git add foo &&
-- 
2.0.0.rc0.33.g27630aa
