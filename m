From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 2/2] init-db.c: factor out probe_case_sensitivity func
Date: Sat,  1 Feb 2014 03:14:27 -0600
Message-ID: <1391246067-30499-2-git-send-email-reubenhwk@gmail.com>
References: <1391246067-30499-1-git-send-email-reubenhwk@gmail.com>
Cc: dpotapov@gmail.com, Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 01 10:17:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9WhZ-0005aJ-F8
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 10:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbaBAJRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 04:17:19 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37030 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaBAJRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 04:17:18 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so6057264obc.36
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 01:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4CB0c11sy6j+x6rxgzk5Q6A2EXKmSK4lLkG5JKg2CgM=;
        b=FHeyaEzqm/8tiFZLD/CfZA1g4A7ZD5AmAVAhtcU9wLZekuSXb8hKc9gQ7ImAo+bYv9
         bBveauCPb3NGhtqiZAnBjSCtqsHCLpKx7BEqfuBggizt1ytj4wIxMONWVQmKZBa9R1Ny
         KBBGdihjhd/WWYuePWcWVF//WVCla4LYY/zQGe4rdbI3UWqbdz570THKZbulIbv+5hTZ
         s3qKWGnlL7HOuK/vSjP0p38s8tjdqTxFPEucbPeQEhAFvQYZU7DvFkl3vWa7A/NR4BeG
         hAu8VhA+S6TNI5mfeJA3ygkKMreldDNFDdt2V3ppEhUq6vDdQRK2Dw2BxxqhrNxUdNdj
         zIlg==
X-Received: by 10.182.42.105 with SMTP id n9mr20793341obl.33.1391246237746;
        Sat, 01 Feb 2014 01:17:17 -0800 (PST)
Received: from zoidberg.austin.rr.com ([72.183.120.155])
        by mx.google.com with ESMTPSA id m7sm21525307obo.7.2014.02.01.01.17.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Feb 2014 01:17:17 -0800 (PST)
Received: from zoidberg (localhost [127.0.0.1])
	by zoidberg.austin.rr.com (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s119HGgB010856;
	Sat, 1 Feb 2014 03:17:16 -0600
Received: (from reuben@localhost)
	by zoidberg (8.14.4/8.14.4/Submit) id s119HG3V005652;
	Sat, 1 Feb 2014 03:17:16 -0600
X-Mailer: git-send-email 1.8.5.3.3.g8f06fb8
In-Reply-To: <1391246067-30499-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241342>

create_default_files was getting a bit long and indented.  This
particular bit of code got long enough to be its own function.

Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 builtin/init-db.c |   97 +++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 34f09d8..bcf7f4c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -177,6 +177,58 @@ static int git_init_db_config(const char *k, const char *v, void *cb)
 	return 0;
 }
 
+static void probe_case_sensitivity(char *path, size_t len)
+{
+	int completely_insensitive_fs = 1;
+	char const * const case_check_filename = ".CaseCheck";
+	struct dirent *dirent;
+	FILE *case_file;
+	DIR *dir;
+
+	/*
+	 * If we can't access "config" by the name "CoNfIg", this fs is
+	 * case sensitive...so do nothing and return.
+	 */
+	path[len] = 0;
+	strcpy(path + len, "CoNfIg");
+	if (access(path, F_OK))
+		return;
+
+	/*
+	 * This filesystem is at least partially case-insensitive.  Let's
+	 * find out if this filesystem is completely case-insensitive.
+	 *
+	 * Create a CamelCase file here, make sure readdir reads a
+	 * CamelCase file below.
+	 */
+	path[len] = 0;
+	strcpy(path + len, case_check_filename);
+	case_file = fopen(path, "w");
+	if (!case_file)
+		die_errno(_("cannot open '%s'"), path);
+	fclose(case_file);
+
+	path[len] = 0;
+	dir = opendir(path);
+	if (!dir)
+		die_errno(_("cannot opendir '%s'"), path);
+
+	while ( (dirent = readdir(dir)) ) {
+		if (0 == strcmp(case_check_filename, dirent->d_name)) {
+			completely_insensitive_fs = 0;
+			break;
+		}
+	}
+
+	closedir(dir);
+	path[len] = 0;
+	strcpy(path + len, case_check_filename);
+	unlink(path);
+
+	if (completely_insensitive_fs)
+		git_config_set("core.ignorecase", "true");
+}
+
 static int create_default_files(const char *template_path)
 {
 	const char *git_dir = get_git_dir();
@@ -285,50 +337,7 @@ static int create_default_files(const char *template_path)
 		else
 			git_config_set("core.symlinks", "false");
 
-		/* Check if the filesystem is case-insensitive */
-		path[len] = 0;
-		strcpy(path + len, "CoNfIg");
-		if (!access(path, F_OK)) {
-			/*
-			 * This filesystem is at least partially case-insensitive.  Let's
-			 * find out if this filesystem is completely case-insensitive.
-			 *
-			 * Create a CamelCase file here, make sure readdir reads a
-			 * CamelCase file below.
-			 */
-			int completely_insensitive_fs = 1;
-			char const * const case_check_filename = ".CaseCheck";
-			struct dirent *dirent;
-			FILE *case_file;
-			DIR *dir;
-
-			path[len] = 0;
-			strcpy(path + len, case_check_filename);
-			case_file = fopen(path, "w");
-			if (!case_file)
-				die_errno(_("cannot open '%s'"), path);
-			fclose(case_file);
-
-			path[len] = 0;
-			dir = opendir(path);
-			if (!dir)
-				die_errno(_("cannot opendir '%s'"), path);
-
-			while ( (dirent = readdir(dir)) ) {
-				if (0 == strcmp(case_check_filename, dirent->d_name)) {
-					completely_insensitive_fs = 0;
-					break;
-				}
-			}
-
-			closedir(dir);
-			path[len] = 0;
-			strcpy(path + len, case_check_filename);
-			unlink(path);
-
-			if (completely_insensitive_fs)
-				git_config_set("core.ignorecase", "true");
-		}
+		probe_case_sensitivity(path, len);
 		probe_utf8_pathname_composition(path, len);
 	}
 
-- 
1.7.9.5
