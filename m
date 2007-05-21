From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] config: Add --quoted option to produce machine-parsable output
Date: Mon, 21 May 2007 19:46:59 +0200
Message-ID: <11797696193384-git-send-email-frank@lichtenheld.de>
References: <20070520225953.GK4085@planck.djpig.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 19:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqByN-0005r2-Uz
	for gcvg-git@gmane.org; Mon, 21 May 2007 19:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbXEURrE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 13:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756248AbXEURrE
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 13:47:04 -0400
Received: from mail.lenk.info ([217.160.134.107]:2360 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756271AbXEURrD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 13:47:03 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HqBwk-0002Bp-UU; Mon, 21 May 2007 19:45:27 +0200
Received: from p3ee3e262.dip.t-dialin.net ([62.227.226.98] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HqByF-0005oO-RB; Mon, 21 May 2007 19:47:00 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HqByF-0002kg-Si; Mon, 21 May 2007 19:46:59 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <20070520225953.GK4085@planck.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48031>

This option will enclose key names in quotes (") if they
contain a subsection and then escape " and \. It will also
escape line breaks in values. Together this should produce
an easily parsable output.

Affects --list and --get-*

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 builtin-config.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 83 insertions(+), 9 deletions(-)

 Will add asciidoc documentation and test cases if people think that this is
 a good idea.

 I'm writing C about once a year, so I really don't mind being told if it's
 crap ;)

diff --git a/builtin-config.c b/builtin-config.c
index b2515f7..454cf4e 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
+"git-config [ --global | --system ] [ --bool | --int ] [--quoted] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
 
 static char *key;
 static regex_t *key_regexp;
@@ -12,14 +12,73 @@ static int use_key_regexp;
 static int do_all;
 static int do_not_match;
 static int seen;
+static int quoted;
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
+static char* quote_key(const char *key_)
+{
+	char *pos1, *pos2;
+	char* key_quot;
+
+	pos1 = strchr(key_, '.');
+	pos2 = strrchr(key_, '.');
+	if (pos1 != pos2) { /* has subsection */
+		char* key;
+		key = xmalloc(strlen(key_)*2 + 1);
+		key_quot = key;
+		*key++ = '"';
+		while (*key_) {
+			if (*key_ == '"' || *key_ == '\\')
+				*key++ = '\\';
+			*key++ = *key_++;
+		}
+		*key++ = '"';
+		*key = 0;
+	} else {
+		key_quot = xstrdup(key_);
+	}
+	return key_quot;
+}
+
+static char* quote_value(const char* value_)
+{
+	char *val_quot, *val;
+	val = xmalloc(strlen(value_)*2 + 1);
+	val_quot = val;
+
+	while (*value_) {
+		if (*value_ == '\n') {
+			*val++ = '\\';
+			*val++ = 'n';
+			value_ += 2;
+		} else
+			*val++ = *value_++;
+	}
+	*val = 0;
+
+	return val_quot;
+}
+
 static int show_all_config(const char *key_, const char *value_)
 {
-	if (value_)
-		printf("%s=%s\n", key_, value_);
-	else
-		printf("%s\n", key_);
+	if (!quoted) {
+		if (value_)
+			printf("%s=%s\n", key_, value_);
+		else
+			printf("%s\n", key_);
+	} else {
+		char* key_quot = quote_key(key_);
+
+		if (value_) {
+			char* val_quot = quote_value(value_);
+			printf("%s=%s\n", key_quot, val_quot);
+			free(val_quot);
+		} else
+			printf("%s\n", key_quot);
+
+		free(key_quot);
+	}
+
 	return 0;
 }
 
@@ -38,16 +97,26 @@ static int show_config(const char* key_, const char* value_)
 			  regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
 
-	if (show_keys)
-		printf("%s ", key_);
+	if (show_keys) {
+		if (quoted) {
+			char* key = quote_key(key_);
+			printf("%s ", key);
+			free(key);
+		} else
+			printf("%s ", key_);
+	}
 	if (seen && !do_all)
 		dup_error = 1;
 	if (type == T_INT)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
 	else if (type == T_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
-	else
-		vptr = value_?value_:"";
+	else {
+		if (quoted)
+			vptr = value_?quote_value(value_):"";
+		else
+			vptr = value_?value_:"";
+	}
 	seen++;
 	if (dup_error) {
 		error("More than one value for the key %s: %s",
@@ -56,6 +125,9 @@ static int show_config(const char* key_, const char* value_)
 	else
 		printf("%s\n", vptr);
 
+	if (quoted && value_)
+		free((char *)vptr);
+
 	return 0;
 }
 
@@ -141,6 +213,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			type = T_INT;
 		else if (!strcmp(argv[1], "--bool"))
 			type = T_BOOL;
+		else if (!strcmp(argv[1], "--quoted"))
+			quoted = 1;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
 		else if (!strcmp(argv[1], "--global")) {
-- 
1.5.2-rc3.GIT
