From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 03/10] Move builtin-remote's skip_prefix() to git-compat-util.h
Date: Thu,  5 Jun 2008 22:44:29 +0200
Message-ID: <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org>
 <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MLc-0006Hd-TA
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbYFEUoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYFEUoh
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:44:37 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:60244 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbYFEUoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:44:32 -0400
Received: from vmobile.example.net (dsl5401CC68.pool.t-online.hu [84.1.204.104])
	by yugo.frugalware.org (Postfix) with ESMTP id D72371DDC5F
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 22:44:29 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BCDD618E2AB; Thu,  5 Jun 2008 22:44:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83973>

builtin-remote.c and parse-options.c both have a skip_prefix() function,
for the same purpose. Move builtin-remote's one to git-compat-util.h and
let parse-options use it as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-remote.c  |    6 ------
 git-compat-util.h |    6 ++++++
 parse-options.c   |   14 ++++----------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index c49f00f..9c25018 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -29,12 +29,6 @@ static inline int postfixcmp(const char *string, const char *postfix)
 	return strcmp(string + len1 - len2, postfix);
 }
 
-static inline const char *skip_prefix(const char *name, const char *prefix)
-{
-	return !name ? "" :
-		prefixcmp(name, prefix) ?  name : name + strlen(prefix);
-}
-
 static int opt_parse_track(const struct option *opt, const char *arg, int not)
 {
 	struct path_list *list = opt->value;
diff --git a/git-compat-util.h b/git-compat-util.h
index 01c4045..af515d4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -127,6 +127,12 @@ extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
 
+static inline const char *skip_prefix(const char *name, const char *prefix)
+{
+	return !name ? "" :
+		prefixcmp(name, prefix) ?  name : name + strlen(prefix);
+}
+
 #ifdef NO_MMAP
 
 #ifndef PROT_READ
diff --git a/parse-options.c b/parse-options.c
index acf3fe3..aa164d0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -22,12 +22,6 @@ static inline const char *get_arg(struct optparse_t *p)
 	return *++p->argv;
 }
 
-static inline const char *skip_prefix(const char *str, const char *prefix)
-{
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
-}
-
 static int opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
@@ -161,7 +155,7 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 
 		rest = skip_prefix(arg, options->long_name);
 		if (options->type == OPTION_ARGUMENT) {
-			if (!rest)
+			if (!strcmp(rest, arg))
 				continue;
 			if (*rest == '=')
 				return opterror(options, "takes no value", flags);
@@ -170,7 +164,7 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 			p->out[p->cpidx++] = arg - 2;
 			return 0;
 		}
-		if (!rest) {
+		if (!strcmp(rest, arg)) {
 			/* abbreviated? */
 			if (!strncmp(options->long_name, arg, arg_end - arg)) {
 is_abbreviated:
@@ -201,9 +195,9 @@ is_abbreviated:
 			flags |= OPT_UNSET;
 			rest = skip_prefix(arg + 3, options->long_name);
 			/* abbreviated and negated? */
-			if (!rest && !prefixcmp(options->long_name, arg + 3))
+			if (!strcmp(rest, arg + 3) && !prefixcmp(options->long_name, arg + 3))
 				goto is_abbreviated;
-			if (!rest)
+			if (!strcmp(rest, arg + 3))
 				continue;
 		}
 		if (*rest) {
-- 
1.5.6.rc0.dirty
