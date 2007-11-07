From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH PARSEOPT 1/4] parse-options new features.
Date: Wed,  7 Nov 2007 11:20:27 +0100
Message-ID: <1194430832-6224-3-git-send-email-madcoder@debian.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
 <1194430832-6224-2-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 11:20:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi1m-00018B-BF
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbXKGKUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbXKGKUi
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:20:38 -0500
Received: from pan.madism.org ([88.191.52.104]:35296 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbXKGKUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:20:35 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0FD1828E23;
	Wed,  7 Nov 2007 11:20:33 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 136E41CA9B; Wed,  7 Nov 2007 11:20:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1598.gdef4e
In-Reply-To: <1194430832-6224-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63794>

options flags:
~~~~~~~~~~~~~
  PARSE_OPT_NONEG allow the caller to disallow the negated option to exists.

option types:
~~~~~~~~~~~~
  OPTION_BIT: ORs (or NANDs) a mask.
  OPTION_SET_INT: force the value to be set to this integer.
  OPTION_SET_PTR: force the value to be set to this pointer.

helper:
~~~~~~
  HAS_MULTI_BITS (in git-compat-util.h) is a bit-hack to check if an
  unsigned integer has more than one bit set, useful to check if conflicting
  options have been used.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-compat-util.h |    1 +
 parse-options.c   |   61 ++++++++++++++++++++++++++++++++++++++--------------
 parse-options.h   |   15 ++++++++++++-
 3 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7b29d1b..f86b19f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -20,6 +20,7 @@
 #endif
 
 #define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (sizeof(x) * 8 - (bits))))
+#define HAS_MULTI_BITS(i)  ((i) & ((i) - 1))  /* checks if an integer has more than 1 bit set */
 
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
diff --git a/parse-options.c b/parse-options.c
index 15b32f7..d3e608a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -40,24 +40,53 @@ static int get_value(struct optparse_t *p,
                      const struct option *opt, int flags)
 {
 	const char *s, *arg;
-	arg = p->opt ? p->opt : (p->argc > 1 ? p->argv[1] : NULL);
+	const int unset = flags & OPT_UNSET;
 
-	if (p->opt && (flags & OPT_UNSET))
+	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
+	if (unset && (opt->flags & PARSE_OPT_NONEG))
+		return opterror(opt, "isn't available", flags);
 
-	switch (opt->type) {
-	case OPTION_BOOLEAN:
-		if (!(flags & OPT_SHORT) && p->opt)
+	if (!(flags & OPT_SHORT) && p->opt) {
+		switch (opt->type) {
+		case OPTION_CALLBACK:
+			if (!(opt->flags & PARSE_OPT_NOARG))
+				break;
+			/* FALLTHROUGH */
+		case OPTION_BOOLEAN:
+		case OPTION_BIT:
+		case OPTION_SET_INT:
+		case OPTION_SET_PTR:
 			return opterror(opt, "takes no value", flags);
-		if (flags & OPT_UNSET)
-			*(int *)opt->value = 0;
+		default:
+			break;
+		}
+	}
+
+	arg = p->opt ? p->opt : (p->argc > 1 ? p->argv[1] : NULL);
+	switch (opt->type) {
+	case OPTION_BIT:
+		if (unset)
+			*(int *)opt->value &= ~opt->defval;
 		else
-			(*(int *)opt->value)++;
+			*(int *)opt->value |= opt->defval;
+		return 0;
+
+	case OPTION_BOOLEAN:
+		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
+		return 0;
+
+	case OPTION_SET_INT:
+		*(int *)opt->value = unset ? 0 : opt->defval;
+		return 0;
+
+	case OPTION_SET_PTR:
+		*(void **)opt->value = unset ? NULL : (void *)opt->defval;
 		return 0;
 
 	case OPTION_STRING:
-		if (flags & OPT_UNSET) {
-			*(const char **)opt->value = (const char *)NULL;
+		if (unset) {
+			*(const char **)opt->value = NULL;
 			return 0;
 		}
 		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg == '-')) {
@@ -70,13 +99,10 @@ static int get_value(struct optparse_t *p,
 		return 0;
 
 	case OPTION_CALLBACK:
-		if (flags & OPT_UNSET)
+		if (unset)
 			return (*opt->callback)(opt, NULL, 1);
-		if (opt->flags & PARSE_OPT_NOARG) {
-			if (p->opt && !(flags & OPT_SHORT))
-				return opterror(opt, "takes no value", flags);
+		if (opt->flags & PARSE_OPT_NOARG)
 			return (*opt->callback)(opt, NULL, 0);
-		}
 		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg == '-'))
 			return (*opt->callback)(opt, NULL, 0);
 		if (!arg)
@@ -84,7 +110,7 @@ static int get_value(struct optparse_t *p,
 		return (*opt->callback)(opt, get_arg(p), 0);
 
 	case OPTION_INTEGER:
-		if (flags & OPT_UNSET) {
+		if (unset) {
 			*(int *)opt->value = 0;
 			return 0;
 		}
@@ -292,7 +318,7 @@ void usage_with_options(const char * const *usagestr,
 					pos += fprintf(stderr, " ...");
 			}
 			break;
-		default:
+		default: /* OPTION_{BIT,BOOLEAN,SET_INT,SET_PTR} */
 			break;
 		}
 
@@ -311,6 +337,7 @@ void usage_with_options(const char * const *usagestr,
 
 /*----- some often used options -----*/
 #include "cache.h"
+
 int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 {
 	int v;
diff --git a/parse-options.h b/parse-options.h
index 65bce6e..a8760ac 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -2,9 +2,15 @@
 #define PARSE_OPTIONS_H
 
 enum parse_opt_type {
+	/* special types */
 	OPTION_END,
 	OPTION_GROUP,
-	OPTION_BOOLEAN,
+	/* options with no arguments */
+	OPTION_BIT,
+	OPTION_BOOLEAN, /* _INCR would have been a better name */
+	OPTION_SET_INT,
+	OPTION_SET_PTR,
+	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_CALLBACK,
@@ -17,6 +23,7 @@ enum parse_opt_flags {
 enum parse_opt_option_flags {
 	PARSE_OPT_OPTARG  = 1,
 	PARSE_OPT_NOARG   = 2,
+	PARSE_OPT_NONEG   = 4,
 };
 
 struct option;
@@ -49,12 +56,15 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *   mask of parse_opt_option_flags.
  *   PARSE_OPT_OPTARG: says that the argument is optionnal (not for BOOLEANs)
  *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBACKs
+ *   PARSE_OPT_NONEG: says that this option cannot be negated
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK.
  *
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
+ *   OPTION_{BIT,SET_INT,SET_PTR} store the {mask,integer,pointer} to put in
+ *   the value when met.
  *   CALLBACKS can use it like they want.
  */
 struct option {
@@ -72,7 +82,10 @@ struct option {
 
 #define OPT_END()                   { OPTION_END }
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
+#define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), 0, NULL, (b) }
 #define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v), NULL, (h) }
+#define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, (h), 0, NULL, (i) }
+#define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, (h), 0, NULL, (p) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), NULL, (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
-- 
1.5.3.5.1598.gdef4e
