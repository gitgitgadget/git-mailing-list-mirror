From: conrad.irwin@gmail.com
Subject: [PATCH] Don't search files with an unset "grep" attribute
Date: Mon, 23 Jan 2012 01:37:36 -0800
Message-ID: <4f1d2a8b.a2d8320a.50ec.576d@mx.google.com>
References: <CACsJy8C0aXgecCWHrCK3yzNLWnWX4g81x-OzZCY0xtonbspzXw@mail.gmail.com>
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Conrad Irwin <conrad.irwin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 10:38:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpGM8-0003a0-1a
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 10:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab2AWJiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 04:38:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42266 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab2AWJiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 04:38:22 -0500
Received: by iacb35 with SMTP id b35so3487351iac.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 01:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=k1yyJVz66/4cISCYQOKv91002EVhu3xPt1Ywo+oZE/o=;
        b=c5SHmCwHfmiGv66o5GB9wSLictQjPlrfMWw2irG8JW26dqpRJ62ILRQo7Z1NUkoRBC
         JE+Gcw6L2Q06SvJN4PWKq2/Vho9sYbk6ki6k+PcjDCKqej0OazZ7XqHzOIEROAPAzvlI
         Senk3Ethw9nS2rTPBEWBfQ89d3h9K3OkRZlxk=
Received: by 10.42.151.196 with SMTP id f4mr8483774icw.29.1327311501738;
        Mon, 23 Jan 2012 01:38:21 -0800 (PST)
Received: from monteverdi.hsd1.ca.comcast.net. (c-69-181-44-79.hsd1.ca.comcast.net. [69.181.44.79])
        by mx.google.com with ESMTPS id or2sm15981343igc.5.2012.01.23.01.38.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jan 2012 01:38:19 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.1.g1fdd3
In-Reply-To: <CACsJy8C0aXgecCWHrCK3yzNLWnWX4g81x-OzZCY0xtonbspzXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188981>

From: Conrad Irwin <conrad.irwin@gmail.com>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:
> Definitely. But because I'm stuck at adding "seen" feature from
> match_pathspec_depth to tree_entry_interesting, that probably won't happen
> this year. Adding "--exclude=<pattern>" to git-grep is a more plausible
> option.

I think the .gitattributes mechanism is a better place to configure this, as the
files I with to exclude from grep are always the same files (test fixtures
mainly, minified library code also). I often want to make git-diff be quieter
about them too, so I'll be setting the -diff attribute already.

I've attached a patch, which adds the "grep" attribute, which can (for now) only
be unset. This has the same effect for me as my original patch [1], but should
also improve life for people with large blobs as described above.

In future we could extend the attribute to give a meaning to set values, but I'm
not yet sure what that would look like. We could also add an --exclude=<foo>
flag to grep for people who want to configure grep on a per-run basis, but I
think that is a much less common desire.

The failing test attached to this patch is a symptom of a larger issue with the
way that git-grep handles objects that are not at the root of the repository. A
more obvious symptom can be revealed by comparing the output of:

  git grep int HEAD:./builtin

  cd builtin; git grep int HEAD:./

The problem is that grep doesn't correctly separate the path from the revision
part of the spec. It's currently unobvious to me how to fix this but I hope
someone more familiar with the code (Nguyen or Junio) might be able to see a
way.

Yours,
Conrad

[1] http://thread.gmane.org/gmane.comp.version-control.git/179299

---8<---


To set -grep on an file in .gitattributes will cause that file to be
skipped completely while grepping. This can be used to reduce the number
of false positives when your repository contains files that are
uninteresting to you, for example test fixtures, dlls or minified source
code.

The other approach considered was to allow an --exclude flag to grep at runtime,
however that better serves the less common use-case of wanting to customise the
list of files per-invocation rather than statically.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-grep.txt      |    7 +++++++
 Documentation/gitattributes.txt |    9 +++++++++
 builtin/grep.c                  |    8 ++++++++
 grep.c                          |   21 +++++++++++++++++++++
 grep.h                          |    1 +
 t/t7810-grep.sh                 |   30 ++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6a8b1e3..7c74165 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -242,6 +242,13 @@ OPTIONS
 	If given, limit the search to paths matching at least one pattern.
 	Both leading paths match and glob(7) patterns are supported.
 
+ATTRIBUTES
+----------
+
+grep::
+	If the grep attribute is unset on a file using the linkgit:gitattributes[1]
+	mechanism, then that file will not be searched.
+
 Examples
 --------
 
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a85b187..3ffcec7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -869,6 +869,15 @@ If this attribute is not set or has an invalid value, the value of the
 `gui.encoding` configuration variable is used instead
 (See linkgit:git-config[1]).
 
+Configuring files to search
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`grep`
+^^^^^^
+
+If the attribute `grep` is unset for a file then linkgit:git-grep[1]
+will ignore that file while searching for matches.
+
 
 USING MACRO ATTRIBUTES
 ----------------------
diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..9f8dfc0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -398,6 +398,10 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	struct strbuf pathbuf = STRBUF_INIT;
 	char *name;
 
+	if (!should_grep_path(opt, filename + tree_name_len)) {
+		return 0;
+	}
+
 	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
 				    opt->prefix);
@@ -464,6 +468,10 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	struct strbuf buf = STRBUF_INIT;
 	char *name;
 
+	if (!should_grep_path(opt, filename)) {
+		return 0;
+	}
+
 	if (opt->relative && opt->prefix_length)
 		quote_path_relative(filename, -1, &buf, opt->prefix);
 	else
diff --git a/grep.c b/grep.c
index 486230b..e948576 100644
--- a/grep.c
+++ b/grep.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "grep.h"
+#include "attr.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
 
@@ -829,6 +830,26 @@ static inline void grep_attr_unlock(struct grep_opt *opt)
 #define grep_attr_unlock(opt)
 #endif
 
+static struct git_attr_check attr_check[1];
+static void setup_attr_check(void)
+{
+	if (attr_check[0].attr)
+		return; /* already done */
+	attr_check[0].attr = git_attr("grep");
+}
+int should_grep_path(struct grep_opt *opt, const char *name) {
+	int ret = 1;
+
+	grep_attr_lock(opt);
+	setup_attr_check();
+	git_check_attr(name, 1, attr_check);
+	if (ATTR_FALSE(attr_check[0].value))
+		ret = 0;
+	grep_attr_unlock(opt);
+
+	return ret;
+}
+
 static int match_funcname(struct grep_opt *opt, const char *name, char *bol, char *eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
diff --git a/grep.h b/grep.h
index fb205f3..266002d 100644
--- a/grep.h
+++ b/grep.h
@@ -129,6 +129,7 @@ extern void append_header_grep_pattern(struct grep_opt *, enum grep_header_field
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
+extern int should_grep_path(struct grep_opt *opt, const char *name);
 
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7ba5b16..c991518 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -871,4 +871,34 @@ test_expect_success 'mimic ack-grep --group' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with -grep attribute' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf &&
+	rm .gitattributes
+'
+
+test_expect_success 'with -grep attribute on specific file' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf hello.c &&
+	rm .gitattributes
+'
+
+test_expect_success 'with -grep attribute on specific revision' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf HEAD &&
+	rm .gitattributes
+'
+
+test_expect_success 'with -grep attribute on specific file/revision' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf HEAD hello.c &&
+	rm .gitattributes
+'
+
+test_expect_failure 'with -grep attribute on specific tree' '
+	echo "hello.c -grep" >.gitattributes &&
+	test_must_fail git grep printf HEAD:hello.c &&
+	rm .gitattributes
+'
+
 test_done
-- 
1.7.9.rc2.1.g1fdd3
