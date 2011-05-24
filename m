From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow built-ins to also use -c var=val via alias
Date: Tue, 24 May 2011 17:46:18 -0400
Message-ID: <20110524214618.GA17727@sigill.intra.peff.net>
References: <7vsjs37qcp.fsf@alter.siamese.dyndns.org>
 <7vmxib7q79.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 23:46:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOzQq-0007Ig-CB
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab1EXVqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:46:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55460
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757491Ab1EXVqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:46:20 -0400
Received: (qmail 22125 invoked by uid 107); 24 May 2011 21:46:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 17:46:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 17:46:18 -0400
Content-Disposition: inline
In-Reply-To: <7vmxib7q79.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174347>

On Tue, May 24, 2011 at 02:18:18PM -0700, Junio C Hamano wrote:

> When the options came as part of an alias to an internal command, e.g.
> 
>   [alias]
>     aw = -c apply.whitespace=fix apply
> 
> and then run as "git aw P.diff", we have already read the configuration to
> find out about the alias definition (setting loaded_environment to true),
> then pushed apply.whitespace=fix to the environment, but not to the
> in-core list of configuration variables. The implementation of the
> internal command, e.g. cmd_apply(), will try to read from git_config() but
> the setting is lost, as the environment is never read in this codepath.
> 
> Add the in-core queuing of the parameters back to fix this.

Hmm. I'm not sure that is right. The fatal assumption in 2b64fc89 is
that we do not load the parameters again once they have already been
loaded. So if your sequence is:

  git_config(...);
  git_config_push_parameter(...);
  git_config(...);

then the first git_config will try git_config_from_parameters, which
will call git_config_parse_environment, which will set the static
loaded_environment variable. And so in the second git_config call, we
will not reparse the environment, and your fix is correct.

But what if the sequence is:

  git_config_push_parameter(...);
  git_config(...);

With your fix, the push_parameter will add the variable to the in-memory
list, and put it in the environment. But our git_config call will then
re-parse the environment, adding a duplicate of the variable.

For most variables, that means a simple overwrite. But there are some
that are additive if multiple instances are found, and they may be
broken.

I say "may" because I am not sure if there are code paths which don't
call git_config before git_config_push_parameter. I suspect there are,
since otherwise "-c" wouldn't work for builtins at all. Even if there
aren't, I'd rather not leave such a fragile thing in place.

I think the right fix is simply to drop the "don't re-check the
environment after the first time" logic. It's not expensive to parse
compared to parsing config files, which is when we would do it. We can
just drop the existing list and reparse. You can even get rid of the
whole list and drop a bunch of code, I think, like:

---
 config.c |   53 +++++++++++++++--------------------------------------
 1 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/config.c b/config.c
index 80dc715..bc5666f 100644
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
+			       const char **name, const char **value)
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
+	*key = strbuf_detach(pair[0], NULL);
 	if (pair[1]) {
 		strbuf_trim(pair[1]);
-		ct->value = strbuf_detach(pair[1], NULL);
+		*value = strbuf_detach(pair[1], NULL);
 	}
 	strbuf_list_free(pair);
-	lowercase(ct->name);
-	*config_parameters_tail = ct;
-	config_parameters_tail = &ct->next;
+	lowercase(name);
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
+	int ret = -1;
 
 	if (!env)
 		return 0;
@@ -92,17 +83,19 @@ int git_config_parse_environment(void) {
 	}
 
 	for (i = 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i]) < 0) {
+		if (git_config_parse_parameter(argv[i], &name, &value) < 0) {
 			error("bogus config parameter: %s", argv[i]);
-			free(argv);
-			free(envw);
-			return -1;
+			goto out;
 		}
+		if (fn(name, value, data) < 0)
+			goto out;
 	}
+	ret = 0;
 
+out:
 	free(argv);
 	free(envw);
-	return 0;
+	return ret;
 }
 
 static int get_next_char(void)
@@ -850,22 +843,6 @@ int git_config_system(void)
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
