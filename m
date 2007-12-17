From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/7] parse-options: Let the integer/string cases be callbacks as well.
Date: Mon, 17 Dec 2007 19:23:13 +0100
Message-ID: <1197915797-30679-4-git-send-email-madcoder@debian.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org>
 <1197915797-30679-2-git-send-email-madcoder@debian.org>
 <1197915797-30679-3-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KdR-0003yo-LW
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbXLQSX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756652AbXLQSXZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:23:25 -0500
Received: from pan.madism.org ([88.191.52.104]:54938 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756310AbXLQSXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:23:19 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6F83730958;
	Mon, 17 Dec 2007 19:23:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 27C7C4BF558; Mon, 17 Dec 2007 19:23:17 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1148.ga3ab1-dirty
In-Reply-To: <1197915797-30679-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68596>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |  115 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d716ccc..f3f0f2a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -7,15 +7,14 @@ struct optparse_t {
 	const char *opt;
 };
 
-static inline const char *get_arg(struct optparse_t *p)
+static inline void use_arg(struct optparse_t *p)
 {
 	if (p->opt) {
-		const char *res = p->opt;
 		p->opt = NULL;
-		return res;
+	} else {
+		p->argc--;
+		++p->argv;
 	}
-	p->argc--;
-	return *++p->argv;
 }
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
@@ -33,15 +32,62 @@ static int opterror(const struct option *opt, const char *reason, int flags)
 	return error("option `%s' %s", opt->long_name, reason);
 }
 
+static int parse_opt_string(const struct option *opt,
+                            const char *arg, int flags)
+{
+	*(const char **)opt->value = flags & PARSE_OPT_UNSET ? NULL : arg;
+	return 0;
+}
+
+static int parse_opt_integer(const struct option *opt,
+                             const char *arg, int flags)
+{
+	int v = flags & PARSE_OPT_UNSET ? 0 : opt->defval;
+	if (arg) {
+		v = strtol(arg, (char **)&arg, 10);
+		if (*arg) {
+			if (flags & PARSE_OPT_MAY_IGN) {
+				*(int *)opt->value = opt->defval;
+				return PARSE_OPT_IGNORE;
+			}
+			return opterror(opt, "expects a numerical value", 0);
+		}
+	}
+	*(int *)opt->value = v;
+	return 0;
+}
+
+static int run_callback(struct optparse_t *p, parse_opt_cb *cb,
+						const struct option *opt, int flags)
+{
+	const char *arg = p->opt ? p->opt : (p->argc > 1 ? p->argv[1] : NULL);
+	int may_ign = 0;
+
+	if (!p->opt && (opt->flags & PARSE_OPT_OPTARG))
+		may_ign = PARSE_OPT_MAY_IGN;
+	if ((flags & PARSE_OPT_UNSET) || (opt->flags & PARSE_OPT_NOARG))
+		return (*cb)(opt, NULL, flags);
+	if (!may_ign && !arg)
+		return opterror(opt, "requires a value", flags);
+	if (may_ign && arg && arg[0] == '-' && arg[1])
+		return (*cb)(opt, NULL, flags);
+	switch ((*cb)(opt, arg, flags | may_ign)) {
+	case PARSE_OPT_OK:
+		use_arg(p);
+		return PARSE_OPT_OK;
+	case PARSE_OPT_IGNORE:
+		if (!may_ign)
+			die("should not happen: MAY_IGN unset, but arg was IGNOREd");
+		return PARSE_OPT_IGNORE;
+	default:
+		return PARSE_OPT_ERR;
+	}
+}
+
 static int get_value(struct optparse_t *p,
                      const struct option *opt, int flags)
 {
-	const char *s, *arg;
 	const int unset = flags & PARSE_OPT_UNSET;
-	int may_ign = 0, res;
-
-	if (!unset && !p->opt && (opt->flags & PARSE_OPT_OPTARG))
-		may_ign = PARSE_OPT_MAY_IGN;
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
 	if (unset && (opt->flags & PARSE_OPT_NONEG))
@@ -63,7 +109,6 @@ static int get_value(struct optparse_t *p,
 		}
 	}
 
-	arg = p->opt ? p->opt : (p->argc > 1 ? p->argv[1] : NULL);
 	switch (opt->type) {
 	case OPTION_BIT:
 		if (unset)
@@ -71,63 +116,21 @@ static int get_value(struct optparse_t *p,
 		else
 			*(int *)opt->value |= opt->defval;
 		return 0;
-
 	case OPTION_BOOLEAN:
 		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
 		return 0;
-
 	case OPTION_SET_INT:
 		*(int *)opt->value = unset ? 0 : opt->defval;
 		return 0;
-
 	case OPTION_SET_PTR:
 		*(void **)opt->value = unset ? NULL : (void *)opt->defval;
 		return 0;
-
 	case OPTION_STRING:
-		if (unset) {
-			*(const char **)opt->value = NULL;
-			return 0;
-		}
-		if (may_ign && (!arg || *arg == '-')) {
-			*(const char **)opt->value = (const char *)opt->defval;
-			return 0;
-		}
-		if (!arg)
-			return opterror(opt, "requires a value", flags);
-		*(const char **)opt->value = get_arg(p);
-		return 0;
-
+		return run_callback(p, &parse_opt_string, opt, flags);
 	case OPTION_CALLBACK:
-		if (unset || (opt->flags & PARSE_OPT_NOARG))
-			return (*opt->callback)(opt, NULL, flags);
-		if (!may_ign && !arg)
-			return opterror(opt, "requires a value", flags);
-		if (may_ign && arg && arg[0] == '-' && arg[1])
-			return (*opt->callback)(opt, NULL, flags);
-		res = (*opt->callback)(opt, arg, flags);
-		if (!may_ign && res == PARSE_OPT_IGNORE)
-			die("should not happen: MAY_IGN unset, but arg was IGNOREd");
-		if (res == PARSE_OPT_IGNORE)
-			get_arg(p);
-		return res;
-
+		return run_callback(p, opt->callback, opt, flags);
 	case OPTION_INTEGER:
-		if (unset) {
-			*(int *)opt->value = 0;
-			return 0;
-		}
-		if (may_ign && (!arg || !isdigit(*arg))) {
-			*(int *)opt->value = opt->defval;
-			return 0;
-		}
-		if (!arg)
-			return opterror(opt, "requires a value", flags);
-		*(int *)opt->value = strtol(get_arg(p), (char **)&s, 10);
-		if (*s)
-			return opterror(opt, "expects a numerical value", flags);
-		return 0;
-
+		return run_callback(p, &parse_opt_integer, opt, flags);
 	default:
 		die("should not happen, someone must be hit on the forehead");
 	}
-- 
1.5.4.rc0.1148.ga3ab1-dirty
