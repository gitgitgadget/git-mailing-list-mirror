From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 1/2] init-db.c: honor case on case preserving fs
Date: Sat,  1 Feb 2014 03:14:26 -0600
Message-ID: <1391246067-30499-1-git-send-email-reubenhwk@gmail.com>
Cc: dpotapov@gmail.com, Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 01 10:16:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Wh0-0005EM-OG
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 10:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbaBAJQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 04:16:14 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:51985 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaBAJQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 04:16:11 -0500
Received: by mail-ob0-f178.google.com with SMTP id wn1so6023846obc.37
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RMzWYkIE5/PZq0J0fvl2lM2I0whVEKy+5uQ5vaJgqTQ=;
        b=i8/4RPUFeucnonwl4g5BaCL79+6djP45tFw9+iURiYr/fN5iy485vMdWwquDM4aG6D
         /3ZMUCatZveb5tFzSO7ip6IaV6JPM7RWeMb5J2vh2CbHg3kRCiCUq2hjVtlFf6PUcuXG
         +clbjfUAlSYQIkhNlY9wpMjTnaZfLxlFq8rDPX/KzI6AM7vxPDPGqv/8+MoPBFMkQuBq
         TpTDmdlIZXJNhGnj47a5CwuPL7TYYR1d5q9DQm9PeeJ3fywbGkvWbJS3q4kLet/YC0N5
         439D8Y7Uw4Z4jZLD50vZzfeaQD58eGK361Yxyb5yVse//PIhcWkhvWJ8liRensT6UZJd
         vGXw==
X-Received: by 10.60.50.202 with SMTP id e10mr20793453oeo.39.1391246170580;
        Sat, 01 Feb 2014 01:16:10 -0800 (PST)
Received: from zoidberg.austin.rr.com ([72.183.120.155])
        by mx.google.com with ESMTPSA id b2sm75269034oed.7.2014.02.01.01.16.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Feb 2014 01:16:10 -0800 (PST)
Received: from zoidberg (localhost [127.0.0.1])
	by zoidberg.austin.rr.com (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s119G8fn004928;
	Sat, 1 Feb 2014 03:16:08 -0600
Received: (from reuben@localhost)
	by zoidberg (8.14.4/8.14.4/Submit) id s119G8P2000385;
	Sat, 1 Feb 2014 03:16:08 -0600
X-Mailer: git-send-email 1.8.5.3.3.g8f06fb8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241341>

Most case-insensitive filesystems are case-preserving. In these
filesystems (such as HFS+ on OS X) you can name a file Filename.txt,
then rename the file to FileName.txt.  That file will be accessible
by both filenames, but the case is otherwise honored.  We don't want
to have git ignore case on these case-preserving filesystem
implementations.

This change adds an additional check in init-db.c before
automatically setting core.ignorecase to true.

This fixes a problem where if you import an hg repository, using
git-remote-hg, on two OSX systems, one with a case-sensitive fs and
the other with case-insensitive fs, the sha1 commit ids of the
repositories diverge on commits where a file was renamed, but only
the case in the filename changes (for example renaming
Filename.cpp -> FileName.cpp).

The alternative solutions are
* to set ignore_case to 0 in fast-import.c at runtime
* explicitly use strcmp, rather than strcmp_icase (also in
  fast-import.c)
* completely rework ignorecase into something that can handle more
  options (true, false, sometimes, maybe, partially, etc...)

Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 builtin/init-db.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 78aa387..34f09d8 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -288,8 +288,47 @@ static int create_default_files(const char *template_path)
 		/* Check if the filesystem is case-insensitive */
 		path[len] = 0;
 		strcpy(path + len, "CoNfIg");
-		if (!access(path, F_OK))
-			git_config_set("core.ignorecase", "true");
+		if (!access(path, F_OK)) {
+			/*
+			 * This filesystem is at least partially case-insensitive.  Let's
+			 * find out if this filesystem is completely case-insensitive.
+			 *
+			 * Create a CamelCase file here, make sure readdir reads a
+			 * CamelCase file below.
+			 */
+			int completely_insensitive_fs = 1;
+			char const * const case_check_filename = ".CaseCheck";
+			struct dirent *dirent;
+			FILE *case_file;
+			DIR *dir;
+
+			path[len] = 0;
+			strcpy(path + len, case_check_filename);
+			case_file = fopen(path, "w");
+			if (!case_file)
+				die_errno(_("cannot open '%s'"), path);
+			fclose(case_file);
+
+			path[len] = 0;
+			dir = opendir(path);
+			if (!dir)
+				die_errno(_("cannot opendir '%s'"), path);
+
+			while ( (dirent = readdir(dir)) ) {
+				if (0 == strcmp(case_check_filename, dirent->d_name)) {
+					completely_insensitive_fs = 0;
+					break;
+				}
+			}
+
+			closedir(dir);
+			path[len] = 0;
+			strcpy(path + len, case_check_filename);
+			unlink(path);
+
+			if (completely_insensitive_fs)
+				git_config_set("core.ignorecase", "true");
+		}
 		probe_utf8_pathname_composition(path, len);
 	}
 
-- 
1.7.9.5
