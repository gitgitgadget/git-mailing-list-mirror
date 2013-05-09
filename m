From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 5/5] do not die when error in config parsing of buf occurs
Date: Thu, 9 May 2013 18:21:02 +0200
Message-ID: <20130509162102.GG3526@book-mint>
References: <20130509154020.GA26423@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 18:27:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaTgB-0004Hb-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab3EIQ0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:26:47 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:51328 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab3EIQ0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:26:46 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UaTae-0008IM-4p; Thu, 09 May 2013 18:21:08 +0200
Content-Disposition: inline
In-Reply-To: <20130509154020.GA26423@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223744>

If a config parsing error in a file occurs we can die and let the user
fix the issue. This is different for the buf parsing function since it
can be used to parse blobs of .gitmodules files. If a parsing error
occurs here we should proceed since otherwise a database containing such
an error in a single revision could be rendered unuseable.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 builtin/config.c       | 10 +++++++---
 config.c               | 10 ++++++++--
 t/t1307-config-blob.sh |  9 +++++++--
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8d01b7a..de32977 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -219,9 +219,11 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
-	git_config_with_options(collect_config, &values,
+	ret = git_config_with_options(collect_config, &values,
 				given_config_file, given_config_blob,
 				respect_includes);
+	if (ret < 0)
+		goto free_values;
 
 	ret = !values.nr;
 
@@ -231,6 +233,7 @@ static int get_value(const char *key_, const char *regex_)
 			fwrite(buf->buf, 1, buf->len, stdout);
 		strbuf_release(buf);
 	}
+free_values:
 	free(values.items);
 
 free_strings:
@@ -333,9 +336,10 @@ static int get_colorbool(int print)
 {
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
-	git_config_with_options(git_get_colorbool_config, NULL,
+	if (git_config_with_options(git_get_colorbool_config, NULL,
 				given_config_file, given_config_blob,
-				respect_includes);
+				respect_includes) < 0)
+		return -1;
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
diff --git a/config.c b/config.c
index 50c762a..8a8408d 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@ struct config_source {
 		} buf;
 	};
 	const char *name;
+	int die_on_error;
 	int linenr;
 	int eof;
 	struct strbuf value;
@@ -442,7 +443,10 @@ static int git_parse_source(config_fn_t fn, void *data)
 		if (get_value(fn, data, var) < 0)
 			break;
 	}
-	die("bad config file line %d in %s", cf->linenr, cf->name);
+	if (cf->die_on_error)
+		die("bad config file line %d in %s", cf->linenr, cf->name);
+	else
+		return error("bad config file line %d in %s", cf->linenr, cf->name);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -940,7 +944,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
 }
 
 /*
- * All source specific fields in the union, name and the callbacks
+ * All source specific fields in the union, die_on_error, name and the callbacks
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
@@ -977,6 +981,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 		top.file = f;
 		top.name = filename;
+		top.die_on_error = 1;
 		top.fgetc = config_file_fgetc;
 		top.ungetc = config_file_ungetc;
 		top.ftell = config_file_ftell;
@@ -996,6 +1001,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
 	top.buf.buf = buf;
 	top.buf.pos = 0;
 	top.name = name;
+	top.die_on_error = 0;
 	top.fgetc = config_buf_fgetc;
 	top.ungetc = config_buf_ungetc;
 	top.ftell = config_buf_ftell;
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index fdc257e..a4929eb 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -55,12 +55,17 @@ test_expect_success 'editing a blob is an error' '
 test_expect_success 'parse errors in blobs are properly attributed' '
 	cat >config <<-\EOF &&
 	[some]
-		value = "
+		value = 1
+		error = "
 	EOF
 	git add config &&
 	git commit -m broken &&
 
-	test_must_fail git config --blob=HEAD:config some.value 2>err &&
+	test_must_fail git config --blob=HEAD:config some.value 1>out 2>err &&
+
+	# Make sure there is no output of values on stdout
+	touch out.expect &&
+	test_cmp out.expect out &&
 
 	# just grep for our token as the exact error message is likely to
 	# change or be internationalized
-- 
1.8.3.rc1.40.gba374ae
