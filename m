From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] get_sha1: allow custom ref mapping with $ref@{~alias} syntax
Date: Fri, 24 Dec 2010 21:07:49 +0700
Message-ID: <1293199669-19016-6-git-send-email-pclouds@gmail.com>
References: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kevin@sb.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 15:10:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW8LE-0007AB-S8
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 15:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab0LXOJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 09:09:46 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61411 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab0LXOJp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 09:09:45 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so1330022pva.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 06:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=VwhSRVU5hUEeyTzGhGlnpIHBlAjG+f3BIq95kydQrDM=;
        b=ju8x/4kI5RCzewCYWvsHoiI7N6m7S2BR1Eistq1oSG9pZurlaLDUWp2PoA51dKCsO9
         1bF2zX2qkhybIdbOKZO2Bd6h8dusJ15ZC2ilnOJWCGnqBrS6oxWpotaV5s19GPjyFQP9
         kkihIwHAKRtIMvUGGXCBimgYl+tkPkEl0FOaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jhBsBgKGcYcNKTOkXB9443gbobzsR5i7zu2b1YivLI51Uh4rkAkg586AtR9nowq1qv
         tf+Wag5V+80ozM7V76G5Zb2kWQPvSQ7FYln6Cb0cHxR6WSF9uR8XyKCSy7x7PV4wbcpN
         3eQHCxFS2sEuHyT09s2RW8/0ybzO26qQmsf7o=
Received: by 10.142.245.19 with SMTP id s19mr7070425wfh.381.1293199785330;
        Fri, 24 Dec 2010 06:09:45 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id y42sm12367294wfd.10.2010.12.24.06.09.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 06:09:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Dec 2010 21:08:27 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164159>

Similar to $SHA1^{~alias}, the alias is defined as ref.alias. It is
supposed to return something that can resolve to a ref.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt    |    9 +++++
 Documentation/revisions.txt |    5 +++
 alias.c                     |    5 +++
 cache.h                     |    1 +
 sha1_name.c                 |   70 +++++++++++++++++++++++++++++++++++=
++++++-
 t/t1512-rev-parse-at.sh     |   63 +++++++++++++++++++++++++++++++++++=
+++
 6 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100755 t/t1512-rev-parse-at.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0c4fb66..a20b467 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -597,6 +597,15 @@ sha1.*::
 	alias command will be substituted with 'extra'. The command is
 	supposed to return an extended SHA-1 syntax.
