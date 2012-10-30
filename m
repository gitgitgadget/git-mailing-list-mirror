From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 20:06:27 +0100
Message-ID: <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 20:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTH9n-0003H2-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965585Ab2J3THH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:07:07 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52686 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965222Ab2J3THD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 15:07:03 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so340997bkc.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yBXjvVRWqMB4YkO3D5ZCrj4lTd0FiJgw9sLuODBiGi4=;
        b=mdM5vjkv9oxmHAYNkyzaEd0qKokFSv8AaqWo4/rKyKu5PnoqBLg7Srdzhua7wO01Av
         FIf40IOhokDSQC+VcXQoMbiZ9dzaSUQqBEl8zedNm8qpyxIfwfdsqhkH26Urtjsc9Zi6
         8FqocaqCL7YHQ0usYvZVcQKHH4mBCag6S3ZVh6exDxO27XayXkjiaU6XfWYIfPFdmRmj
         fUzHsC/vCIamQHOvkXCRHUO8fjXoZVacZmf1VOni/8y4JoE/rYsDjfaxZb9ha07iY2Sw
         ePBLcmD1Xn5GycHg8u33unNjqttg8wBx9XnrLNNBYif2YV2eLygUnmiBtBByRztfd36K
         AEdQ==
Received: by 10.204.9.3 with SMTP id j3mr10864746bkj.15.1351624022882;
        Tue, 30 Oct 2012 12:07:02 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id e13sm1968382bkw.12.2012.10.30.12.06.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 12:07:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208730>

When an object has already been exported (and thus is in the marks) it
is flagged as SHOWN, so it will not be exported again, even if this time
it's exported through a different ref.

We don't need the object to be exported again, but we want the ref
updated, which doesn't happen.

Since we can't know if a ref was exported or not, let's just assume that
if the commit was marked (flags & SHOWN), the user still wants the ref
updated.

So:

 % git branch test master
 % git fast-export $mark_flags master
 % git fast-export $mark_flags test

Would export 'test' properly.

Additionally, this fixes issues with remote helpers; now they can push
refs wich objects have already been exported.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c     | 11 ++++++++---
 t/t5800-remote-helpers.sh | 11 +++++++++++
 t/t9350-fast-export.sh    | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7fb6fe1..663a93d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -523,11 +523,16 @@ static void get_tags_and_duplicates(struct object_array *pending,
 				typename(e->item->type));
 			continue;
 		}
-		if (commit->util) {
-			/* more than one name for the same object */
+
+		/*
+		 * This ref will not be updated through a commit, lets make
+		 * sure it gets properly upddated eventually.
+		 */
+		if (commit->util || commit->object.flags & SHOWN) {
 			if (!(commit->object.flags & UNINTERESTING))
 				string_list_append(extra_refs, full_name)->util = commit;
-		} else
+		}
+		if (!commit->util)
 			commit->util = full_name;
 	}
 }
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index e7dc668..69a145a 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -145,4 +145,15 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs clone HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'push ref with existing object' '
+	(cd localclone &&
+	git branch point-to-master master &&
+	git push origin point-to-master
+	) &&
+
+	(cd server &&
+	git show-ref refs/heads/point-to-master
+	)
+'
+
 test_done
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 6ea8f6f..a4178e3 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -446,4 +446,18 @@ test_expect_success 'proper extra refs handling' '
 	test_cmp expected actual
 '
 
+cat > expected << EOF
+reset refs/heads/master
+from :13
+
+EOF
+
+test_expect_success 'refs are updated even if no commits need to be exported' '
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
