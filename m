From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] mv: allow moving nested submodules
Date: Fri, 15 Apr 2016 12:11:32 -0700
Message-ID: <1460747492-6640-1-git-send-email-sbeller@google.com>
References: <CAGZ79kajE-R84=dSpBBFttwwDg4DbF59gnmzaN-C2w6U3rFwVw@mail.gmail.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gmane@otterhall.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 15 21:11:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar99a-00010P-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcDOTLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:11:39 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35160 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcDOTLi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:11:38 -0400
Received: by mail-pf0-f180.google.com with SMTP id n1so59569660pfn.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4oDHhJoInys/WQGelqLLjkf279M1Hh7KFlMFe4ebukQ=;
        b=VmSm237q3bMBmKpjYnn3mpVLmSmkoVnh1q7Y3ZDrhLW1dmtm58OMnaX6jdLEBgMF1O
         6wvgFfiv87HApHSLENAYfGMjJhhESig+JZGzbnWMMN/IBpIwuHUUihU8eYDBtMnuF5iH
         ps6l/NKvs2TMel7MGdBvCHXOfO9cPbut9gtqjfRBARmsysWHTszfeEnefWiUncjh4XnX
         tGWzgkm7xSVq0MDFPcsrFkSOlnOEFWN73gmG+HoVlOjW5WwDWk+F1ndjdimn2tEImhuM
         OTJqVM9J8diwFWFTL9w7CGi9KipKmbwmG/U4jGm//8n6mWCr2RZauMclCRNdeO/6LzKr
         H8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4oDHhJoInys/WQGelqLLjkf279M1Hh7KFlMFe4ebukQ=;
        b=N2WuF4cM+UOEWPviqQ7UW3KafEWot9BbZ3s5euAU9abOu679laBaBDMWguYfwuYF+c
         UoWQEQqjCiYG945IgZZ6Zv7zeGteBk8hdqLj7/0319qiqVbbmRjjFw6bXWOU4/FqgO0H
         n4ZtotCI+TBbBW+wV9TyScm6SFWxUo7ePaX/oIecIUtHxp+EsKIMridvVr963pXyvfmh
         Z/wVws+yUM3TxMbltYpQt5w33zZBQxlWpT1mcpSDYZHNpVowUVB1FBKxFe0wddfo/UgA
         +rhFvEcP+WLZ2E6JwX+gUKzdSaUxPqkD+ialOaoGk7DMd50qt5JPj6l1U7eGRLklVUH4
         FAQA==
X-Gm-Message-State: AOPr4FWM1YR1QGupt9wndzooGFSlPQavYZzoR3XS4OA4sAAhh5le+g6OMFfwro7dAlOGZEhF
X-Received: by 10.98.64.4 with SMTP id n4mr31656040pfa.58.1460747497221;
        Fri, 15 Apr 2016 12:11:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c97d:dddf:ab88:e90])
        by smtp.gmail.com with ESMTPSA id a86sm25748511pfc.42.2016.04.15.12.11.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 12:11:36 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.211.g630c034
In-Reply-To: <CAGZ79kajE-R84=dSpBBFttwwDg4DbF59gnmzaN-C2w6U3rFwVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291638>

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

Albin,
I think this would fix your problem.

Developed on origin/master (it may apply on older versions, though I did not test)

Thanks,
Stefan

 builtin/mv.c  |  7 +++++--
 t/t7001-mv.sh | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index aeae855..65fff11 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -252,9 +252,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		int pos;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
-		if (!show_only && mode != INDEX) {
-			if (rename(src, dst) < 0 && !ignore_errors)
+		if (!show_only) {
+			if (mode != INDEX &&
+			    rename(src, dst) < 0 &&
+			    !ignore_errors)
 				die_errno(_("renaming '%s' failed"), src);
+
 			if (submodule_gitfile[i]) {
 				if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
 					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
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
2.8.1.211.g630c034
