From: Petr Onderka <gsvick@gmail.com>
Subject: [PATCH/RFC] Add global and system-wide gitattributes
Date: Wed, 11 Aug 2010 01:04:06 +0000
Message-ID: <1281488646-7108-1-git-send-email-gsvick@gmail.com>
Cc: Henrik Grubbstrm <grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 03:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OizkJ-00078C-GA
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 03:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358Ab0HKBEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 21:04:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59830 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758277Ab0HKBEa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 21:04:30 -0400
Received: by bwz3 with SMTP id 3so2311427bwz.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 18:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:x-antivirus:x-antivirus-status;
        bh=XOT8xGUqueraz3qrz7UE1hlcUfH4dvxMgmnCNsAZr+8=;
        b=bni3z90yMIfGPs0zRmlAOC4H9XqowkLRhy3C+3BOIQcrFirDjFlLmRXvnz8ytS1n2D
         5udRnyoXYa66pN/yaSa+GeGGWjWgtbR6pfW9jpSy4RkNt+VCAPS8kMgl5oh81M8X6Obi
         1zUywB4hvMxDTc1ysGlI8fofUivgJgoxuFXNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:x-antivirus
         :x-antivirus-status;
        b=RA3Q8q3HLv8bFzze4cLIT/10ireDbQw18fkpW7VIh1ZTGFIZGGMueBC/38tBvvLUs8
         6Tp1+gjE+NDbciQkXUEAWdRUhUYpDEa8G/FZ8rW7IArUGSgh3jMTH6T27AMJAEHBmakd
         4n00at5o/sFSr9IMGFEE5hQZU+/qJKK7O78/Y=
Received: by 10.204.72.209 with SMTP id n17mr4665463bkj.52.1281488668079;
        Tue, 10 Aug 2010 18:04:28 -0700 (PDT)
Received: from localhost (217-112-171-197.cust.avonet.cz [217.112.171.197])
        by mx.google.com with ESMTPS id f10sm4669456bkl.5.2010.08.10.18.04.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 18:04:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.msysgit.0.10.g9ffa0
X-Antivirus: avast! (VPS 100810-1, 10.08.2010), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153179>

Allow gitattributes to be set globally and system wide in ~/.giattributes
and $(prefix)/etc/gitattributes files, respectively. This way, settings
for particular file types can be set in one place and apply for all user's
repositories.

Contents of those two files are added to the attr_stack struct that
contains content of info/attributes, so that prepare_attr_stack()
keeps working as is and doesn't have to pop and then put back two more
structs (in addition to the "info" one).

Some parts of the code were copied from the implementation of the same
functionality in config.c.

Signed-off-by: Petr Onderka <gsvick@gmail.com>
---
Hi,

I thought this feature would be useful for me, so I coded it up.
What do you think? Is it ready to be included to the official repository as is?

 Documentation/gitattributes.txt |    5 ++-
 Makefile                        |    6 +++++
 attr.c                          |   43 ++++++++++++++++++++++++++++++++------
 configure.ac                    |    7 ++++++
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..351b014 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -7,7 +7,7 @@ gitattributes - defining attributes per path
 
 SYNOPSIS
 --------
-$GIT_DIR/info/attributes, .gitattributes
+$GIT_DIR/info/attributes, /etc/gitattributes, ~/.gitattributes, .gitattributes
 
 
 DESCRIPTION
@@ -58,7 +58,8 @@ attribute.  The rules how the pattern matches paths are the
 same as in `.gitignore` files; see linkgit:gitignore[5].
 
 When deciding what attributes are assigned to a path, git
