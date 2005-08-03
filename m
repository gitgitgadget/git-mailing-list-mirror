From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Install sample hooks
Date: Tue, 02 Aug 2005 23:23:24 -0700
Message-ID: <7vbr4fk083.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 03 08:25:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Cfw-00028m-6u
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 08:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVHCGYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 02:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVHCGX5
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 02:23:57 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13240 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262110AbVHCGX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 02:23:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803062326.YEGE7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 02:23:26 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer made a good suggestion to throw in sample
hooks, disabled by default, to newly created repositories.  Here
is a proposed patch.  I will advance it to the master branch if
I do not hear objections, probably by the end of the week.

------------
A template mechanism to populate newly initialized repository
with default set of files is introduced.  Use it to ship example
hooks that can be used for update and post update checks, as
Josef Weidendorfer suggests.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile                     |    5 +
 cache.h                      |    4 +
 init-db.c                    |  142 ++++++++++++++++++++++++++++++++++++++++++
 templates/Makefile           |   19 ++++++
 templates/hooks--post-update |    8 ++
 templates/hooks--update      |   21 ++++++
 6 files changed, 199 insertions(+), 0 deletions(-)
 create mode 100644 templates/Makefile
 create mode 100644 templates/hooks--post-update
 create mode 100644 templates/hooks--update

a03cd67d2ff5dd0cf43a0be53e6f35e4cb684b8e
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -39,6 +39,8 @@ CFLAGS+=$(COPTS) -Wall $(DEFINES)
 
 prefix=$(HOME)
 bindir=$(prefix)/bin
+etcdir=$(prefix)/etc
+etcgitdir=$(etcdir)/git-core
 # dest=
 
 CC?=gcc
@@ -143,6 +145,7 @@ endif
 endif
 
 CFLAGS += '-DSHA1_HEADER=$(SHA1_HEADER)'
+CFLAGS += '-DDEFAULT_GIT_TEMPLATE_ENVIRONMENT="$(etcgitdir)/templates"'
 
 
 
@@ -195,6 +198,7 @@ check:
 install: $(PROG) $(SCRIPTS)
 	$(INSTALL) -m755 -d $(dest)$(bindir)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bindir)
+	$(MAKE) -C templates install
 
 install-tools:
 	$(MAKE) -C tools install
@@ -235,4 +239,5 @@ clean:
 	rm -f git-core-*.tar.gz git-core.spec
 	$(MAKE) -C tools/ clean
 	$(MAKE) -C Documentation/ clean
+	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -128,6 +128,10 @@ extern unsigned int active_nr, active_al
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
+#define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIRECTORY"
+#ifndef DEFAULT_GIT_TEMPLATE_ENVIRONMENT
+#define DEFAULT_GIT_TEMPLATE_ENVIRONMENT "/etc/git-core/templates"
+#endif
 
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
diff --git a/init-db.c b/init-db.c
--- a/init-db.c
+++ b/init-db.c
@@ -15,6 +15,147 @@ static void safe_create_dir(const char *
 	}
 }
 
