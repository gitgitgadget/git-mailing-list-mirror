From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add config variable core.symrefsonly
Date: Tue, 15 Nov 2005 19:24:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511151923120.1103@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-395633738-1132079059=:1103"
X-From: git-owner@vger.kernel.org Tue Nov 15 19:30:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec5Tk-000348-87
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 19:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVKOSYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 13:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVKOSYV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 13:24:21 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34962 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964989AbVKOSYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 13:24:21 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1AC1713F633; Tue, 15 Nov 2005 19:24:20 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F010F9F2FB; Tue, 15 Nov 2005 19:24:19 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D10A39F2E3; Tue, 15 Nov 2005 19:24:19 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B5AD913F633; Tue, 15 Nov 2005 19:24:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11929>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-395633738-1132079059=:1103
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


This allows you to force git to avoid symlinks for refs. Just add
something like

	[core]
		symrefsonly =3D true

to .git/config.

Don=B4t forget to "git checkout your_branch", or it does not do anything.=
..

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

	Linus, is there any reason you don=B4t allow spaces, underscores
	and dashes in the config variables?

	Petr, happy?

 cache.h        |    1 +
 config.c       |    5 +++++
 environment.c  |    1 +
 refs.c         |   10 ++++++----
 symbolic-ref.c |    1 +
 5 files changed, 14 insertions(+), 4 deletions(-)

applies-to: 4b6dbe856a3e63699b299c76f4f1fc5cb34cbe26
b12e60607e70f01de9dc65b88f15c9b17f7be4c5
diff --git a/cache.h b/cache.h
index 677c6ac..9a6bfb9 100644
--- a/cache.h
+++ b/cache.h
@@ -179,6 +179,7 @@ extern int commit_index_file(struct cach
 extern void rollback_index_file(struct cache_file *);
=20
 extern int trust_executable_bit;
+extern int only_use_symrefs;
=20
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
diff --git a/config.c b/config.c
index e89bab2..bd35138 100644
--- a/config.c
+++ b/config.c
@@ -214,6 +214,11 @@ int git_default_config(const char *var,=20
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.symrefsonly")) {
+		only_use_symrefs =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strncpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index 1dc7af5..b5026f1 100644
--- a/environment.c
+++ b/environment.c
@@ -12,6 +12,7 @@
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit =3D 1;
+int only_use_symrefs =3D 0;
=20
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
diff --git a/refs.c b/refs.c
index a52b038..f324be5 100644
--- a/refs.c
+++ b/refs.c
@@ -121,10 +121,12 @@ int create_symref(const char *git_HEAD,=20
 	int fd, len, written;
=20
 #if USE_SYMLINK_HEAD
-	unlink(git_HEAD);
-	if (!symlink(refs_heads_master, git_HEAD))
-		return 0;
-	fprintf(stderr, "no symlink - falling back to symbolic ref\n");
+	if (!only_use_symrefs) {
+		unlink(git_HEAD);
+		if (!symlink(refs_heads_master, git_HEAD))
+			return 0;
+		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
+	}
 #endif
=20
 	len =3D snprintf(ref, sizeof(ref), "ref: %s\n", refs_heads_master);
diff --git a/symbolic-ref.c b/symbolic-ref.c
index a72d7ac..193c87c 100644
--- a/symbolic-ref.c
+++ b/symbolic-ref.c
@@ -20,6 +20,7 @@ static void check_symref(const char *HEA
 int main(int argc, const char **argv)
 {
 	setup_git_directory();
+	git_config(git_default_config);
 	switch (argc) {
 	case 2:
 		check_symref(argv[1]);
---
0.99.9.GIT
---1148973799-395633738-1132079059=:1103--
