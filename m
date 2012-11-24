From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 14/14] fast-export: make sure updated refs get updated
Date: Sat, 24 Nov 2012 04:17:14 +0100
Message-ID: <1353727034-24698-15-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
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
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6GN-0002Mf-Ee
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036Ab2KXDST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:18:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932649Ab2KXDSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:18:17 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4JkQNxN4oiwN+dFOv1N/4uFu9rXXFkc8ejVTgDGAQKU=;
        b=gRAJx0pdrhhrd/PkLJ2RVcWHFWwa3vkXvcEwukAMn2d7klFcjUTBfHvwJLD9KlRV61
         Si7wyvdVaqEacw1lZszxPHzKgsgDRJJni/w/GMRLeQdQxvSMBmiPTsOSrB7UTQZgZG1L
         C5mUI9jEd74+xXwCeCH2I2lZhr8TvA5CW7qLY2qUQJTSjyPpqsGysQdvgOtyMCrhxSWf
         4Lz9GHcBZJW0Z04p4hkuWYKaPWjD72XWBZi1iq5u62GykSzwuACHPoUj36BsEBt5ZN+T
         lCjQGXXt9lXJC3JLj7MHCHz8Iwu/dF1FjDhRTi+IvZNAXN1K3P2pMtj51CTdtd13/dvo
         hcTg==
Received: by 10.204.3.206 with SMTP id 14mr1674394bko.120.1353727096372;
        Fri, 23 Nov 2012 19:18:16 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id e22sm5472846bke.14.2012.11.23.19.18.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:18:15 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210297>

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
index 191936c..31bfbee 100644
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
index 12ae256..b2782a2 100755
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
@@ -162,4 +150,12 @@ test_expect_failure 'pushing without marks' '
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
index 1f59862..237d2e5 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -454,4 +454,19 @@ test_expect_success 'test bidirectionality' '
 	git fast-import --export-marks=marks-cur --import-marks=marks-cur
 '
 
+cat > expected << EOF
+reset refs/heads/master
+from :12
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
1.8.0
