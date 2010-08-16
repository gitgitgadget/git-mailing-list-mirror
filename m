From: Petr Onderka <gsvick@gmail.com>
Subject: [PATCH v2] Add global and system-wide gitattributes
Date: Mon, 16 Aug 2010 16:56:53 +0000
Message-ID: <1281977813-6528-1-git-send-email-gsvick@gmail.com>
References: <AANLkTi=2tRjGicxJxnJ3xccCGxcP3bLUy8u0O7q85D=R@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Henrik Grubbstrm <grubba@grubba.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Onderka <gsvick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 18:58:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol30i-0003Xn-St
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 18:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab0HPQ5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 12:57:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43257 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab0HPQ5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 12:57:49 -0400
Received: by bwz3 with SMTP id 3so2846115bwz.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-antivirus
         :x-antivirus-status;
        bh=mOkrM0Z68AHsvDhCzZ+AaQSudkaCD3x+ryVJpbLvOj4=;
        b=mklfjraCCoG7X4SDcLsDmo6XdQzPX+VXF28zDXDfzqSwx58YbJ5xNEnGhunVShZsoV
         cRIAuIau4ew3ZpK7j7LcZOd+u9Akf9CUsjwssP3KcLH0R8UufwGpLZv8OypdR5LMnsA6
         eJKAQ8bfjewtHzft+g3bulYiIt7i0QGPebk/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-antivirus:x-antivirus-status;
        b=ChdhCj3yMgGwSSOj+UAz0d0XORWGHPQp73Mbvc8q3I1MSCpYDS/YSCUBkmukydoIaq
         yoOKyZp7WCH5izJcYyUS/0V+Cmg+4gmcUCvtedF4VhoxCWihI16WEhIpljsX1WlO3D2V
         /Js+iYnS67TDp5PQ9/G2LCTkPgnn3hmzNC8Ss=
Received: by 10.204.102.138 with SMTP id g10mr3570920bko.42.1281977867639;
        Mon, 16 Aug 2010 09:57:47 -0700 (PDT)
Received: from localhost (217-112-171-197.cust.avonet.cz [217.112.171.197])
        by mx.google.com with ESMTPS id y2sm4462207bkx.8.2010.08.16.09.57.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 09:57:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.2361.g5f8e3
In-Reply-To: <AANLkTi=2tRjGicxJxnJ3xccCGxcP3bLUy8u0O7q85D=R@mail.gmail.com>
X-Antivirus: avast! (VPS 100816-0, 16.08.2010), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153664>

Allow gitattributes to be set globally and system wide. This way, settings
for particular file types can be set in one place and apply for all user's
repositories.

The location of system-wide attributes file is $(prefix)/etc/gitattributes.
The location of the global file can be configured by setting
core.attributesfile.

Some parts of the code were copied from the implementation of the same
functionality in config.c.

Signed-off-by: Petr Onderka <gsvick@gmail.com>
---
This version has the correct precedence for global and system-wide attributes.

I decided not to implement having user config files in a directory (at least
for now). The location of the global attributes file can be set using
core.attributesfile. This setting has no default, as Matthieu suggested.

 Documentation/config.txt        |    6 +++++
 Documentation/gitattributes.txt |   13 ++++++++--
 Makefile                        |    6 +++++
 attr.c                          |   44 ++++++++++++++++++++++++++++++++++++++-
 cache.h                         |    1 +
 config.c                        |    3 ++
 configure.ac                    |   10 ++++++++-
 environment.c                   |    1 +
 8 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f81fb91..e5034f4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -450,6 +450,12 @@ core.excludesfile::
 	to the value of `$HOME` and "{tilde}user/" to the specified user's
 	home directory.  See linkgit:gitignore[5].
 
