From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] pager: config variable pager.color
Date: Sun, 30 Jul 2006 00:27:43 +0200
Message-ID: <E1G6xHb-0008Rw-G2@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 30 00:27:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6xHi-0002ng-0Y
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 00:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWG2W1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 18:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWG2W1q
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 18:27:46 -0400
Received: from moooo.ath.cx ([85.116.203.178]:40903 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750718AbWG2W1q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 18:27:46 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24438>

enable/disable colored output when the pager is in use

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
setup_pager has to be called before git_diff_ui_config because the
latter uses pager_use_color initialized by setup_pager.
---
 Documentation/config.txt |    4 ++++
 builtin-log.c            |    4 +++-
 cache.h                  |    1 +
 diff.c                   |    2 +-
 environment.c            |    1 +
 pager.c                  |    4 ++++
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 96429b6..5e243a8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -121,6 +121,10 @@ pager.program::
 	variable first, then the 'PAGER' environment variable and
 	"less" as fallback.
 
+pager.color::
+	A boolean to enable/disable colored output when the pager is in
+	use (default is true).
+
 diff.color::
 	When true (or `always`), always use colors in patch.
 	When false (or `never`), never.  When set to `auto`, use
diff --git a/builtin-log.c b/builtin-log.c
index 82c69d1..7fdefec 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -34,7 +34,6 @@ static int cmd_log_walk(struct rev_info 
 	struct commit *commit;
 
 	prepare_revision_walk(rev);
-	setup_pager();
 	while ((commit = get_revision(rev)) != NULL) {
 		log_tree_commit(rev, commit);
 		free(commit->buffer);
@@ -49,6 +48,7 @@ int cmd_whatchanged(int argc, const char
 {
 	struct rev_info rev;
 
+	setup_pager();
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
@@ -64,6 +64,7 @@ int cmd_show(int argc, const char **argv
 {
 	struct rev_info rev;
 
+	setup_pager();
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
@@ -81,6 +82,7 @@ int cmd_log(int argc, const char **argv,
 {
 	struct rev_info rev;
 
+	setup_pager();
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
diff --git a/cache.h b/cache.h
index 8891073..913be6a 100644
--- a/cache.h
+++ b/cache.h
@@ -392,6 +392,7 @@ extern int receive_keep_pack(int fd[2], 
 /* pager.c */
 extern void setup_pager(void);
 extern int pager_in_use;
+extern int pager_use_color;
 
 /* base85 */
 int decode_85(char *dst, char *line, int linelen);
diff --git a/diff.c b/diff.c
index 6198a61..16d47bf 100644
--- a/diff.c
+++ b/diff.c
@@ -175,7 +175,7 @@ int git_diff_ui_config(const char *var, 
 			diff_use_color_default = 1; /* bool */
 		else if (!strcasecmp(value, "auto")) {
 			diff_use_color_default = 0;
-			if (isatty(1) || pager_in_use) {
+			if (isatty(1) || (pager_in_use && pager_use_color)) {
 				char *term = getenv("TERM");
 				if (term && strcmp(term, "dumb"))
 					diff_use_color_default = 1;
diff --git a/environment.c b/environment.c
index 558801a..1ce3411 100644
--- a/environment.c
+++ b/environment.c
@@ -23,6 +23,7 @@ int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace = NULL;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
+int pager_use_color = 1;
 
 static int dyn_git_object_dir, dyn_git_index_file, dyn_git_graft_file;
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
diff --git a/pager.c b/pager.c
index 3f753f6..afd684e 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,10 @@ static int git_pager_config(const char *
 			pager = strdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "pager.color")) {
+		pager_use_color = git_config_bool(var,value);
+		return 0;
+	}
 	return 0;
 }
 
-- 
1.4.2.rc2.g91b7
