From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 33/37] conflict_rename_rename_1to2(): Fix checks for presence of D/F conflicts
Date: Mon, 20 Sep 2010 02:29:06 -0600
Message-ID: <1284971350-30590-34-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblQ-0006R4-0G
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0ITI3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:29:01 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932Ab0ITI2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:39 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sZ0iu/8AFVJ9AqqoWqqLGEXkngahwg4EIw4GCpHWCLs=;
        b=GkqHd2fUJDA44/Fhc5Cp5HSyNjfj2Hp4gMenDysTk8XWtP1w7J0p8yneiPJuuw95zF
         a7rlSNc5h5oNW7cdqcM0YuYBA3pvK0bqOAUUH+xt0a7vRZgi4o/s69oaRHWXYmzIFZ/M
         CZKjyu36YEfF9P/F38Xrd9vBEO0nT8rSrnVO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P9I3oe/VJh8ex3dBvokWICDkURfXon0ONAgCecV8D54bQt2YOIU0mvaTRTgODYAJOG
         YO4Lq24/GRNgBt49WDQ8ks+gYhobVqFtDw04nMrgZAXXGSkusNQYAyNigeaiEHm5tuQ1
         zfXTUSlYAhxFZEbOjfF+G7npdNioc7vJ+mYZ4=
Received: by 10.142.126.2 with SMTP id y2mr6377758wfc.129.1284971318783;
        Mon, 20 Sep 2010 01:28:38 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156596>

This function is called from process_df_entry(), near the end of the merge.
Rather than just checking whether one of the sides of the merge had a
directory at the same path as one of our files, check whether that
directory is still present by this point of our merge.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       |    7 +++----
 t/t6022-merge-rename.sh |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c6a3465..3cc5886 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -841,17 +841,16 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	const char *ren2_dst = pair2->two->path;
 	const char *dst_name1 = ren1_dst;
 	const char *dst_name2 = ren2_dst;
-	if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
+	struct stat st;
+	if (lstat(ren1_dst, &st) == 0 && S_ISDIR(st.st_mode)) {
 		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren1_dst, branch2, dst_name1);
-		remove_file(o, 0, ren1_dst, 0);
 	}
-	if (string_list_has_string(&o->current_directory_set, ren2_dst)) {
+	if (lstat(ren2_dst, &st) == 0 && S_ISDIR(st.st_mode)) {
 		dst_name2 = del[delp++] = unique_path(o, ren2_dst, branch2);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren2_dst, branch1, dst_name2);
-		remove_file(o, 0, ren2_dst, 0);
 	}
 	if (o->call_depth) {
 		remove_file_from_cache(dst_name1);
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 9bf190e..0b67002 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -692,7 +692,7 @@ test_expect_success 'setup rename one file to two; directories moving out of the
 	git commit -m "Rename to two"
 '
 
-test_expect_failure 'check handling of differently renamed file with D/F conflicts' '
+test_expect_success 'check handling of differently renamed file with D/F conflicts' '
 	git checkout -q first-rename-redo^0 &&
 	test_must_fail git merge --strategy=recursive second-rename-redo &&
 
-- 
1.7.3.271.g16009
