From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] mv: allow moving nested submodules
Date: Tue, 19 Apr 2016 11:32:04 -0700
Message-ID: <1461090724-16325-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gmane@otterhall.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 19 20:32:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asaRl-00057r-DP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbcDSScV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 14:32:21 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33158 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933548AbcDSScU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 14:32:20 -0400
Received: by mail-pf0-f180.google.com with SMTP id 184so9394326pff.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wNrnzWMUg+HTXZ/itXQnh35qU32PJ8FiywlsNqiJdpE=;
        b=OZ/OIFFfM5dkSsCSDoeK+UAD4F4a0FC4O0+R5wT7boejyiiad44TLVz3l2AFzjz51w
         1CFzlOWrOMyzZfvYxn5y9UUXs6eeFD6eMly7U9o9nSTpfT7vRvYBwJ0at1HxdueSqvj4
         3swEXkCtm12yg1iVlTmRiROqsAkNpbpegw27h65kQ70EdI+ZCjLFCVfXRsk7j3Appk4u
         Ig6++k4//goeQXMhqgj137bRRpuygaNhHTGBwANNdu1FThIwG6C7EcD4TLRwTJGyBX/Z
         mWCAb3Vc69Y/fqqb1JJZy6AQv9yAjtnHGbvFiK4wJLT2Vawb2N5cHmrSEf2XZEAfRmKC
         p9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wNrnzWMUg+HTXZ/itXQnh35qU32PJ8FiywlsNqiJdpE=;
        b=g6yaOryewpsdtdP2svCkmWCWMlLTKghIVAeJU+J3QTtoqVBcDqWagjP6xJ1f7VC+BK
         u4ZZsKqEW9E2NHX21QO6UtVGWwpXqD9NlrnZCtGSQQ2+nmhrdUzH+NyzVxoVCUbfE910
         T972d4UvO3yhmrfr9vf8nyNPRhGik0SvrtMmV1gWVaUZUc/d4iqG5GQQ5XTus4h6+gbY
         z4mJtH8155I9Gm57fS/VqNUJljQ3QJ4QaGw6KQfbn8gQ8XYY5PDBK/ZwxKBlFYbEbiVz
         NOJ/LQvU6jGtousixGXbaDxtpnCTk9W/xnsYWr/aVgHBtfDgpnV/S9ip4j0xdbzZo189
         vHKQ==
X-Gm-Message-State: AOPr4FXDVzJlg0TZchUYaBL47zxNl5QOgLGLqkG5SfrLByI8UVSKvMlvErWRhxIxJ+EgXQ5f
X-Received: by 10.98.1.69 with SMTP id 66mr6281331pfb.10.1461090739437;
        Tue, 19 Apr 2016 11:32:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:7418:717f:4b27:128f])
        by smtp.gmail.com with ESMTPSA id s66sm92551086pfi.3.2016.04.19.11.32.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 11:32:18 -0700 (PDT)
X-Mailer: git-send-email 2.6.6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291899>

When directories are moved using `git mv` all files in the directory
have been just moved, but no further action was taken on them. This
was done by assigning the mode = WORKING_DIRECTORY to the files
inside a moved directory.

submodules however need to update their link to the git directory as
well as updates to the .gitmodules file. By removing the condition of
`mode != INDEX` (the remaining modes are BOTH and WORKING_DIRECTORY) for
the required submodule actions, we perform these for submodules in a
moved directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> Can you do only the 2/2 on top of maint (or maint-2.6) for now then?

This is developed on maint-2.6.

 builtin/mv.c  | 22 +++++++++++++---------
 t/t7001-mv.sh | 16 ++++++++++++++++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index d1d4316..77f3ec5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -251,15 +251,19 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		int pos;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
-		if (!show_only && mode != INDEX) {
-			if (rename(src, dst) < 0 && !ignore_errors)
-				die_errno(_("renaming '%s' failed"), src);
-			if (submodule_gitfile[i]) {
-				if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
-					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
-				if (!update_path_in_gitmodules(src, dst))
-					gitmodules_modified = 1;
-			}
+		if (show_only)
+			continue;
+		if (mode != INDEX &&
+		    rename(src, dst) < 0) {
+			if (ignore_errors)
+				continue;
+			die_errno(_("renaming '%s' failed"), src);
+		}
+		if (submodule_gitfile[i]) {
+			if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
+				connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
+			if (!update_path_in_gitmodules(src, dst))
+				gitmodules_modified = 1;
 		}
 
 		if (mode == WORKING_DIRECTORY)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7b56081..fcfc953 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -292,6 +292,9 @@ test_expect_success 'setup submodule' '
 	echo content >file &&
 	git add file &&
 	git commit -m "added sub and file" &&
+	mkdir -p deep/directory/hierachy &&
+	git submodule add ./. deep/directory/hierachy/sub &&
+	git commit -m "added another submodule" &&
 	git branch submodule
 '
 
@@ -475,4 +478,17 @@ test_expect_success 'mv -k does not accidentally destroy submodules' '
 	git checkout .
 '
 
+test_expect_success 'moving a submodule in nested directories' '
+	(
+		cd deep &&
+		git mv directory ../ &&
+		# git status would fail if the update of linking git dir to
+		# work dir of the submodule failed.
+		git status &&
+		git config -f ../.gitmodules submodule.deep/directory/hierachy/sub.path >../actual &&
+		echo "directory/hierachy/sub" >../expect
+	) &&
+	test_cmp actual expect
+'
+
 test_done
-- 
2.6.6.dirty
