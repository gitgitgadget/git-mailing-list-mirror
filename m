From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow built-ins to also use -c var=val via alias
Date: Tue, 24 May 2011 17:52:02 -0400
Message-ID: <20110524215202.GA22243@sigill.intra.peff.net>
References: <7vsjs37qcp.fsf@alter.siamese.dyndns.org>
 <7vmxib7q79.fsf@alter.siamese.dyndns.org>
 <20110524214618.GA17727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 23:52:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOzWO-0001pp-AF
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757628Ab1EXVwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:52:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55304
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770Ab1EXVwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:52:05 -0400
Received: (qmail 22187 invoked by uid 107); 24 May 2011 21:52:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 17:52:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 17:52:02 -0400
Content-Disposition: inline
In-Reply-To: <20110524214618.GA17727@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174348>

On Tue, May 24, 2011 at 05:46:18PM -0400, Jeff King wrote:

> I think the right fix is simply to drop the "don't re-check the
> environment after the first time" logic. It's not expensive to parse
> compared to parsing config files, which is when we would do it. We can
> just drop the existing list and reparse. You can even get rid of the
> whole list and drop a bunch of code, I think, like:

Ack, wrong patch. That one doesn't even come close to compiling.

Try this (still not well tested, though).

---
 cache.h  |    2 -
 config.c |   68 ++++++++++++++++++++++++-------------------------------------
 2 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/cache.h b/cache.h
index 28a921d..69e09a1 100644
--- a/cache.h
+++ b/cache.h
@@ -1037,8 +1037,6 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern void git_config_push_parameter(const char *text);
-extern int git_config_parse_parameter(const char *text);
-extern int git_config_parse_environment(void);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
diff --git a/config.c b/config.c
index 9d36848..90d5e6d 100644
--- a/config.c
+++ b/config.c
@@ -20,14 +20,6 @@ static int zlib_compression_seen;
 
 const char *config_exclusive_filename = NULL;
 
-struct config_item {
-	struct config_item *next;
-	char *name;
-	char *value;
-};
-static struct config_item *config_parameters;
-static struct config_item **config_parameters_tail = &config_parameters;
-
 static void lowercase(char *p)
 {
 	for (; *p; p++)
@@ -47,9 +39,9 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
-int git_config_parse_parameter(const char *text)
+int git_config_parse_parameter(const char *text,
+			       char **name, char **value)
 {
-	struct config_item *ct;
 	struct strbuf tmp = STRBUF_INIT;
 	struct strbuf **pair;
 	strbuf_addstr(&tmp, text);
@@ -61,25 +53,24 @@ int git_config_parse_parameter(const char *text)
 		strbuf_list_free(pair);
 		return -1;
 	}
-	ct = xcalloc(1, sizeof(struct config_item));
-	ct->name = strbuf_detach(pair[0], NULL);
+	*name = strbuf_detach(pair[0], NULL);
 	if (pair[1]) {
 		strbuf_trim(pair[1]);
-		ct->value = strbuf_detach(pair[1], NULL);
+		*value = strbuf_detach(pair[1], NULL);
 	}
 	strbuf_list_free(pair);
-	lowercase(ct->name);
-	*config_parameters_tail = ct;
-	config_parameters_tail = &ct->next;
+	lowercase(*name);
 	return 0;
 }
 
-int git_config_parse_environment(void) {
+int git_config_from_parameters(config_fn_t fn, void *data)
+{
 	const char *env = getenv(CONFIG_DATA_ENVIRONMENT);
 	char *envw;
 	const char **argv = NULL;
 	int nr = 0, alloc = 0;
 	int i;
+	int ret = 0;
 
 	if (!env)
 		return 0;
@@ -92,17 +83,25 @@ int git_config_parse_environment(void) {
 	}
 
 	for (i = 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i]) < 0) {
+		char *name, *value;
+		if (git_config_parse_parameter(argv[i], &name, &value) < 0) {
 			error("bogus config parameter: %s", argv[i]);
-			free(argv);
-			free(envw);
-			return -1;
+			ret = -1;
+			goto out;
 		}
+		if (fn(name, value, data) < 0) {
+			ret = -1;
+			goto out;
+		}
+		free(name);
+		free(value);
+		ret++;
 	}
 
+out:
 	free(argv);
 	free(envw);
-	return 0;
+	return ret;
 }
 
 static int get_next_char(void)
@@ -837,25 +836,10 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-int git_config_from_parameters(config_fn_t fn, void *data)
-{
-	static int loaded_environment;
-	const struct config_item *ct;
-
-	if (!loaded_environment) {
-		if (git_config_parse_environment() < 0)
-			return -1;
-		loaded_environment = 1;
-	}
-	for (ct = config_parameters; ct; ct = ct->next)
-		if (fn(ct->name, ct->value, data) < 0)
-			return -1;
-	return 0;
-}
-
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
 	int ret = 0, found = 0;
+	int n;
 	const char *home = NULL;
 
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
@@ -882,9 +866,11 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		found += 1;
 	}
 
-	ret += git_config_from_parameters(fn, data);
-	if (config_parameters)
-		found += 1;
+	n = git_config_from_parameters(fn, data);
+	if (n < 0)
+		ret += n;
+	else
+		found += n;
 
 	return ret == 0 ? found : ret;
 }
