From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/4] Split up default "core" config parsing into helper
 routine
Date: Wed, 18 Jun 2008 15:30:35 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <dbueno@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K96CZ-0003el-Nq
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 00:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606AbYFRWbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbYFRWbR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:31:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41881 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756549AbYFRWbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 18:31:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMUa0E017028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 15:30:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMUZI8024094;
	Wed, 18 Jun 2008 15:30:36 -0700
In-Reply-To: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.853 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85415>



From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Jun 2008 14:37:18 -0700
Subject: [PATCH 1/4] Split up default "core" config parsing into helper routine

It makes the code a bit easier to read, and in theory a bit faster too
(no need to compare all the different "core.*" strings against non-core
config options).

The config system really should get something of a complete overhaul,
but in the absense of that, this at least improves on it a tiny bit.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 config.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/config.c b/config.c
index c2f2bbb..c3597e0 100644
--- a/config.c
+++ b/config.c
@@ -332,7 +332,7 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
-int git_default_config(const char *var, const char *value, void *dummy)
+static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
@@ -444,6 +444,31 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.pager"))
+		return git_config_string(&pager_program, var, value);
+
+	if (!strcmp(var, "core.editor"))
+		return git_config_string(&editor_program, var, value);
+
+	if (!strcmp(var, "core.excludesfile"))
+		return git_config_string(&excludes_file, var, value);
+
+	if (!strcmp(var, "core.whitespace")) {
+		if (!value)
+			return config_error_nonbool(var);
+		whitespace_rule_cfg = parse_whitespace_rule(value);
+		return 0;
+	}
+
+	/* Add other config variables here and to Documentation/config.txt. */
+	return 0;
+}
+
+int git_default_config(const char *var, const char *value, void *dummy)
+{
+	if (!prefixcmp(var, "core."))
+		return git_default_core_config(var, value);
+
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -473,21 +498,6 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.pager"))
-		return git_config_string(&pager_program, var, value);
-
-	if (!strcmp(var, "core.editor"))
-		return git_config_string(&editor_program, var, value);
-
-	if (!strcmp(var, "core.excludesfile"))
-		return git_config_string(&excludes_file, var, value);
-
-	if (!strcmp(var, "core.whitespace")) {
-		if (!value)
-			return config_error_nonbool(var);
-		whitespace_rule_cfg = parse_whitespace_rule(value);
-		return 0;
-	}
 	if (!strcmp(var, "branch.autosetupmerge")) {
 		if (value && !strcasecmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
-- 
1.5.6.rc3.7.g336d0.dirty
