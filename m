From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/2] diff --word-diff: use non-whitespace regex by default
Date: Thu, 12 Jan 2012 01:25:02 +0800
Message-ID: <1326302702-4536-2-git-send-email-rctay89@gmail.com>
References: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 18:40:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl29a-0004QQ-GU
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 18:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757304Ab2AKR1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 12:27:04 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35635 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933703Ab2AKRZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 12:25:15 -0500
Received: by mail-vx0-f174.google.com with SMTP id fk14so674012vcb.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 09:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6lRZKnx/P9pVNq2QL2qhpwUKJajY128qzTW0wOkiOD4=;
        b=PiokdsXdgxsw2s4ttijEYBiaaKOmv0Wg3Q1EucwPAJaaHiRmCzqXYk3ereShmfZqpy
         0eVwLcV2rNvDDDzJWkWniOF3Ae6z/v2sdfR8yynxHolHYpZOUC/aHvolJio1tGdn4rCC
         BAY4fhT+SDXPsayLPHL5LiqgIM6XGkO7IbPco=
Received: by 10.52.16.78 with SMTP id e14mr46704vdd.60.1326302715158;
        Wed, 11 Jan 2012 09:25:15 -0800 (PST)
Received: from localhost (nusnet-253-163.dynip.nus.edu.sg. [137.132.253.163])
        by mx.google.com with ESMTPS id hn6sm824319vdb.14.2012.01.11.09.25.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 09:25:14 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.dirty
In-Reply-To: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188377>

Factor out the comprehensive non-whitespace regex in use by PATTERNS and
IPATTERN and use it as the word-diff regex for the default diff driver.

As the default regex is no longer non-empty, update the word-regex
selection logic (non-default driver from pre-image, then post-image,
then the diff.wordRegex config) accordingly.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 diff.c                |   14 ++++++++------
 t/t4034-diff-words.sh |   31 +++++++++----------------------
 userdiff.c            |    8 +++++---
 3 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/diff.c b/diff.c
index 374ecf3..5f71f9f 100644
--- a/diff.c
+++ b/diff.c
@@ -1987,9 +1987,10 @@ static const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespe
 	return one->driver->funcname.pattern ? &one->driver->funcname : NULL;
 }
 
-static const char *userdiff_word_regex(struct diff_filespec *one)
+static const char *userdiff_word_regex(struct diff_filespec *one, int *is_default)
 {
 	diff_filespec_load_driver(one);
+	*is_default = !strcmp(one->driver->name, "default");
 	return one->driver->word_regex;
 }
 
@@ -2180,17 +2181,18 @@ static void builtin_diff(const char *name_a,
 		else if (!prefixcmp(diffopts, "-u"))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
 		if (o->word_diff) {
-			int i;
+			int i, is_default;
 
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->type = o->word_diff;
 			ecbdata.diff_words->opt = o;
+			is_default = 0;
 			if (!o->word_regex)
-				o->word_regex = userdiff_word_regex(one);
-			if (!o->word_regex)
-				o->word_regex = userdiff_word_regex(two);
-			if (!o->word_regex)
+				o->word_regex = userdiff_word_regex(one, &is_default);
+			if (is_default)
+				o->word_regex = userdiff_word_regex(two, &is_default);
+			if (is_default && diff_word_regex_cfg)
 				o->word_regex = diff_word_regex_cfg;
 			if (o->word_regex) {
 				ecbdata.diff_words->word_regex = (regex_t *)
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 9ae0e1a..e588849 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -84,26 +84,13 @@ test_expect_success setup '
 	git config diff.color.func magenta
 '
 
-test_expect_success 'set up pre and post with runs of whitespace' '
+test_expect_success 'set up pre and post with runs of non-whitespace' '
 	cp pre.simple pre &&
-	cp post.simple post
+	cp post.simple post &&
+	cp expect.non-whitespace-is-word expect
 '
 
-test_expect_success 'word diff with runs of whitespace' '
-	cat >expect <<-\EOF &&
-		<BOLD>diff --git a/pre b/post<RESET>
-		<BOLD>index 330b04f..5ed8eff 100644<RESET>
-		<BOLD>--- a/pre<RESET>
-		<BOLD>+++ b/post<RESET>
-		<CYAN>@@ -1,3 +1,7 @@<RESET>
-		<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
-
-		a = b + c<RESET>
-
-		<GREEN>aa = a<RESET>
-
-		<GREEN>aeff = aeff * ( aaa )<RESET>
-	EOF
+test_expect_success 'word diff defaults to runs of non-whitespace' '
 	word_diff --color-words &&
 	word_diff --word-diff=color &&
 	word_diff --color --word-diff=color
@@ -116,8 +103,8 @@ test_expect_success '--word-diff=porcelain' '
 		--- a/pre
 		+++ b/post
 		@@ -1,3 +1,7 @@
-		-h(4)
-		+h(4),hh[44]
+		 h(4)
+		+,hh[44]
 		~
 		 # significant space
 		~
@@ -140,7 +127,7 @@ test_expect_success '--word-diff=plain' '
 		--- a/pre
 		+++ b/post
 		@@ -1,3 +1,7 @@
-		[-h(4)-]{+h(4),hh[44]+}
+		h(4){+,hh[44]+}
 
 		a = b + c
 
@@ -159,7 +146,7 @@ test_expect_success '--word-diff=plain --color' '
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1,3 +1,7 @@<RESET>
-		<RED>[-h(4)-]<RESET><GREEN>{+h(4),hh[44]+}<RESET>
+		h(4)<GREEN>{+,hh[44]+}<RESET>
 
 		a = b + c<RESET>
 
@@ -177,7 +164,7 @@ test_expect_success 'word diff without context' '
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1 +1 @@<RESET>
-		<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
+		h(4)<GREEN>,hh[44]<RESET>
 		<CYAN>@@ -3,0 +4,4 @@<RESET> <RESET><MAGENTA>a = b + c<RESET>
 
 		<GREEN>aa = a<RESET>
diff --git a/userdiff.c b/userdiff.c
index 76109da..cf38566 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -7,12 +7,14 @@ static struct userdiff_driver *drivers;
 static int ndrivers;
 static int drivers_alloc;
 
+#define NON_WHITESPACE	\
+	"[^[:space:]]|[\xc0-\xff][\x80-\xbf]+"
 #define PATTERNS(name, pattern, word_regex)			\
 	{ name, NULL, -1, { pattern, REG_EXTENDED },		\
-	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
+	  word_regex "|" NON_WHITESPACE }
 #define IPATTERN(name, pattern, word_regex)			\
 	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, \
-	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
+	  word_regex "|" NON_WHITESPACE }
 static struct userdiff_driver builtin_drivers[] = {
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
@@ -140,7 +142,7 @@ PATTERNS("csharp",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
-{ "default", NULL, -1, { NULL, 0 } },
+{ "default", NULL, -1, { NULL, 0 }, NON_WHITESPACE },
 };
 #undef PATTERNS
 #undef IPATTERN
-- 
1.7.7.584.g16d0ea
