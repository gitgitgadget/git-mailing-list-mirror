From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH] git-log: allow --decorate[=short|full]
Date: Sat, 15 Aug 2009 16:23:12 +0200
Message-ID: <8c5c35580908150723h6e4c8fcay43b708969a86ae27@mail.gmail.com>
References: <8c5c35580908150250y62b1042cmf6071016bac98a48@mail.gmail.com>
	 <20090815122812.GB30630@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 16:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McKAD-0004RE-Uf
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 16:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbZHOOXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 10:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbZHOOXN
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 10:23:13 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:36761 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbZHOOXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 10:23:12 -0400
Received: by yxe5 with SMTP id 5so2596562yxe.33
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F9UFmZK/eOd5NE1lgYL1IMOHjLS05dbFG3YW4j29CWQ=;
        b=rB6ThBD5N74nJZxXQWCuJKl7SgbG6XrZgcIibbLukOYPwqvOUWHz4SnN7agSQgEzQv
         +rMPciRvwT4G8gxfAdI/8Sm6pQ7a0K8g+PHCMz/CoE9P3ajuAFopmGZ7t4nYy5piRQKM
         e8qvLrrIOk9Mkx/Immjh9zfePBumu9WZSQK3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FG3NK22fbaq7KGd2ORgNxtYRAUZtRJXCCueKPk+YgMjrpirGwtckXGWrrUMJIgk/09
         nYJyJTOp/jJzwiKLSCNDc+Yv+vOXI/XND5lNPxGMcgj66JJI9X9wNPfi38Num318pW2y
         76TSpFoz3pKY4E/zqvxtrY+Z3u/GdMz+fydSQ=
Received: by 10.150.89.41 with SMTP id m41mr3550318ybb.277.1250346192883; Sat, 
	15 Aug 2009 07:23:12 -0700 (PDT)
In-Reply-To: <20090815122812.GB30630@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126006>

Commit de435ac0 changed the behavior of --decorate from printing the
full ref (e.g., "refs/heads/master") to a shorter, more human-readable
version (e.g., just "master"). While this is nice for human readers,
external tools using the output from "git log" may prefer the full
version.

This patch introduces an extension to --decorate to allow the caller to
specify either the short or the full versions.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Thanks for the review. I've adapted the patch to your comments, and
modified the documentation of '--decorate' to be more specific.

 Documentation/git-log.txt                          |    8 ++++++--
 builtin-log.c                                      |   13 +++++++++++--
 log-tree.c                                         |    7 ++++---
 log-tree.h                                         |    2 +-
 pretty.c                                           |    2 +-
 revision.c                                         |    2 +-
 revision.h                                         |    5 ++++-
 t/t4013-diff-various.sh                            |    1 +
 ...corate_--all => diff.log_--decorate=full_--all} |    8 ++++----
 9 files changed, 33 insertions(+), 15 deletions(-)
 copy t/t4013/{diff.log_--decorate_--all =>
diff.log_--decorate=full_--all} (72%)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 34cf4e5..3d79de1 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -37,8 +37,12 @@ include::diff-options.txt[]
 	and <until>, see "SPECIFYING REVISIONS" section in
 	linkgit:git-rev-parse[1].

---decorate::
-	Print out the ref names of any commits that are shown.
+--decorate[=short|full]::
+	Print out the ref names of any commits that are shown. If 'short' is
+	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
+	'refs/remotes/' will not be printed. If 'full' is specified, the
+	full ref name (including prefix) will be printed. The default option
+	is 'short'.

 --source::
 	Print out the ref name given on the command line by which each
diff --git a/builtin-log.c b/builtin-log.c
index 3817bf1..1ed4c76 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -61,8 +61,15 @@ static void cmd_log_init(int argc, const char
**argv, const char *prefix,
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--decorate")) {
-			load_ref_decorations();
-			rev->show_decorations = 1;
+			rev->show_decorations = DECORATE_SHORT_REFS;
+		} else if (!prefixcmp(arg, "--decorate=")) {
+			const char *v = skip_prefix(arg, "--decorate=");
+			if (!strcmp(v, "full"))
+				rev->show_decorations = DECORATE_FULL_REFS;
+			else if (!strcmp(v, "short"))
+				rev->show_decorations = DECORATE_SHORT_REFS;
+			else
+				die("invalid --decorate option: %s", arg);
 		} else if (!strcmp(arg, "--source")) {
 			rev->show_source = 1;
 		} else if (!strcmp(arg, "-h")) {
@@ -70,6 +77,8 @@ static void cmd_log_init(int argc, const char
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
index fb74492..9a644ee 100644
--- a/revision.h
+++ b/revision.h
@@ -15,6 +15,9 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define ALL_REV_FLAGS	((1u<<9)-1)

+#define DECORATE_SHORT_REFS	1
+#define DECORATE_FULL_REFS	2
+
 struct rev_info;
 struct log_info;

@@ -56,7 +59,6 @@ struct rev_info {
 			rewrite_parents:1,
 			print_parents:1,
 			show_source:1,
-			show_decorations:1,
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
@@ -96,6 +98,7 @@ struct rev_info {
 	const char	*subject_prefix;
 	int		no_inline;
 	int		show_log_size;
+	int		show_decorations;

 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
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
