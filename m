Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5056203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919AbcG0SA2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:00:28 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35600 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754303AbcG0SA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:00:27 -0400
Received: (qmail 32628 invoked from network); 27 Jul 2016 18:00:24 -0000
Received: (qmail 4572 invoked from network); 27 Jul 2016 18:00:23 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 27 Jul 2016 18:00:21 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH] i18n: config: unfold error messages marked for translation
Date:	Wed, 27 Jul 2016 17:59:35 +0000
Message-Id: <1469642375-27305-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Introduced in 473166b ("config: add 'origin_type' to config_source
struct", 2016-02-19), Git can inform the user about the origin of a
config error, but the implementation does not allow translators to
translate the keywords 'file', 'blob, 'standard input', and
'submodule-blob'. Moreover, for the second message, a reason for the
error is appended to the message, not allowing translators to translate
that reason either.

Unfold the message into several templates for each known origin_type.
That would result in better translation at the expense of code
verbosity.

Add enum config_oringin_type to ease management of the various
configuration origin types (blob, file, etc).  Previously origin type
was considered from command line if cf->origin_type == NULL, i.e.,
uninitialized. Now we set origin_type to CONFIG_ORIGIN_CMDLINE in
git_config_from_parameters() and configset_add_value().

For error message in git_parse_source(), use xstrfmt() function to
prepare the message string, instead of doing something like it's done
for die_bad_number(), because intelligibility and code conciseness are
improved for that instance.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 cache.h            |  12 +++++-
 config.c           | 117 ++++++++++++++++++++++++++++++++++++++++++++---------
 submodule-config.c |   2 +-
 3 files changed, 109 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 3855ddf..c802098 100644
--- a/cache.h
+++ b/cache.h
@@ -1566,10 +1566,18 @@ struct git_config_source {
 	const char *blob;
 };
 
+enum config_origin_type {
+	CONFIG_ORIGIN_BLOB,
+	CONFIG_ORIGIN_FILE,
+	CONFIG_ORIGIN_STDIN,
+	CONFIG_ORIGIN_SUBMODULE_BLOB,
+	CONFIG_ORIGIN_CMDLINE
+};
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
-extern int git_config_from_mem(config_fn_t fn, const char *origin_type,
+extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
@@ -1713,7 +1721,7 @@ extern int ignore_untracked_cache_config;
 struct key_value_info {
 	const char *filename;
 	int linenr;
-	const char *origin_type;
+	enum config_origin_type origin_type;
 	enum config_scope scope;
 };
 
diff --git a/config.c b/config.c
index bea937e..2b12730 100644
--- a/config.c
+++ b/config.c
@@ -24,7 +24,7 @@ struct config_source {
 			size_t pos;
 		} buf;
 	} u;
-	const char *origin_type;
+	enum config_origin_type origin_type;
 	const char *name;
 	const char *path;
 	int die_on_error;
@@ -245,6 +245,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 
 	memset(&source, 0, sizeof(source));
 	source.prev = cf;
+	source.origin_type = CONFIG_ORIGIN_CMDLINE;
 	cf = &source;
 
 	/* sq_dequote will write over it */
@@ -453,6 +454,8 @@ static int git_parse_source(config_fn_t fn, void *data)
 	int comment = 0;
 	int baselen = 0;
 	struct strbuf *var = &cf->var;
+	int error_return = 0;
+	char *error_msg = NULL;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -507,10 +510,40 @@ static int git_parse_source(config_fn_t fn, void *data)
 		if (get_value(fn, data, var) < 0)
 			break;
 	}
+
+	switch (cf->origin_type) {
+	case CONFIG_ORIGIN_BLOB:
+		error_msg = xstrfmt(_("bad config line %d in blob %s"),
+				      cf->linenr, cf->name);
+		break;
+	case CONFIG_ORIGIN_FILE:
+		error_msg = xstrfmt(_("bad config line %d in file %s"),
+				      cf->linenr, cf->name);
+		break;
+	case CONFIG_ORIGIN_STDIN:
+		error_msg = xstrfmt(_("bad config line %d in standard input %s"),
+				      cf->linenr, cf->name);
+		break;
+	case CONFIG_ORIGIN_SUBMODULE_BLOB:
+		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
+				       cf->linenr, cf->name);
+		break;
+	case CONFIG_ORIGIN_CMDLINE:
+		error_msg = xstrfmt(_("bad config line %d in command line %s"),
+				       cf->linenr, cf->name);
+		break;
+	default:
+		error_msg = xstrfmt(_("bad config line %d in %s"),
+				      cf->linenr, cf->name);
+	}
+
 	if (cf->die_on_error)
