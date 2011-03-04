From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH v2 4/6] cgit_open_filter: also take the repo as a parameter
Date: Fri,  4 Mar 2011 01:31:33 +0100
Message-ID: <1299198695-23215-5-git-send-email-mailings@hupie.com>
References: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 01:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvIwI-0005if-9t
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 01:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759200Ab1CDAb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 19:31:57 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:62945 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759079Ab1CDAbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 19:31:43 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id ACA9A58C9C4;
	Fri,  4 Mar 2011 01:31:36 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168422>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

To prepare for handing repo configuration to the
script that is executed.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 cgit.h        |    2 +-
 shared.c      |    2 +-
 ui-commit.c   |    6 +++---
 ui-repolist.c |    2 +-
 ui-snapshot.c |    2 +-
 ui-summary.c  |    2 +-
 ui-tree.c     |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/cgit.h b/cgit.h
index be29d6e..2551cb7 100644
--- a/cgit.h
+++ b/cgit.h
@@ -312,7 +312,7 @@ extern const char *cgit_repobasename(const char *reponame);
 
 extern int cgit_parse_snapshots_mask(const char *str);
 
-extern int cgit_open_filter(struct cgit_filter *filter);
+extern int cgit_open_filter(struct cgit_filter *filter, struct cgit_repo * repo);
 extern int cgit_close_filter(struct cgit_filter *filter);
 
 extern int readfile(const char *path, char **buf, size_t *size);
diff --git a/shared.c b/shared.c
index 765cd27..49128ad 100644
--- a/shared.c
+++ b/shared.c
@@ -375,7 +375,7 @@ int cgit_parse_snapshots_mask(const char *str)
 	return rv;
 }
 
-int cgit_open_filter(struct cgit_filter *filter)
+int cgit_open_filter(struct cgit_filter *filter, struct cgit_repo * repo)
 {
 
 	filter->old_stdout = chk_positive(dup(STDOUT_FILENO),
diff --git a/ui-commit.c b/ui-commit.c
index 2b4f677..2da9fcf 100644
--- a/ui-commit.c
+++ b/ui-commit.c
@@ -110,7 +110,7 @@ void cgit_print_commit(char *hex, const char *prefix)
 	html("</table>\n");
 	html("<div class='commit-subject'>");
 	if (ctx.repo->commit_filter)
-		cgit_open_filter(ctx.repo->commit_filter);
+		cgit_open_filter(ctx.repo->commit_filter, ctx.repo);
 	html_txt(info->subject);
 	if (ctx.repo->commit_filter)
 		cgit_close_filter(ctx.repo->commit_filter);
@@ -118,7 +118,7 @@ void cgit_print_commit(char *hex, const char *prefix)
 	html("</div>");
 	html("<div class='commit-msg'>");
 	if (ctx.repo->commit_filter)
-		cgit_open_filter(ctx.repo->commit_filter);
+		cgit_open_filter(ctx.repo->commit_filter, ctx.repo);
 	html_txt(info->msg);
 	if (ctx.repo->commit_filter)
 		cgit_close_filter(ctx.repo->commit_filter);
@@ -127,7 +127,7 @@ void cgit_print_commit(char *hex, const char *prefix)
 		html("<div class='notes-header'>Notes</div>");
 		html("<div class='notes'>");
 		if (ctx.repo->commit_filter)
-			cgit_open_filter(ctx.repo->commit_filter);
+			cgit_open_filter(ctx.repo->commit_filter, ctx.repo);
 		html_txt(notes.buf);
 		if (ctx.repo->commit_filter)
 			cgit_close_filter(ctx.repo->commit_filter);
diff --git a/ui-repolist.c b/ui-repolist.c
index 2c98668..05b4548 100644
--- a/ui-repolist.c
+++ b/ui-repolist.c
@@ -291,7 +291,7 @@ void cgit_print_site_readme()
 	if (!ctx.cfg.root_readme)
 		return;
 	if (ctx.cfg.about_filter)
-		cgit_open_filter(ctx.cfg.about_filter);
+		cgit_open_filter(ctx.cfg.about_filter, NULL);
 	html_include(ctx.cfg.root_readme);
 	if (ctx.cfg.about_filter)
 		cgit_close_filter(ctx.cfg.about_filter);
diff --git a/ui-snapshot.c b/ui-snapshot.c
index 6e3412c..067082c 100644
--- a/ui-snapshot.c
+++ b/ui-snapshot.c
@@ -19,7 +19,7 @@ static int write_compressed_tar_archive(struct archiver_args *args,const char *f
 	f.argv = malloc(2 * sizeof(char *));
 	f.argv[0] = f.cmd;
 	f.argv[1] = NULL;
-	cgit_open_filter(&f);
+	cgit_open_filter(&f, NULL);
 	rv = write_tar_archive(args);
 	cgit_close_filter(&f);
 	return rv;
diff --git a/ui-summary.c b/ui-summary.c
index b203bcc..1b1d93b 100644
--- a/ui-summary.c
+++ b/ui-summary.c
@@ -113,7 +113,7 @@ void cgit_print_repo_readme(char *path)
 	 */
 	html("<div id='summary'>");
 	if (ctx.repo->about_filter)
-		cgit_open_filter(ctx.repo->about_filter);
+		cgit_open_filter(ctx.repo->about_filter, ctx.repo);
 	if (ref)
 		cgit_print_file(tmp, ref);
 	else
diff --git a/ui-tree.c b/ui-tree.c
index 442b6be..2d8d2f3 100644
--- a/ui-tree.c
+++ b/ui-tree.c
@@ -45,7 +45,7 @@ static void print_text_buffer(const char *name, char *buf, unsigned long size)
 	if (ctx.repo->source_filter) {
 		html("<td class='lines'><pre><code>");
 		ctx.repo->source_filter->argv[1] = xstrdup(name);
-		cgit_open_filter(ctx.repo->source_filter);
+		cgit_open_filter(ctx.repo->source_filter, ctx.repo);
 		html_raw(buf, size);
 		cgit_close_filter(ctx.repo->source_filter);
 		free(ctx.repo->source_filter->argv[1]);
-- 
1.7.4
