From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] builtin-config: add --path option doing ~ and ~user expansion.
Date: Wed, 30 Dec 2009 17:51:53 +0100
Message-ID: <1262191913-8340-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 30 17:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ1mN-0005fc-9x
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 17:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbZL3QwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 11:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbZL3QwG
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 11:52:06 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51467 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbZL3QwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 11:52:05 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nBUGos73024077
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 30 Dec 2009 17:50:54 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NQ1m7-0006a8-59; Wed, 30 Dec 2009 17:51:55 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NQ1m7-0002B5-45; Wed, 30 Dec 2009 17:51:55 +0100
X-Mailer: git-send-email 1.6.6.71.g392d.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Dec 2009 17:50:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nBUGos73024077
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1262796658.17601@yH4wXUbnqBh5+gQBpvSzEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135907>

395de250 (Expand ~ and ~user in core.excludesfile, commit.template)
introduced a C function git_config_pathname, doing ~/ and ~user/
expansion. This patch makes the feature available to scripts with 'git
config --get --path'.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-config.txt |   14 +++++++++++---
 builtin-config.c             |   20 +++++++++++++++++++-
 t/t1300-repo-config.sh       |   28 ++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f68b198..2632928 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -37,11 +37,12 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-The type specifier can be either '--int' or '--bool', which will make
+The type specifier can be either '--int' or '--bool', to make
 'git-config' ensure that the variable(s) are of the given type and
 convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool).  If no type specifier is passed,
-no checks or transformations are performed on the value.
+a "true" or "false" string for bool), or '--path', which does some
+path expansion (see '--path' below).  If no type specifier is passed, no
+checks or transformations are performed on the value.
 
 The file-option can be one of '--system', '--global' or '--file'
 which specify where the values will be read from or written to.
@@ -136,6 +137,13 @@ See also <<FILES>>.
 	'git-config' will ensure that the output matches the format of
 	either --bool or --int, as described above.
 
+--path::
+	'git-config' will expand leading '{tilde}' to the value of
+	'$HOME', and '{tilde}user' to the home directory for the
+	specified user.  This option has no effect when setting the
+	value (but you can use 'git config bla {tilde}/' from the
+	command line to let your shell do the expansion).
+
 -z::
 --null::
 	For all options that output values and/or keys, always
diff --git a/builtin-config.c b/builtin-config.c
index a2d656e..2e3ef91 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -45,6 +45,7 @@ static int end_null;
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
 #define TYPE_BOOL_OR_INT (1<<2)
+#define TYPE_PATH (1<<3)
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP("Config file location"),
@@ -69,6 +70,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
 	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
 	OPT_BIT(0, "bool-or-int", &types, "value is --bool or --int", TYPE_BOOL_OR_INT),
+	OPT_BIT(0, "path", &types, "value is a path (file or directory name)", TYPE_PATH),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
 	OPT_END(),
@@ -94,6 +96,7 @@ static int show_config(const char *key_, const char *value_, void *cb)
 {
 	char value[256];
 	const char *vptr = value;
+	int must_free_vptr = 0;
 	int dup_error = 0;
 
 	if (!use_key_regexp && strcmp(key_, key))
@@ -123,6 +126,9 @@ static int show_config(const char *key_, const char *value_, void *cb)
 			vptr = v ? "true" : "false";
 		else
 			sprintf(value, "%d", v);
+	} else if (types == TYPE_PATH) {
+		git_config_pathname(&vptr, key_, value_);
+		must_free_vptr = 1;
 	}
 	else
 		vptr = value_?value_:"";
@@ -133,6 +139,12 @@ static int show_config(const char *key_, const char *value_, void *cb)
 	}
 	else
 		printf("%s%c", vptr, term);
+	if (must_free_vptr)
+		/* If vptr must be freed, it's a pointer to a
+		 * dynamically allocated buffer, it's safe to cast to
+		 * const.
+		*/
+		free((char *)vptr);
 
 	return 0;
 }
@@ -215,7 +227,13 @@ static char *normalize_value(const char *key, const char *value)
 	if (!value)
 		return NULL;
 
-	if (types == 0)
+	if (types == 0 || types == TYPE_PATH)
+		/*
+		 * We don't do normalization for TYPE_PATH here: If
+		 * the path is like ~/foobar/, we prefer to store
+		 * "~/foobar/" in the config file, and to expand the ~
+		 * when retrieving the value.
+		 */
 		normalized = xstrdup(value);
 	else {
 		normalized = xmalloc(64);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 83b7294..f89d7e9 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -683,6 +683,34 @@ test_expect_success 'set --bool-or-int' '
 
 rm .git/config
 
+cat >expect <<\EOF
+[path]
+	home = ~/
+	normal = /dev/null
+	trailingtilde = foo~
+EOF
+
+test_expect_success 'set --path' '
+	git config --path path.home "~/" &&
+	git config --path path.normal "/dev/null" &&
+	git config --path path.trailingtilde "foo~" &&
+	test_cmp expect .git/config'
+
+cat >expect <<EOF
+$HOME/
+/dev/null
+foo~
+EOF
+
+test_expect_success 'get --path' '
+	git config --get --path path.home > result &&
+	git config --get --path path.normal >> result &&
+	git config --get --path path.trailingtilde >> result &&
+	test_cmp expect result
+'
+
+rm .git/config
+
 git config quote.leading " test"
 git config quote.ending "test "
 git config quote.semicolon "test;test"
-- 
1.6.6.71.g392d.dirty
