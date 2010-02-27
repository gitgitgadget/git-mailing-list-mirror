From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH 3/3] clean up parsing of expiration dates
Date: Fri, 26 Feb 2010 19:50:04 -0800
Message-ID: <1267242604-5215-3-git-send-email-simpkins@facebook.com>
References: <20100227012130.GA28452@facebook.com>
 <1267242604-5215-1-git-send-email-simpkins@facebook.com>
 <1267242604-5215-2-git-send-email-simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Adam Simpkins <simpkins@facebook.com>
To: <git@vger.kernel.org>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 04:52:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDj1-0001L5-AC
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 04:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967766Ab0B0DwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 22:52:11 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:50255 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967761Ab0B0DwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 22:52:09 -0500
Received: from mail.thefacebook.com ([192.168.18.83])
	by pp01.snc1.tfbnw.net (8.14.3/8.14.3) with ESMTP id o1R3paEL004077
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 26 Feb 2010 19:51:39 -0800
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.83) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 26 Feb
 2010 19:50:39 -0800
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1NlDhP-0001N1-OY; Fri, 26 Feb 2010 19:50:39 -0800
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1267242604-5215-2-git-send-email-simpkins@facebook.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166
 definitions=2010-02-27_02:2010-02-06,2010-02-27,2010-02-26 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141170>

The gc, prune, and reflog command all take arguments that control
expiring of old objects/log entries.  This cleans up the parsing of
these arguments, and centralizes the logic so the commands behave
consistently.

Two new functions have been added for parsing expiration dates:
parse_expire_date() is similar to approxidate_careful(), but also
accepts the value "false" as a synonym for "never".
git_config_expire_date() calls parse_expire_date(), and prints an
error message if the value is invalid.  A new OPT_EXPIRE_DATE option
type has also been added to parse-options.h for parsing expiration
date command line arguments.

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---
 builtin-gc.c      |    9 ++++-----
 builtin-prune.c   |    4 ++--
 builtin-reflog.c  |   27 +++++++++++----------------
 cache.h           |    2 ++
 config.c          |   12 ++++++++++++
 date.c            |   10 ++++++++++
 parse-options.c   |   17 +++++++++++++++++
 parse-options.h   |    4 ++++
 t/t1410-reflog.sh |   11 +++++++++++
 t/t5304-prune.sh  |   36 +++++++++++++++++++++++++++++++++++-
 10 files changed, 108 insertions(+), 24 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index c304638..3921e6e 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -57,11 +57,10 @@ static int gc_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "gc.pruneexpire")) {
-		if (value && strcmp(value, "now")) {
-			unsigned long now = approxidate("now");
-			if (approxidate(value) >= now)
-				return error("Invalid %s: '%s'", var, value);
-		}
+		/* Make sure the value is valid */
+		unsigned long expire_date;
+		if (git_config_expire_date(&expire_date, var, value))
+			return -1;
 		return git_config_string(&prune_expire, var, value);
 	}
 	return git_default_config(var, value, cb);
diff --git a/builtin-prune.c b/builtin-prune.c
index f22bcf6..e8d25a6 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -129,8 +129,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			    "do not remove, show only"),
 		OPT_BOOLEAN('v', NULL, &verbose,
 			"report pruned objects"),
-		OPT_DATE(0, "expire", &expire,
-			 "expire objects older than <time>"),
+		OPT_EXPIRE_DATE(0, "expire", &expire,
+				"expire objects older than <time>"),
 		OPT_END()
 	};
 	char *s;
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 64e45bd..2d2a9aa 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -425,18 +425,6 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 	return ent;
 }
 
-static int parse_expire_cfg_value(const char *var, const char *value, unsigned long *expire)
-{
-	if (!value)
-		return config_error_nonbool(var);
-	if (!strcmp(value, "never") || !strcmp(value, "false")) {
-		*expire = 0;
-		return 0;
-	}
-	*expire = approxidate(value);
-	return 0;
-}
-
 /* expiry timer slot */
 #define EXPIRE_TOTAL   01
 #define EXPIRE_UNREACH 02
@@ -453,11 +441,11 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(lastdot, ".reflogexpire")) {
 		slot = EXPIRE_TOTAL;
-		if (parse_expire_cfg_value(var, value, &expire))
+		if (git_config_expire_date(&expire, var, value))
 			return -1;
 	} else if (!strcmp(lastdot, ".reflogexpireunreachable")) {
 		slot = EXPIRE_UNREACH;
-		if (parse_expire_cfg_value(var, value, &expire))
+		if (git_config_expire_date(&expire, var, value))
 			return -1;
 	} else
 		return git_default_config(var, value, cb);
