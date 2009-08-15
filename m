From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-log: allow --decorate[=short|full]
Date: Sat, 15 Aug 2009 11:50:25 +0200
Message-ID: <8c5c35580908150250y62b1042cmf6071016bac98a48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 11:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McFxV-0005Mm-1l
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 11:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbZHOJu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 05:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbZHOJu0
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 05:50:26 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:33781 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbZHOJuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 05:50:25 -0400
Received: by yxe5 with SMTP id 5so2515454yxe.33
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=4Vs3Gc4jxV0Luzj/8PbBlC09bDrptaBrmjHKLD2enFw=;
        b=cDQrbsRe9iak1P9BbO8cOw8pqDuRkAX0FwA6u0VPabLJbzJcqEmW8muHubE4fMxQZ+
         Slb2W43RWIe/lxRCdp7bocyLNvux8pCVotY2If/HrdkYAFTZGfDmmRgT9IqWm2VmKqRs
         VLinKlyz/pPF5FVd5jMTUJB18wWEdcmtRiuNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=rPvkIKYI/sqhitMPh2+70HiojRDiMs9TMZfwELX2rQV0eAzkvhZrM+yZw5W2dmLjij
         KalvePwypPIJzlb4CH9SBsiNNWuTyUy17tGoSCS81FV5dUABFIDN4fwII0Np3Pq7dY9l
         p8qFgW9bSo4uR/Z0pbP4qpbG1xEFUdKf4Xv/E=
Received: by 10.150.81.1 with SMTP id e1mr3388963ybb.338.1250329825436; Sat, 
	15 Aug 2009 02:50:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125987>

This extension to --decorate makes it possible to generate decorations
similar to pre-1.6.4 git, which is nice when the output from git-log
is used by external tools.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-log.txt                          |    6 ++++--
 builtin-log.c                                      |   12 ++++++++++--
 log-tree.c                                         |    7 ++++---
 log-tree.h                                         |    2 +-
 pretty.c                                           |    2 +-
 revision.c                                         |    2 +-
 revision.h                                         |    6 +++++-
 t/t4013-diff-various.sh                            |    1 +
 ...corate_--all => diff.log_--decorate=full_--all} |    8 ++++----
 9 files changed, 31 insertions(+), 15 deletions(-)
 copy t/t4013/{diff.log_--decorate_--all =>
diff.log_--decorate=full_--all} (72%)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 34cf4e5..451839c 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -37,8 +37,10 @@ include::diff-options.txt[]
 	and <until>, see "SPECIFYING REVISIONS" section in
 	linkgit:git-rev-parse[1].

---decorate::
-	Print out the ref names of any commits that are shown.
+--decorate[=short|full]::
+	Print out the ref names of any commits that are shown. If 'short' is
+	specified, the ref names will be shortened, and if 'full' is specified,
+	the ref names will not be shortened. The default option is 'short'.

 --source::
 	Print out the ref name given on the command line by which each
diff --git a/builtin-log.c b/builtin-log.c
index 3817bf1..cb886d8 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -61,8 +61,14 @@ static void cmd_log_init(int argc, const char
**argv, const char *prefix,
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--decorate")) {
-			load_ref_decorations();
-			rev->show_decorations = 1;
+			rev->show_decorations = DECORATE_SHORT_REFS;
+		} else if (!strncmp(arg, "--decorate=", 11)) {
+			if (!strcmp(arg + 11, "full"))
+				rev->show_decorations = DECORATE_FULL_REFS;
+			else if (!strcmp(arg + 11, "short"))
+				rev->show_decorations = DECORATE_SHORT_REFS;
+			else
+				die("invalid --decorate option: %s", arg + 11);
 		} else if (!strcmp(arg, "--source")) {
 			rev->show_source = 1;
 		} else if (!strcmp(arg, "-h")) {
@@ -70,6 +76,8 @@ static void cmd_log_init(int argc, const char
**argv, const char *prefix,
 		} else
 			die("unrecognized argument: %s", arg);
 	}
