From: Linus Torvalds <torvalds@osdl.org>
Subject: Add "git show-ref" builtin command
Date: Fri, 15 Sep 2006 11:19:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609151108560.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Sep 15 20:20:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOIIB-0004w3-26
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 20:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWIOSTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 14:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWIOSTs
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 14:19:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932140AbWIOSTr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 14:19:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8FIJXnW000433
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Sep 2006 11:19:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8FIJWXq010051;
	Fri, 15 Sep 2006 11:19:32 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-3.506 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27097>


It's kind of like "git peek-remote", but works only locally (and thus 
avoids the whole overhead of git_connect()) and has some extra 
verification features.

For example, it allows you to filter the results, and to choose whether 
you want the tag dereferencing or not. You can also use it to just test 
whether a particular ref exists.

For example:

	git show-ref master

will show all references called "master", whether tags or heads or 
anything else, and regardless of how deep in the reference naming 
hierarchy they are (so it would show "refs/heads/master" but also 
"refs/remote/other-repo/master").

When using the "--verify" flag, the command requires an exact ref path:

	git show-ref --verify refs/heads/master

will only match the exact branch called "master".

If nothing matches, show-ref will return an error code of 1, and in the 
case of verification, it will show an error message.

For scripting, you can ask it to be quiet with the "--quiet" flag, which 
allows you to do things like

	git-show-ref --quiet --verify -- "refs/heads/$headname" ||
		echo "$headname is not a valid branch"

to check whether a particular branch exists or not (notice how we don't 
actually want to show any results, and we want to use the full refname for 
it in order to not trigger the problem with ambiguous partial matches).

To show only tags, or only proper branch heads, use "--tags" and/or 
"--heads" respectively (using both means that it shows tags _and_ heads, 
but not other random references under the refs/ subdirectory).

To do automatic tag object dereferencing, use the "-d" or "--dereference" 
flag, so you can do

	git show-ref --tags --dereference

to get a listing of all tags together with what they dereference.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

NOTE! This is against the current master branch, and does _not_ depend on 
my other ref-work. In fact, I'd argue that this is much better to merge 
first and independently of the packed references branch, because it allows 
us to much more easily update the scripts etc to be totally unaware of how 
the refs are actually stored.

I've given it some basic testing, and it all seems obvious enough.

diff --git a/Makefile b/Makefile
index 7b3114f..c365138 100644
--- a/Makefile
+++ b/Makefile
@@ -295,7 +295,8 @@ BUILTIN_OBJS = \
 	builtin-upload-tar.o \
 	builtin-verify-pack.o \
 	builtin-write-tree.o \
-	builtin-zip-tree.o
+	builtin-zip-tree.o \
+	builtin-show-ref.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
new file mode 100644
index 0000000..161b236
--- /dev/null
+++ b/builtin-show-ref.c
@@ -0,0 +1,112 @@
+#include "cache.h"
+#include "refs.h"
+#include "object.h"
+#include "tag.h"
+
+static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--deref] [--tags] [--heads] [--] [pattern*]";
+
+static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0, found_match = 0, verify = 0, quiet = 0;
+static const char **pattern;
+
+static int show_ref(const char *refname, const unsigned char *sha1)
+{
+	struct object *obj;
+
+	if (tags_only || heads_only) {
+		int match;
+
+		match = heads_only && !strncmp(refname, "refs/heads/", 11);
+		match |= tags_only && !strncmp(refname, "refs/tags/", 10);
+		if (!match)
+			return 0;
+	}
+	if (pattern) {
+		int reflen = strlen(refname);
+		const char **p = pattern, *m;
+		while ((m = *p++) != NULL) {
+			int len = strlen(m);
+			if (len > reflen)
+				continue;
+			if (memcmp(m, refname + reflen - len, len))
+				continue;
+			if (len == reflen)
+				goto match;
+			/* "--verify" requires an exact match */
+			if (verify)
+				continue;
+			if (refname[reflen - len - 1] == '/')
+				goto match;
+		}
+		return 0;
+	}
+
+match:
+	found_match++;
+	obj = parse_object(sha1);
+	if (!obj) {
+		if (quiet)
+			return 0;
+		die("git-show-ref: bad ref %s (%s)", refname, sha1_to_hex(sha1));
+	}
+	if (quiet)
+		return 0;
+	printf("%s %s\n", sha1_to_hex(sha1), refname);
+	if (deref_tags && obj->type == OBJ_TAG) {
+		obj = deref_tag(obj, refname, 0);
+		printf("%s %s^{}\n", sha1_to_hex(obj->sha1), refname);
+	}
+	return 0;
+}
+
+int cmd_show_ref(int argc, const char **argv, const char *prefix)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (*arg != '-') {
+			pattern = argv + i;
+			break;
+		}
+		if (!strcmp(arg, "--")) {
+			pattern = argv + i + 1;
+			if (!*pattern)
+				pattern = NULL;
+			break;
+		}
+		if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet")) {
+			quiet = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-h") || !strcmp(arg, "--head")) {
+			show_head = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-d") || !strcmp(arg, "--dereference")) {
+			deref_tags = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--verify")) {
+			verify = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--tags")) {
+			tags_only = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--heads")) {
+			heads_only = 1;
+			continue;
+		}
+		usage(show_ref_usage);
+	}
+	if (show_head)
+		head_ref(show_ref);
+	for_each_ref(show_ref);
+	if (!found_match) {
+		if (verify && !quiet)
+			die("No match");
+		return 1;
+	}
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 25431d7..bca5f79 100644
--- a/builtin.h
+++ b/builtin.h
@@ -61,5 +61,6 @@ extern int cmd_version(int argc, const c
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/git.c b/git.c
index 8c182a5..fedd536 100644
--- a/git.c
+++ b/git.c
@@ -266,6 +266,7 @@ static void handle_internal_command(int 
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
 		{ "verify-pack", cmd_verify_pack },
+		{ "show-ref", cmd_show_ref, RUN_SETUP },
 	};
 	int i;
 