+core.attributesfile::
+	In addition to '.gitattributes' (per-directory) and
+	'.git/info/attributes', git looks into this file for attributes
+	(see linkgit:gitattributes[5]). Path expansions are made the same
+	way as for `core.excludesfile`.
+
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 564586b..c6bdeae 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -62,14 +62,21 @@ consults `$GIT_DIR/info/attributes` file (which has the highest
 precedence), `.gitattributes` file in the same directory as the
 path in question, and its parent directories up to the toplevel of the
 work tree (the further the directory that contains `.gitattributes`
-is from the path in question, the lower its precedence).
+is from the path in question, the lower its precedence). Finally
+global and system-wide files are considered (they have the lowest
+precedence).
 
 If you wish to affect only a single repository (i.e., to assign
-attributes to files that are particular to one user's workflow), then
+attributes to files that are particular to
+one user's workflow for that repository), then
 attributes should be placed in the `$GIT_DIR/info/attributes` file.
 Attributes which should be version-controlled and distributed to other
 repositories (i.e., attributes of interest to all users) should go into
-`.gitattributes` files.
+`.gitattributes` files. Attributes that should affect all repositories
+for a single user should be placed in a file specified by the
+`core.attributesfile` configuration option (see linkgit:git-config[1]).
+Attributes for all users on a system should be placed in the
+`$(prefix)/etc/gitattributes` file.
 
 Sometimes you would need to override an setting of an attribute
 for a path to `unspecified` state.  This can be done by listing
diff --git a/Makefile b/Makefile
index f33648d..3bfc483 100644
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
index 8ba606c..068e13b 100644
--- a/attr.c
+++ b/attr.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "exec_cmd.h"
 #include "attr.h"
 
 const char git_attr__true[] = "(builtin)true";
@@ -462,6 +463,24 @@ static void drop_attr_stack(void)
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
 	if (!attr_stack) {
@@ -472,6 +491,27 @@ static void bootstrap_attr_stack(void)
 		elem->prev = attr_stack;
 		attr_stack = elem;
 
+		if (git_attr_system()) {
+			elem = read_attr_from_file(git_etc_gitattributes(), 1);
+			if (elem) {
+				elem->origin = NULL;
+				elem->prev = attr_stack;
+				attr_stack = elem;
+			}
+		}
+
+		if (git_attr_global() && attributes_file) {
+			char *user_attr = xstrdup(attributes_file);
+
+			elem = read_attr_from_file(user_attr, 1);
+			free(user_attr);
+			if (elem) {
+				elem->origin = NULL;
+				elem->prev = attr_stack;
+				attr_stack = elem;
+			}
+		}
+
 		if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
 			elem = read_attr(GITATTRIBUTES_FILE, 1);
 			elem->origin = strdup("");
@@ -499,7 +539,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
 
 	/*
 	 * At the bottom of the attribute stack is the built-in
-	 * set of attribute definitions.  Then, contents from
+	 * set of attribute definitions, followed by the contents
+	 * of $(prefix)/etc/gitattributes and a file specified by
+	 * core.attributesfile.  Then, contents from
 	 * .gitattribute files from directories closer to the
 	 * root to the ones in deeper directories are pushed
 	 * to the stack.  Finally, at the very top of the stack
diff --git a/cache.h b/cache.h
index c9fa3df..cd95801 100644
--- a/cache.h
+++ b/cache.h
@@ -1030,6 +1030,7 @@ extern int pager_use_color;
 
 extern const char *editor_program;
 extern const char *excludes_file;
+extern const char *attributes_file;
 
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
diff --git a/config.c b/config.c
index cdcf583..f602cd4 100644
--- a/config.c
+++ b/config.c
@@ -563,6 +563,9 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.excludesfile"))
 		return git_config_pathname(&excludes_file, var, value);
 
+	if (!strcmp(var, "core.attributesfile"))
+		return git_config_pathname(&attributes_file, var, value);
+
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/configure.ac b/configure.ac
index 5601e8b..c5b3a41 100644
--- a/configure.ac
+++ b/configure.ac
@@ -282,7 +282,15 @@ GIT_PARSE_WITH(iconv))
 GIT_PARSE_WITH_SET_MAKE_VAR(gitconfig, ETC_GITCONFIG,
 			Use VALUE instead of /etc/gitconfig as the
 			global git configuration file.
-			If VALUE is not fully qualified it will be interpretted
+			If VALUE is not fully qualified it will be interpreted
+			as a path relative to the computed prefix at runtime.)
+
+#
+# Allow user to set ETC_GITATTRIBUTES variable
+GIT_PARSE_WITH_SET_MAKE_VAR(gitattributes, ETC_GITATTRIBUTES,
+			Use VALUE instead of /etc/gitattributes as the
+			global git attributes file.
+			If VALUE is not fully qualified it will be interpreted
 			as a path relative to the computed prefix at runtime.)
 
 #
diff --git a/environment.c b/environment.c
index 83d38d3..58f719a 100644
--- a/environment.c
+++ b/environment.c
@@ -38,6 +38,7 @@ const char *pager_program;
 int pager_use_color = 1;
 const char *editor_program;
 const char *excludes_file;
+const char *attributes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int read_replace_refs = 1;
 enum eol eol = EOL_UNSET;
-- 
1.7.2.1.2361.g5f8e3
