From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] config: set up config_source for command-line config
Date: Wed, 18 May 2016 18:41:08 -0400
Message-ID: <20160518224107.GC22443@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:41:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3A9W-0000BD-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbcERWlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:41:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:41568 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751653AbcERWlL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:41:11 -0400
Received: (qmail 32467 invoked by uid 102); 18 May 2016 22:41:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:41:10 -0400
Received: (qmail 27664 invoked by uid 107); 18 May 2016 22:41:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:41:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 18:41:08 -0400
Content-Disposition: inline
In-Reply-To: <20160518223712.GA18317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295021>

When we parse a config file, we set up the global "cf"
variable as a pointer to a "struct config_source" describing
the file we are parsing. This is used for error messages, as
well as for lookup functions like current_config_name().

The "cf" variable is NULL in two cases:

  1. When we are parsing command-line config, in which case
     there is no source file.

  2. When we are not parsing any config at all.

Callers like current_config_name() must assume we are in
case 1 if they see a NULL "cf". However, this means that if
they are accidentally used outside of a config parsing
callback, they will quietly return a bogus answer.

This might seem like an unlikely accident (why would you ask
for the current config file if you are not parsing config?),
but it's actually an easy mistake to make due to the
configset caching. git_config() serves the answers from a
configset cache, and any calls to current_config_name() will
claim that we are parsing command-line config, no matter
what the original source.

So let's distinguish these cases by having the command-line
config parser set up a config_source with a NULL name (which
callers already handle properly). We can use this to catch
programming errors in some cases, and to give better
messages to the user in others.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index eb1e268..4beba52 100644
--- a/config.c
+++ b/config.c
@@ -131,7 +131,9 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!access_or_die(path, R_OK, 0)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(include_depth_advice, MAX_INCLUDE_DEPTH, path,
-			    cf && cf->name ? cf->name : "the command line");
+			    !cf ? "<unknown>" :
+			    cf->name ? cf->name :
+			    "the command line");
 		ret = git_config_from_file(git_config_include, path, inc);
 		inc->depth--;
 	}
@@ -210,9 +212,15 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	const char **argv = NULL;
 	int nr = 0, alloc = 0;
 	int i;
+	struct config_source source;
 
 	if (!env)
 		return 0;
+
+	memset(&source, 0, sizeof(source));
+	source.prev = cf;
+	cf = &source;
+
 	/* sq_dequote will write over it */
 	envw = xstrdup(env);
 
@@ -231,6 +239,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 out:
 	free(argv);
 	free(envw);
+	cf = source.prev;
 	return ret;
 }
 
@@ -1345,7 +1354,9 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (cf) {
+	if (!cf)
+		die("BUG: configset_add_value has no source");
+	if (cf->name) {
 		kv_info->filename = strintern(cf->name);
 		kv_info->linenr = cf->linenr;
 	} else {
@@ -2431,10 +2442,14 @@ int parse_config_key(const char *var,
 
 const char *current_config_origin_type(void)
 {
-	return cf && cf->origin_type ? cf->origin_type : "command line";
+	if (!cf)
+		die("BUG: current_config_origin_type called outside config callback");
+	return cf->origin_type ? cf->origin_type : "command line";
 }
 
 const char *current_config_name(void)
 {
-	return cf && cf->name ? cf->name : "";
+	if (!cf)
+		die("BUG: current_config_name called outside config callback");
+	return cf->name ? cf->name : "";
 }
-- 
2.8.2.888.gecb1fe3
