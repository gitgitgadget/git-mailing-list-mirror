From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/7] parse-options: allow callbacks to ignore arguments they don't need to use.
Date: Mon, 17 Dec 2007 19:23:12 +0100
Message-ID: <1197915797-30679-3-git-send-email-madcoder@debian.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org>
 <1197915797-30679-2-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KdQ-0003yo-Au
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608AbXLQSXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756642AbXLQSXV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:23:21 -0500
Received: from pan.madism.org ([88.191.52.104]:54933 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756078AbXLQSXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:23:19 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 693CE30957;
	Mon, 17 Dec 2007 19:23:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 20E6C2AD7F0; Mon, 17 Dec 2007 19:23:17 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1148.ga3ab1-dirty
In-Reply-To: <1197915797-30679-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68591>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   22 +++++++++++++++-------
 parse-options.h |    7 +++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8f70e5d..d716ccc 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -38,7 +38,10 @@ static int get_value(struct optparse_t *p,
 {
 	const char *s, *arg;
 	const int unset = flags & PARSE_OPT_UNSET;
+	int may_ign = 0, res;
 
+	if (!unset && !p->opt && (opt->flags & PARSE_OPT_OPTARG))
+		may_ign = PARSE_OPT_MAY_IGN;
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
 	if (unset && (opt->flags & PARSE_OPT_NONEG))
@@ -86,7 +89,7 @@ static int get_value(struct optparse_t *p,
 			*(const char **)opt->value = NULL;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg == '-')) {
+		if (may_ign && (!arg || *arg == '-')) {
 			*(const char **)opt->value = (const char *)opt->defval;
 			return 0;
 		}
@@ -98,18 +101,23 @@ static int get_value(struct optparse_t *p,
 	case OPTION_CALLBACK:
 		if (unset || (opt->flags & PARSE_OPT_NOARG))
 			return (*opt->callback)(opt, NULL, flags);
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || *arg == '-'))
-			return (*opt->callback)(opt, NULL, flags);
-		if (!arg)
+		if (!may_ign && !arg)
 			return opterror(opt, "requires a value", flags);
-		return (*opt->callback)(opt, get_arg(p), flags);
+		if (may_ign && arg && arg[0] == '-' && arg[1])
+			return (*opt->callback)(opt, NULL, flags);
+		res = (*opt->callback)(opt, arg, flags);
+		if (!may_ign && res == PARSE_OPT_IGNORE)
+			die("should not happen: MAY_IGN unset, but arg was IGNOREd");
+		if (res == PARSE_OPT_IGNORE)
+			get_arg(p);
+		return res;
 
 	case OPTION_INTEGER:
 		if (unset) {
 			*(int *)opt->value = 0;
 			return 0;
 		}
-		if (opt->flags & PARSE_OPT_OPTARG && (!arg || !isdigit(*arg))) {
+		if (may_ign && (!arg || !isdigit(*arg))) {
 			*(int *)opt->value = opt->defval;
 			return 0;
 		}
@@ -251,7 +259,7 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			usage_with_options_internal(usagestr, options, 1);
 		if (!strcmp(arg + 2, "help"))
 			usage_with_options(usagestr, options);
-		if (parse_long_opt(&args, arg + 2, options))
+		if (parse_long_opt(&args, arg + 2, options) < 0)
 			usage_with_options(usagestr, options);
 	}
 
diff --git a/parse-options.h b/parse-options.h
index ae6b3ca..eeb40a4 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -27,9 +27,16 @@ enum parse_opt_option_flags {
 	PARSE_OPT_HIDDEN  = 8,
 };
 
+enum parse_opt_cbres {
+	PARSE_OPT_ERR     = -1,
+	PARSE_OPT_OK      =  0,
+	PARSE_OPT_IGNORE  =  1,
+};
+
 enum parse_opt_cbflags {
 	PARSE_OPT_SHORT   = 1,
 	PARSE_OPT_UNSET   = 2,
+	PARSE_OPT_MAY_IGN = 4,
 };
 
 struct option;
-- 
1.5.4.rc0.1148.ga3ab1-dirty
