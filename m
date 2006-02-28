From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] apply --whitespace: configuration option.
Date: Mon, 27 Feb 2006 17:13:44 -0800
Message-ID: <7vacccuvxz.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 02:13:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDtR2-0006n5-Hc
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 02:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWB1BNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 20:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbWB1BNs
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 20:13:48 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:2728 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751878AbWB1BNr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 20:13:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228011103.LUJU17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 20:11:03 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16904>

The new configuration option apply.whitespace can take one of
"warn", "error", "error-all", or "strip".  When git-apply is run
to apply the patch to the index, they are used as the default
value if there is no command line --whitespace option.

Andrew can now tell people who feed him git trees to update to
this version and say:

	git repo-config apply.whitespace error

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Already in "next".

 apply.c       |   72 ++++++++++++++++++++++++++++++++++++++-------------------
 cache.h       |    2 ++
 environment.c |    1 +
 3 files changed, 51 insertions(+), 24 deletions(-)

2ae1c53b51ff78b13cc8abf8e9798a12140b7638
diff --git a/apply.c b/apply.c
index 8139d83..a5cdd8e 100644
--- a/apply.c
+++ b/apply.c
@@ -35,16 +35,42 @@ static const char apply_usage[] =
 "git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] [-pNUM] <patch>...";
 
 static enum whitespace_eol {
-	nowarn,
+	nowarn_whitespace,
 	warn_on_whitespace,
 	error_on_whitespace,
-	strip_and_apply,
-} new_whitespace = nowarn;
+	strip_whitespace,
+} new_whitespace = nowarn_whitespace;
 static int whitespace_error = 0;
 static int squelch_whitespace_errors = 5;
 static int applied_after_stripping = 0;
 static const char *patch_input_file = NULL;
 
+static void parse_whitespace_option(const char *option)
+{
+	if (!option) {
+		new_whitespace = nowarn_whitespace;
+		return;
+	}
+	if (!strcmp(option, "warn")) {
+		new_whitespace = warn_on_whitespace;
+		return;
+	}
+	if (!strcmp(option, "error")) {
+		new_whitespace = error_on_whitespace;
+		return;
+	}
+	if (!strcmp(option, "error-all")) {
+		new_whitespace = error_on_whitespace;
+		squelch_whitespace_errors = 0;
+		return;
+	}
+	if (!strcmp(option, "strip")) {
+		new_whitespace = strip_whitespace;
+		return;
+	}
+	die("unrecognized whitespace option '%s'", option);
+}
+
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
  * we've seen, and the longest filename. That allows us to do simple
@@ -832,7 +858,7 @@ static int parse_fragment(char *line, un
 			 * That is, an addition of an empty line would check
 			 * the '+' here.  Sneaky...
 			 */
-			if ((new_whitespace != nowarn) &&
+			if ((new_whitespace != nowarn_whitespace) &&
 			    isspace(line[len-2])) {
 				whitespace_error++;
 				if (squelch_whitespace_errors &&
@@ -1129,7 +1155,7 @@ static int apply_line(char *output, cons
 	 * patch[plen] is '\n'.
 	 */
 	int add_nl_to_tail = 0;
-	if ((new_whitespace == strip_and_apply) &&
+	if ((new_whitespace == strip_whitespace) &&
 	    1 < plen && isspace(patch[plen-1])) {
 		if (patch[plen] == '\n')
 			add_nl_to_tail = 1;
@@ -1824,10 +1850,21 @@ static int apply_patch(int fd, const cha
 	return 0;
 }
 
+static int git_apply_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "apply.whitespace")) {
+		apply_default_whitespace = strdup(value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
+
 int main(int argc, char **argv)
 {
 	int i;
 	int read_stdin = 1;
+	const char *whitespace_option = NULL;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -1895,30 +1932,17 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strncmp(arg, "--whitespace=", 13)) {
-			if (!strcmp(arg+13, "warn")) {
-				new_whitespace = warn_on_whitespace;
-				continue;
-			}
-			if (!strcmp(arg+13, "error")) {
-				new_whitespace = error_on_whitespace;
-				continue;
-			}
-			if (!strcmp(arg+13, "error-all")) {
-				new_whitespace = error_on_whitespace;
-				squelch_whitespace_errors = 0;
-				continue;
-			}
-			if (!strcmp(arg+13, "strip")) {
-				new_whitespace = strip_and_apply;
-				continue;
-			}
-			die("unrecognized whitespace option '%s'", arg+13);
+			whitespace_option = arg + 13;
+			parse_whitespace_option(arg + 13);
+			continue;
 		}
 
 		if (check_index && prefix_length < 0) {
 			prefix = setup_git_directory();
 			prefix_length = prefix ? strlen(prefix) : 0;
-			git_config(git_default_config);
+			git_config(git_apply_config);
+			if (!whitespace_option && apply_default_whitespace)
+				parse_whitespace_option(apply_default_whitespace);
 		}
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
diff --git a/cache.h b/cache.h
index 58eec00..0d3b244 100644
--- a/cache.h
+++ b/cache.h
@@ -161,11 +161,13 @@ extern int hold_index_file_for_update(st
 extern int commit_index_file(struct cache_file *);
 extern void rollback_index_file(struct cache_file *);
 
+/* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int only_use_symrefs;
 extern int diff_rename_limit_default;
 extern int shared_repository;
+extern const char *apply_default_whitespace;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/environment.c b/environment.c
index 251e53c..16c08f0 100644
--- a/environment.c
+++ b/environment.c
@@ -17,6 +17,7 @@ int only_use_symrefs = 0;
 int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = 0;
+const char *apply_default_whitespace = NULL;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
-- 
1.2.3.gbfea
