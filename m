From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] revision: add --except option
Date: Sat, 31 Aug 2013 16:26:23 -0500
Message-ID: <1377984383-15770-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 23:31:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFslL-0003Tk-QK
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 23:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab3HaVbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 17:31:08 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:64300 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106Ab3HaVbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 17:31:06 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so3160360obc.17
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aXdpUIWJgC/+IQ3ub+ZlHYb1POhfYQtLpSERmrCi0IE=;
        b=tXFounuc+id/J3L2Ye3HLGXec07yc457+xrsS7jjgWfHtYBCbVwzBCObiMHRTuqK0s
         5BTmsuUUN1E2zPI9zAPnn/TtH2oSi/DD/3O0GRYLR8ieTYX+SDL/AR+jThVMSxo+jeq0
         KGGckfSj6bevuA/O4sxuKUzBslzATDJHJqrbRGcPWTtB9GhSpuqyxuYvBoV98De8DTof
         IT+8//m45hskd/aOsLQTc91+3ikaTTByYHSNRY0tFAokjha8BWE5QXCyfftpvJwTVo5J
         s8TDCpaKaUK7icJi9TRP6MliuVp9g67o0D59FEfQsPvc7e1JgAhzOTTy0A7mPPJ0mbT5
         FV+A==
X-Received: by 10.182.242.11 with SMTP id wm11mr11907709obc.26.1377984664295;
        Sat, 31 Aug 2013 14:31:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm5037839obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 31 Aug 2013 14:31:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233549>

So that it's possible to remove certain refs from the list without
removing the objects that are referenced by other refs.

For example this repository:

  C (crap)
  B (test)
  A (HEAD, master)

When using '--branches --except crap':

  B (test)
  A (HEAD, master)

But when using '--branches --not crap' nothing will come out.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I don't like the complexity of recalculate_flag(), but it seems to be the most
straight-forward way of making --not and --except work.

 Documentation/git-rev-parse.txt        |  6 ++++
 contrib/completion/git-completion.bash |  2 +-
 revision.c                             | 52 ++++++++++++++++++++++++++++-
 revision.h                             |  3 +-
 t/t6112-rev-list-except.sh             | 60 ++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 3 deletions(-)
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
index 84ccc05..a7664dd 100644
--- a/revision.c
+++ b/revision.c
@@ -1984,6 +1984,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		handle_reflog(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING | BOTTOM;
+	} else if (!strcmp(arg, "--except")) {
+		*flags |= SKIP;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
 	} else if (!prefixcmp(arg, "--no-walk=")) {
@@ -2573,24 +2575,72 @@ void reset_revision_walk(void)
 	clear_object_flags(SEEN | ADDED | SHOWN);
 }
 
+static int refcmp(const char *a, const char *b)
+{
+	a = prettify_refname(a);
+	if (*a == '^')
+		a++;
+	b = prettify_refname(b);
+	if (*b == '^')
+		b++;
+	return strcmp(a, b);
+}
+
+static int recalculate_flag(struct rev_info *revs, unsigned char *sha1, const char *name)
+{
+	int flags = 0;
+	int i;
+	for (i = 0; i < revs->cmdline.nr; i++) {
+		struct object *object;
+		struct rev_cmdline_entry *ce;
+		ce = &revs->cmdline.rev[i];
+		object = ce->item;
+		while (object->type == OBJ_TAG) {
+			struct tag *tag = (struct tag *) object;
+			if (!tag->tagged)
+				continue;
+			object = parse_object(tag->tagged->sha1);
+			if (!object)
+				continue;
+		}
+		if (hashcmp(object->sha1, sha1))
+			continue;
+		if (!strcmp(ce->name, name))
+			continue;
+		flags |= ce->flags;
+	}
+	return flags;
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
 	struct object_array_entry *e, *list;
 	struct commit_list **next = &revs->commits;
+	int i;
 
 	e = list = revs->pending.objects;
 	revs->pending.nr = 0;
 	revs->pending.alloc = 0;
 	revs->pending.objects = NULL;
 	while (--nr >= 0) {
-		struct commit *commit = handle_commit(revs, e->item, e->name);
+		struct commit *commit;
+		for (i = 0; i < revs->cmdline.nr; i++) {
+			struct rev_cmdline_entry *ce;
+			ce = &revs->cmdline.rev[i];
+			if ((ce->flags & SKIP) && !refcmp(ce->name, e->name)) {
+				e->item->flags = recalculate_flag(revs, e->item->sha1, ce->name);
+				goto next;
+			}
+		}
+		commit = handle_commit(revs, e->item, e->name);
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
index 0000000..a40a641
--- /dev/null
+++ b/t/t6112-rev-list-except.sh
@@ -0,0 +1,60 @@
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
+test_expect_success 'rev-list --except with full ref' '
+
+	git rev-list --topo-order --branches --except refs/heads/merge > actual &&
+	git rev-list --topo-order test > expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --except and --not' '
+
+	git rev-list --topo-order test --not master --except master > actual &&
+	git rev-list --topo-order test > expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --except and --not with proper flags' '
+
+	git checkout -b maint master &&
+	git checkout -b next test &&
+	echo four > content &&
+	git commit -a -m four &&
+	git rev-list --topo-order next --not master maint --except maint > actual &&
+	git rev-list --topo-order next --not master > expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.4-337-g7358a66-dirty
