From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] get_sha1: allow custom SHA-1 mapping with $SHA1^{~alias} syntax
Date: Fri, 24 Dec 2010 21:07:46 +0700
Message-ID: <1293199669-19016-3-git-send-email-pclouds@gmail.com>
References: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kevin@sb.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 15:09:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW8L2-000736-3B
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 15:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab0LXOJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 09:09:25 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34972 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0LXOJY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 09:09:24 -0500
Received: by mail-pz0-f46.google.com with SMTP id 35so236960pzk.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 06:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FRYKoZz2T+Jd4afoyf0kFmEMKl3Wgt3bcxnLTq+NdmE=;
        b=Y9LPinf0C8nPRno3ejYWAe8l4iJtmwIdpQ6yP1uLf+ETk8vbQsrlyz8CsR+nZ3pjRH
         sWNqqfQiUFKXSGFxzmxiKW0Qo9JP4IPvJr4II5LuOdjRA2y5eWQR+BD00DEN6oazDEw/
         wIvLSFJZQ6Lb+QcIBGCiz2KBw0NnYnjwTPBHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VAaJd2LRObT1mE2Ehz30KrsGnGUv3imVTqP1B0jtyqbMfTeM65PVmnxNTE982a1dfA
         zSkG9rLtAo9agyLq01UqUTt+IGmHuH6bzBHS3FibPTvgf5j9qsDcHV1/m0Ymxmet/1UU
         ho2haQl6z3nn8S/GKQQkqNsD/GRY7hA7YEZhI=
Received: by 10.142.207.8 with SMTP id e8mr7477141wfg.405.1293199763666;
        Fri, 24 Dec 2010 06:09:23 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id b11sm12367614wff.9.2010.12.24.06.09.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 06:09:22 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Dec 2010 21:08:05 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164157>

"alias" is defined in config as sha1.alias. %sha1% and %arg% in the
alias command will be substituted.

The alias command is supposed to return a piece of text that
get_sha1() can consume, preferably straight SHA-1.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt    |    9 ++++
 Documentation/revisions.txt |    7 +++
 alias.c                     |   23 +++++++++--
 cache.h                     |    1 +
 sha1_name.c                 |   86 +++++++++++++++++++++++++++++++++++=
++++++++
 t/t1511-rev-parse-caret.sh  |   45 ++++++++++++++++++++++
 6 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0f85793..0c4fb66 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -588,6 +588,15 @@ it will be treated as a shell command.  For exampl=