+static int copy_file(const char *dst, const char *src, int mode)
+{
+	int fdi, fdo;
+
+	mode = (mode & 0111) ? 0777 : 0666;
+	if ((fdi = open(src, O_RDONLY)) < 0)
+		return fdi;
+	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
+		close(fdi);
+		return fdo;
+	}
+	while (1) {
+		char buf[BUFSIZ];
+		ssize_t leni, leno, ofs;
+		leni = read(fdi, buf, sizeof(buf));
+		if (leni < 0) {
+		error_return:
+			close(fdo);
+			close(fdi);
+			return -1;
+		}
+		if (!leni)
+			break;
+		ofs = 0;
+		do {
+			leno = write(fdo, buf+ofs, leni);
+			if (leno < 0)
+				goto error_return;
+			leni -= leno;
+			ofs += leno;
+		} while (0 < leni);
+	}
+	close(fdo);
+	close(fdi);
+	return 0;
+}
+
+static void copy_templates_1(char *path, int baselen,
+			     char *template, int template_baselen,
+			     DIR *dir)
+{
+	struct dirent *de;
+
+	/* Note: if ".git/hooks" file exists in the repository being
+	 * re-initialized, /etc/core-git/templates/hooks/update would
+	 * cause git-init-db to fail here.  I think this is sane but
+	 * it means that the set of templates we ship by default, along
+	 * with the way the namespace under .git/ is organized, should
+	 * be really carefully chosen.
+	 */
+	safe_create_dir(path);
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st_git, st_template;
+		int namelen;
+		int exists = 0;
+
+		if (de->d_name[0] == '.')
+			continue;
+		namelen = strlen(de->d_name);
+		if ((PATH_MAX <= baselen + namelen) ||
+		    (PATH_MAX <= template_baselen + namelen))
+			die("insanely long template name %s", de->d_name);
+		memcpy(path + baselen, de->d_name, namelen+1);
+		memcpy(template + template_baselen, de->d_name, namelen+1);
+		if (lstat(path, &st_git)) {
+			if (errno != ENOENT)
+				die("cannot stat %s", path);
+		}
+		else
+			exists = 1;
+
+		if (lstat(template, &st_template))
+			die("cannot stat template %s", template);
+
+		if (S_ISDIR(st_template.st_mode)) {
+			DIR *subdir = opendir(template);
+			int baselen_sub = baselen + namelen;
+			int template_baselen_sub = template_baselen + namelen;
+			if (!subdir)
+				die("cannot opendir %s", template);
+			path[baselen_sub++] =
+				template[template_baselen_sub++] = '/';
+			path[baselen_sub] =
+				template[template_baselen_sub] = 0;
+			copy_templates_1(path, baselen_sub,
+					 template, template_baselen_sub,
+					 subdir);
+			closedir(subdir);
+		}
+		else if (exists)
+			continue;
+		else if (S_ISLNK(st_template.st_mode)) {
+			char lnk[256];
+			int len;
+			len = readlink(template, lnk, sizeof(lnk));
+			if (len < 0)
+				die("cannot readlink %s", template);
+			if (sizeof(lnk) <= len)
+				die("insanely long symlink %s", template);
+			lnk[len] = 0;
+			if (symlink(lnk, path))
+				die("cannot symlink %s %s", lnk, path);
+		}
+		else if (S_ISREG(st_template.st_mode)) {
+			if (copy_file(path, template, st_template.st_mode))
+				die("cannot copy %s to %s", template, path);
+		}
+		else
+			error("ignoring template %s", template);
+	}
+}
+
+static void copy_templates(const char *git_dir)
+{
+	char path[PATH_MAX];
+	char template_path[PATH_MAX];
+	char *template_dir;
+	int len, template_len;
+	DIR *dir;
+
+	strcpy(path, git_dir);
+	len = strlen(path);
+	template_dir = gitenv(TEMPLATE_DIR_ENVIRONMENT);
+	if (!template_dir)
+		template_dir = DEFAULT_GIT_TEMPLATE_ENVIRONMENT;
+	strcpy(template_path, template_dir);
+	template_len = strlen(template_path);
+	if (template_path[template_len-1] != '/') {
+		template_path[template_len++] = '/';
+		template_path[template_len] = 0;
+	}
+
+	dir = opendir(template_path);
+	if (!dir)
+		return;
+	copy_templates_1(path, len,
+			 template_path, template_len,
+			 dir);
+	closedir(dir);
+}
+
 static void create_default_files(const char *git_dir)
 {
 	unsigned len = strlen(git_dir);
@@ -48,6 +189,7 @@ static void create_default_files(const c
 			exit(1);
 		}
 	}
+	copy_templates(path);
 }
 
 /*
diff --git a/templates/Makefile b/templates/Makefile
new file mode 100644
--- /dev/null
+++ b/templates/Makefile
@@ -0,0 +1,19 @@
+# make
+
+INSTALL=install
+prefix=$(HOME)
+etcdir=$(prefix)/etc
+etcgitdir=$(etcdir)/git-core
+templatedir=$(etcgitdir)/templates
+# dest=
+
+all:
+clean:
+
+install:
+	$(INSTALL) -d -m755 $(dest)$(templatedir)/hooks/
+	$(foreach s,$(wildcard hooks--*),\
+		$(INSTALL) -m644 $s \
+		$(dest)$(templatedir)/hooks/$(patsubst hooks--%,%,$s);)
+	$(INSTALL) -d -m755 $(dest)$(templatedir)/info
+	$(INSTALL) -d -m755 $(dest)$(templatedir)/branches
diff --git a/templates/hooks--post-update b/templates/hooks--post-update
new file mode 100644
--- /dev/null
+++ b/templates/hooks--post-update
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# An example hook script to prepare a packed repository for use over
+# dumb transports.
+#
+# To enable this hook, make this file executable by "chmod +x post-update".
+
+exec git-update-server-info
diff --git a/templates/hooks--update b/templates/hooks--update
new file mode 100644
--- /dev/null
+++ b/templates/hooks--update
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# An example hook script to mail out commit update information.
+#
+# To enable this hook:
+# (1) change the recipient e-mail address
+# (2) make this file executable by "chmod +x update".
+#
+
+recipient="commit-list@mydomain.xz"
+
+if expr "$2" : '0*$' >/dev/null
+then
+	echo "Created a new ref, with the following commits:"
+	git-rev-list --pretty "$2"
+else
+	echo "New commits:"
+	git-rev-list --pretty "$3" "^$2"
+fi |
+mail -s "Changes to ref $1" "$recipient"
+exit 0