=20
+ref.*::
+	Ref translation aliases. These aliases are similar to alias.*
+	but each will correspond to a '@\{{tilde}alias\}' syntax (see
+	linkgit:gitrevisions[7]). '%ref%' in the alias command will be
+	substituted with the ref before the '@'. If
+	'@\{{tilde}alias:extra\}' syntax is used, '%arg%' in the alias
+	command will be substituted with 'extra'. The command is supposed
+	to return a ref.
+
 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
 	with parameter '--keep-cr'. In this case git-mailsplit will
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 413f91c..86b0b63 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -80,6 +80,11 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/=
packed-refs` file.
   the branch the ref is set to build on top of.  Missing ref defaults
   to the current branch.
=20
+* A ref followed by '@\{{tilde}alias\}' will invoke the corresponding
+  alias command, specified in config (see linkgit:git-config[1],
+  key 'ref.*'). The command is supposed to return a ref. The
+  result ref can contain '@\{..\}' syntax.
+
 * A suffix '{caret}' to a revision parameter (e.g. 'HEAD{caret}') mean=
s the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
diff --git a/alias.c b/alias.c
index 29a9903..242401e 100644
--- a/alias.c
+++ b/alias.c
@@ -36,6 +36,11 @@ char *sha1_alias_lookup(const char *alias)
 	return generic_alias_lookup(alias, "sha1.");
 }
=20
+char *ref_alias_lookup(const char *alias)
+{
+	return generic_alias_lookup(alias, "ref.");
+}
+
 #define SPLIT_CMDLINE_BAD_ENDING 1
 #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
 static const char *split_cmdline_errors[] =3D {
diff --git a/cache.h b/cache.h
index 56a1b18..1d4ce65 100644
--- a/cache.h
+++ b/cache.h
@@ -1121,6 +1121,7 @@ struct alias_param {
=20
 char *alias_lookup(const char *alias);
 char *sha1_alias_lookup(const char *alias);
+char *ref_alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
 /* Takes a negative value returned by split_cmdline */
 const char *split_cmdline_strerror(int cmdline_errno);
diff --git a/sha1_name.c b/sha1_name.c
index cdf14c7..2734f24 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -359,7 +359,8 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1)
 	if (len && str[len-1] =3D=3D '}') {
 		for (at =3D len-2; at >=3D 0; at--) {
 			if (str[at] =3D=3D '@' && str[at+1] =3D=3D '{') {
-				if (!upstream_mark(str + at, len - at)) {
+				if (!upstream_mark(str + at, len - at) &&
+				    str[at+2] !=3D '~') {
 					reflog_len =3D (len-1) - (at+2);
 					len =3D at;
 				}
@@ -994,6 +995,69 @@ static int interpret_at_upstream(const char *at, s=
truct strbuf *real_ref)
 	return len;
 }
=20
+static int interpret_at_alias(const char *at, struct strbuf *real_ref)
+{
+	struct alias_param *params, *param;
+	struct strbuf alias =3D STRBUF_INIT;
+	struct strbuf cmd =3D STRBUF_INIT;
+	char *s;
+	int ret, len, arg_len =3D 0;
+
+	if (at[1] !=3D '{' || at[2] !=3D '~')
+		return -1;
+	len =3D strcspn(at + 3, ":}");
+	if (!len)
+		return error("$ref@{~alias} syntax with no alias");
+	if (at[3 + len] =3D=3D ':') {
+		s =3D strchr(at + 3 + len + 1, '}');
+		if (!s)
+			return error("$ref@{~alias} does not end with }");
+		arg_len =3D s - at - (3 + len + 1);
+	}
+	strbuf_add(&alias, at + 3, len);
+	s =3D ref_alias_lookup(alias.buf);
+	if (!s) {
+		ret =3D error("unable to find ref alias '%s'", alias.buf);
+		goto done;
+	}
+
+	strbuf_attach(&cmd, s, strlen(s), strlen(s)+1);
+	extract_alias_params(cmd.buf, &params);
+	param =3D lookup_alias_param(params, "%ref%");
+	if (param && real_ref->len)
+		param->value =3D xstrdup(real_ref->buf);
+	else if (param) {
+		ret =3D error("%%ref%% not found in alias '%s'", cmd.buf);
+		goto done;
+	}
+	else if (real_ref->len) {
+		ret =3D error("%%ref%% is required but alias '%s' is not followed by=
 a ref", cmd.buf);
+		goto done;
+	}
+	param =3D lookup_alias_param(params, "%arg%");
+	if (param && arg_len) {
+		param->value =3D xstrndup(at + len + 4, arg_len);
+		len +=3D arg_len + 1;
+	}
+	else if (param) {
+		ret =3D error("Alias '%s' needs arguments", alias.buf);
+		goto done;
+	}
+	else if (arg_len) {
+		ret =3D error("Arguments are given but alias '%s' does not need them=
", alias.buf);
+		goto done;
+	}
+	expand_alias_params(&cmd, params);
+	free_alias_params(params);
+
+	trace_printf("trace: ref alias expansion: %s =3D> %s\n", alias.buf, c=
md.buf);
+	ret =3D get_alias_oneline(alias.buf, cmd.buf, real_ref) ? -1 : len + =
4;
+done:
+	strbuf_release(&alias);
+	strbuf_release(&cmd);
+	return ret;
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -1035,6 +1099,8 @@ int interpret_branch_name(const char *name, struc=
t strbuf *buf)
=20
 	if (len =3D=3D -1)
 		len =3D interpret_at_upstream(cp, buf);
+	if (len =3D=3D -1)
+		len =3D interpret_at_alias(cp, buf);
 	if (len =3D=3D -1) {
 		strbuf_reset(buf);
 		return -1;
@@ -1044,7 +1110,7 @@ int interpret_branch_name(const char *name, struc=
t strbuf *buf)
 		return len; /* syntax Ok, not enough switches */
=20
 	used +=3D len;
-	if (used =3D=3D namelen)
+	if (used =3D=3D namelen && !strstr(buf->buf, "@{"))
 		return used; /* consumed all */
=20
 	/* we have extra data, which might need further processing */
diff --git a/t/t1512-rev-parse-at.sh b/t/t1512-rev-parse-at.sh
new file mode 100755
index 0000000..6594146
--- /dev/null
+++ b/t/t1512-rev-parse-at.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description=3D'tests for $ref@{something}'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit foo &&
+	git branch foo &&
+	test_commit bar &&
+	git branch bar &&
+	test_commit zoo-bar &&
+	git branch zoo/bar &&
+	test_commit zoo-zoo-bar &&
+	git branch zoo/zoo/bar
+'
+
+test_expect_success 'ref@{~}' '
+	test_must_fail git rev-parse HEAD@{~}
+'
+
+test_expect_success 'ref@{~non-existent}' '
+	test_must_fail git rev-parse HEAD@{~non-existent}
+'
+
+test_expect_success 'ref@{~simple}' '
+	git config ref.simple "symbolic-ref %ref%" &&
+	test_must_fail git rev-parse HEAD@{~simple:something} &&
+	git rev-parse HEAD@{~simple} >actual &&
+	git rev-parse HEAD >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref@{~external}' '
+	git config ref.external "!echo zoo/%ref%" &&
+	test_must_fail git rev-parse bar@{~external:something} &&
+	git rev-parse bar@{~external} >actual &&
+	git rev-parse zoo/bar >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref@{~witharg:args}' '
+	git config ref.witharg "!echo %ref%/%arg%" &&
+	test_must_fail git rev-parse zoo@{~witharg} &&
+	git rev-parse zoo@{~witharg:bar} >actual &&
+	git rev-parse zoo/bar >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref@{~external}@{~external}' '
+	git rev-parse bar@{~external}@{~external} >actual &&
+	git rev-parse zoo/zoo/bar >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref@{~mapping}' '
+	git config ref.mapping "!echo %ref%@{~external}@{~external}" &&
+	git rev-parse bar@{~mapping} >actual &&
+	git rev-parse zoo/zoo/bar >expected &&
+	test_cmp expected actual
+'
+
+test_done
--=20
1.7.3.3.476.g10a82
