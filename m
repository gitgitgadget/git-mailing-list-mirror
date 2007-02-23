From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Limit filename for format-patch
Date: Fri, 23 Feb 2007 22:47:26 +0100
Message-ID: <20070223214631.24544.96597.stgit@lathund.dewire.com>
References: <200702232239.19504.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 22:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKiEx-0004jk-86
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 22:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933222AbXBWVqD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 16:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933228AbXBWVqD
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 16:46:03 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12638 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933222AbXBWVqA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 16:46:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 87598803396;
	Fri, 23 Feb 2007 22:40:59 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18353-01; Fri, 23 Feb 2007 22:40:59 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 217AB802AB6;
	Fri, 23 Feb 2007 22:40:59 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 0966329821;
	Fri, 23 Feb 2007 22:47:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id UBfE5pO-7jzp; Fri, 23 Feb 2007 22:47:26 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B2BDB297EA;
	Fri, 23 Feb 2007 22:47:26 +0100 (CET)
In-Reply-To: <200702232239.19504.robin.rosenberg@dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40470>

Badly formatted commits may have very long comments. This causes
git-format-patch to fail. To avoid that, truncate the filename
to a value we believe will always work. 

Err out if the patch file cannot be created.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

Same as previous patch minus one strlen.

 builtin-log.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index ad1e8c0..5afd772 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -264,15 +264,17 @@ static int git_format_config(const char *var, const char *value)
 static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 
-static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
+static int reopen_stdout(struct commit *commit, int nr, int keep_subject)
 {
-	char filename[1024];
+	char filename[PATH_MAX];
 	char *sol;
 	int len = 0;
-	int suffix_len = strlen(fmt_patch_suffix) + 10; /* ., NUL and slop */
+	int suffix_len = strlen(fmt_patch_suffix) + 1;
 
 	if (output_directory) {
-		strlcpy(filename, output_directory, 1000);
+		if (strlen(output_directory) > sizeof filename - suffix_len)
+			return error("name of output directory is too long");
+		strlcpy(filename, output_directory, sizeof filename - suffix_len);
 		len = strlen(filename);
 		if (filename[len - 1] != '/')
 			filename[len++] = '/';
@@ -297,6 +299,7 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 		}
 
 		for (j = 0;
+		     j< 64-suffix_len-5 && 
 		     len < sizeof(filename) - suffix_len &&
 			     sol[j] && sol[j] != '\n';
 		     j++) {
@@ -314,10 +317,16 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 		}
 		while (filename[len - 1] == '.' || filename[len - 1] == '-')
 			len--;
+		filename[len] = 0;
 	}
+	if (len + suffix_len >= sizeof filename)
+		return error("Patch pathname too long");
 	strcpy(filename + len, fmt_patch_suffix);
 	fprintf(realstdout, "%s\n", filename);
-	freopen(filename, "w", stdout);
+	if (freopen(filename, "w", stdout) == NULL)
+		return error("Cannot open patch file %s",filename);
+	return 0;
+	
 }
 
 static int get_patch_id(struct commit *commit, struct diff_options *options,
@@ -573,7 +582,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.message_id = message_id;
 		}
 		if (!use_stdout)
-			reopen_stdout(commit, rev.nr, keep_subject);
+			if (reopen_stdout(commit, rev.nr, keep_subject))
+				die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
