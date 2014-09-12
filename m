From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 2/2] make config --add behave correctly for empty and NULL
 values
Date: Fri, 12 Sep 2014 12:55:21 +0530
Message-ID: <54129FE1.6020303@gmail.com>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>	<xmqqvbppwtir.fsf@gitster.dls.corp.google.com>	<20140819051732.GA13765@peff.net>	<xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>	<20140819062000.GA7805@peff.net> <xmqqy4tpbuii.fsf@gitster.dls.corp.google.com> <54129F66.9080905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 09:25:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLEa-0001YI-FT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 09:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbaILHZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 03:25:28 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33605 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaILHZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 03:25:27 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so619070pde.40
        for <git@vger.kernel.org>; Fri, 12 Sep 2014 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=a9iuqvFw7fwh2sdFNKKnmwty/g4NcIS2rX1E8Pu8icE=;
        b=YPwOV5FqPMRrekW/3vljqT4OR625f7c7NomYw9N01V4eatR5taAEQmUn4fTywnH0UW
         tzcCXVmgI15Dn/oOyikxySdSUAzdiiCp5HvQvs7m57DiilBVHXbpIpzi/SdgS9xcDrAM
         KE4S6klIVoX5E8p/R75zc/oDZUF8KddI8EC77PKE9rbjOopkceO8rXSlJbt3Ku/Sgrd1
         QZzIn3WbfaBI5giV3LjAqBUWUKZsJQ+rElz8QBdZiHzGSPeCiY2CVivhwJFdssduUtVP
         ZAYUL0AsHFpxYrvcjosRLW7W3bvWf//IKrhWNwBAjIb7S3NbM/sDQk8Miq7yIY1KU85f
         mBZA==
X-Received: by 10.70.118.38 with SMTP id kj6mr1175306pdb.167.1410506726612;
        Fri, 12 Sep 2014 00:25:26 -0700 (PDT)
Received: from [127.0.0.1] ([223.188.87.40])
        by mx.google.com with ESMTPSA id qp15sm2962804pbb.54.2014.09.12.00.25.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Sep 2014 00:25:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <54129F66.9080905@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256904>

The problem lies with the regexp used for simulating --add in
`git_config_set_multivar_in_file()`, "^$", which in ideal case should
not match with any string but is true for empty strings. Instead use a
sentinel value CONFIG_REGEX_NONE to say "we do not want to replace any
existing entry" and use it in the implementation of "git config --add".

For removing the segfault add a check for NULL values in `matches()` in
config.c.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 builtin/config.c        |  2 +-
 cache.h                 |  2 ++
 config.c                | 21 +++++++++++++++++----
 t/t1303-wacky-config.sh |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index aba7135..195664b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -611,7 +611,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, "^$", 0);
+						       argv[0], value, CONFIG_REGEX_NONE, 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
diff --git a/cache.h b/cache.h
index dfa1a56..a09217d 100644
--- a/cache.h
+++ b/cache.h
@@ -1284,6 +1284,8 @@ extern int update_server_info(int);
 #define CONFIG_INVALID_PATTERN 6
 #define CONFIG_GENERIC_ERROR 7

+extern const char CONFIG_REGEX_NONE[];
+
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
diff --git a/config.c b/config.c
index 83c913a..20476e0 100644
--- a/config.c
+++ b/config.c
@@ -46,6 +46,8 @@ static int zlib_compression_seen;
  */
 static struct config_set the_config_set;

+const char CONFIG_REGEX_NONE[] = "a^";
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return fgetc(conf->u.file);
@@ -1607,14 +1609,20 @@ static struct {
 	unsigned int offset_alloc;
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
 	int seen;
+	unsigned value_never_matches:1;
 } store;

 static int matches(const char *key, const char *value)
 {
-	return !strcmp(key, store.key) &&
-		(store.value_regex == NULL ||
-		 (store.do_not_match ^
-		  !regexec(store.value_regex, value, 0, NULL, 0)));
+	if (strcmp(key, store.key))
+		return 0; /* not ours */
+	if (!store.value_regex)
+		return 1; /* always matches */
+	if (store.value_never_matches)
+		return 0; /* never matches */
+
+	return store.do_not_match ^
+	(value && !regexec(store.value_regex, value, 0, NULL, 0));
 }

 static int store_aux(const char *key, const char *value, void *cb)
@@ -1876,6 +1884,8 @@ out_free_ret_1:
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
+ * if value_regex==CONFIG_REGEX_NONE, do not match any existing values
+ * (only add a new one)
  * if multi_replace==0, nothing, or only one matching key/value is replaced,
  *     else all matching key/values (regardless how many) are removed,
  *     before the new pair is written.
@@ -1966,6 +1976,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			} else
 				store.do_not_match = 0;

+			if (value_regex == CONFIG_REGEX_NONE)
+				store.value_never_matches = 1;
+
 			store.value_regex = (regex_t*)xmalloc(sizeof(regex_t));
 			if (regcomp(store.value_regex, value_regex,
 					REG_EXTENDED)) {
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index e5c0f07..3b92083 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -111,7 +111,7 @@ test_expect_success 'unset many entries' '
 	test_must_fail git config section.key
 '

-test_expect_failure '--add appends new value after existing empty value' '
+test_expect_success '--add appends new value after existing empty value' '
 	cat >expect <<-\EOF &&


-- 
1.9.0.GIT
