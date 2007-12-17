From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/7] parse-options: Make callbacks take flags instead of boolean `unset`
Date: Mon, 17 Dec 2007 19:23:11 +0100
Message-ID: <1197915797-30679-2-git-send-email-madcoder@debian.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KdS-0003yo-Aw
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763AbXLQSX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756438AbXLQSX0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:23:26 -0500
Received: from pan.madism.org ([88.191.52.104]:54936 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756230AbXLQSXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:23:19 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5D37930956;
	Mon, 17 Dec 2007 19:23:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 1E23156A6; Mon, 17 Dec 2007 19:23:17 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1148.ga3ab1-dirty
In-Reply-To: <1197915797-30679-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68597>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-branch.c       |    2 +-
 builtin-commit.c       |    4 ++--
 builtin-fast-export.c  |    4 ++--
 builtin-for-each-ref.c |    2 +-
 builtin-tag.c          |    2 +-
 parse-options.c        |   37 ++++++++++++++++---------------------
 parse-options.h        |    7 ++++++-
 7 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 089cae5..677eee5 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -531,7 +531,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		die("Branch is renamed, but update of config-file failed");
 }
 
-static int opt_parse_with_commit(const struct option *opt, const char *arg, int unset)
+static int opt_parse_with_commit(const struct option *opt, const char *arg, int flags)
 {
 	unsigned char sha1[20];
 	struct commit *commit;
diff --git a/builtin-commit.c b/builtin-commit.c
index 0a91013..ca18a5c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -52,10 +52,10 @@ static int no_edit, initial_commit, in_merge;
 const char *only_include_assumed;
 struct strbuf message;
 
-static int opt_parse_m(const struct option *opt, const char *arg, int unset)
+static int opt_parse_m(const struct option *opt, const char *arg, int flags)
 {
 	struct strbuf *buf = opt->value;
-	if (unset)
+	if (flags & PARSE_OPT_UNSET)
 		strbuf_setlen(buf, 0);
 	else {
 		strbuf_addstr(buf, arg);
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index ef27eee..9f914b9 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -26,9 +26,9 @@ static int progress;
 static enum { VERBATIM, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
-				     const char *arg, int unset)
+				     const char *arg, int flags)
 {
-	if (unset || !strcmp(arg, "abort"))
+	if (flags & PARSE_OPT_UNSET || !strcmp(arg, "abort"))
 		signed_tag_mode = ABORT;
 	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
 		signed_tag_mode = VERBATIM;
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index f36a43c..3eecfe9 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -802,7 +802,7 @@ static struct ref_sort *default_sort(void)
 	return sort;
 }
 
-int opt_parse_sort(const struct option *opt, const char *arg, int unset)
+int opt_parse_sort(const struct option *opt, const char *arg, int flags)
 {
 	struct ref_sort **sort_tail = opt->value;
 	struct ref_sort *s;
diff --git a/builtin-tag.c b/builtin-tag.c
index 274901a..fd44b2e 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -348,7 +348,7 @@ struct msg_arg {
 	struct strbuf buf;
 };
 
-static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
+static int parse_msg_arg(const struct option *opt, const char *arg, int flags)
 {
 	struct msg_arg *msg = opt->value;
 
diff --git a/parse-options.c b/parse-options.c
index e12b428..8f70e5d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,9 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 
-#define OPT_SHORT 1
-#define OPT_UNSET 2
-
 struct optparse_t {
 	const char **argv;
 	int argc;
@@ -29,9 +26,9 @@ static inline const char *skip_prefix(const char *str, const char *prefix)
 
 static int opterror(const struct option *opt, const char *reason, int flags)
 {
-	if (flags & OPT_SHORT)
+	if (flags & PARSE_OPT_SHORT)
 		return error("switch `%c' %s", opt->short_name, reason);
-	if (flags & OPT_UNSET)
+	if (flags & PARSE_OPT_UNSET)
 		return error("option `no-%s' %s", opt->long_name, reason);
 	return error("option `%s' %s", opt->long_name, reason);
 }
@@ -40,14 +37,14 @@ static int get_value(struct optparse_t *p,
                      const struct option *opt, int flags)
 {
 	const char *s, *arg;
-	const int unset = flags & OPT_UNSET;
+	const int unset = flags & PARSE_OPT_UNSET;
 
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
 	if (unset && (opt->flags & PARSE_OPT_NONEG))
 		return opterror(opt, "isn't available", flags);
 
-	if (!(flags & OPT_SHORT) && p->opt) {
+	if (!(flags & PARSE_OPT_SHORT) && p->opt) {
 		switch (opt->type) {
 		case OPTION_CALLBACK:
 			if (!(opt->flags & PARSE_OPT_NOARG))
@@ -99,15 +96,13 @@ static int get_value(struct optparse_t *p,
 		return 0;
 
 	case OPTION_CALLBACK:
-		if (unset)
-			return (*opt->callback)(opt, NULL, 1);
-		if (opt->flags & PARSE_OPT_NOARG)
-			return (*opt->callback)(opt, NULL, 0);
+		if (unset || (opt->flags & PARSE_OPT_NOARG))
+			return (*opt->callback)(opt, NULL, flags);
 		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg == '-'))
-			return (*opt->callback)(opt, NULL, 0);
+			return (*opt->callback)(opt, NULL, flags);
 		if (!arg)
 			return opterror(opt, "requires a value", flags);
-		return (*opt->callback)(opt, get_arg(p), 0);
+		return (*opt->callback)(opt, get_arg(p), flags);
 
 	case OPTION_INTEGER:
 		if (unset) {
@@ -135,7 +130,7 @@ static int parse_short_opt(struct optparse_t *p, const struct option *options)
 	for (; options->type != OPTION_END; options++) {
 		if (options->short_name == *p->opt) {
 			p->opt = p->opt[1] ? p->opt + 1 : NULL;
-			return get_value(p, options, OPT_SHORT);
+			return get_value(p, options, PARSE_OPT_SHORT);
 		}
 	}
 	return error("unknown switch `%c'", *p->opt);
@@ -173,7 +168,7 @@ is_abbreviated:
 					ambiguous_option = abbrev_option;
 					ambiguous_flags = abbrev_flags;
 				}
-				if (!(flags & OPT_UNSET) && *arg_end)
+				if (!(flags & PARSE_OPT_UNSET) && *arg_end)
 					p->opt = arg_end + 1;
 				abbrev_option = options;
 				abbrev_flags = flags;
@@ -181,13 +176,13 @@ is_abbreviated:
 			}
 			/* negated and abbreviated very much? */
 			if (!prefixcmp("no-", arg)) {
-				flags |= OPT_UNSET;
+				flags |= PARSE_OPT_UNSET;
 				goto is_abbreviated;
 			}
 			/* negated? */
 			if (strncmp(arg, "no-", 3))
 				continue;
-			flags |= OPT_UNSET;
+			flags |= PARSE_OPT_UNSET;
 			rest = skip_prefix(arg + 3, options->long_name);
 			/* abbreviated and negated? */
 			if (!rest && !prefixcmp(options->long_name, arg + 3))
@@ -207,9 +202,9 @@ is_abbreviated:
 		return error("Ambiguous option: %s "
 			"(could be --%s%s or --%s%s)",
 			arg,
-			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
+			(ambiguous_flags & PARSE_OPT_UNSET) ?  "no-" : "",
 			ambiguous_option->long_name,
-			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
+			(abbrev_flags & PARSE_OPT_UNSET) ?  "no-" : "",
 			abbrev_option->long_name);
 	if (abbrev_option)
 		return get_value(p, abbrev_option, abbrev_flags);
@@ -351,12 +346,12 @@ void usage_with_options(const char * const *usagestr,
 /*----- some often used options -----*/
 #include "cache.h"
 
-int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
+int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int flags)
 {
 	int v;
 
 	if (!arg) {
-		v = unset ? 0 : DEFAULT_ABBREV;
+		v = flags & PARSE_OPT_UNSET ? 0 : DEFAULT_ABBREV;
 	} else {
 		v = strtol(arg, (char **)&arg, 10);
 		if (*arg)
diff --git a/parse-options.h b/parse-options.h
index 102ac31..ae6b3ca 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -27,8 +27,13 @@ enum parse_opt_option_flags {
 	PARSE_OPT_HIDDEN  = 8,
 };
 
+enum parse_opt_cbflags {
+	PARSE_OPT_SHORT   = 1,
+	PARSE_OPT_UNSET   = 2,
+};
+
 struct option;
-typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
+typedef int parse_opt_cb(const struct option *, const char *arg, int flags);
 
 /*
  * `type`::
-- 
1.5.4.rc0.1148.ga3ab1-dirty
