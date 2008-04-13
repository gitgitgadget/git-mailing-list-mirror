From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] builtin-apply.c: use git_config_string() to get
 apply_default_whitespace
Date: Sat, 12 Apr 2008 23:26:40 -0700
Message-ID: <7vskxqe0db.fsf@gitster.siamese.dyndns.org>
References: <20080408084233.GA7785@leksak.fem-net>
 <200804130556.45141.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 13 08:28:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkvgx-0008QF-MQ
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 08:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbYDMG05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 02:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYDMG05
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 02:26:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYDMG04 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2008 02:26:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 848D03039;
	Sun, 13 Apr 2008 02:26:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 090CA3031; Sun, 13 Apr 2008 02:26:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79392>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le mardi 8 avril 2008, Stephan Beyer a =C3=A9crit :
>> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
>> ---
>> Hi,
>>
>> a simple `Janitor patch'.
>
> Thanks.
> ...
> Tested-by: Christian Couder <chriscool@tuxfamily.org>
>
> Junio, please apply.

Hmmmm.

$ git grep -A1 config_error_nonbool | grep -B1 '^[^ ]*-.* =3D xstrdup'

shows these 13:

alias.c:			return config_error_nonbool(k);
alias.c-		alias_val =3D xstrdup(v);
--
builtin-apply.c:			return config_error_nonbool(var);
builtin-apply.c-		apply_default_whitespace =3D xstrdup(value);
--
builtin-commit.c:			return config_error_nonbool(v);
builtin-commit.c-		template_file =3D xstrdup(v);
--
builtin-log.c:			config_error_nonbool(var);
builtin-log.c-		fmt_patch_subject_prefix =3D xstrdup(value);
--
builtin-log.c:			return config_error_nonbool(var);
builtin-log.c-		fmt_patch_suffix =3D xstrdup(value);
--
config.c:		return config_error_nonbool(var);
config.c-	*dest =3D xstrdup(value);
--
diff.c:			return config_error_nonbool(var);
diff.c-		external_diff_cmd_cfg =3D xstrdup(value);
--
http.c:				return config_error_nonbool(var);
http.c-			ssl_cert =3D xstrdup(value);
--
http.c:				return config_error_nonbool(var);
http.c-			ssl_key =3D xstrdup(value);
--
http.c:				return config_error_nonbool(var);
http.c-			ssl_capath =3D xstrdup(value);
--
http.c:				return config_error_nonbool(var);
http.c-			ssl_cainfo =3D xstrdup(value);
--
http.c:				return config_error_nonbool(var);
http.c-			curl_http_proxy =3D xstrdup(value);
--
remote.c:				return config_error_nonbool(key);
remote.c-			branch->remote_name =3D xstrdup(value);

Among these, obviously the one in config.c cannot be replaced (it is th=
e
implementation of git_config_string() itself ;-), and the one in remote=
=2Ec
has a different pattern (it does not return immediately after that, but
everything else can be mechanically replaced.

I also have strong doubt about the way http.c handles duplicated
configuration values; everybody else let's the later one override the
previous one, while these take and keep the first occurrence.  I left t=
he
logic of them as they were, because changing them would change the
semantics of the program.

--
 alias.c          |    8 ++------
 builtin-apply.c  |    8 ++------
 builtin-commit.c |    9 ++-------
 builtin-log.c    |   16 ++++------------
 diff.c           |    8 ++------
 http.c           |   44 +++++++++++++++-----------------------------
 6 files changed, 27 insertions(+), 66 deletions(-)

diff --git a/alias.c b/alias.c
index 116cac8..1513681 100644
--- a/alias.c
+++ b/alias.c
@@ -4,12 +4,8 @@ static const char *alias_key;
 static char *alias_val;
 static int alias_lookup_cb(const char *k, const char *v)
 {
-	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
-		if (!v)
-			return config_error_nonbool(k);
-		alias_val =3D xstrdup(v);
-		return 0;
-	}
+	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key))
+		return git_config_string((const char **)&alias_val, k, v);
 	return 0;
 }
=20
diff --git a/builtin-apply.c b/builtin-apply.c
index abe73a0..c8ca41b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2981,12 +2981,8 @@ static int apply_patch(int fd, const char *filen=
ame, int inaccurate_eof)
=20
 static int git_apply_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "apply.whitespace")) {
-		if (!value)
-			return config_error_nonbool(var);
-		apply_default_whitespace =3D xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "apply.whitespace"))
+		return git_config_string(&apply_default_whitespace, var, value);
 	return git_default_config(var, value);
 }
=20
diff --git a/builtin-commit.c b/builtin-commit.c
index bcb7aaa..995fd73 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -827,13 +827,8 @@ static void print_summary(const char *prefix, cons=
t unsigned char *sha1)
=20
 int git_commit_config(const char *k, const char *v)
 {
-	if (!strcmp(k, "commit.template")) {
-		if (!v)
-			return config_error_nonbool(v);
-		template_file =3D xstrdup(v);
-		return 0;
-	}
-
+	if (!strcmp(k, "commit.template"))
+		return git_config_string((const char **)&template_file, k, v);
 	return git_status_config(k, v);
 }
=20
diff --git a/builtin-log.c b/builtin-log.c
index 5c00725..59d8f2e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -226,12 +226,8 @@ static int git_log_config(const char *var, const c=
har *value)
 {
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
-	if (!strcmp(var, "format.subjectprefix")) {
-		if (!value)
-			config_error_nonbool(var);
-		fmt_patch_subject_prefix =3D xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "format.subjectprefix"))
+		return git_config_string(&fmt_patch_subject_prefix, var, value);
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root =3D git_config_bool(var, value);
 		return 0;
@@ -478,12 +474,8 @@ static int git_format_config(const char *var, cons=
t char *value)
 		add_header(value);
 		return 0;
 	}
-	if (!strcmp(var, "format.suffix")) {
-		if (!value)
-			return config_error_nonbool(var);
-		fmt_patch_suffix =3D xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "format.suffix"))
+		return git_config_string(&fmt_patch_suffix, var, value);
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
diff --git a/diff.c b/diff.c
index 8022e67..ce28bbc 100644
--- a/diff.c
+++ b/diff.c
@@ -153,12 +153,8 @@ int git_diff_ui_config(const char *var, const char=
 *value)
 		diff_auto_refresh_index =3D git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.external")) {
-		if (!value)
-			return config_error_nonbool(var);
-		external_diff_cmd_cfg =3D xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "diff.external"))
+		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep =3D strrchr(var, '.');
=20
diff --git a/http.c b/http.c
index 256a5f1..9bdf27e 100644
--- a/http.c
+++ b/http.c
@@ -13,18 +13,18 @@ static CURL *curl_default;
 char curl_errorstr[CURL_ERROR_SIZE];
=20
 static int curl_ssl_verify =3D -1;
-static char *ssl_cert =3D NULL;
+static const char *ssl_cert =3D NULL;
 #if LIBCURL_VERSION_NUM >=3D 0x070902
-static char *ssl_key =3D NULL;
+static const char *ssl_key =3D NULL;
 #endif
 #if LIBCURL_VERSION_NUM >=3D 0x070908
-static char *ssl_capath =3D NULL;
+static const char *ssl_capath =3D NULL;
 #endif
-static char *ssl_cainfo =3D NULL;
+static const char *ssl_cainfo =3D NULL;
 static long curl_low_speed_limit =3D -1;
 static long curl_low_speed_time =3D -1;
 static int curl_ftp_no_epsv =3D 0;
-static char *curl_http_proxy =3D NULL;
+static const char *curl_http_proxy =3D NULL;
=20
 static struct curl_slist *pragma_header;
=20
@@ -100,38 +100,27 @@ static int http_options(const char *var, const ch=
ar *value)
 	}
=20
 	if (!strcmp("http.sslcert", var)) {
-		if (ssl_cert =3D=3D NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_cert =3D xstrdup(value);
-		}
+		if (ssl_cert =3D=3D NULL)
+			return git_config_string(&ssl_cert, var, value);
 		return 0;
 	}
 #if LIBCURL_VERSION_NUM >=3D 0x070902
 	if (!strcmp("http.sslkey", var)) {
-		if (ssl_key =3D=3D NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_key =3D xstrdup(value);
-		}
+		if (ssl_key =3D=3D NULL)
+			return git_config_string(&ssl_key, var, value);
 		return 0;
 	}
 #endif
 #if LIBCURL_VERSION_NUM >=3D 0x070908
 	if (!strcmp("http.sslcapath", var)) {
-		if (ssl_capath =3D=3D NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_capath =3D xstrdup(value);
-		}
+		if (ssl_capath =3D=3D NULL)
+			return git_config_string(&ssl_capath, var, value);
 		return 0;
 	}
 #endif
 	if (!strcmp("http.sslcainfo", var)) {
 		if (ssl_cainfo =3D=3D NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_cainfo =3D xstrdup(value);
+			return git_config_string(&ssl_cainfo, var, value);
 		}
 		return 0;
 	}
@@ -160,11 +149,8 @@ static int http_options(const char *var, const cha=
r *value)
 		return 0;
 	}
 	if (!strcmp("http.proxy", var)) {
-		if (curl_http_proxy =3D=3D NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			curl_http_proxy =3D xstrdup(value);
-		}
+		if (curl_http_proxy =3D=3D NULL)
+			return git_config_string(&curl_http_proxy, var, value);
 		return 0;
 	}
=20
@@ -311,7 +297,7 @@ void http_cleanup(void)
 	pragma_header =3D NULL;
=20
 	if (curl_http_proxy) {
-		free(curl_http_proxy);
+		free((char *)curl_http_proxy);
 		curl_http_proxy =3D NULL;
 	}
 }
