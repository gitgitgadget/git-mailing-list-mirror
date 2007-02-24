From: Peter Baumann <waste.manager@gmx.de>
Subject: [RFC/PATCH] Fix git-diff --cached to not error out if HEAD points to a nonexistant branch
Date: Sat, 24 Feb 2007 18:20:37 +0100
Message-ID: <20070224172037.GA31963@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 24 18:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL0di-0004Zp-7Y
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 18:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbXBXRYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 12:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbXBXRYM
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 12:24:12 -0500
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:47229 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S932617AbXBXRYL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Feb 2007 12:24:11 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Feb 2007 12:24:10 EST
Received: (qmail 21848 invoked by uid 0); 24 Feb 2007 17:17:28 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 24 Feb 2007 17:17:28 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40520>

The documentation mentions "git-diff --cached" to see what is staged for
the next commit. But this failes if you haven't done any commits yet.
So lets fix it.

Signed-off-by: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
---

I was bitten by this during explaining a total git newbie the index and
the several ways to diff index <-> wd, index <-> commit, commit <-> commit.
I posted this example

 mkdir testrepo && cd testrepo
 git init
 echo foo > test.txt
 git add test.txt

 git diff --cached
 usage: git-diff <options> <rev>{0,2} -- <path>*

and was totaly shocked to see the above error message.
I am not sure if this is the right fix and/or if git-diff-index
should also be fixed. I decided against it and let the core cmd git-diff-index
stay as it is now.

 builtin-diff.c         |   22 +++++++++++++++++++---
 t/t4017-diff-cached.sh |   21 +++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100755 t/t4017-diff-cached.sh

diff --git a/builtin-diff.c b/builtin-diff.c
index c387ebb..aace507 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -203,11 +203,27 @@ void add_head(struct rev_info *revs)
 {
 	unsigned char sha1[20];
 	struct object *obj;
-	if (get_sha1("HEAD", sha1))
+	int ret = get_sha1("HEAD", sha1);
+	if (ret > 0)
 		return;
-	obj = parse_object(sha1);
-	if (!obj)
+
+	if (ret == 0)
+		obj = parse_object(sha1);
+	else {
+		/* HEAD exists but the branch it points to does not;
+		 * we haven't done any commit yet => create an empty tree
+		 * to make git diff --cached work
+		 */
+		obj = xcalloc(1, sizeof(struct object));
+	        obj->parsed = 1;
+		obj->type = OBJ_TREE;
+
+		pretend_sha1_file(NULL, 0, tree_type, obj->sha1);
+	}
+
+	if (!obj) {
 		return;
+	}
 	add_pending_object(revs, obj, "HEAD");
 }
 
diff --git a/t/t4017-diff-cached.sh b/t/t4017-diff-cached.sh
new file mode 100755
index 0000000..39fc32f
--- /dev/null
+++ b/t/t4017-diff-cached.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Peter Baumann
+#
+
+test_description='Test diff --cached without inital commit.
+
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'setup' \
+    'echo frotz >rezrov &&
+     git-update-index --add rezrov'
+
+test_expect_success \
+    'git-diff --cached' \
+    'git-diff --cached'
+
+test_done
+
-- 
1.5.0.1.213.g509b-dirty