-		die(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
+		die(error_msg);
 	else
-		return error(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
+		error_return =  error(error_msg);
+
+	free(error_msg);
+	return error_return;
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -619,16 +652,47 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
-	const char *reason = errno == ERANGE ?
-			     "out of range" :
-			     "invalid unit";
 	if (!value)
 		value = "";
 
-	if (cf && cf->origin_type && cf->name)
-		die(_("bad numeric config value '%s' for '%s' in %s %s: %s"),
-		    value, name, cf->origin_type, cf->name, reason);
-	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
+	if (!(cf && cf->name))
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s': out of range")
+		    : _("bad numeric config value '%s' for '%s': invalid unit"),
+		    value, name);
+
+	switch (cf->origin_type) {
+	case CONFIG_ORIGIN_BLOB:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in blob %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in blob %s: invalid unit"),
+		    value, name, cf->name);
+	case CONFIG_ORIGIN_FILE:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in file %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in file %s: invalid unit"),
+		    value, name, cf->name);
+	case CONFIG_ORIGIN_STDIN:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in standard input %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in standard input %s: invalid unit"),
+		    value, name, cf->name);
+	case CONFIG_ORIGIN_SUBMODULE_BLOB:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in submodule-blob %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in submodule-blob %s: invalid unit"),
+		    value, name, cf->name);
+	case CONFIG_ORIGIN_CMDLINE:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in command line %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in command line %s: invalid unit"),
+		    value, name, cf->name);
+	default:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in %s: invalid unit"),
+		    value, name, cf->name);
+	}
 }
 
 int git_config_int(const char *name, const char *value)
@@ -1105,7 +1169,8 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 }
 
 static int do_config_from_file(config_fn_t fn,
-		const char *origin_type, const char *name, const char *path, FILE *f,
+		const enum config_origin_type origin_type,
+		const char *name, const char *path, FILE *f,
 		void *data)
 {
 	struct config_source top;
@@ -1124,7 +1189,7 @@ static int do_config_from_file(config_fn_t fn,
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, "standard input", "", NULL, stdin, data);
+	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data);
 }
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
@@ -1135,14 +1200,14 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	f = fopen(filename, "r");
 	if (f) {
 		flockfile(f);
-		ret = do_config_from_file(fn, "file", filename, filename, f, data);
+		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
 		funlockfile(f);
 		fclose(f);
 	}
 	return ret;
 }
 
-int git_config_from_mem(config_fn_t fn, const char *origin_type,
+int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_type,
 			const char *name, const char *buf, size_t len, void *data)
 {
 	struct config_source top;
@@ -1179,7 +1244,7 @@ static int git_config_from_blob_sha1(config_fn_t fn,
 		return error("reference '%s' does not point to a blob", name);
 	}
 
-	ret = git_config_from_mem(fn, "blob", name, buf, size, data);
+	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size, data);
 	free(buf);
 
 	return ret;
@@ -1390,12 +1455,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	if (cf->name) {
 		kv_info->filename = strintern(cf->name);
 		kv_info->linenr = cf->linenr;
-		kv_info->origin_type = strintern(cf->origin_type);
+		kv_info->origin_type = cf->origin_type;
 	} else {
 		/* for values read from `git_config_from_parameters()` */
 		kv_info->filename = NULL;
 		kv_info->linenr = -1;
-		kv_info->origin_type = NULL;
+		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
 	}
 	kv_info->scope = current_parsing_scope;
 	si->util = kv_info;
@@ -2476,14 +2541,28 @@ int parse_config_key(const char *var,
 
 const char *current_config_origin_type(void)
 {
-	const char *type;
+	int type;
 	if (current_config_kvi)
 		type = current_config_kvi->origin_type;
 	else if(cf)
 		type = cf->origin_type;
 	else
 		die("BUG: current_config_origin_type called outside config callback");
-	return type ? type : "command line";
+
+	switch (type) {
+	case CONFIG_ORIGIN_BLOB:
+		return "blob";
+	case CONFIG_ORIGIN_FILE:
+		return "file";
+	case CONFIG_ORIGIN_STDIN:
+		return "standard input";
+	case CONFIG_ORIGIN_SUBMODULE_BLOB:
+		return "submodule-blob";
+	case CONFIG_ORIGIN_CMDLINE:
+		return "command line";
+	default:
+		die("BUG: unknown config origin type");
+	}
 }
 
 const char *current_config_name(void)
diff --git a/submodule-config.c b/submodule-config.c
index 077db40..1753e01 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -448,7 +448,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.commit_sha1 = commit_sha1;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
-	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
+	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
 			config, config_size, &parameter);
 	free(config);
 
-- 
2.7.4