-consults `$GIT_DIR/info/attributes` file (which has the highest
+consults `$GIT_DIR/info/attributes`, `~/.gitattributes`
+and `$(prefix)/etc/gitconfig` files (in order of decreasing
 precedence), `.gitattributes` file in the same directory as the
 path in question, and its parent directories up to the toplevel of the
 work tree (the further the directory that contains `.gitattributes`
diff --git a/Makefile b/Makefile
index bc3c570..eadd2d7 100644
--- a/Makefile
+++ b/Makefile
@@ -268,6 +268,7 @@ STRIP ?= strip
 #   infodir
 #   htmldir
 #   ETC_GITCONFIG (but not sysconfdir)
+#   ETC_GITATTRIBUTES
 # can be specified as a relative path some/where/else;
 # this is interpreted as relative to $(prefix) and "git" at
 # runtime figures out where they are based on the path to the executable.
@@ -286,9 +287,11 @@ htmldir = share/doc/git-doc
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
+ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
 else
 sysconfdir = $(prefix)/etc
 ETC_GITCONFIG = etc/gitconfig
+ETC_GITATTRIBUTES = etc/gitattributes
 endif
 lib = lib
 # DESTDIR=
@@ -1502,6 +1505,7 @@ endif
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
 ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
+ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
@@ -1872,6 +1876,8 @@ builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 
 config.s config.o: EXTRA_CPPFLAGS = -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
+attr.s attr.o: EXTRA_CPPFLAGS = -DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
+
 http.s http.o: EXTRA_CPPFLAGS = -DGIT_USER_AGENT='"git/$(GIT_VERSION)"'
 
 ifdef NO_EXPAT
diff --git a/attr.c b/attr.c
index 8ba606c..b1c3a30 100644
--- a/attr.c
+++ b/attr.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "exec_cmd.h"
 #include "attr.h"
 
 const char git_attr__true[] = "(builtin)true";
@@ -326,16 +327,16 @@ static struct attr_stack *read_attr_from_array(const char **list)
 static enum git_attr_direction direction;
 static struct index_state *use_index;
 
-static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
+static struct attr_stack *read_attr_from_file(const char *path, int macro_ok, struct attr_stack *res)
 {
 	FILE *fp = fopen(path, "r");
-	struct attr_stack *res;
 	char buf[2048];
 	int lineno = 0;
 
 	if (!fp)
-		return NULL;
-	res = xcalloc(1, sizeof(*res));
+		return res;
+	if (!res)
+		res = xcalloc(1, sizeof(*res));
 	while (fgets(buf, sizeof(buf), fp))
 		handle_attr_line(res, buf, path, ++lineno, macro_ok);
 	fclose(fp);
@@ -407,10 +408,10 @@ static struct attr_stack *read_attr(const char *path, int macro_ok)
 	if (direction == GIT_ATTR_CHECKOUT) {
 		res = read_attr_from_index(path, macro_ok);
 		if (!res)
-			res = read_attr_from_file(path, macro_ok);
+			res = read_attr_from_file(path, macro_ok, NULL);
 	}
 	else if (direction == GIT_ATTR_CHECKIN) {
-		res = read_attr_from_file(path, macro_ok);
+		res = read_attr_from_file(path, macro_ok, NULL);
 		if (!res)
 			/*
 			 * There is no checked out .gitattributes file there, but
@@ -462,8 +463,28 @@ static void drop_attr_stack(void)
 	}
 }
 
+const char *git_etc_gitattributes(void)
+{
+	static const char *system_wide;
+	if (!system_wide)
+		system_wide = system_path(ETC_GITATTRIBUTES);
+	return system_wide;
+}
+
+int git_attr_system(void)
+{
+	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
+}
+
+int git_attr_global(void)
+{
+	return !git_env_bool("GIT_ATTR_NOGLOBAL", 0);
+}
+
 static void bootstrap_attr_stack(void)
 {
+	const char *home;
+
 	if (!attr_stack) {
 		struct attr_stack *elem;
 
@@ -480,7 +501,15 @@ static void bootstrap_attr_stack(void)
 			debug_push(elem);
 		}
 
-		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
+		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1, NULL);
+		home = get_home_directory();
+		if (git_attr_global() && home) {
+			char *user_attr = xstrdup(mkpath("%s/%s", home, GITATTRIBUTES_FILE));
+			elem = read_attr_from_file(user_attr, 1, elem);
+			free(user_attr);
+		}
+		if (git_attr_system())
+			elem = read_attr_from_file(git_etc_gitattributes(), 1, elem);
 		if (!elem)
 			elem = xcalloc(1, sizeof(*elem));
 		elem->origin = NULL;
diff --git a/configure.ac b/configure.ac
index 5601e8b..773b835 100644
--- a/configure.ac
+++ b/configure.ac
@@ -285,6 +285,13 @@ GIT_PARSE_WITH_SET_MAKE_VAR(gitconfig, ETC_GITCONFIG,
 			If VALUE is not fully qualified it will be interpretted
 			as a path relative to the computed prefix at runtime.)
 
+# Allow user to set ETC_GITATTRIBUTS variable
+GIT_PARSE_WITH_SET_MAKE_VAR(gitattributes, ETC_GITATTRIBUTES,
+			Use VALUE instead of /etc/gitattributes as the
+			global git attributes file.
+			If VALUE is not fully qualified it will be interpretted
+			as a path relative to the computed prefix at runtime.)
+
 #
 # Allow user to set the default pager
 GIT_PARSE_WITH_SET_MAKE_VAR(pager, DEFAULT_PAGER,
-- 
1.7.1.msysgit.0.10.g9ffa0
