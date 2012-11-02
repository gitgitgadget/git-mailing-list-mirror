From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 13/14] fast-export: make sure updated refs get updated
Date: Fri,  2 Nov 2012 03:02:17 +0100
Message-ID: <1351821738-17526-14-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bg-0001Jy-O4
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992623Ab2KBCDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:03:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992658Ab2KBCDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:03:20 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+fl7VDJGtixEfI8gnY9AbJXJ1PYQay7rJVqup1U46dk=;
        b=TowCot2KwnXz/WCBAnmZkAvwmZG/3j1K+q9XGTfeWgFWN/iyBsaAPSNSyXg2GqAhJ6
         WmZjg03ZQaNTWB9XVsGkM4M8jUpnorPMghdDp0rK/0pLuyAiyCJP7K4hoQf02+xDoVWs
         oV6ks3Ym3MsBeBwZlcEGpXv3X1v4VxWHbOidq5wOH5ny1nT5r2Je60g3t/dnk+jUkEBb
         GrfOdNshW5AOelFF2kcJcuhfB2ZLblpm3BIKh7eDG9Rx6fXfJne6+OIfO2sC+zUPZ90S
         YWLfc9j741KLwNt08DuUIioaV5TuWGc8fe0BWoTOEJ1tVHZ/tPy3hkUW+iWv9W8+MMQU
         0u2w==
Received: by 10.205.123.147 with SMTP id gk19mr22218bkc.90.1351821800020;
        Thu, 01 Nov 2012 19:03:20 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id r15sm5771423bkw.9.2012.11.01.19.03.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:03:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208909>

When an object has already been exported (and thus is in the marks) it's
flagged as SHOWN, so it will not be exported again, even if in a later
time it's exported through a different ref.

We don't need the object to be exported again, but we want the ref
updated, which doesn't happen.

Since we can't know if a ref was exported or not, let's just assume that
if the commit was marked (flags & SHOWN), the user still wants the ref
updated.

IOW: If it's specified in the command line, it will get updated,
regardless of wihether or not the object was marked.

So:

 % git branch test master
 % git fast-export $mark_flags master
 % git fast-export $mark_flags test

Would export 'test' properly.

Additionally, this fixes issues with remote helpers; now they can push
refs wich objects have already been exported, and a few other issues as
well. So update the tests accordingly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c     | 10 +++++++---
 t/t5801-remote-helpers.sh | 24 ++++++++++--------------
 t/t9350-fast-export.sh    | 15 +++++++++++++++
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4f3c35f..26f6d1c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -523,10 +523,14 @@ static void get_tags_and_duplicates(struct object_array *pending,
 				typename(e->item->type));
 			continue;
 		}
-		if (commit->util)
-			/* more than one name for the same object */
+
+		/*
+		 * This ref will not be updated through a commit, lets make
+		 * sure it gets properly upddated eventually.
+		 */
+		if (commit->util || commit->object.flags & SHOWN)
 			string_list_append(extra_refs, full_name)->util = commit;
-		else
+		if (!commit->util)
 			commit->util = full_name;
 	}
 }
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 83561f8..6e4e078 100644
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -58,18 +58,6 @@ test_expect_success 'fetch new branch' '
 	compare_refs server HEAD local FETCH_HEAD
 '
 
-#
-# This is only needed because of a bug not detected by this script. It will be
-# fixed shortly, but for now lets not cause regressions.
-# 
-test_expect_success 'bump commit in server' '
-	(cd server &&
-	git checkout master &&
-	echo content >>file &&
-	git commit -a -m four) &&
-	compare_refs server HEAD server HEAD
-'
-
 test_expect_success 'fetch multiple branches' '
 	(cd local &&
 	 git fetch
@@ -105,13 +93,13 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
-test_expect_failure 'cloning without refspec' '
+test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 &&
 	compare_refs local2 HEAD server HEAD
 '
 
-test_expect_failure 'pulling without refspecs' '
+test_expect_success 'pulling without refspecs' '
 	(cd local2 &&
 	git reset --hard &&
 	GIT_REMOTE_TESTGIT_REFSPEC="" git pull) &&
@@ -154,4 +142,12 @@ test_expect_failure 'pushing without marks' '
 	compare_refs local2 HEAD server HEAD
 '
 
+test_expect_success 'push ref with existing object' '
+	(cd local &&
+	git branch dup master &&
+	git push origin dup
+	) &&
+	compare_refs local dup server dup
+'
+
 test_done
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b7d3009..67a7372 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -454,4 +454,19 @@ test_expect_success 'test biridectionality' '
 	git fast-import --export-marks=marks-cur --import-marks=marks-cur
 '
 
+cat > expected << EOF
+reset refs/heads/master
+from :12
+
+EOF
+
+test_expect_success 'refs are updated even if no commits need to be exported' '
+	echo -n > tmp-marks &&
+	git fast-export --import-marks=tmp-marks \
+		--export-marks=tmp-marks master > /dev/null &&
+	git fast-export --import-marks=tmp-marks \
+		--export-marks=tmp-marks master > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.0
