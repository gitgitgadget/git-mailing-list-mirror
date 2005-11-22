From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH 2/6] Make init-db check repo format version if copying a config file.
Date: Tue, 22 Nov 2005 03:28:12 +0300
Message-ID: <11326192922669-git-send-email-matlads@dsmagic.com>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 01:29:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeM1U-0006BT-Mr
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVKVA2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVKVA2c
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:28:32 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:2564 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964794AbVKVA2b
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:28:31 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 22B24527C; Tue, 22 Nov 2005 03:30:08 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1EeM16-0006Fe-Sz; Tue, 22 Nov 2005 03:28:12 +0300
In-Reply-To: <11326192921291-git-send-email-matlads@dsmagic.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12505>

This patch enables init-db to check the repo format version for a
repository being re-initialised. If the version of the repo is larger than
GIT_VERSION_REPO, it simply dies with an appropriate message.

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 init-db.c |   14 ++++++++++++++
 setup.c   |   19 +++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

applies-to: 3e86d91031df530695933e7d9d5d8d9c2f3a683d
601dd50b595a9aa0a57972364262d98290a5d7b2
diff --git a/init-db.c b/init-db.c
index bd88291..90be428 100644
--- a/init-db.c
+++ b/init-db.c
@@ -110,6 +110,19 @@ static void copy_templates_1(char *path,
 	}
 }
 
+static int init_db_config_check(const char *template_path)
+{
+	DIR *dir;
+	struct dirent *de;
+
+	dir = opendir(template_path);
+	while((de = readdir(dir)) != NULL) {
+		if ((strncmp(de->d_name, "config", 5) == 0))
+			return check_repo_format();
+	}
+	return 0;
+}
+
 static void copy_templates(const char *git_dir, int len, char *template_dir)
 {
 	char path[PATH_MAX];
@@ -131,6 +144,7 @@ static void copy_templates(const char *g
 			template_dir);
 		return;
 	}
+	init_db_config_check(template_path);
 
 	memcpy(path, git_dir, len);
 	path[len] = 0;
diff --git a/setup.c b/setup.c
index c487d7e..8597424 100644
--- a/setup.c
+++ b/setup.c
@@ -127,3 +127,22 @@ const char *setup_git_directory(void)
 	cwd[len] = 0;
 	return cwd + offset;
 }
+
+static int check_repo_config(const char *var, const char *value)
+{
+       if (strcmp(var, "core.repositoryformatversion") == 0) {
+               repository_format_version = git_config_int(var, value);
+               return 0;
+       }
+       return 1;
+}
+
+int check_repo_format(void)
+{
+	if (git_config(check_repo_config) == -1)
+		return -1;
+	if (repository_format_version > GIT_REPO_VERSION)
+		die ("Expected git repo version <= %d, found %d", GIT_REPO_VERSION,
+			repository_format_version);
+	return 0;
+}
---
0.99.9.GIT
