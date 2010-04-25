From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v2 3/3] pretty: add aliases for pretty formats
Date: Sun, 25 Apr 2010 22:56:19 +0100
Message-ID: <1272232579-18895-4-git-send-email-wmpalmer@gmail.com>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 23:57:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O69pr-0002Dg-CS
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 23:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab0DYV5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 17:57:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59529 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0DYV51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 17:57:27 -0400
Received: by mail-wy0-f174.google.com with SMTP id 36so881071wyg.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pcI0a6EkbHfES/CBhDWIQ0oKZyheEVqOfGF0c4fzQcI=;
        b=QOxKCngjr1SQ9lBNx2ECd144bCR8vNG9oSHUWthQJ6UGh7EjOK6ZEd0mKfdxASRyhO
         ERL/VgPmaDx7HJQfd0Nb9WoqlmMe9yd5tKvFmDskFaoCtoXmfybLqdkYgdGIJFdYI5zh
         q2mM97dSGhGJCiEGGeZEd1qkrpvZ6pe24iTPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g60Tu6gtepRE94W3DKF0EnOJ3qCL1p7jJ18K/fcib9qv6kPZgKnTeQQMoK15xfFkpZ
         TtgTM2B59GhX4u6xGqMErdrwoh3HGzSFwEGeOrnj5CbcNTCDdgQWUPYMEOT1PZ+JWOfZ
         tdfb9EvHYZ93SgpJCXkLvwokoliSIx58wADsA=
Received: by 10.216.89.203 with SMTP id c53mr4223318wef.79.1272232646243;
        Sun, 25 Apr 2010 14:57:26 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id r29sm16328252wbv.9.2010.04.25.14.57.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 14:57:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145772>

previously the only ways to alias a --pretty format within git were
either to set the format as your default format (via the format.pretty
configuration variable), or by using a regular git alias. This left the
definition of more complicated formats to the realm of "builtin or
nothing", with user-defined formats usually being reserved for quick
one-offs.

Here we allow user-defined formats to enjoy more or less the same
benefits of builtins. By defining format.pretty.myalias, "myalias" can
be used in place of whatever would normally come after --pretty=. This
can be a format:, tformat:, raw (ie, defaulting to tformat), or the name
of another builtin or user-defined pretty format.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/config.txt      |    8 ++
 pretty.c                      |  169 +++++++++++++++++++++++++++++++++++------
 t/t4205-log-pretty-formats.sh |   53 ++++++++++++-
 3 files changed, 202 insertions(+), 28 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..6573d18 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -894,6 +894,14 @@ format.pretty::
 	See linkgit:git-log[1], linkgit:git-show[1],
 	linkgit:git-whatchanged[1].
 
+format.pretty.<name>::
+	Alias for a --pretty= format string, as specified in
+	linkgit:git-log[1]. Any aliases defined here can be used just
+	as the builtin pretty formats could. For example, defining
+	"format.pretty.hash = format:%H" would cause the invocation
+	"git log --pretty=hash" to be equivalent to running
+	"git log --pretty=format:%H".
+
 format.thread::
 	The default threading style for 'git format-patch'.  Can be
 	a boolean value, or `shallow` or `deep`.  `shallow` threading
diff --git a/pretty.c b/pretty.c
index f884f48..d49fec7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -11,6 +11,16 @@
 #include "reflog-walk.h"
 
 static char *user_format;
+static struct cmt_fmt_map {
+	const char *name;
+	enum cmit_fmt format;
+	const char *user_format;
+	int is_tformat;
+	int is_alias;
+} *commit_formats = NULL;
+static size_t commit_formats_len = 0;
+static size_t commit_formats_alloc = 0;
+static struct cmt_fmt_map *find_commit_format(const char *sought);
 
 static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
 {
@@ -21,22 +31,134 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 	rev->commit_format = CMIT_FMT_USERFORMAT;
 }
 
