From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3 v4] Add global and system-wide gitattributes
Date: Tue, 31 Aug 2010 01:15:23 +0200
Message-ID: <1283210123-19752-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
Cc: Petr Onderka <gsvick@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 31 01:15:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqDZu-0007oP-QJ
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 01:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0H3XPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 19:15:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44541 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab0H3XPp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 19:15:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7UN3oJ0010223
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 Aug 2010 01:03:51 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OqDZk-000228-OK; Tue, 31 Aug 2010 01:15:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OqDZk-0007ge-N6; Tue, 31 Aug 2010 01:15:40 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpqhbibbthi.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 31 Aug 2010 01:03:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7UN3oJ0010223
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1283814231.33485@TQkajO94VEuCzcWS9VjSLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154870>

From: Petr Onderka <gsvick@gmail.com>

Allow gitattributes to be set globally and system wide. This way, settings
for particular file types can be set in one place and apply for all user's
repositories.

The location of system-wide attributes file is $(prefix)/etc/gitattributes.
The location of the global file can be configured by setting
core.attributesfile.

Some parts of the code were copied from the implementation of the same
functionality in config.c.

Signed-off-by: Petr Onderka <gsvick@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This version doesn't touch config.c, and calls git_config with a
trivial callback reading only the core.attributesfile variable.

This time, I did run the whole testsuite ;-).

 Documentation/config.txt        |    6 ++++
 Documentation/gitattributes.txt |   13 +++++++--
 Makefile                        |    6 ++++
 attr.c                          |   50 ++++++++++++++++++++++++++++++++++++++-
 cache.h                         |    1 +
 configure.ac                    |   10 +++++++-
 environment.c                   |    1 +
 t/t0003-attributes.sh           |   13 ++++++++++
 8 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 05ec3fe..0e15e72 100644
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
index 2e2370c..ebd4852 100644
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
index b4745a5..fdb7b4e 100644
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
@@ -1873,6 +1877,8 @@ builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 
 config.s config.o: EXTRA_CPPFLAGS = -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
+attr.s attr.o: EXTRA_CPPFLAGS = -DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
+
 http.s http.o: EXTRA_CPPFLAGS = -DGIT_HTTP_USER_AGENT='"git/$(GIT_VERSION)"'
 
 ifdef NO_EXPAT
diff --git a/attr.c b/attr.c
index 8ba606c..eeb80d3 100644
--- a/attr.c
+++ b/attr.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "exec_cmd.h"
 #include "attr.h"
 
 const char git_attr__true[] = "(builtin)true";
@@ -462,6 +463,32 @@ static void drop_attr_stack(void)
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
+static int git_attr_config(const char *var, const char *value, void *dummy)
+{
+	if (!strcmp(var, "core.attributesfile"))
+		return git_config_pathname(&attributes_file, var, value);
+	
+	return 0;
+}
+
 static void bootstrap_attr_stack(void)
 {
 	if (!attr_stack) {
@@ -472,6 +499,25 @@ static void bootstrap_attr_stack(void)
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
+		git_config(git_attr_config, NULL);
+		if (git_attr_global() && attributes_file) {
+			elem = read_attr_from_file(attributes_file, 1);
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
@@ -499,7 +545,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
 
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
index 7e10a39..4b6e424 100644
--- a/cache.h
+++ b/cache.h
@@ -1051,6 +1051,7 @@ extern int pager_use_color;
 
 extern const char *editor_program;
 extern const char *excludes_file;
+extern const char *attributes_file;
 
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
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
index 212f086..32c6c96 100644
--- a/environment.c
+++ b/environment.c
@@ -40,6 +40,7 @@ const char *pager_program;
 int pager_use_color = 1;
 const char *editor_program;
 const char *excludes_file;
+const char *attributes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int read_replace_refs = 1;
 enum eol eol = EOL_UNSET;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 114967a..b884bb7 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -35,6 +35,9 @@ test_expect_success 'setup' '
 		echo "d/* test=a/b/d/*"
 		echo "d/yes notest"
 	) >a/b/.gitattributes
+	(
+		echo "global test=global"
+	) >$HOME/global-gitattributes
 
 '
 
@@ -56,6 +59,16 @@ test_expect_success 'attribute test' '
 
 '
 
+test_expect_success 'core.attributesfile' '
+	attr_check global unspecified &&
+	git config core.attributesfile "$HOME/global-gitattributes" &&
+	attr_check global global &&
+	git config core.attributesfile "~/global-gitattributes" &&
+	attr_check global global &&
+	echo "global test=precedence" >> .gitattributes &&
+	attr_check global precedence
+'
+
 test_expect_success 'attribute test: read paths from stdin' '
 
 	cat <<EOF > expect
-- 
1.7.2.2.175.ga619d.dirty
