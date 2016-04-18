From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] mv: allow moving nested submodules
Date: Mon, 18 Apr 2016 16:41:24 -0700
Message-ID: <1461022884-30819-3-git-send-email-sbeller@google.com>
References: <1461022884-30819-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, gmane@otterhall.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 01:41:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asIna-0007fF-2J
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 01:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbcDRXli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 19:41:38 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34720 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbcDRXlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 19:41:36 -0400
Received: by mail-pf0-f172.google.com with SMTP id c20so42872pfc.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 16:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZsQrRcMr5K+d7zwh7LP3oOrsgdO1rPhWaLHxue9VVMI=;
        b=i4yUQl1S1loHunDh/gd3KdJ4DQlOdKz6g+Fixz76rr5KVzqV5ZlXQdZ2deKQ4K1Mb/
         86/puUhmKost5rls3W76of2QWqjc6y7z8VE0d6UPnkR4fc0Vg0hp7CAwX0Y0iAm1wl+9
         7NmFajwKKIUev5sNTIayw49+WRAqbff3d6Wf2p1SGMWvmkLFc9/InvZYDZVNAWUVRyDz
         X0eXuBI3qkquIZOnYvP4H4+wtoNDg1EW4D+SPqOM1HCfTibQWclwXgOEQo9E4EywPekr
         Fnk9wgWLx7ZNIdWfFFaKS8LFT7IPYXKqXAJOX6+S5lvrALUicA1fURfGTaWD8chuSeFe
         HHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZsQrRcMr5K+d7zwh7LP3oOrsgdO1rPhWaLHxue9VVMI=;
        b=mkxYTzCikj9Ra0aXKANC05Js9pJjhPwEHUuP2L/nbPQAluukwtDcxMYZZsahJGz0Ky
         xOk2gCKPW98A+NaMlc3QzOujpcYXP2TJkeTkt0B5mRLKXOph10Y2wYyZRr6lJAYB9kpa
         XMa2dDGD7b13fT3CafRj4nkDHztQiCXPEfg5AYaedFjzVjKyTSJ2muGiYa97eWAGIRTK
         dcxzKE8sywnXLCR1ocL07AXycSLECD1p4Unj1VfRi4oxkU+dA+lwCzMeeQ/KmQTSpCUR
         XBRgLDBy35yl7MAQnastK11ovI0Aegg5cndgbk2dr95zuRTWZINgo0pa4me4voyEogAn
         w92Q==
X-Gm-Message-State: AOPr4FWYMCk2TixlUyWxTtQsdPtWpPmNeHWrlJaCEpcze8TURG+S8AV6kcox1ETYVI3xpJpU
X-Received: by 10.98.44.70 with SMTP id s67mr53562103pfs.59.1461022895223;
        Mon, 18 Apr 2016 16:41:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6869:43f:e72f:2f19])
        by smtp.gmail.com with ESMTPSA id vu5sm80606619pab.43.2016.04.18.16.41.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 16:41:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.211.g24879d1
In-Reply-To: <1461022884-30819-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291837>

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
 builtin/mv.c  | 39 ++++++++++++++++++++++-----------------
 t/t7001-mv.sh | 16 ++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 74516f4..2deb95b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -253,23 +253,28 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		int pos;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
-		if (!show_only && mode != INDEX) {
-			if (rename(src, dst) < 0 && !ignore_errors)
-				die_errno(_("renaming '%s' failed"), src);
-			if (submodule_gitfile[i]) {
-				if ((submodule_gitfile[i] != SUBMODULE_WITH_GITDIR &&
-				    connect_work_tree_and_git_dir(dst, submodule_gitfile[i], &err)) ||
-				    update_path_in_gitmodules(src, dst, &err)) {
-					if (err.len) {
-						if (ignore_errors) {
-							warning("%s", err.buf);
-							continue;
-						} else
-							die("%s", err.buf);
-					}
-				} else
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
+
+		if (submodule_gitfile[i]) {
+			if ((submodule_gitfile[i] != SUBMODULE_WITH_GITDIR &&
+			    connect_work_tree_and_git_dir(dst, submodule_gitfile[i], &err)) ||
+			    update_path_in_gitmodules(src, dst, &err)) {
+				if (err.len) {
+					if (ignore_errors) {
+						warning("%s", err.buf);
+						continue;
+					} else
+						die("%s", err.buf);
+				}
+			} else
+				gitmodules_modified = 1;
 		}
 
 		if (mode == WORKING_DIRECTORY)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4008fae..4a2570e 100755
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
2.8.1.211.g24879d1