+	if (rev->show_decorations)
+		load_ref_decorations(rev->show_decorations);
 }

 /*
diff --git a/log-tree.c b/log-tree.c
index 6f73c17..70223eb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -25,7 +25,8 @@ static int add_ref_decoration(const char *refname,
const unsigned char *sha1, in
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return 0;
-	refname = prettify_refname(refname);
+	if (!cb_data || *(int *)cb_data & DECORATE_SHORT_REFS)
+		refname = prettify_refname(refname);
 	add_name_decoration("", refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
@@ -36,12 +37,12 @@ static int add_ref_decoration(const char *refname,
const unsigned char *sha1, in
 	return 0;
 }

-void load_ref_decorations(void)
+void load_ref_decorations(int flags)
 {
 	static int loaded;
 	if (!loaded) {
 		loaded = 1;
-		for_each_ref(add_ref_decoration, NULL);
+		for_each_ref(add_ref_decoration, &flags);
 	}
 }

diff --git a/log-tree.h b/log-tree.h
index 20b5caf..3f7b400 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -17,7 +17,7 @@ void log_write_email_headers(struct rev_info *opt,
struct commit *commit,
 			     const char **subject_p,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
-void load_ref_decorations(void);
+void load_ref_decorations(int flags);

 #define FORMAT_PATCH_NAME_MAX 64
 void get_patch_filename(struct commit *commit, int nr, const char *suffix,
diff --git a/pretty.c b/pretty.c
index e5328da..daa721b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -571,7 +571,7 @@ static void format_decoration(struct strbuf *sb,
const struct commit *commit)
 	struct name_decoration *d;
 	const char *prefix = " (";

-	load_ref_decorations();
+	load_ref_decorations(DECORATE_SHORT_REFS);
 	d = lookup_decoration(&name_decoration, &commit->object);
 	while (d) {
 		strbuf_addstr(sb, prefix);
diff --git a/revision.c b/revision.c
index 9f5dac5..ce24ad9 100644
--- a/revision.c
+++ b/revision.c
@@ -1052,7 +1052,7 @@ static int handle_revision_opt(struct rev_info
*revs, int argc, const char **arg
 		revs->simplify_by_decoration = 1;
 		revs->limited = 1;
 		revs->prune = 1;
-		load_ref_decorations();
+		load_ref_decorations(DECORATE_SHORT_REFS);
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->lifo = 0;
 		revs->topo_order = 1;
diff --git a/revision.h b/revision.h
index fb74492..16e65f6 100644
--- a/revision.h
+++ b/revision.h
@@ -15,6 +15,10 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define ALL_REV_FLAGS	((1u<<9)-1)

+
+#define DECORATE_SHORT_REFS	1
+#define DECORATE_FULL_REFS	2
+
 struct rev_info;
 struct log_info;

@@ -56,7 +60,7 @@ struct rev_info {
 			rewrite_parents:1,
 			print_parents:1,
 			show_source:1,
-			show_decorations:1,
+			show_decorations:2,
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8b33321..8e3694e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -207,6 +207,7 @@ log --root --cc --patch-with-stat --summary master
 log -SF master
 log -SF -p master
 log --decorate --all
+log --decorate=full --all

 rev-list --parents HEAD
 rev-list --children HEAD
diff --git a/t/t4013/diff.log_--decorate_--all
b/t/t4013/diff.log_--decorate=full_--all
similarity index 72%
copy from t/t4013/diff.log_--decorate_--all
copy to t/t4013/diff.log_--decorate=full_--all
index 954210e..903d9d9 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -1,12 +1,12 @@
-$ git log --decorate --all
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (master)
+$ git log --decorate=full --all
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (refs/heads/master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000

     Merge branch 'side'

-commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000

@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000

     This is the second commit.

-commit 444ac553ac7612cc88969031b02b3767fb8a353a (initial)
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (refs/heads/initial)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:00:00 2006 +0000

-- 
1.6.4.135.g4e5b