-void get_commit_format(const char *arg, struct rev_info *rev)
+static int git_pretty_formats_config(const char *var, const char *value, void *cb)
+{
+	if (!prefixcmp(var, "format.pretty.")) {
+		struct cmt_fmt_map user_format = {0};
+		const char *fmt;
+
+		user_format.name = xstrdup(&var[14]);
+		user_format.format = CMIT_FMT_USERFORMAT;
+		git_config_string(&fmt, var, value);
+		if (!prefixcmp(fmt, "format:") || !prefixcmp(fmt, "tformat:")) {
+			user_format.is_tformat = fmt[0] == 't';
+			fmt = strchr(fmt, ':') + 1;
+		} else if (strchr(fmt, '%'))
+			user_format.is_tformat = 1;
+		else
+			user_format.is_alias = 1;
+		user_format.user_format = fmt;
+
+		ALLOC_GROW(commit_formats, commit_formats_len+1,
+			   commit_formats_alloc);
+		memcpy(&commit_formats[ commit_formats_len ], &user_format,
+		       sizeof(user_format));
+		commit_formats_len++;
+	}
+	return 0;
+}
+
+static void setup_commit_formats(void)
 {
 	int i;
-	static struct cmt_fmt_map {
-		const char *n;
-		size_t cmp_len;
-		enum cmit_fmt v;
-	} cmt_fmts[] = {
-		{ "raw",	1,	CMIT_FMT_RAW },
-		{ "medium",	1,	CMIT_FMT_MEDIUM },
-		{ "short",	1,	CMIT_FMT_SHORT },
-		{ "email",	1,	CMIT_FMT_EMAIL },
-		{ "full",	5,	CMIT_FMT_FULL },
-		{ "fuller",	5,	CMIT_FMT_FULLER },
-		{ "oneline",	1,	CMIT_FMT_ONELINE },
+	const char **attempted_aliases = NULL;
+	size_t attempted_aliases_alloc = 0;
+	size_t attempted_aliases_len;
+	struct cmt_fmt_map builtin_formats[] = {
+		{ "raw",	CMIT_FMT_RAW,		NULL,	0 },
+		{ "medium",	CMIT_FMT_MEDIUM,	NULL,	0 },
+		{ "short",	CMIT_FMT_SHORT,		NULL,	0 },
+		{ "email",	CMIT_FMT_EMAIL,		NULL,	0 },
+		{ "full",	CMIT_FMT_FULL,		NULL,	0 },
+		{ "fuller",	CMIT_FMT_FULLER,	NULL,	0 },
+		{ "oneline",	CMIT_FMT_ONELINE,	NULL,	1 }
 	};
+	commit_formats_len = ARRAY_SIZE(builtin_formats);
+	ALLOC_GROW(commit_formats, commit_formats_len, commit_formats_alloc);
+	memcpy(commit_formats, builtin_formats,
+	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
+
+	git_config(git_pretty_formats_config, NULL);
+
+	for (i = ARRAY_SIZE(builtin_formats); i < commit_formats_len; i++) {
+		attempted_aliases_len = 0;
+		struct cmt_fmt_map *aliased_format = &commit_formats[i];
+		const char *fmt = commit_formats[i].user_format;
+		int j;
+
+		if (!commit_formats[i].is_alias)
+			continue;
+
+		while ((aliased_format = find_commit_format(fmt))) {
+			if (!aliased_format->is_alias)
+				break;
+
+			fmt = aliased_format->user_format;
+			for (j=0; j<attempted_aliases_len; j++) {
+				if (!strcmp(fmt, attempted_aliases[j])) {
+					aliased_format = NULL;
+					break;
+				}
+			}
+			if (!aliased_format)
+				break;
+
+			ALLOC_GROW(attempted_aliases, attempted_aliases_len+1,
+				   attempted_aliases_alloc);
+			attempted_aliases[attempted_aliases_len] = fmt;
+			attempted_aliases_len++;
+		}
+		if (aliased_format) {
+			commit_formats[i].format = aliased_format->format;
+			commit_formats[i].user_format = aliased_format->user_format;
+			commit_formats[i].is_tformat = aliased_format->is_tformat;
+			commit_formats[i].is_alias = 0;
+		} else
+			commit_formats[i].format = CMIT_FMT_UNSPECIFIED;
+	}
+}
+
+static struct cmt_fmt_map *find_commit_format(const char *sought)
+{
+	struct cmt_fmt_map *found = NULL;
+	size_t found_match_len = 0;
+
+	if (!commit_formats)
+		setup_commit_formats();
+
+	int i;
+	for (i = 0; i < commit_formats_len; i++) {
+		const char *candidate = commit_formats[i].name;
+		const char *s = sought;
+		size_t match_len = 0;
+
+		if (commit_formats[i].format == CMIT_FMT_UNSPECIFIED)
+			continue;
+
+		for (; s++, candidate++;) {
+			if (!*candidate && *s) {
+				match_len = 0;
+				break;
+			}
+			if (!*candidate || !*s) {
+				match_len = s - sought;
+				break;
+			}
+			if (*s != *candidate) {
+				match_len = 0;
+				break;
+			}
+		}
+		if (match_len > found_match_len) {
+			found = &commit_formats[i];
+		}
+	}
+	return found;
+}
+
+void get_commit_format(const char *arg, struct rev_info *rev)
+{
+	struct cmt_fmt_map *commit_format;
 
 	rev->use_terminator = 0;
 	if (!arg || !*arg) {
@@ -47,21 +169,22 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
 		return;
 	}
-	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
-		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
-		    !strncmp(arg, cmt_fmts[i].n, strlen(arg))) {
-			if (cmt_fmts[i].v == CMIT_FMT_ONELINE)
-				rev->use_terminator = 1;
-			rev->commit_format = cmt_fmts[i].v;
-			return;
-		}
-	}
+
 	if (strchr(arg, '%')) {
 		save_user_format(rev, arg, 1);
 		return;
 	}
 
-	die("invalid --pretty format: %s", arg);
+	commit_format = find_commit_format(arg);
+	if( !commit_format )
+		die("invalid --pretty format: %s", arg);
+
+	rev->commit_format = commit_format->format;
+	rev->use_terminator = commit_format->is_tformat;
+	if( commit_format->format == CMIT_FMT_USERFORMAT ){
+		save_user_format(rev, commit_format->user_format,
+				 commit_format->is_tformat);
+	}
 }
 
 /*
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 28d2948..ee3e934 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -6,7 +6,15 @@
 test_description='Test pretty formats'
 . ./test-lib.sh
 
-test_expect_success "set up basic repos" ">foo && git add foo && git commit -m initial"
+test_expect_success "set up basic repos" \
+	">foo &&
+	>bar &&
+	git add foo &&
+	test_tick &&
+	git commit -m initial &&
+	git add bar &&
+	test_tick &&
+	git commit -m 'add bar'"
 
 for flag in false true always; do
 for color in red green blue reset; do
@@ -16,29 +24,64 @@ for color in red green blue reset; do
 		"$make_expected &&
 		git config color.ui $flag &&
 		git log -1 --pretty=format:'%C$color' > actual &&
-		cmp expected actual"
+		test_cmp expected actual"
 
 
 	test_expect_success "%C($color) with color.ui $flag" \
 		"$make_expected &&
 		git config color.ui $flag &&
 		git log -1 --pretty=format:'%C($color)' > actual &&
-		cmp expected actual"
+		test_cmp expected actual"
 
 	[ ! "$flag" = "always" ] && make_expected=">expected"
 	test_expect_success "%C?$color with color.ui $flag" \
 		"$make_expected &&
 		git config color.ui $flag &&
 		git log -1 --pretty=format:'%C?$color' > actual &&
-		cmp expected actual"
+		test_cmp expected actual"
 
 	test_expect_success "%C?($color) with color.ui $flag" \
 		"$make_expected &&
 		git config color.ui $flag &&
 		git log -1 --pretty=format:'%C?($color)' > actual &&
-		cmp expected actual"
+		test_cmp expected actual"
 
 done
 done
+test_expect_success "reset color flags" "git config --unset color.ui"
+
+test_expect_success "alias builtin format" \
+	"git log --pretty=oneline >expected &&
+	git config format.pretty.test-alias oneline &&
+	git log --pretty=test-alias >actual &&
+	test_cmp expected actual"
+
+test_expect_success "alias user-defined format" \
+	"git log --pretty='format:%h' >expected &&
+	git config format.pretty.test-alias 'format:%h' &&
+	git log --pretty=test-alias >actual &&
+	test_cmp expected actual"
+
+test_expect_success "alias user-defined tformat" \
+	"git log --pretty='tformat:%h' >expected &&
+	git config format.pretty.test-alias 'tformat:%h' &&
+	git log --pretty=test-alias >actual &&
+	test_cmp expected actual"
+
+test_expect_code 128 "alias non-existant format" \
+	"git config format.pretty.test-alias format-that-will-never-exist &&
+	git log --pretty=test-alias"
+
+test_expect_success "alias of an alias" \
+	"git log --pretty='tformat:%h' >expected &&
+	git config format.pretty.test-foo 'tformat:%h' &&
+	git config format.pretty.test-bar test-foo &&
+	git log --pretty=test-bar >actual &&
+	test_cmp expected actual"
+
+test_expect_code 128 "alias loop" \
+	"git config format.pretty.test-foo test-bar &&
+	git config format.pretty.test-bar test-foo &&
+	git log --pretty=test-foo"
 
 test_done
-- 
1.7.1.rc1.13.gbb0a0a.dirty
