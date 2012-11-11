From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 14/15] fast-export: make sure updated refs get updated
Date: Sun, 11 Nov 2012 14:59:51 +0100
Message-ID: <1352642392-28387-15-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY6Z-00080m-8w
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab2KKOB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:01:26 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab2KKOBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:01:25 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c6XTPMYHGL82nSlyQ/TEc+KZk54MJdU7nhDthnEQxls=;
        b=mrIWhmKgBfHv8VofeXRLcbYxXB+DWl3vJbKudL91AlLesyChDKT3IAl9vsCl2chgLb
         L7xs5+BpQUsJAwWqwvkPupwe9PXt7Ars3+bGR34kXEyX2nzmweIJIBuzp4pEZa8pTV6K
         Xa8MdUGv+ck9lDcaQHhNfsv08PfMj7LWitszb/rv1NtzjM/MyjDPgZsOeI5t/2OPFlem
         yKDdlRJjr1EaOXdHeVcx6JoR/vBfx1Zq2WKUBIIYaSPK/Xgb9ReW6CXnEfOAR/n7RFKH
         oIAVCd3b1Lrp84Fa4hnw9WuOVS45M72MMYWMu4u7+0VrfkXS5mWh/SUoxKSh+wxsp8/4
         9TJg==
Received: by 10.204.8.17 with SMTP id f17mr316434bkf.110.1352642484560;
        Sun, 11 Nov 2012 06:01:24 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id hu14sm1487704bkc.12.2012.11.11.06.01.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:01:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209369>

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
index 31940c9..b6cc5c0 100644
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -63,18 +63,6 @@ test_expect_success 'fetch new branch' '
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
@@ -110,13 +98,13 @@ test_expect_failure 'push new branch with old:new refspec' '
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
@@ -159,4 +147,12 @@ test_expect_failure 'pushing without marks' '
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
