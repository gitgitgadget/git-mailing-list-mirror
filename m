From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] builtin/grep.c: make configuration callback more
 reusable
Date: Wed, 10 Oct 2012 00:55:08 -0700
Message-ID: <1349855714-17008-2-git-send-email-gitster@pobox.com>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 09:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLr8m-0000U2-1l
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab2JJHz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:55:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab2JJHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:55:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95EAD6F93
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KBFn
	NVbxlnaO73zX85ceNiPlAgY=; b=PFD8X7wRugLGr7+/B0SCk0zLezeMsVNRbboo
	WMcN87Nu1YODYorLtmUayMYEv44Id6pcfd6LQGVH43sxZAcZmmoec5YAu9PWqZcg
	BKXm+lNBlkM1fpbJEH3AkX9Vzki3nzo0F4VlQqktbDFcZ+mIFPtYeuSI+0TC7HiW
	ZnBmpI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UiX4EU
	BkVa+OQo2CLGgK2xs1f6tVXixI8gMf4jkowjTGS/rAnhkpd2EIfxnkfEQGFcHnJP
	zrrgOx+ZV2OXK/1yht8FeM7h6ur5ifdLvE2iTUzfZHR9AClYevrwqHu+wNoSuwzJ
	WFZ86lWSQKESdSMt523XEwim/3FlDx2almkzs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8471B6F91
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 649136F90 for
 <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:20 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc1.76.g5a375e6
In-Reply-To: <1349855714-17008-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D73C8EF8-12AF-11E2-87BE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207373>

The grep_config() function takes one instance of grep_opt as its
callback parameter, and populates it by running git_config().

This has three practical implications:

 - You have to have an instance of grep_opt already when you call
   the configuration, but that is not necessarily always true.  You
   may be trying to initialize the grep_filter member of rev_info,
   but are not ready to call init_revisions() on it yet.

 - It is not easy to enhance grep_config() in such a way to make it
   cascade to other callback functions to grab other variables in
   one call of git_config(); grep_config() can be cascaded into from
   other callbacks, but it has to be at the leaf level of a cascade.

 - If you ever need to use more than one instance of grep_opt, you
   will have to open and read the configuration file(s) every time
   you initialize them.

Rearrange the configuration mechanism and model it after how diff
configuration variables are handled.  An early call to git_config()
reads and remembers the values taken from the configuration in the
default "template", and a separate call to grep_init() uses this
template to instantiate a grep_opt.

The next step will be to move some of this out of this file so that
the other user of the grep machinery (i.e. "log") can use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 104 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 25 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 82530a6..83232c9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -308,9 +308,41 @@ static void grep_pattern_type_options(const int pattern_type, struct grep_opt *o
 	}
 }
 
+static struct grep_opt grep_defaults;
+
+/*
+ * Initialize the grep_defaults template with hardcoded defaults.
+ * We could let the compiler do this, but without C99 initializers
+ * the code gets unwieldy and unreadable, so...
+ */
+static void init_grep_defaults(void)
+{
+	struct grep_opt *opt = &grep_defaults;
+
+	memset(opt, 0, sizeof(*opt));
+	opt->relative = 1;
+	opt->pathname = 1;
+	opt->regflags = REG_NEWLINE;
+	opt->max_depth = -1;
+	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
+	opt->extended_regexp_option = 0;
+	strcpy(opt->color_context, "");
+	strcpy(opt->color_filename, "");
+	strcpy(opt->color_function, "");
+	strcpy(opt->color_lineno, "");
+	strcpy(opt->color_match, GIT_COLOR_BOLD_RED);
+	strcpy(opt->color_selected, "");
+	strcpy(opt->color_sep, GIT_COLOR_CYAN);
+	opt->color = -1;
+}
+
+/*
+ * Read the configuration file once and store it in
+ * the grep_defaults template.
+ */
 static int grep_config(const char *var, const char *value, void *cb)
 {
-	struct grep_opt *opt = cb;
+	struct grep_opt *opt = &grep_defaults;
 	char *color = NULL;
 
 	if (userdiff_config(var, value) < 0)
@@ -327,7 +359,7 @@ static int grep_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "grep.patterntype")) {
 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
 		return 0;
-  }
+	}
 
 	if (!strcmp(var, "grep.linenumber")) {
 		opt->linenum = git_config_bool(var, value);
@@ -350,8 +382,7 @@ static int grep_config(const char *var, const char *value, void *cb)
 		color = opt->color_selected;
 	else if (!strcmp(var, "color.grep.separator"))
 		color = opt->color_sep;
-	else
-		return git_color_default_config(var, value, cb);
+
 	if (color) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -360,6 +391,47 @@ static int grep_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/*
+ * Initialize one instance of grep_opt and copy the
+ * default values from the template we read the configuration
+ * information in an earlier call to git_config(grep_config).
+ */
+static void grep_init(struct grep_opt *opt, const char *prefix)
+{
+	struct grep_opt *def = &grep_defaults;
+
+	memset(opt, 0, sizeof(*opt));
+	opt->prefix = prefix;
+	opt->prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
+	opt->pattern_tail = &opt->pattern_list;
+	opt->header_tail = &opt->header_list;
+
+	opt->color = def->color;
+	opt->extended_regexp_option = def->extended_regexp_option;
+	opt->pattern_type_option = def->pattern_type_option;
+	opt->linenum = def->linenum;
+	opt->max_depth = def->max_depth;
+	opt->pathname = def->pathname;
+	opt->regflags = def->regflags;
+	opt->relative = def->relative;
+
+	strcpy(opt->color_context, def->color_context);
+	strcpy(opt->color_filename, def->color_filename);
+	strcpy(opt->color_function, def->color_function);
+	strcpy(opt->color_lineno, def->color_lineno);
+	strcpy(opt->color_match, def->color_match);
+	strcpy(opt->color_selected, def->color_selected);
+	strcpy(opt->color_sep, def->color_sep);
+}
+
+static int grep_cmd_config(const char *var, const char *value, void *cb)
+{
+	int st = grep_config(var, value, cb);
+	if (git_color_default_config(var, value, cb) < 0)
+		st = -1;
+	return st;
+}
+
 static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
 	void *data;
@@ -839,27 +911,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(grep_usage, options);
 
-	memset(&opt, 0, sizeof(opt));
-	opt.prefix = prefix;
-	opt.prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
-	opt.relative = 1;
-	opt.pathname = 1;
-	opt.pattern_tail = &opt.pattern_list;
-	opt.header_tail = &opt.header_list;
-	opt.regflags = REG_NEWLINE;
-	opt.max_depth = -1;
-	opt.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
-	opt.extended_regexp_option = 0;
-
-	strcpy(opt.color_context, "");
-	strcpy(opt.color_filename, "");
-	strcpy(opt.color_function, "");
-	strcpy(opt.color_lineno, "");
-	strcpy(opt.color_match, GIT_COLOR_BOLD_RED);
-	strcpy(opt.color_selected, "");
-	strcpy(opt.color_sep, GIT_COLOR_CYAN);
-	opt.color = -1;
-	git_config(grep_config, &opt);
+	init_grep_defaults();
+	git_config(grep_cmd_config, NULL);
+	grep_init(&opt, prefix);
 
 	/*
 	 * If there is no -- then the paths must exist in the working
-- 
1.8.0.rc1.76.g5a375e6