e, defining
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
=20
+sha1.*::
+	Extended SHA-1 syntax aliases. These aliases are similar to alias.*
+	but each will correspond to a '{caret}\{{tilde}alias\}' syntax (see
+	linkgit:gitrevisions[7]). '%sha1%' in the alias command will be
+	substituted with resolved SHA-1 before the caret. If
+	'{caret}\{{tilde}alias:extra\}' syntax is used, '%arg%' in the
+	alias command will be substituted with 'extra'. The command is
+	supposed to return an extended SHA-1 syntax.
+
 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
 	with parameter '--keep-cr'. In this case git-mailsplit will
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 174fa8e..413f91c 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -106,6 +106,13 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DI=
R/packed-refs` file.
   and dereference the tag recursively until a non-tag object is
   found.
=20
+* A suffix '{caret}' followed by an SHA-1 alias with a leading
+  '{tilde}', all enclosed in brace pair (e.g.
+  `v0.998{caret}\{{tilde}alias\}`) will invoke the corresponding
+  alias command, specified in config (see linkgit:git-config[1],
+  key 'sha1.*'). The command is supposed to return an extended
+  SHA-1.
+
 * A suffix '{caret}' to a revision parameter followed by a brace
   pair that contains a text led by a slash (e.g. `HEAD^{/fix nasty bug=
}`):
   this is the same as `:/fix nasty bug` syntax below except that
diff --git a/alias.c b/alias.c
index 6626bb0..29a9903 100644
--- a/alias.c
+++ b/alias.c
@@ -1,12 +1,12 @@
 #include "cache.h"
 #include "run-command.h"
=20
-static const char *alias_key;
 static char *alias_val;
=20
 static int alias_lookup_cb(const char *k, const char *v, void *cb)
 {
-	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
+	const char *key =3D cb;
+	if (!strcmp(k, key)) {
 		if (!v)
 			return config_error_nonbool(k);
 		alias_val =3D xstrdup(v);
@@ -15,14 +15,27 @@ static int alias_lookup_cb(const char *k, const cha=
r *v, void *cb)
 	return 0;
 }
=20
-char *alias_lookup(const char *alias)
+static char *generic_alias_lookup(const char *alias, const char *names=
pase)
 {
-	alias_key =3D alias;
+	struct strbuf key =3D STRBUF_INIT;
+	strbuf_addstr(&key, namespase);
+	strbuf_addstr(&key, alias);
 	alias_val =3D NULL;
-	git_config(alias_lookup_cb, NULL);
+	git_config(alias_lookup_cb, key.buf);
+	strbuf_release(&key);
 	return alias_val;
 }
=20
+char *alias_lookup(const char *alias)
+{
+	return generic_alias_lookup(alias, "alias.");
+}
+
+char *sha1_alias_lookup(const char *alias)
+{
+	return generic_alias_lookup(alias, "sha1.");
+}
+
 #define SPLIT_CMDLINE_BAD_ENDING 1
 #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
 static const char *split_cmdline_errors[] =3D {
diff --git a/cache.h b/cache.h
index 20a37ff..56a1b18 100644
--- a/cache.h
+++ b/cache.h
@@ -1120,6 +1120,7 @@ struct alias_param {
 };
=20
 char *alias_lookup(const char *alias);
+char *sha1_alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
 /* Takes a negative value returned by split_cmdline */
 const char *split_cmdline_strerror(int cmdline_errno);
diff --git a/sha1_name.c b/sha1_name.c
index c5c59ce..3a98a50 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -529,6 +529,76 @@ struct object *peel_to_type(const char *name, int =
namelen,
 	}
 }
=20
+/*
+ * Handle $SHA1^{~alias} syntax. Config key sha1.alias will be used.
+ * The following parameters are substituted:
+ *
+ *  - %sha1%  SHA-1 before ^{~alias}, required
+ *  - %arg%   extra arguments after colon in SHA1^{~alias:args}
+ *
+ * The alias returns a string, preferabbly SHA-1.
+ */
+static int peel_alias(const char *name, int len, const char *sp,
+		      const unsigned char *input_sha1,
+		      struct strbuf *result)
+{
+	struct alias_param *params, *param;
+	struct strbuf alias =3D STRBUF_INIT;
+	struct strbuf cmd =3D STRBUF_INIT;
+	char *s;
+	int ret, arg_len =3D 0;
+
+	if (name[len-1] !=3D '}')
+		return -1;
+	len -=3D sp - name + 1; /* remove $SHA1^{~ and } */
+	if (!len)
+		return error("$SHA1^{~alias} syntax with no alias");
+
+	s =3D strchr(sp, ':');
+	if (s) {
+		arg_len =3D (sp + len) - (s + 1);
+		len =3D s - sp;
+	}
+	strbuf_add(&alias, sp, len);
+	s =3D sha1_alias_lookup(alias.buf);
+	if (!s) {
+		ret =3D error("unable to find SHA-1 alias '%s'", alias.buf);
+		goto done;
+	}
+	strbuf_attach(&cmd, s, strlen(s), strlen(s)+1);
+
+	extract_alias_params(cmd.buf, &params);
+	param =3D lookup_alias_param(params, "%sha1%");
+	if (!param) {		/* %sha1% is mandatory */
+		ret =3D error("%%sha1%% not found in alias '%s'", alias.buf);
+		goto done;
+	}
+	param->value =3D xstrdup(sha1_to_hex(input_sha1));
+
+	param =3D lookup_alias_param(params, "%arg%");
+	if (param && arg_len)
+		param->value =3D xstrndup(sp + len + 1,arg_len);
+	else if (param) {
+		ret =3D error("Alias '%s' needs arguments", alias.buf);
+		goto done;
+	}
+	else if (arg_len) {
+		ret =3D error("Arguments are given but alias '%s' does not need them=
", alias.buf);
+		goto done;
+	}
+
+	expand_alias_params(&cmd, params);
+	free_alias_params(params);
+
+	trace_printf("trace: sha1 alias expansion: %s =3D> %s\n",
+		     alias.buf, cmd.buf);
+	ret =3D get_alias_oneline(alias.buf, cmd.buf, result);
+done:
+	strbuf_release(&alias);
+	strbuf_release(&cmd);
+	return ret;
+}
+
 static int peel_onion(const char *name, int len, unsigned char *sha1)
 {
 	unsigned char outer[20];
@@ -566,6 +636,22 @@ static int peel_onion(const char *name, int len, u=
nsigned char *sha1)
 		expected_type =3D OBJ_NONE;
 	else if (sp[0] =3D=3D '/')
 		expected_type =3D OBJ_COMMIT;
+	else if (sp[0] =3D=3D '~') {
+		struct strbuf new_name =3D STRBUF_INIT;
+
+		if (get_sha1_1(name, sp - name - 2, outer))
+			return -1;
+
+		if (peel_alias(name, len, sp + 1, outer, &new_name))
+			return -1;
+		if (get_sha1_1(new_name.buf, new_name.len, sha1)) {
+			strbuf_release(&new_name);
+			return -1;
+		}
+
+		strbuf_release(&new_name);
+		return 0;
+	}
 	else
 		return -1;
=20
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e043cb7..b99bfa2 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -70,4 +70,49 @@ test_expect_success 'ref^{/Initial}' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'ref^{~}' '
+	test_must_fail git rev-parse HEAD^{~}
+'
+
+test_expect_success 'ref^{~non-existent}' '
+	test_must_fail git rev-parse HEAD^{~non-existent}
+'
+
+test_expect_success 'ref^{~simple}' '
+	git config sha1.simple "rev-parse %sha1%" &&
+	test_must_fail git rev-parse master^{~simple:something} &&
+	git rev-parse master^{~simple} >actual &&
+	git rev-parse master >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{~external}' '
+	git config sha1.external "!echo %sha1%" &&
+	test_must_fail git rev-parse master^{~external:something} &&
+	git rev-parse master^{~external} >actual &&
+	git rev-parse master >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{~witharg:args}' '
+	git config sha1.witharg "!echo %sha1%^{%arg%}" &&
+	test_must_fail git rev-parse master^{~witharg} &&
+	git rev-parse master^{~witharg:tree} >actual &&
+	git rev-parse master^{tree} >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{~simple}^{~external}' '
+	git rev-parse master^{~simple}^{~external} >actual &&
+	git rev-parse master >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{~mapping}' '
+	git config sha1.mapping "!echo %sha1%^{~simple}" &&
+	git rev-parse master^{~mapping} >actual &&
+	git rev-parse master >expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.3.3.476.g10a82
