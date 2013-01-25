From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] branch: give a more helpful message on redundant arguments
Date: Fri, 25 Jan 2013 19:50:24 +0700
Message-ID: <1359118225-14356-2-git-send-email-pclouds@gmail.com>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
 <1359118225-14356-1-git-send-email-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 13:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyijr-00034Z-24
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 13:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab3AYMuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 07:50:13 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:62650 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3AYMuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 07:50:11 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so159879dak.25
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ErD+Y/8iJT7YaOwTwCSAxDydd1Q86Z8rIXrf0P/g4Ts=;
        b=hb5gsir9mBrMRRq0E8EODdo5rvZxdXwUih+IyL1hKoXnpLtSDXo6a/hGPkXsMvvk94
         rOqXcB5UwFdGPGhQo7/1ZZjHjwLDZpcALtZqjjfBUv1bhPKJ285GifGK/LYwjn35h4cT
         eO4PWPrBeu9h3Jp+w78lbBZwlz64xT1kLUwgjFS2Fpkz958Vm6pk4lw+VYvsYgxoYI/M
         bC1r0dsF5QYoGmsiL8kSAx1r8f9roUcw9UqOgfs9qD8goucp/vxV4Rz8j3XRPvBfog6J
         6GNzroy1/qyTCl/t19EYHFQ5xBH4Dvhq+f2HZIc0uWlbInmjkf/YF/3TFvU0D7j87zg/
         3lPw==
X-Received: by 10.66.79.97 with SMTP id i1mr13196084pax.47.1359118210738;
        Fri, 25 Jan 2013 04:50:10 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id im5sm627702pbc.55.2013.01.25.04.50.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 04:50:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 25 Jan 2013 19:50:38 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214548>

While at there, do not stop user from editing a branch description
when the unrelated HEAD is detached.
---
 builtin/branch.c  | 12 ++++++------
 t/t3200-branch.sh |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 50fcacc..ca61c5b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -852,14 +852,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
 
-		if (detached)
-			die("Cannot give description to detached HEAD");
-		if (!argc)
+		if (!argc) {
+			if (detached)
+				die("Cannot give description to detached HEAD");
 			branch_name = head;
-		else if (argc == 1)
+		} else if (argc == 1)
 			branch_name = argv[0];
 		else
-			usage_with_options(builtin_branch_usage, options);
+			die(_("cannot edit description of more than one branch"));
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf)) {
@@ -881,7 +881,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else if (argc == 2)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
-			usage_with_options(builtin_branch_usage, options);
+			die(_("too many branches for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 80e6be3..f3e0e4a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -73,8 +73,8 @@ test_expect_success \
 
 test_expect_success \
     'git branch -m dumps usage' \
-       'test_expect_code 129 git branch -m 2>err &&
-	test_i18ngrep "[Uu]sage: git branch" err'
+       'test_expect_code 128 git branch -m 2>err &&
+	test_i18ngrep "too many branches for a rename operation" err'
 
 test_expect_success \
     'git branch -m m m/m should work' \
-- 
1.8.0.rc2.23.g1fb49df
