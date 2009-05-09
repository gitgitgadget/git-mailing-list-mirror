From: Dave O <cxreg@pobox.com>
Subject: [PATCH] fix for incorrect index update
Date: Sat, 9 May 2009 14:49:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905091356070.21000@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 23:50:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2uR2-0001vn-9f
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 23:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbZEIVuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 17:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbZEIVuD
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 17:50:03 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:37994 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753263AbZEIVuC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2009 17:50:02 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id n49Lnxa3006227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 9 May 2009 16:50:01 -0500
X-X-Sender: count@narbuckle.genericorp.net
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118685>

call_depth > 0 requires trees to be constructed from the files with
conflicts, therefore the stages thusly must not be updated

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
  merge-recursive.c          |   11 +++--
  t/t3031-merge-criscross.sh |   95 ++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 101 insertions(+), 5 deletions(-)
  create mode 100644 t/t3031-merge-criscross.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index a3721ef..f5df9b9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -933,11 +933,12 @@ static int process_renames(struct merge_options *o,
  				       ren1_src, ren1_dst, branch1,
  				       branch2);
  				update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
-				update_stages(ren1_dst, NULL,
-						branch1 == o->branch1 ?
-						ren1->pair->two : NULL,
-						branch1 == o->branch1 ?
-						NULL : ren1->pair->two, 1);
+				if (!o->call_depth)
+					update_stages(ren1_dst, NULL,
+							branch1 == o->branch1 ?
+							ren1->pair->two : NULL,
+							branch1 == o->branch1 ?
+							NULL : ren1->pair->two, 1);
  			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
  				const char *new_path;
  				clean_merge = 0;
diff --git a/t/t3031-merge-criscross.sh b/t/t3031-merge-criscross.sh
new file mode 100644
index 0000000..cbfd95b
--- /dev/null
+++ b/t/t3031-merge-criscross.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='merge-recursive backend test'
+
+. ./test-lib.sh
+
+#         A      <- create some files
+#        / \
+#       B   C    <- cause rename/delete conflicts between B and C
+#      /     \
+#     |\     /|
+#     | D   E |
+#     |  \ /  |
+#     |   X   |
+#     |  / \  |
+#     | /   \ |
+#     |/     \|
+#     F       G  <- merge E into B, D into C
+#      \     /
+#       \   /
+#        \ /
+#         H      <- recursive merge crashes
+#
+
+# initialize
+test_expect_success 'setup repo with criss-cross history' '
+	mkdir data &&
+
+	test_debug create a bunch of files &&
+	n=1 &&
+	while test $n -le 10
+	do
+		echo $n > data/$n &&
+		n=$(($n+1)) ||
+		break
+	done &&
+
+	test_debug check them in &&
+	git add data &&
+	git commit -m A &&
+	git branch A &&
+
+	test_debug a file in one branch &&
+	git checkout -b B A &&
+	git rm data/9 &&
+	git add data &&
+	git commit -m B &&
+
+	test_debug with a branch off of it &&
+	git branch D &&
+
+	test_debug put some commits on D &&
+	git checkout D &&
+	echo testD > data/testD &&
+	git add data &&
+	git commit -m D &&
+
+	test_debug back up to the top, create another branch and cause a rename  &&
+	test_debug conflict with the file we deleted earlier &&
+	git checkout -b C A &&
+	git mv data/9 data/new-9 &&
+	git add data &&
+	git commit -m C &&
+
+	test_debug with a branch off of it &&
+	git branch E &&
+
+	test_debug put a commit on E &&
+	git checkout E &&
+	echo testE > data/testE &&
+	git add data &&
+	git commit -m E &&
+
+	test_debug now, merge E into B &&
+	git checkout B &&
+	test_must_fail git merge E &&
+	test_debug force-resolve &&
+	git add data &&
+	git commit -m F &&
+	git branch F &&
+
+	test_debug and merge D into C &&
+	git checkout C &&
+	test_must_fail git merge D &&
+	test_debug force-resolve &&
+	git add data &&
+	git commit -m G &&
+	git branch G
+'
+
+test_expect_failure 'recursive merge between F and G, causes segfault' '
+	git merge F
+'
+
+test_done
-- 
1.6.2.4
