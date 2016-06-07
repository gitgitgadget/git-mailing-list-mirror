From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 27/38] i18n: config: unfold error messages marked for translation
Date: Tue,  7 Jun 2016 11:52:26 +0000
Message-ID: <1465300357-7557-28-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:55:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFbL-00088Y-HO
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbcFGLzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:55:10 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:54410 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161146AbcFGLzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:55:08 -0400
Received: (qmail 24940 invoked from network); 7 Jun 2016 11:55:06 -0000
Received: (qmail 22938 invoked from network); 7 Jun 2016 11:55:06 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:55:03 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296658>

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

Add enum git_config_oringin_type to ease management of the various
configuration origin types (blob, file, etc).

For the first instance, use xstrfmt() function to prepare the message
string, instead of doing something like it's done for the second one,
because intelligibility and code conciseness are improved for that
instance.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 cache.h            |   9 ++++-
 config.c           | 101 ++++++++++++++++++++++++++++++++++++++++++++---------
 submodule-config.c |   2 +-
 3 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 6049f86..4bded9a 100644
--- a/cache.h
+++ b/cache.h
@@ -1559,10 +1559,17 @@ struct git_config_source {
 	const char *blob;
 };
 
+enum git_config_origin_type {
+	CFG_BLOB,
+	CFG_FILE,
+	CFG_STDIN,
+	CFG_SUBMODULE_BLOB
+};
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
-extern int git_config_from_mem(config_fn_t fn, const char *origin_type,
+extern int git_config_from_mem(config_fn_t fn, const enum git_config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
diff --git a/config.c b/config.c
index f51c56b..e86f0aa 100644
--- a/config.c
+++ b/config.c
@@ -24,7 +24,7 @@ struct config_source {
 			size_t pos;
 		} buf;
 	} u;
-	const char *origin_type;
+	enum git_config_origin_type origin_type;
 	const char *name;
 	const char *path;
 	int die_on_error;
@@ -417,6 +417,8 @@ static int git_parse_source(config_fn_t fn, void *data)
 	int comment = 0;
 	int baselen = 0;
 	struct strbuf *var = &cf->var;
+	int error_return = 0;
+	char *error_msg = NULL;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -471,10 +473,36 @@ static int git_parse_source(config_fn_t fn, void *data)
 		if (get_value(fn, data, var) < 0)
 			break;
 	}
+
+	switch (cf->origin_type) {
+	case CFG_BLOB:
+		error_msg = xstrfmt(_("bad config line %d in blob %s"),
+				      cf->linenr, cf->name);
+		break;
+	case CFG_FILE:
+		error_msg = xstrfmt(_("bad config line %d in file %s"),
+				      cf->linenr, cf->name);
+		break;
+	case CFG_STDIN:
+		error_msg = xstrfmt(_("bad config line %d in standard input"),
+				      cf->linenr);
+		break;
+	case CFG_SUBMODULE_BLOB:
+		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
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
@@ -583,16 +611,42 @@ int git_parse_ulong(const char *value, unsigned long *ret)
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
+	case CFG_BLOB:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in blob %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in blob %s: invalid unit"),
+		    value, name, cf->name);
+	case CFG_FILE:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in file %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in file %s: invalid unit"),
+		    value, name, cf->name);
+	case CFG_STDIN:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in standard input: out of range")
+		    : _("bad numeric config value '%s' for '%s' in standard input: invalid unit"),
+		    value, name);
+	case CFG_SUBMODULE_BLOB:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in submodule-blob %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in submodule-blob %s: invalid unit"),
+		    value, name, cf->name);
+	default:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in %s: invalid unit"),
+		    value, name, cf->name);
+	}
 }
 
 int git_config_int(const char *name, const char *value)
@@ -1069,7 +1123,8 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 }
 
 static int do_config_from_file(config_fn_t fn,
-		const char *origin_type, const char *name, const char *path, FILE *f,
+		const enum git_config_origin_type origin_type,
+		const char *name, const char *path, FILE *f,
 		void *data)
 {
 	struct config_source top;
@@ -1088,7 +1143,7 @@ static int do_config_from_file(config_fn_t fn,
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, "standard input", "", NULL, stdin, data);
+	return do_config_from_file(fn, CFG_STDIN, "", NULL, stdin, data);
 }
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
@@ -1099,14 +1154,14 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	f = fopen(filename, "r");
 	if (f) {
 		flockfile(f);
-		ret = do_config_from_file(fn, "file", filename, filename, f, data);
+		ret = do_config_from_file(fn, CFG_FILE, filename, filename, f, data);
 		funlockfile(f);
 		fclose(f);
 	}
 	return ret;
 }
 
-int git_config_from_mem(config_fn_t fn, const char *origin_type,
+int git_config_from_mem(config_fn_t fn, const enum git_config_origin_type origin_type,
 			const char *name, const char *buf, size_t len, void *data)
 {
 	struct config_source top;
@@ -1143,7 +1198,7 @@ static int git_config_from_blob_sha1(config_fn_t fn,
 		return error("reference '%s' does not point to a blob", name);
 	}
 
-	ret = git_config_from_mem(fn, "blob", name, buf, size, data);
+	ret = git_config_from_mem(fn, CFG_BLOB, name, buf, size, data);
 	free(buf);
 
 	return ret;
@@ -2442,7 +2497,21 @@ int parse_config_key(const char *var,
 
 const char *current_config_origin_type(void)
 {
-	return cf && cf->origin_type ? cf->origin_type : "command line";
+	if (!cf)
+		return "command line";
+
+	switch (cf->origin_type) {
+	case CFG_BLOB:
+		return "blob";
+	case CFG_FILE:
+		return "file";
+	case CFG_STDIN:
+		return "standard input";
+	case CFG_SUBMODULE_BLOB:
+		return "submodule-blob";
+	default:
+		return "command line";
+	}
 }
 
 const char *current_config_name(void)
diff --git a/submodule-config.c b/submodule-config.c
index debab29..f53f6bd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -439,7 +439,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.commit_sha1 = commit_sha1;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
-	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
+	git_config_from_mem(parse_config, CFG_SUBMODULE_BLOB, rev.buf,
 			config, config_size, &parameter);
 	free(config);
 
-- 
2.7.3
