From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2] add a flag to supress errors in git_config_parse_key()
Date: Mon, 16 Feb 2015 13:28:07 +0530
Message-ID: <54E1A30F.5010303@gmail.com>
References: <20150206124528.GA18859@inner.h.apk.li>	<20150206193313.GA4220@peff.net>	<xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>	<20150206203902.GB10857@peff.net> <54DA5FC1.9010707@gmail.com>	<20150211002754.GC30561@peff.net> <xmqq386cuvxl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 09:01:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNGcY-0005Ms-MF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 09:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbbBPIBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 03:01:30 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38506 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255AbbBPH6U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 02:58:20 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so33577607pab.3
        for <git@vger.kernel.org>; Sun, 15 Feb 2015 23:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UOkjrXT47s9B/74SXw3EUloIPeVRIssJ2nToB5xCdyQ=;
        b=LhttAHShOmNEtbNXZbIwKNSj+FtuY2ATPR2lrdGy63ZKWYRbOf3XXcFk0sWY+MKdZy
         Lp599dEeRwgc9Kgh3NLjo/4C6UUrRaT5zYYj4Z+SeEHzm97CiDEXGbe0d07vK6wTtPFk
         o/gJOxc9h7x9ShOzRGmLzKjjva5zeBsq3+QoNEMH2Jp7OyhkKpPxg3qmz/NvrXuFUNOM
         iQSNG9JeoEtvnRyzMRBB4YXXCz0VQKvspX3oohMfEbUfdwsy6E7+XTpaFhu/8ZxW6nS9
         4RIL0FUVf1UxmJ9ISqcg857a6DiUkhp9Q4c5bJ6kchCRS7mv7eTN2cl/bzXuSZJyWugC
         lADw==
X-Received: by 10.70.56.34 with SMTP id x2mr37040944pdp.127.1424073500309;
        Sun, 15 Feb 2015 23:58:20 -0800 (PST)
Received: from [27.56.33.148] ([27.56.33.148])
        by mx.google.com with ESMTPSA id yf6sm13933900pab.26.2015.02.15.23.58.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Feb 2015 23:58:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq386cuvxl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263888>


`git_config_parse_key()` is used to sanitize the input key.
Some callers of the function like `git_config_set_multivar_in_file()`
get the pre-sanitized key directly from the user so it becomes
necessary to raise an error specifying what went wrong when the entered
key is syntactically malformed.

Other callers like `configset_find_element()` get their keys from
the git itself so a return value signifying error would be enough.
The error output shown to the user is useless and confusing in this
case so add a flag to suppress errors in such cases.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
Hi Jeff,

I went through Junio's config guideline patch series
and the whole thread of underscore bug report and I also think
that pager.*.command is the right path to go.

If you want to relax the syntactic requirement (such as add '_' to
the current set of allowed chacters), I can work upon it but most of the
comments point that moving towards pager.*.command would be better.

p.s: I hope that I got the unsigned flag suggestion by Junio correctly.

-Tanay

 builtin/config.c |  2 +-
 cache.h          |  4 +++-
 config.c         | 20 +++++++++++++-------
 t/t7006-pager.sh |  9 +++++++++
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d32c532..326d3d3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -200,7 +200,7 @@ static int get_value(const char *key_, const char *regex_)
 			goto free_strings;
 		}
 	} else {
-		if (git_config_parse_key(key_, &key, NULL)) {
+		if (git_config_parse_key(key_, &key, NULL, 0)) {
 			ret = CONFIG_INVALID_KEY;
 			goto free_strings;
 		}
diff --git a/cache.h b/cache.h
index f704af5..9073ee2 100644
--- a/cache.h
+++ b/cache.h
@@ -1329,6 +1329,8 @@ extern int update_server_info(int);

 #define CONFIG_REGEX_NONE ((void *)1)

+#define CONFIG_ERROR_QUIET 0x0001
+
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
@@ -1358,7 +1360,7 @@ extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
-extern int git_config_parse_key(const char *, char **, int *);
+extern int git_config_parse_key(const char *, char **, int *, unsigned int);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index e5e64dc..7e23bb9 100644
--- a/config.c
+++ b/config.c
@@ -1309,7 +1309,7 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	 * `key` may come from the user, so normalize it before using it
 	 * for querying entries from the hashmap.
 	 */
-	ret = git_config_parse_key(key, &normalized_key, NULL);
+	ret = git_config_parse_key(key, &normalized_key, NULL, CONFIG_ERROR_QUIET);

 	if (ret)
 		return NULL;
@@ -1842,8 +1842,10 @@ int git_config_set(const char *key, const char *value)
  *             lowercase section and variable name
  * baselen - pointer to int which will hold the length of the
  *           section + subsection part, can be NULL
+ * flags - toggle whether the function raises an error on a syntactically
+ *         malformed key
  */
-int git_config_parse_key(const char *key, char **store_key, int *baselen_)
+int git_config_parse_key(const char *key, char **store_key, int *baselen_, unsigned int flags)
 {
 	int i, dot, baselen;
 	const char *last_dot = strrchr(key, '.');
@@ -1854,12 +1856,14 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	 */

 	if (last_dot == NULL || last_dot == key) {
-		error("key does not contain a section: %s", key);
+		if (!flags)
+			error("key does not contain a section: %s", key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}

 	if (!last_dot[1]) {
-		error("key does not contain variable name: %s", key);
+		if (!flags)
+			error("key does not contain variable name: %s", key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}

@@ -1881,12 +1885,14 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 		if (!dot || i > baselen) {
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
-				error("invalid key: %s", key);
+				if (!flags)
+					error("invalid key: %s", key);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
-			error("invalid key (newline): %s", key);
+			if (!flags)
+				error("invalid key (newline): %s", key);
 			goto out_free_ret_1;
 		}
 		(*store_key)[i] = c;
@@ -1936,7 +1942,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	char *filename_buf = NULL;

 	/* parse-key returns negative; flip the sign to feed exit(3) */
-	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
+	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen, 0);
 	if (ret)
 		goto out_free;

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index da958a8..2dd71c0 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -447,4 +447,13 @@ test_expect_success TTY 'external command pagers override sub-commands' '
 	test_cmp expect actual
 '

+test_expect_success 'command with underscores does not complain' '
+	write_script git-under_score <<-\EOF &&
+	echo ok
+	EOF
+	git --exec-path=. under_score >actual 2>&1 &&
+	echo ok >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.9.0.GIT
