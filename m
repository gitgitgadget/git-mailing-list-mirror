From: Deepak Saxena <dsaxena@plexity.net>
Subject: [PATCH] Use commit template when cherry picking
Date: Thu, 10 Jan 2008 23:45:05 -0800
Message-ID: <20080111074505.GC14022@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Perry Wagle <pwagle@mvista.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 08:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDEaA-0000gW-Dw
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYAKHpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbYAKHpJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:45:09 -0500
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:51356
	"EHLO QMTA10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140AbYAKHpH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 02:45:07 -0500
Received: from OMTA10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by QMTA10.westchester.pa.mail.comcast.net with comcast
	id bjaW1Y00E0cZkys5A00W00; Fri, 11 Jan 2008 07:45:06 +0000
Received: from plexity.net ([71.59.208.117])
	by OMTA10.westchester.pa.mail.comcast.net with comcast
	id bjko1Y0012YWqFb3W00000; Fri, 11 Jan 2008 07:44:49 +0000
X-Authority-Analysis: v=1.0 c=1 a=5A2GFgTln-UA:10 a=5nLO5BDCAAAA:8 a=gQGbs8_HAAAA:8 a=eQxQWBvfHLyWa0qMaD0A:9 a=9fb7uCHkvtBUCznJZDkA:7 a=DAxkoPWO1dzTM70oufR_jOc3IbAA:4 a=gH_wm7_JyAQA:10 a=hpF-ijbX5cwA:10
Received: by plexity.net (Postfix, from userid 1025)
	id 3AF0B544518; Thu, 10 Jan 2008 23:45:05 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70135>

When using a workflow with a default commit message template/header,
git-cherry-pick should also pick that up. Users can manually read
the header into the commit message, but this is simpler.

Signed-off-by: Deepak Saxena <dsaxena@mvista.com>

---

We are using git to manage our kernel tree and we often cherry-pick
patches from upstream and while we want to save the original commit
message, we also want to apply our default commit header to the log.
If this patch is not the ideal solution, please let me know how
I should go about this.

(I'm not on the mailing list, so please cc: me on replies)

diff --git a/builtin-commit.c b/builtin-commit.c
index 73f1e35..6bd937a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -43,7 +43,8 @@ static enum {
 	COMMIT_PARTIAL,
 } commit_style;
 
-static char *logfile, *force_author, *template_file;
+char *template_file;
+static char *logfile, *force_author;
 static char *edit_message, *use_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, untracked_files, no_verify, allow_empty;
@@ -89,7 +90,7 @@ static struct option builtin_commit_options[] = {
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header"),
-	OPT_STRING('t', "template", &template_file, "FILE", "use specified template file"),
+	OPT_STRING('t', "template", &template_file, "FILE", "use specified commit message template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 
 	OPT_GROUP("Commit contents options"),
diff --git a/builtin-revert.c b/builtin-revert.c
index 4bf8eb2..cbb57c6 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -8,6 +8,7 @@
 #include "exec_cmd.h"
 #include "utf8.h"
 #include "parse-options.h"
+#include "strbuf.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -49,6 +50,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
 		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-picking"),
+		OPT_STRING('t', "template", &template_file, "FILE", "use specified commit message template file"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_END(),
@@ -249,16 +251,24 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
+	struct strbuf sb;
 	int i;
 	char *oneline, *reencoded_message = NULL;
 	const char *message, *encoding;
 	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
 
-	git_config(git_default_config);
+	git_config(git_commit_config);	
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
 
+	strbuf_init(&sb, 0);
+	if (template_file) {
+		if (strbuf_read_file(&sb, template_file, 0) < 0)
+			 die("could not read %s: %s", 
+				template_file, strerror(errno));
+	}
+
 	/* this is copied from the shell script, but it's never triggered... */
 	if (action == REVERT && !no_replay)
 		die("revert is incompatible with replay");
@@ -332,6 +342,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	oneline = get_oneline(message);
 
+	add_to_msg(sb.buf);
+
 	if (action == REVERT) {
 		char *oneline_body = strchr(oneline, ' ');
 
diff --git a/commit.h b/commit.h
index 10e2b5d..7746ec6 100644
--- a/commit.h
+++ b/commit.h
@@ -23,6 +23,7 @@ struct commit {
 
 extern int save_commit_buffer;
 extern const char *commit_type;
+extern char *template_file;
 
 /* While we can decorate any object with a name, it's only used for commits.. */
 extern struct decoration name_decoration;
@@ -116,6 +117,8 @@ int in_merge_bases(struct commit *, struct commit **, int);
 extern int interactive_add(int argc, const char **argv, const char *prefix);
 extern int rerere(void);
 
+extern int git_commit_config(const char *k, const char *v);
+
 static inline int single_parent(struct commit *commit)
 {
 	return commit->parents && !commit->parents->next;

-- 
   _____   __o  Living Deepak Saxena - CarFree and CareFree            (o>
------    -\<,  Towards Carfree Cities 2008 - www.carfreeportland.org  //\
 ----- ( )/ ( ) Linux Plumber's Conference - www.linuxplumbersconf.org V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
