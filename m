From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 4/4] do not die on error of parsing
	fetchrecursesubmodules option
Date: Sat, 28 Jun 2014 12:04:28 +0200
Message-ID: <20140628100428.GE89729@book.hvoigt.net>
References: <20140628095800.GA89729@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 12:04:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0pUq-0008Ky-LW
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 12:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbaF1KEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 06:04:33 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:59638 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbaF1KEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 06:04:32 -0400
Received: from [92.194.105.81] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1X0pUj-0006Tr-Ty; Sat, 28 Jun 2014 12:04:30 +0200
Content-Disposition: inline
In-Reply-To: <20140628095800.GA89729@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252605>

We should not die when reading the submodule config cache since the user
might not be able to get out of that situation when the configuration is
part of the history.

We should handle this condition later when the value is about to be
used.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 builtin/fetch.c             |  1 +
 submodule-config.c          | 29 ++++++++++++++++++++++++++++-
 submodule-config.h          |  1 +
 submodule.c                 | 15 ---------------
 submodule.h                 |  2 +-
 t/t7411-submodule-config.sh | 35 +++++++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..706326f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "sigchain.h"
 #include "transport.h"
+#include "submodule-config.h"
 #include "submodule.h"
 #include "connected.h"
 #include "argv-array.h"
diff --git a/submodule-config.c b/submodule-config.c
index 4046233..96623ad 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -199,6 +199,30 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	return submodule;
 }
 
+static int parse_fetch_recurse(const char *opt, const char *arg,
+			       int die_on_error)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (!strcmp(arg, "on-demand"))
+			return RECURSE_SUBMODULES_ON_DEMAND;
+
+		if (die_on_error)
+			die("bad %s argument: %s", opt, arg);
+		else
+			return RECURSE_SUBMODULES_ERROR;
+	}
+}
+
+int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	return parse_fetch_recurse(opt, arg, 1);
+}
+
 static void warn_multiple_config(const unsigned char *commit_sha1,
 				 const char *name, const char *option)
 {
@@ -250,6 +274,8 @@ static int parse_config(const char *var, const char *value, void *data)
 		submodule->path = strbuf_detach(&path, NULL);
 		cache_put_path(me->cache, submodule);
 	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+		/* when parsing worktree configurations we can die early */
+		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
 		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
@@ -257,7 +283,8 @@ static int parse_config(const char *var, const char *value, void *data)
 			goto release_return;
 		}
 
-		submodule->fetch_recurse = parse_fetch_recurse_submodules_arg(var, value);
+		submodule->fetch_recurse = parse_fetch_recurse(var, value,
+								die_on_error);
 	} else if (!strcmp(item.buf, "ignore")) {
 		struct strbuf ignore = STRBUF_INIT;
 		if (!me->overwrite && submodule->ignore != NULL) {
diff --git a/submodule-config.h b/submodule-config.h
index 2083cb9..58afc83 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -18,6 +18,7 @@ struct submodule {
 	unsigned char gitmodules_sha1[20];
 };
 
+int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_submodule_config_option(const char *var, const char *value);
 const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
diff --git a/submodule.c b/submodule.c
index 188b4d2..75f502f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -288,21 +288,6 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
-{
-	switch (git_config_maybe_bool(opt, arg)) {
-	case 1:
-		return RECURSE_SUBMODULES_ON;
-	case 0:
-		return RECURSE_SUBMODULES_OFF;
-	default:
-		if (!strcmp(arg, "on-demand"))
-			return RECURSE_SUBMODULES_ON_DEMAND;
-		/* TODO: remove the die for history parsing here */
-		die("bad %s argument: %s", opt, arg);
-	}
-}
-
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/submodule.h b/submodule.h
index 547219d..5507c3d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,7 @@ struct diff_options;
 struct argv_array;
 
 enum {
+	RECURSE_SUBMODULES_ERROR = -3,
 	RECURSE_SUBMODULES_NONE = -2,
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
 	RECURSE_SUBMODULES_OFF = 0,
@@ -21,7 +22,6 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index dcd5e01..1ba0d64 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -103,4 +103,39 @@ test_expect_success 'reading of local configuration' '
 	)
 '
 
+cat >super/expect_fetchrecurse_die.err <<EOF
+fatal: bad submodule.submodule.fetchrecursesubmodules argument: blabla
+EOF
+
+test_expect_success 'local error in fetchrecursesubmodule dies early' '
+	(cd super &&
+		git config submodule.submodule.fetchrecursesubmodules blabla &&
+		test_must_fail test-submodule-config \
+			"" b \
+			"" submodule \
+				>actual.out 2>actual.err &&
+		touch expect_fetchrecurse_die.out &&
+		test_cmp expect_fetchrecurse_die.out actual.out  &&
+		test_cmp expect_fetchrecurse_die.err actual.err  &&
+		git config --unset submodule.submodule.fetchrecursesubmodules
+	)
+'
+
+test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
+	(cd super &&
+		git config -f .gitmodules \
+			submodule.submodule.fetchrecursesubmodules blabla &&
+		git add .gitmodules &&
+		git config --unset -f .gitmodules \
+			submodule.submodule.fetchrecursesubmodules &&
+		git commit -m "add error in fetchrecursesubmodules" &&
+		test-submodule-config \
+			HEAD b \
+			HEAD submodule \
+				>actual &&
+		test_cmp expect_error actual  &&
+		git reset --hard HEAD^
+	)
+'
+
 test_done
-- 
1.9.2.464.g1bbf329
