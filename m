From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] grep: move configuration support to top-level grep.[ch]
Date: Wed,  3 Oct 2012 18:33:34 -0700
Message-ID: <1349314419-8397-2-git-send-email-gitster@pobox.com>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:07:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtN0-0001DP-26
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab2JDBdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 21:33:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab2JDBdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 21:33:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60146805D
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HlUp
	EYJTI8+AeW3BnRT0ylr2Exw=; b=tZN3cDLsW+f5simDrieovIdBtPQlvlzuDf46
	lS7r4t0NcfcEMp+WEuX2DN9GyN8Zddixex6KcWYP+jXy4i97pO64Ohh55VpU9Lis
	ksb7y/nu3syQHAIGINpcuhdkgvylgwy22kBlsxX5Z4Tx2S36f09CM85z9c3p+xpg
	V3PtDRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=o0IzMJ
	gycUcYtlZClPG3Gk/CrCNIAWNGU4eI/pE8rCnKaaHUbv9iWaCQvnnXSvz0ztufy7
	g046K10P/r0nhNXcKHmX7QKthcyOXQA6WuKN4BQX1nRlKlan0d7E9jkTwL9c44vc
	+I8r0IqyoFzc1kYJvwK+GpiFZRvcjMJQ+Qy+M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E818805C
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C69D805B for
 <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:42 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc0.57.g712528f
In-Reply-To: <1349314419-8397-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 87FCE2F2-0DC3-11E2-BD03-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206967>

As "git grep" will not stay to be the only command that will know
about the grep machinery, move these to a more appropriate place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 67 ----------------------------------------------------------
 grep.c         | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 grep.h         |  2 ++
 3 files changed, 69 insertions(+), 67 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 82530a6..ce379d5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -261,21 +261,6 @@ static int wait_all(void)
 }
 #endif
 
-static int parse_pattern_type_arg(const char *opt, const char *arg)
-{
-	if (!strcmp(arg, "default"))
-		return GREP_PATTERN_TYPE_UNSPECIFIED;
-	else if (!strcmp(arg, "basic"))
-		return GREP_PATTERN_TYPE_BRE;
-	else if (!strcmp(arg, "extended"))
-		return GREP_PATTERN_TYPE_ERE;
-	else if (!strcmp(arg, "fixed"))
-		return GREP_PATTERN_TYPE_FIXED;
-	else if (!strcmp(arg, "perl"))
-		return GREP_PATTERN_TYPE_PCRE;
-	die("bad %s argument: %s", opt, arg);
-}
-
 static void grep_pattern_type_options(const int pattern_type, struct grep_opt *opt)
 {
 	switch (pattern_type) {
@@ -308,58 +293,6 @@ static void grep_pattern_type_options(const int pattern_type, struct grep_opt *o
 	}
 }
 
-static int grep_config(const char *var, const char *value, void *cb)
-{
-	struct grep_opt *opt = cb;
-	char *color = NULL;
-
-	if (userdiff_config(var, value) < 0)
-		return -1;
-
-	if (!strcmp(var, "grep.extendedregexp")) {
-		if (git_config_bool(var, value))
-			opt->extended_regexp_option = 1;
-		else
-			opt->extended_regexp_option = 0;
-		return 0;
-	}
-
-	if (!strcmp(var, "grep.patterntype")) {
-		opt->pattern_type_option = parse_pattern_type_arg(var, value);
-		return 0;
-  }
-
-	if (!strcmp(var, "grep.linenumber")) {
-		opt->linenum = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "color.grep"))
-		opt->color = git_config_colorbool(var, value);
-	else if (!strcmp(var, "color.grep.context"))
-		color = opt->color_context;
-	else if (!strcmp(var, "color.grep.filename"))
-		color = opt->color_filename;
-	else if (!strcmp(var, "color.grep.function"))
-		color = opt->color_function;
-	else if (!strcmp(var, "color.grep.linenumber"))
-		color = opt->color_lineno;
-	else if (!strcmp(var, "color.grep.match"))
-		color = opt->color_match;
-	else if (!strcmp(var, "color.grep.selected"))
-		color = opt->color_selected;
-	else if (!strcmp(var, "color.grep.separator"))
-		color = opt->color_sep;
-	else
-		return git_color_default_config(var, value, cb);
-	if (color) {
-		if (!value)
-			return config_error_nonbool(var);
-		color_parse(value, var, color);
-	}
-	return 0;
-}
-
 static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
 	void *data;
diff --git a/grep.c b/grep.c
index edc7776..551a2ed 100644
--- a/grep.c
+++ b/grep.c
@@ -1518,3 +1518,70 @@ static int grep_source_is_binary(struct grep_source *gs)
 
 	return 0;
 }
+
+static int parse_pattern_type_arg(const char *opt, const char *arg)
+{
+	if (!strcmp(arg, "default"))
+		return GREP_PATTERN_TYPE_UNSPECIFIED;
+	else if (!strcmp(arg, "basic"))
+		return GREP_PATTERN_TYPE_BRE;
+	else if (!strcmp(arg, "extended"))
+		return GREP_PATTERN_TYPE_ERE;
+	else if (!strcmp(arg, "fixed"))
+		return GREP_PATTERN_TYPE_FIXED;
+	else if (!strcmp(arg, "perl"))
+		return GREP_PATTERN_TYPE_PCRE;
+	die("bad %s argument: %s", opt, arg);
+}
+
+int grep_config(const char *var, const char *value, void *cb)
+{
+	struct grep_opt *opt = cb;
+	char *color = NULL;
+
+	if (userdiff_config(var, value) < 0)
+		return -1;
+
+	if (!strcmp(var, "grep.extendedregexp")) {
+		if (git_config_bool(var, value))
+			opt->extended_regexp_option = 1;
+		else
+			opt->extended_regexp_option = 0;
+		return 0;
+	}
+
+	if (!strcmp(var, "grep.patterntype")) {
+		opt->pattern_type_option = parse_pattern_type_arg(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "grep.linenumber")) {
+		opt->linenum = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "color.grep"))
+		opt->color = git_config_colorbool(var, value);
+	else if (!strcmp(var, "color.grep.context"))
+		color = opt->color_context;
+	else if (!strcmp(var, "color.grep.filename"))
+		color = opt->color_filename;
+	else if (!strcmp(var, "color.grep.function"))
+		color = opt->color_function;
+	else if (!strcmp(var, "color.grep.linenumber"))
+		color = opt->color_lineno;
+	else if (!strcmp(var, "color.grep.match"))
+		color = opt->color_match;
+	else if (!strcmp(var, "color.grep.selected"))
+		color = opt->color_selected;
+	else if (!strcmp(var, "color.grep.separator"))
+		color = opt->color_sep;
+	else
+		return git_color_default_config(var, value, cb);
+	if (color) {
+		if (!value)
+			return config_error_nonbool(var);
+		color_parse(value, var, color);
+	}
+	return 0;
+}
diff --git a/grep.h b/grep.h
index c256ac6..5381adc 100644
--- a/grep.h
+++ b/grep.h
@@ -145,6 +145,8 @@ extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size);
 
+int grep_config(const char *var, const char *value, void *cb);
+
 struct grep_source {
 	char *name;
 
-- 
1.8.0.rc0.57.g712528f
