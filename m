From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] Test in git-init-db if the filemode can be trusted
Date: Wed, 26 Oct 2005 01:43:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510260141220.30576@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 01:43:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYRg-0006At-P2
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVJYXnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVJYXnF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:43:05 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21139 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932485AbVJYXnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:43:04 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BE83A13EEF1; Wed, 26 Oct 2005 01:43:03 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A31B89ABB1; Wed, 26 Oct 2005 01:43:03 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8DE659AB5F; Wed, 26 Oct 2005 01:43:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7CC8113EEF1; Wed, 26 Oct 2005 01:43:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10638>

... and if not, write an appropriate .git/config. Of course, that happens 
only if no config file was yet created (by a template or a hook).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This might be a bit controversial, as we probably need a way to 
	write to .git/config anyway. Until there are such functions, I'll
	live with this patch.

 init-db.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

applies-to: 047019cf0b103c8350c6b4da7836b15795c69498
64ca59712d766e8264f9208d70b8f5c811dfd3ea
diff --git a/init-db.c b/init-db.c
index 2c27e18..b242fbf 100644
--- a/init-db.c
+++ b/init-db.c
@@ -196,6 +196,43 @@ static void create_default_files(const c
 	}
 	path[len] = 0;
 	copy_templates(path, len, template_path);
+
+	/*
+	 * Find out if we can trust the executable bit.
+	 */
+	safe_create_dir(path);
+	strcpy(path + len, "config");
+	if (access(path, R_OK) < 0) {
+		static const char contents[] =
+			"#\n"
+			"# This is the config file\n"
+			"#\n"
+			"\n"
+			"; core variables\n"
+			"[core]\n"
+			"	; Don't trust file modes\n"
+			"	filemode = false\n"
+			"\n";
+		FILE *config = fopen(path, "w");
+		struct stat st;
+
+		if (!config)
+			die("Can not write to %s?", path);
+
+		fwrite(contents, sizeof(contents)-1, 1, config);
+
+		fclose(config);
+
+		if (!lstat(path, &st)) {
+			struct stat st2;
+			if (!chmod(path, st.st_mode ^ S_IXUSR) &&
+					!lstat(path, &st2) &&
+					st.st_mode != st2.st_mode)
+				unlink(path);
+			else
+				fprintf(stderr, "Ignoring file modes\n");
+		}
+	}
 }
 
 static const char init_db_usage[] =
---
0.99.8.GIT
