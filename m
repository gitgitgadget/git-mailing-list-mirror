From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 32/37] conflict_rename_delete(): Check whether D/F conflicts are still present
Date: Mon, 20 Sep 2010 02:29:05 -0600
Message-ID: <1284971350-30590-33-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblM-0006R4-Oz
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab0ITI2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:39 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63878 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab0ITI2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:37 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1072016pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9ZHoAZ2RONQOCNh9VIVl1U3YkjMJ8aITyY3hBXiHyRM=;
        b=DeDTvodi6/3k6dgf1lJPwmfcafnfJfld6vwneS5VIMUSqymYA1V120vaFMV2/PQjAD
         +Mv5PZTy5rR+Pr2Y0ZYxrYdVfR5Mktq41WpKK+tdI99Ee2a5xHGMNcOtpjqpjuX5xQvV
         V5hHG5QN79J3AlRjuH/51R56/n0YQ4hdVMIlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oHFn/nQ4Q1han3sA3QH4CeJ27aAA+Puj08u8tzJSnoVIxvuis/QF8s6fgC4Xpl6bFS
         dE1rTDAjF4j+4UvNrTjKZcoL2sEgqfyodqsRRTRovkP+W5xSipwFDQ2YbVZ2PXtNTeTc
         czt8HvNPUltLmH2NT7pMxlKZh/CwOi/oxO5sQ=
Received: by 10.142.199.13 with SMTP id w13mr5326972wff.183.1284971316807;
        Mon, 20 Sep 2010 01:28:36 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156586>

If all the paths below some directory involved in a D/F conflict were not
removed during the rest of the merge, then the contents of the file whose
path conflicted needs to be recorded in file with an alternative filename.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       |    8 ++++++++
 t/t6022-merge-rename.sh |    4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d9fcd6d..c6a3465 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -807,6 +807,8 @@ static void conflict_rename_delete(struct merge_options *o,
 				   const char *other_branch)
 {
 	char *dest_name = pair->two->path;
+	int df_conflict = 0;
+	struct stat st;
 
 	output(o, 1, "CONFLICT (rename/delete): Rename %s->%s in %s "
 	       "and deleted in %s",
@@ -817,7 +819,13 @@ static void conflict_rename_delete(struct merge_options *o,
 			      rename_branch == o->branch1 ? pair->two : NULL,
 			      rename_branch == o->branch1 ? NULL : pair->two,
 			      1);
+	if (lstat(dest_name, &st) == 0 && S_ISDIR(st.st_mode)) {
+		dest_name = unique_path(o, dest_name, rename_branch);
+		df_conflict = 1;
+	}
 	update_file(o, 0, pair->two->sha1, pair->two->mode, dest_name);
+	if (df_conflict)
+		free(dest_name);
 }
 
 static void conflict_rename_rename_1to2(struct merge_options *o,
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index edbfa47..9bf190e 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -549,7 +549,7 @@ test_expect_success 'setup both rename source and destination involved in D/F co
 	git commit -m "Conflicts in the way"
 '
 
-test_expect_failure 'both rename source and destination involved in D/F conflict' '
+test_expect_success 'both rename source and destination involved in D/F conflict' '
 	git reset --hard &&
 	rm -rf dir~* &&
 	git checkout -q rename-dest^0 &&
@@ -589,7 +589,7 @@ test_expect_success 'setup pair rename to parent of other (D/F conflicts)' '
 	git commit -m "Rename one/file -> two"
 '
 
-test_expect_failure 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
+test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
 	git checkout -q rename-one^0 &&
 	mkdir one &&
 	test_must_fail git merge --strategy=recursive rename-two &&
-- 
1.7.3.271.g16009
