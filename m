From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH 6/6] Add check for downgrading of repo format version via init-db
Date: Tue, 22 Nov 2005 03:28:13 +0300
Message-ID: <11326192931463-git-send-email-matlads@dsmagic.com>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 01:30:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeM1p-0006Fp-Ee
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVKVA2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVKVA2j
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:28:39 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:3076 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964799AbVKVA2i
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:28:38 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 3D3065288; Tue, 22 Nov 2005 03:30:10 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1EeM17-0006Fu-7z; Tue, 22 Nov 2005 03:28:13 +0300
In-Reply-To: <11326192921291-git-send-email-matlads@dsmagic.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12510>

This corrects an earlier assumption that init-db made. It assumed that the
config file was specifying a correct repo format version.

This patch clarifies the assumption by checking the repo format version
specified in the config to be copied, and dies if the copy will result in
an upgrade.

It however, warns if the copy will result in a downgrade of the repo format
version, as git tools are supposed (or will be able) to handle this case :)

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 init-db.c |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)

applies-to: 0095aa60b05c91308a25a00dc939bcd95e63b03f
7858de7a1a57e73d2585271b57acfcd044e27e68
diff --git a/init-db.c b/init-db.c
index 90be428..d1fc142 100644
--- a/init-db.c
+++ b/init-db.c
@@ -110,6 +110,15 @@ static void copy_templates_1(char *path,
 	}
 }
 
+static int check_repo_config(const char *var, const char *value)
+{
+       if (strcmp(var, "core.repositoryformatversion") == 0) {
+               repository_format_version = git_config_int(var, value);
+               return 0;
+       }
+       return 1;
+}
+
 static int init_db_config_check(const char *template_path)
 {
 	DIR *dir;
@@ -117,8 +126,36 @@ static int init_db_config_check(const ch
 
 	dir = opendir(template_path);
 	while((de = readdir(dir)) != NULL) {
-		if ((strncmp(de->d_name, "config", 5) == 0))
-			return check_repo_format();
+		if ((strncmp(de->d_name, "config", 5) == 0)) {
+			int rfv1, rfv2;
+			char cpath[PATH_MAX];
+			check_repo_format();
+
+			/* is the file we are copying friendly? */
+			rfv1 = repository_format_version;
+			snprintf(cpath, sizeof(cpath), "%s%s", template_path,
+				de->d_name);
+			git_config_from_file(cpath, check_repo_config);
+			rfv2 = repository_format_version;
+			if (rfv1 == rfv2) {
+				break;
+			}
+			if (rfv2 < rfv1) {
+				/* the repo format specified in the conf file
+				 * we are copying is older than the repo we
+				 * are re-initialising! Downgrading?
+				 */
+				fprintf(stderr, "Possibly downgrading repo"
+					" format version from %d to %d. Check"
+					" config template file!\n", rfv1, rfv2);
+				break;
+			} else 
+				/* OK we die */
+				die ("Won't copy config file"
+					" for repo format version %d over"
+					" one for version %d",
+					rfv2, rfv1);
+		}
 	}
 	return 0;
 }
---
0.99.9.GIT
