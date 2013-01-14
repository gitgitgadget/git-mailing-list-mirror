From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] convert some config callbacks to match_config_key
Date: Mon, 14 Jan 2013 10:05:51 -0800
Message-ID: <20130114180550.GA12961@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150322.GC16828@sigill.intra.peff.net>
 <20130114165527.GB3121@elie.Belkin>
 <20130114170610.GB22098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 19:06:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuoQJ-0004LR-Re
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 19:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab3ANSFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 13:05:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33093 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756216Ab3ANSFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 13:05:54 -0500
Received: (qmail 21918 invoked by uid 107); 14 Jan 2013 18:07:10 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 13:07:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 10:05:51 -0800
Content-Disposition: inline
In-Reply-To: <20130114170610.GB22098@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213509>

On Mon, Jan 14, 2013 at 09:06:10AM -0800, Jeff King wrote:

>   struct config_key k;
>   parse_config_key(&k, var);
>   if (strcmp(k.section, "filter") || k.subsection))
>           return 0;
> 
> would be a better start (or having git_config do the first two lines
> itself before triggering the callback).

Here's what that looks like, along with the cleanups in submodule.c that
are made possible by it.

I "cheat" a little and use a static buffer when parsing the config key,
so that the caller does not have to deal with freeing it. It makes using
the parser literally as simple as the lines above, but it does mean it
isn't re-entrant (and worse, it has to be invoked from a config
callback, since the static buffer is tied to the config file stack).

None of that is a problem for the use here, but it is not a
generally-callable function. For that reason, it might make more sense
to have the config parser just provide the config_key, and not have a
public function at all. The downside to that is that we have to update
the function signature of all of the config callbacks.

---
 cache.h     |  7 ++++++
 config.c    | 35 ++++++++++++++++++++++++++++++
 submodule.c | 41 ++++++++++++++---------------------
 3 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/cache.h b/cache.h
index c257953..df756e6 100644
--- a/cache.h
+++ b/cache.h
@@ -1119,6 +1119,13 @@ extern int update_server_info(int);
 #define CONFIG_INVALID_PATTERN 6
 #define CONFIG_GENERIC_ERROR 7
 
+struct config_key {
+	const char *section;
+	const char *subsection;
+	const char *key;
+};
+void config_key_parse(struct config_key *, const char *);
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
diff --git a/config.c b/config.c
index 7b444b6..7b8df3e 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,7 @@ typedef struct config_file {
 	int eof;
 	struct strbuf value;
 	struct strbuf var;
+	struct strbuf key_parse_buf;
 } config_file;
 
 static config_file *cf;
@@ -899,6 +900,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		top.eof = 0;
 		strbuf_init(&top.value, 1024);
 		strbuf_init(&top.var, 1024);
+		strbuf_init(&top.key_parse_buf, 1024);
 		cf = &top;
 
 		ret = git_parse_file(fn, data);
@@ -906,6 +908,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		/* pop config-file parsing state stack */
 		strbuf_release(&top.value);
 		strbuf_release(&top.var);
+		strbuf_release(&top.key_parse_buf);
 		cf = top.prev;
 
 		fclose(f);
@@ -1667,3 +1670,35 @@ int config_error_nonbool(const char *var)
 {
 	return error("Missing value for '%s'", var);
 }
+
+void config_key_parse(struct config_key *key, const char *var)
+{
+	/*
+	 * We want to use a static buffer so the caller does not have to worry
+	 * about memory ownership. But since config parsing can happen
+	 * recursively, we must use storage from the stack of config files.
+	 */
+	struct strbuf *sb = &cf->key_parse_buf;
+	char *dot;
+	char *rdot;
+
+	strbuf_reset(sb);
+	strbuf_addstr(sb, var);
+
+	dot = strchr(sb->buf, '.');
+	rdot = strrchr(sb->buf, '.');
+	/* Should never happen because our keys come from git_parse_file. */
+	if (!dot)
+		die("BUG: config_key_parse was fed a bogus key");
+	key->section = sb->buf;
+	*dot = '\0';
+	key->key = rdot + 1;
+
+	if (rdot == dot)
+		key->subsection = NULL;
+	else {
+		*rdot = '\0';
+		key->subsection = dot + 1;
+	}
+
+}
diff --git a/submodule.c b/submodule.c
index 2f55436..4894718 100644
--- a/submodule.c
+++ b/submodule.c
@@ -11,9 +11,9 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 
-static struct string_list config_name_for_path;
-static struct string_list config_fetch_recurse_submodules_for_name;
-static struct string_list config_ignore_for_name;
+static struct string_list config_name_for_path = STRING_LIST_INIT_DUP;
+static struct string_list config_fetch_recurse_submodules_for_name = STRING_LIST_INIT_DUP;
+static struct string_list config_ignore_for_name = STRING_LIST_INIT_DUP;
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
@@ -126,47 +126,38 @@ int parse_submodule_config_option(const char *var, const char *value)
 
 int parse_submodule_config_option(const char *var, const char *value)
 {
-	int len;
+	struct config_key key;
 	struct string_list_item *config;
-	struct strbuf submodname = STRBUF_INIT;
 
-	var += 10;		/* Skip "submodule." */
+	config_key_parse(&key, var);
+	if (strcmp(key.section, "submodule") || !key.subsection)
+		return 0;
 
-	len = strlen(var);
-	if ((len > 5) && !strcmp(var + len - 5, ".path")) {
-		strbuf_add(&submodname, var, len - 5);
+	if (!strcmp(key.key, "path")) {
 		config = unsorted_string_list_lookup(&config_name_for_path, value);
 		if (config)
 			free(config->util);
 		else
-			config = string_list_append(&config_name_for_path, xstrdup(value));
-		config->util = strbuf_detach(&submodname, NULL);
-		strbuf_release(&submodname);
-	} else if ((len > 23) && !strcmp(var + len - 23, ".fetchrecursesubmodules")) {
-		strbuf_add(&submodname, var, len - 23);
-		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, submodname.buf);
+			config = string_list_append(&config_name_for_path, value);
+		config->util = xstrdup(key.subsection);
+	} else if (!strcmp(key.key, "fetchrecursesubmodules")) {
+		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, key.subsection);
 		if (!config)
-			config = string_list_append(&config_fetch_recurse_submodules_for_name,
-						    strbuf_detach(&submodname, NULL));
+			config = string_list_append(&config_fetch_recurse_submodules_for_name, key.subsection);
 		config->util = (void *)(intptr_t)parse_fetch_recurse_submodules_arg(var, value);
-		strbuf_release(&submodname);
-	} else if ((len > 7) && !strcmp(var + len - 7, ".ignore")) {
+	} else if (!strcmp(key.key, "ignore")) {
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
 			return 0;
 		}
 
-		strbuf_add(&submodname, var, len - 7);
-		config = unsorted_string_list_lookup(&config_ignore_for_name, submodname.buf);
+		config = unsorted_string_list_lookup(&config_ignore_for_name, key.subsection);
 		if (config)
 			free(config->util);
 		else
-			config = string_list_append(&config_ignore_for_name,
-						    strbuf_detach(&submodname, NULL));
-		strbuf_release(&submodname);
+			config = string_list_append(&config_ignore_for_name, key.subsection);
 		config->util = xstrdup(value);
-		return 0;
 	}
 	return 0;
 }
