From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH v2 3/6] new_filter: determine extra_args from filter type
Date: Fri,  4 Mar 2011 01:31:32 +0100
Message-ID: <1299198695-23215-4-git-send-email-mailings@hupie.com>
References: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 01:31:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvIvu-0005Zb-P3
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 01:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759178Ab1CDAbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 19:31:45 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:62942 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759071Ab1CDAbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 19:31:43 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 9DC0958C9C3;
	Fri,  4 Mar 2011 01:31:36 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168419>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 cgit.c |   27 ++++++++++++++++++++-------
 cgit.h |    4 ++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/cgit.c b/cgit.c
index 4440feb..5874034 100644
--- a/cgit.c
+++ b/cgit.c
@@ -26,14 +26,27 @@ void add_mimetype(const char *name, const char *value)
 	item->util = xstrdup(value);
 }
 
-struct cgit_filter *new_filter(const char *cmd, int extra_args)
+struct cgit_filter *new_filter(const char *cmd, filter_type filtertype)
 {
 	int i = 0;
 	struct cgit_filter *f;
+	int extra_args;
 
 	if (!cmd || !cmd[0])
 		return NULL;
 
+	switch (filtertype) {
+		case SOURCE:
+			extra_args = 1;
+			break;
+
+		case ABOUT:
+		case COMMIT:
+		default:
+			extra_args = 0;
+			break;
+	}
+
 	f = xmalloc(sizeof(struct cgit_filter));
 	f->cmd = xstrdup(cmd);
 	f->argv = xmalloc((2 + extra_args) * sizeof(char *));
@@ -78,11 +91,11 @@ void repo_config(struct cgit_repo *repo, const char *name, const char *value)
 		repo->readme = xstrdup(value);
 	} else if (ctx.cfg.enable_filter_overrides) {
 		if (!strcmp(name, "about-filter"))
-			repo->about_filter = new_filter(value, 0);
+			repo->about_filter = new_filter(value, ABOUT);
 		else if (!strcmp(name, "commit-filter"))
-			repo->commit_filter = new_filter(value, 0);
+			repo->commit_filter = new_filter(value, COMMIT);
 		else if (!strcmp(name, "source-filter"))
-			repo->source_filter = new_filter(value, 1);
+			repo->source_filter = new_filter(value, SOURCE);
 	}
 }
 
@@ -171,9 +184,9 @@ void config_cb(const char *name, const char *value)
 	else if (!strcmp(name, "cache-dynamic-ttl"))
 		ctx.cfg.cache_dynamic_ttl = atoi(value);
 	else if (!strcmp(name, "about-filter"))
-		ctx.cfg.about_filter = new_filter(value, 0);
+		ctx.cfg.about_filter = new_filter(value, ABOUT);
 	else if (!strcmp(name, "commit-filter"))
-		ctx.cfg.commit_filter = new_filter(value, 0);
+		ctx.cfg.commit_filter = new_filter(value, COMMIT);
 	else if (!strcmp(name, "embedded"))
 		ctx.cfg.embedded = atoi(value);
 	else if (!strcmp(name, "max-atom-items"))
@@ -201,7 +214,7 @@ void config_cb(const char *name, const char *value)
 	else if (!strcmp(name, "section-from-path"))
 		ctx.cfg.section_from_path = atoi(value);
 	else if (!strcmp(name, "source-filter"))
-		ctx.cfg.source_filter = new_filter(value, 1);
+		ctx.cfg.source_filter = new_filter(value, SOURCE);
 	else if (!strcmp(name, "summary-log"))
 		ctx.cfg.summary_log = atoi(value);
 	else if (!strcmp(name, "summary-branches"))
diff --git a/cgit.h b/cgit.h
index f5f68ac..be29d6e 100644
--- a/cgit.h
+++ b/cgit.h
@@ -50,6 +50,10 @@ typedef void (*configfn)(const char *name, const char *value);
 typedef void (*filepair_fn)(struct diff_filepair *pair);
 typedef void (*linediff_fn)(char *line, int len);
 
+typedef enum {
+	ABOUT, COMMIT, SOURCE
+} filter_type;
+
 struct cgit_filter {
 	char *cmd;
 	char **argv;
-- 
1.7.4
