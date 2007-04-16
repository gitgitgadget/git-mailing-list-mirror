From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Add support for "commit name decorations" to log family
 of commands
Date: Mon, 16 Apr 2007 16:05:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704161603220.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704161600470.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>, "Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdaGA-000539-Q8
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 01:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbXDPXFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 19:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbXDPXFU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 19:05:20 -0400
Received: from smtp.osdl.org ([65.172.181.24]:55150 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017AbXDPXFS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 19:05:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GN5BIs008086
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 16:05:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GN5Aeh014530;
	Mon, 16 Apr 2007 16:05:10 -0700
In-Reply-To: <Pine.LNX.4.64.0704161600470.5473@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.95 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44701>


This adds "--decorate" as a log option, which prints out the ref names 
of any commits that are shown.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I'm not married to the exact format, but if people prefer some other 
setup it should be easy to change. The code is fairly simple and obvious.

 builtin-log.c |   34 ++++++++++++++++++++++++++++++++--
 commit.h      |    8 ++++++++
 log-tree.c    |   21 +++++++++++++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 4699494..38bf52f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -13,16 +13,43 @@
 #include "tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
+#include "refs.h"
 
 static int default_show_root = 1;
 
 /* this is in builtin-diff.c */
 void add_head(struct rev_info *revs);
 
+static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
+{
+	int plen = strlen(prefix);
+	int nlen = strlen(name);
+	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
+	memcpy(res->name, prefix, plen);
+	memcpy(res->name + plen, name, nlen + 1);
+	res->next = add_decoration(&name_decoration, obj, res);
+}
+
+static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct object *obj = parse_object(sha1);
+	if (!obj)
+		return 0;
+	add_name_decoration("", refname, obj);
+	while (obj->type == OBJ_TAG) {
+		obj = ((struct tag *)obj)->tagged;
+		if (!obj)
+			break;
+		add_name_decoration("tag: ", refname, obj);
+	}
+	return 0;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
 	int i;
+	int decorate = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -39,8 +66,11 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 				git_log_output_encoding = xstrdup(arg);
 			else
 				git_log_output_encoding = "";
-		}
-		else
+		} else if (!strcmp(arg, "--decorate")) {
+			if (!decorate)
+				for_each_ref(add_ref_decoration, NULL);
+			decorate = 1;
+		} else
 			die("unrecognized argument: %s", arg);
 	}
 }
diff --git a/commit.h b/commit.h
index 83507a0..59de17e 100644
--- a/commit.h
+++ b/commit.h
@@ -3,6 +3,7 @@
 
 #include "object.h"
 #include "tree.h"
+#include "decorate.h"
 
 struct commit_list {
 	struct commit *item;
@@ -21,6 +22,13 @@ struct commit {
 extern int save_commit_buffer;
 extern const char *commit_type;
 
+/* While we can decorate any object with a name, it's only used for commits.. */
+extern struct decoration name_decoration;
+struct name_decoration {
+	struct name_decoration *next;
+	char name[1];
+};
+
 struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
diff --git a/log-tree.c b/log-tree.c
index dad5513..300b733 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -4,6 +4,8 @@
 #include "log-tree.h"
 #include "reflog-walk.h"
 
+struct decoration name_decoration = { "object names" };
+
 static void show_parents(struct commit *commit, int abbrev)
 {
 	struct commit_list *p;
@@ -13,6 +15,23 @@ static void show_parents(struct commit *commit, int abbrev)
 	}
 }
 
+static void show_decorations(struct commit *commit)
+{
+	const char *prefix;
+	struct name_decoration *decoration;
+
+	decoration = lookup_decoration(&name_decoration, &commit->object);
+	if (!decoration)
+		return;
+	prefix = " (";
+	while (decoration) {
+		printf("%s%s", prefix, decoration->name);
+		prefix = ", ";
+		decoration = decoration->next;
+	}
+	putchar(')');
+}
+
 /*
  * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
  * Signed-off-by: and Acked-by: lines.
@@ -136,6 +155,7 @@ void show_log(struct rev_info *opt, const char *sep)
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->parents)
 			show_parents(commit, abbrev_commit);
+		show_decorations(commit);
 		putchar(opt->diffopt.line_termination);
 		return;
 	}
@@ -240,6 +260,7 @@ void show_log(struct rev_info *opt, const char *sep)
 			printf(" (from %s)",
 			       diff_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
+		show_decorations(commit);
 		printf("%s",
 		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
-- 
1.5.1.1.107.g7a15
