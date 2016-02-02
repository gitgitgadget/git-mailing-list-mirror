From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Identify where a Git config is defined
Date: Tue, 2 Feb 2016 05:32:16 -0500
Message-ID: <20160202103215.GA18074@sigill.intra.peff.net>
References: <3226E251-73F9-4410-84DE-49C8FFAD92EB@gmail.com>
 <20160202101551.GA17349@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 11:32:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQYFz-0006oK-AK
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 11:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbcBBKcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 05:32:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:36049 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754369AbcBBKcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 05:32:18 -0500
Received: (qmail 13741 invoked by uid 102); 2 Feb 2016 10:32:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 05:32:18 -0500
Received: (qmail 12762 invoked by uid 107); 2 Feb 2016 10:32:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 05:32:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2016 05:32:16 -0500
Content-Disposition: inline
In-Reply-To: <20160202101551.GA17349@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285249>

On Tue, Feb 02, 2016 at 05:15:51AM -0500, Jeff King wrote:

> It looks like I tweaked it at some point, and I've been carrying this in
> my tree (rebasing forward and using it in my normal build):
> 
>   git fetch git://github.com/peff/git jk/config-sources
> 
> Feel free to use it as a starting point if that's helpful. I don't
> recall offhand how close it is to ready.

Just to leave a record in the list archive, here's the patch itself:

-- >8 --
Subject: [PATCH] show sources of config options (WIP)

 - needs tests
 - probably should complain when not LIST or getting a value

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 32 ++++++++++++++++++++++++++++++++
 cache.h          |  1 +
 config.c         |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index adc7727..b8caf18 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -3,6 +3,7 @@
 #include "color.h"
 #include "parse-options.h"
 #include "urlmatch.h"
+#include "quote.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
@@ -27,6 +28,7 @@ static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
 static int respect_includes = -1;
+static int show_sources;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -81,6 +83,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
+	OPT_BOOL(0, "sources", &show_sources, N_("show source filenames of config")),
 	OPT_END(),
 };
 
@@ -91,8 +94,35 @@ static void check_argc(int argc, int min, int max) {
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
+/* output to either fp or buf; only one should be non-NULL */
+static void show_config_source(struct strbuf *buf, FILE *fp)
+{
+	char term = '\t';
+	const char *fn = current_config_filename();
+
+	if (!fn)
+		fn = "";
+
+	if (!end_null)
+		quote_c_style(fn, buf, fp, 0);
+	else {
+		term = '\0';
+		if (fp)
+			fprintf(fp, "%s", fn);
+		else
+			strbuf_addstr(buf, fn);
+	}
+
+	if (fp)
+		fputc(term, fp);
+	else
+		strbuf_addch(buf, term);
+}
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
+	if (show_sources)
+		show_config_source(NULL, stdout);
 	if (!omit_values && value_)
 		printf("%s%c%s%c", key_, delim, value_, term);
 	else
@@ -108,6 +138,8 @@ struct strbuf_list {
 
 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
+	if (show_sources)
+		show_config_source(buf, NULL);
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
diff --git a/cache.h b/cache.h
index dfc459c..95a7f65 100644
--- a/cache.h
+++ b/cache.h
@@ -1528,6 +1528,7 @@ extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+extern const char *current_config_filename(void);
 
 struct config_include_data {
 	int depth;
diff --git a/config.c b/config.c
index 86a5eb2..b437002 100644
--- a/config.c
+++ b/config.c
@@ -2385,3 +2385,10 @@ int parse_config_key(const char *var,
 
 	return 0;
 }
+
+const char *current_config_filename(void)
+{
+	if (cf && cf->name)
+		return cf->name;
+	return NULL;
+}
-- 
2.7.0.489.g6faad84
