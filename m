From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH 3/6] new_filter: determine extra_args from filter type
Date: Thu, 17 Feb 2011 22:11:06 +0100
Message-ID: <1297977069-21884-4-git-send-email-mailings@hupie.com>
References: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 22:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqB8R-0007Wi-40
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041Ab1BQVLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:11:18 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:57501 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756259Ab1BQVLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:11:11 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 9E4E858C99A;
	Thu, 17 Feb 2011 22:11:09 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167120>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 cgit.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/cgit.c b/cgit.c
index 4440feb..6fa8f60 100644
--- a/cgit.c
+++ b/cgit.c
@@ -18,6 +18,10 @@
 
 const char *cgit_version = CGIT_VERSION;
 
+typedef enum {
+	about, commit, source
+} filter_type;
+
 void add_mimetype(const char *name, const char *value)
 {
 	struct string_list_item *item;
@@ -26,14 +30,30 @@ void add_mimetype(const char *name, const char *value)
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
+		case about:
+		case commit:
+			extra_args = 0;
+			break;
+
+		case source:
+			extra_args = 1;
+			break;
+
+		default:
+			extra_args = 0;
+			break;
+	}
+
 	f = xmalloc(sizeof(struct cgit_filter));
 	f->cmd = xstrdup(cmd);
 	f->argv = xmalloc((2 + extra_args) * sizeof(char *));
@@ -78,11 +98,11 @@ void repo_config(struct cgit_repo *repo, const char *name, const char *value)
 		repo->readme = xstrdup(value);
 	} else if (ctx.cfg.enable_filter_overrides) {
 		if (!strcmp(name, "about-filter"))
-			repo->about_filter = new_filter(value, 0);
+			repo->about_filter = new_filter(value, about);
 		else if (!strcmp(name, "commit-filter"))
-			repo->commit_filter = new_filter(value, 0);
+			repo->commit_filter = new_filter(value, commit);
 		else if (!strcmp(name, "source-filter"))
-			repo->source_filter = new_filter(value, 1);
+			repo->source_filter = new_filter(value, source);
 	}
 }
 
@@ -171,9 +191,9 @@ void config_cb(const char *name, const char *value)
 	else if (!strcmp(name, "cache-dynamic-ttl"))
 		ctx.cfg.cache_dynamic_ttl = atoi(value);
 	else if (!strcmp(name, "about-filter"))
-		ctx.cfg.about_filter = new_filter(value, 0);
+		ctx.cfg.about_filter = new_filter(value, about);
 	else if (!strcmp(name, "commit-filter"))
-		ctx.cfg.commit_filter = new_filter(value, 0);
+		ctx.cfg.commit_filter = new_filter(value, commit);
 	else if (!strcmp(name, "embedded"))
 		ctx.cfg.embedded = atoi(value);
 	else if (!strcmp(name, "max-atom-items"))
@@ -201,7 +221,7 @@ void config_cb(const char *name, const char *value)
 	else if (!strcmp(name, "section-from-path"))
 		ctx.cfg.section_from_path = atoi(value);
 	else if (!strcmp(name, "source-filter"))
-		ctx.cfg.source_filter = new_filter(value, 1);
+		ctx.cfg.source_filter = new_filter(value, source);
 	else if (!strcmp(name, "summary-log"))
 		ctx.cfg.summary_log = atoi(value);
 	else if (!strcmp(name, "summary-branches"))
-- 
1.7.4
