From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p2 2/2] fast-export: make sure updated refs get updated
Date: Wed, 28 Nov 2012 23:24:00 +0100
Message-ID: <1354141440-26534-3-git-send-email-felipe.contreras@gmail.com>
References: <1354141440-26534-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:24:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdq3d-0007Ck-RU
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602Ab2K1WY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:24:26 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58508 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325Ab2K1WYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:24:25 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5975572bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YHtUHU7ZD2oOVdV3zAlcShxgqq+3QoKi2gt9EIEvFRY=;
        b=Mdf7Iss+bODC4vWaC9/2WsyP9gm7kDiv4yif50nK9CgCS/waMez7mVSiH3ikrkmvXz
         2OeNHFqTFwr2nJCCqx0pPTBtL9m0zYT2e7k09zgMFmvYTTO7gFx4poKPibOfpb2gdRFr
         OY7Uercu2VwB78Vlm2u/d+bnDEUwQGY9q4ZwU1HNgHRiVwu2s0+GPaTrmseriwWmm4jj
         gozhUOARQBD1UUGfMBu5u2JPtr/nBzEUVVLM62hHcbFlB+b6P5LPTZsh03mtx0CnZF6s
         0A2JaLy3vz6ZWIGkL5yxrCq4X3ofleAHKzuHsLpQlOVw73bn8HnQwEgxhgRge8iuIE8k
         hPvA==
Received: by 10.204.145.219 with SMTP id e27mr6068247bkv.140.1354141464683;
        Wed, 28 Nov 2012 14:24:24 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id go4sm13836000bkc.15.2012.11.28.14.24.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:24:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354141440-26534-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210800>

When an object has already been exported (and thus is in the marks) it's
flagged as SHOWN, so it will not be exported again, even if in a later
time it's exported through a different ref.

We don't need the object to be exported again, but we want the ref
updated, which doesn't happen.

Since we can't know if a ref was exported or not, let's just assume that
if the commit was marked (flags & SHOWN), the user still wants the ref
updated.

IOW: If it's specified in the command line, it will get updated,
regardless of whether or not the object was marked.

So:

 % git branch test master
 % git fast-export $mark_flags master
 % git fast-export $mark_flags test

Would export 'test' properly.

Additionally, this fixes issues with remote helpers; now they can push
refs whose objects have already been exported, and a few other issues as
well. Update the tests accordingly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c     | 10 +++++++---
 t/t5801-remote-helpers.sh | 20 ++++++++------------
 t/t9350-fast-export.sh    | 15 +++++++++++++++
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2547e6c..77dffd1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -526,10 +526,14 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
 				typename(e->item->type));
 			continue;
 		}
-		if (commit->util)
-			/* more than one name for the same object */
+
+		/*
+		 * This ref will not be updated through a commit, lets make
+		 * sure it gets properly updated eventually.
+		 */
+		if (commit->util || commit->object.flags & SHOWN)
 			string_list_append(extra_refs, full_name)->util = commit;
-		else
+		if (!commit->util)
 			commit->util = full_name;
 	}
 }
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index ece8fd5..f387027 100755
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
@@ -170,4 +158,12 @@ test_expect_success 'push all with existing object' '
 	compare_refs local dup2 server dup2
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
index c8e41c1..9320b4f 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -484,4 +484,19 @@ test_expect_success 'avoid uninteresting refs' '
 	test_cmp expected actual
 '
 
+cat > expected << EOF
+reset refs/heads/master
+from :14
+
+EOF
+
+test_expect_success 'refs are updated even if no commits need to be exported' '
+	> tmp-marks &&
+	git fast-export --import-marks=tmp-marks \
+		--export-marks=tmp-marks master > /dev/null &&
+	git fast-export --import-marks=tmp-marks \
+		--export-marks=tmp-marks master > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.0.1
