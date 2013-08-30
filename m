From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 00:00:05 -0500
Message-ID: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 07:04:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFGt8-00005L-T5
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 07:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab3H3FEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 01:04:46 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:64180 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab3H3FEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 01:04:46 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so1780875oah.9
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 22:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=i3uHOnXhhS0ymaRdYzy0WK2+ntV3t7EL/C8k37AUK9E=;
        b=XBY3HGhyhqNDz4K+XSyPYGWn695MqwBcCEvs4yVrShiGJJ8fPrrn4l6LPfZ9DDVqrI
         VxQ17VeDtnB1OhZtomX4ClMY9TCXD9nLGvmH8lIKQEXGj5yJ11DYig4ElK/p7Z7BwyFH
         ssff40/cZXqxH11Bc5Pfk2Yu6iqDl382KAA3IMtNFUG8VXY6GbEuISvvX3UPySHeJejf
         YzXyR9MiSf8iQ97RPHcZOTeFCCb08A26wtveARvHfKMTTsag/d+RJuTlCzeRPNxpl77t
         kEHF5hlgDQQM4oaufAW06HpAYBfpPWKSP73IQC15nDURU3c3dDU5kw6Ixxl+NRtXMLR/
         Y4rQ==
X-Received: by 10.182.131.166 with SMTP id on6mr5325870obb.60.1377839083187;
        Thu, 29 Aug 2013 22:04:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z2sm35539854obi.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 22:04:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233392>

So that it's possible to remove certain refs from the list without
removing the objects that are referenced by other refs.

For example this repository:

  * 374e8dd (crap) crap
  * 4cbbf7b (test) two
  * d025ae0 (HEAD, master) one

When using '--branches --except crap':

  * 4cbbf7b (test) two
  * d025ae0 (HEAD, master) one

But when using '--branches --not crap' nothing will come out.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-rev-parse.txt        |  6 ++++++
 contrib/completion/git-completion.bash |  2 +-
 revision.c                             | 10 ++++++++++
 revision.h                             |  3 ++-
 t/t6112-rev-list-except.sh             | 35 ++++++++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100755 t/t6112-rev-list-except.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2b126c0..fe5cc6b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -110,6 +110,12 @@ can be used.
 	strip '{caret}' prefix from the object names that already have
 	one.
 
+--except::
+	Skip the following object names. For example:
+	'--branches --except master' will show all the branches, except master.
+	This differs from --not in that --except will still show the object, if
+	they are referenced by another object name.
+
 --symbolic::
 	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5da920e..aed8c12 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1386,7 +1386,7 @@ _git_ls_tree ()
 
 # Options that go well for log, shortlog and gitk
 __git_log_common_options="
-	--not --all
+	--not --except --all
 	--branches --tags --remotes
 	--first-parent --merges --no-merges
 	--max-count=
diff --git a/revision.c b/revision.c
index 84ccc05..375adab 100644
--- a/revision.c
+++ b/revision.c
@@ -1984,6 +1984,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		handle_reflog(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING | BOTTOM;
+	} else if (!strcmp(arg, "--except")) {
+		*flags ^= SKIP;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
 	} else if (!prefixcmp(arg, "--no-walk=")) {
@@ -2578,6 +2580,7 @@ int prepare_revision_walk(struct rev_info *revs)
 	int nr = revs->pending.nr;
 	struct object_array_entry *e, *list;
 	struct commit_list **next = &revs->commits;
+	int i;
 
 	e = list = revs->pending.objects;
 	revs->pending.nr = 0;
@@ -2585,12 +2588,19 @@ int prepare_revision_walk(struct rev_info *revs)
 	revs->pending.objects = NULL;
 	while (--nr >= 0) {
 		struct commit *commit = handle_commit(revs, e->item, e->name);
+		for (i = 0; i < revs->cmdline.nr; i++) {
+			struct rev_cmdline_entry *ce;
+			ce = &revs->cmdline.rev[i];
+			if ((ce->flags & SKIP) && !strcmp(ce->name, e->name))
+				goto next;
+		}
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
 				next = commit_list_append(commit, next);
 			}
 		}
+next:
 		e++;
 	}
 	if (!revs->leak_pending)
diff --git a/revision.h b/revision.h
index 95859ba..89f5037 100644
--- a/revision.h
+++ b/revision.h
@@ -17,7 +17,8 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
 #define BOTTOM		(1u<<10)
-#define ALL_REV_FLAGS	((1u<<11)-1)
+#define SKIP		(1u<<11)
+#define ALL_REV_FLAGS	((1u<<12)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
diff --git a/t/t6112-rev-list-except.sh b/t/t6112-rev-list-except.sh
new file mode 100755
index 0000000..b8f9a61
--- /dev/null
+++ b/t/t6112-rev-list-except.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='test for rev-list --except'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	echo one > content &&
+	git add content &&
+	git commit -m one &&
+	git checkout -b test master &&
+	echo two > content &&
+	git commit -a -m two &&
+	git checkout -b merge master &&
+	git merge test
+'
+
+test_expect_success 'rev-list --except' '
+
+	git rev-list --topo-order --branches --except merge > actual &&
+	git rev-list --topo-order test > expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --except with extra' '
+
+	echo three > content &&
+	git commit -a -m three &&
+	git rev-list --topo-order --branches --except merge > actual &&
+	git rev-list --topo-order test > expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.4-fc