@@ -546,11 +534,18 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run = 1;
 		else if (!prefixcmp(arg, "--expire=")) {
-			cb.expire_total = approxidate(arg + 9);
+			if (git_config_expire_date(&cb.expire_total,
+						   "--expire", arg + 9)) {
+				usage(reflog_expire_usage);
+			}
 			explicit_expiry |= EXPIRE_TOTAL;
 		}
 		else if (!prefixcmp(arg, "--expire-unreachable=")) {
-			cb.expire_unreachable = approxidate(arg + 21);
+			if (git_config_expire_date(&cb.expire_unreachable,
+						   "--expire-unreachable",
+						   arg + 21)) {
+				usage(reflog_expire_usage);
+			}
 			explicit_expiry |= EXPIRE_UNREACH;
 		}
 		else if (!strcmp(arg, "--stale-fix"))
diff --git a/cache.h b/cache.h
index d478eff..981987e 100644
--- a/cache.h
+++ b/cache.h
@@ -766,6 +766,7 @@ void datestamp(char *buf, int bufsize);
 unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
 enum date_mode parse_date_format(const char *format);
+unsigned long parse_expire_date(const char *value, int *error_ret);
 
 #define IDENT_WARN_ON_NO_NAME  1
 #define IDENT_ERROR_ON_NO_NAME 2
@@ -926,6 +927,7 @@ extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_expire_date(unsigned long *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 6963fbe..47df868 100644
--- a/config.c
+++ b/config.c
@@ -361,6 +361,18 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_expire_date(unsigned long *dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	int error_code = 0;
+	*dest = parse_expire_date(value, &error_code);
+	if (error_code) {
+		return error("Invalid value for %s: '%s'", var, value);
+	}
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/date.c b/date.c
index 002aa3c..1191c9d 100644
--- a/date.c
+++ b/date.c
@@ -673,6 +673,16 @@ void datestamp(char *buf, int bufsize)
 	date_string(now, offset, buf, bufsize);
 }
 
+unsigned long parse_expire_date(const char *value, int *error_ret)
+{
+	if (!strcmp(value, "never") || !strcmp(value, "false")) {
+		if (error_ret)
+			*error_ret = 0;
+		return 0;
+	}
+	return approxidate_careful(value, error_ret);
+}
+
 /*
  * Relative time update (eg "2 days ago").  If we haven't set the time
  * yet, we need to set it from current time.
diff --git a/parse-options.c b/parse-options.c
index d218122..431d367 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -599,6 +599,23 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+int parse_opt_expire_date_cb(const struct option *opt, const char *arg,
+			     int unset)
+{
+	int error_code = 0;
+
+	if (unset) {
+		*(unsigned long *)(opt->value) = 0;
+		return 0;
+	}
+
+	*(unsigned long *)(opt->value) = parse_expire_date(arg, &error_code);
+	if (error_code) {
+		return opterror(opt, "expects a date or \"false\"", 0);
+	}
+	return 0;
+}
+
 int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 			   int unset)
 {
diff --git a/parse-options.h b/parse-options.h
index 0c99691..8f446cc 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -128,6 +128,9 @@ struct option {
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
 	  parse_opt_approxidate_cb }
+#define OPT_EXPIRE_DATE(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
+	  parse_opt_expire_date_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
 #define OPT_NUMBER_CALLBACK(v, h, f) \
@@ -187,6 +190,7 @@ extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
+extern int parse_opt_expire_date_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 25046c4..d6641fa 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -233,6 +233,17 @@ test_expect_success '--expire=never' '
 
 '
 
+test_expect_success '--expire=false' '
+
+	git reflog expire --verbose \
+		--expire=false \
+		--expire-unreachable=false \
+		--all &&
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 4
+
+'
+
 test_expect_success 'gc.reflogexpire=never' '
 
 	git config gc.reflogexpire never &&
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e2ed13d..43e5b1d 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -166,7 +166,21 @@ test_expect_success 'gc respects gc.pruneExpire=never' '
 	test -f $BLOB_FILE &&
 	git config gc.pruneExpire now &&
 	git gc &&
-	test ! -f $BLOB_FILE
+	test ! -f $BLOB_FILE &&
+	git config --unset gc.pruneExpire
+
+'
+
+test_expect_success 'gc respects gc.pruneExpire=false' '
+
+	git config gc.pruneExpire false &&
+	add_blob &&
+	git gc &&
+	test -f $BLOB_FILE &&
+	git config gc.pruneExpire now &&
+	git gc &&
+	test ! -f $BLOB_FILE &&
+	git config --unset gc.pruneExpire
 
 '
 
@@ -180,6 +194,26 @@ test_expect_success 'prune --expire=never' '
 
 '
 
+test_expect_success 'prune --expire=false' '
+
+	add_blob &&
+	git prune --expire=false &&
+	test -f $BLOB_FILE &&
+	git prune &&
+	test ! -f $BLOB_FILE
+
+'
+
+test_expect_success 'prune --no-expire' '
+
+	add_blob &&
+	git prune --no-expire &&
+	test -f $BLOB_FILE &&
+	git prune &&
+	test ! -f $BLOB_FILE
+
+'
+
 test_expect_success 'gc: prune old objects after local clone' '
 	add_blob &&
 	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
-- 
1.6.3.3
