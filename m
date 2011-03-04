From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH v2 5/6] cgit_open_filter: hand down repo configuration to script
Date: Fri,  4 Mar 2011 01:31:34 +0100
Message-ID: <1299198695-23215-6-git-send-email-mailings@hupie.com>
References: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 01:32:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvIwH-0005if-87
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 01:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759190Ab1CDAbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 19:31:50 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:63013 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759182Ab1CDAbt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 19:31:49 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id B1DFB58C9C5;
	Fri,  4 Mar 2011 01:31:36 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168423>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 shared.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 107 insertions(+), 1 deletions(-)

diff --git a/shared.c b/shared.c
index 49128ad..5f09a63 100644
--- a/shared.c
+++ b/shared.c
@@ -7,6 +7,8 @@
  */
 
 #include "cgit.h"
+#include <stdio.h>
+#include <linux/limits.h>
 
 struct cgit_repolist cgit_repolist;
 struct cgit_context ctx;
@@ -375,6 +377,100 @@ int cgit_parse_snapshots_mask(const char *str)
 	return rv;
 }
 
+#define ENV_VARS			7
+#define ENV_SIZE_PER_VAR	(PATH_MAX + 64)
+#define ENV_SIZE			(ENV_VARS * ENV_SIZE_PER_VAR)
+
+typedef struct {
+	char * vars[ENV_VARS + 1];
+	char buffer[ENV_SIZE];
+} env_struct;
+
+static env_struct * prepare_env(struct cgit_repo * repo) {
+	long buffer_space = sizeof(env_struct);
+	env_struct * env = malloc(buffer_space);
+	int var_index = 0;
+	char * buffer_var_index;
+	unsigned int chars_printed;
+
+	if (!env)
+		return NULL;
+
+	/**
+	 * CGIT_REPO_URL
+	 * CGIT_REPO_NAME
+	 * CGIT_REPO_PATH
+	 * CGIT_REPO_OWNER
+	 * CGIT_REPO_DEFBRANCH
+	 * CGIT_REPO_SECTION
+	 * CGIT_REPO_CLONE_URL
+	 */
+
+	buffer_var_index = &env->buffer[0];
+
+	while (var_index < ENV_VARS) {
+		chars_printed = 0;
+		switch (var_index) {
+		case 0:
+			chars_printed = snprintf(buffer_var_index, buffer_space,
+					"CGIT_REPO_URL=%s", (repo->url) ? repo->url : "");
+			break;
+
+		case 1:
+			chars_printed = snprintf(buffer_var_index, buffer_space,
+					"CGIT_REPO_NAME=%s", (repo->name) ? repo->name : "");
+			break;
+
+		case 2:
+			chars_printed = snprintf(buffer_var_index, buffer_space,
+					"CGIT_REPO_PATH=%s", (repo->path) ? repo->path : "");
+			break;
+
+		case 3:
+			chars_printed = snprintf(buffer_var_index, buffer_space,
+					"CGIT_REPO_OWNER=%s", (repo->owner) ? repo->owner : "");
+			break;
+
+		case 4:
+			chars_printed = snprintf(buffer_var_index, buffer_space,
+					"CGIT_REPO_DEFBRANCH=%s",
+					(repo->defbranch) ? repo->defbranch : "");
+			break;
+
+		case 5:
+			chars_printed = snprintf(buffer_var_index, buffer_space,
+					"CGIT_REPO_SECTION=%s", (repo->section) ? repo->section
+							: "");
+			break;
+
+		case 6:
+			chars_printed = snprintf(buffer_var_index, buffer_space,
+					"CGIT_REPO_CLONE_URL=%s",
+					(repo->clone_url) ? repo->clone_url : "");
+			break;
+
+		default:
+			break;
+		}
+
+		if (chars_printed > buffer_space) {
+			free(env);
+			return NULL;
+		}
+
+		env->vars[var_index] = buffer_var_index;
+		buffer_var_index[chars_printed] = '\0';
+		buffer_var_index += chars_printed + 1;
+		buffer_space -= chars_printed;
+
+		var_index++;
+	}
+	env->vars[var_index] = NULL;
+
+	return env;
+}
+
+
 int cgit_open_filter(struct cgit_filter *filter, struct cgit_repo * repo)
 {
 
@@ -383,10 +479,20 @@ int cgit_open_filter(struct cgit_filter *filter, struct cgit_repo * repo)
 	chk_zero(pipe(filter->pipe_fh), "Unable to create pipe to subprocess");
 	filter->pid = chk_non_negative(fork(), "Unable to create subprocess");
 	if (filter->pid == 0) {
+		env_struct * env = NULL;
+
 		close(filter->pipe_fh[1]);
 		chk_non_negative(dup2(filter->pipe_fh[0], STDIN_FILENO),
 			"Unable to use pipe as STDIN");
-		execvp(filter->cmd, filter->argv);
+
+		if (repo)
+			env = prepare_env(repo);
+
+		execve(filter->cmd, filter->argv, (env) ? &env->vars[0] : NULL);
+
+		if (env)
+			free(env);
+
 		die("Unable to exec subprocess %s: %s (%d)", filter->cmd,
 			strerror(errno), errno);
 	}
-- 
1.7.4
