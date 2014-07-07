From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 0/3] git config cache & special querying api utilizing the cache
Date: Mon,  7 Jul 2014 00:52:44 -0700
Message-ID: <1404719566-3368-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 07 09:53:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X43jz-0001tR-Da
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 09:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbaGGHxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 03:53:32 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51467 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaGGHxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 03:53:30 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so4892079pdj.5
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fuNWMadgAo60s3OXyNuX1xlrOPifeUUbI8YhimetNrQ=;
        b=VZD2Wkk1C58joOiBbwxfWkiNP9ssRZiLDSdhK/+QcTbppr7aIku9Txyx5xcn/pBV+n
         cyl3SJCsAaJnCo+pkhXImQUBCpttAKvodA8WUYzSj0Mu7PVn/kmgQZn1fuJ3EzeZ4xWV
         XN0dI7zBxhioDos9ff/fFmy8naG9noDATuNl7iQ4Xc8q8sXQb/be0KJyE4WGFXwUNJft
         oInqtU4HYotulNcmN3wz0IwsXF0b7+JVRaI3YkTiKlkVDfE5ojefWYcBcT8ZyBsz5mAb
         09oSSTuLy2equoG6h7RF6gVGlVyjuiVTCEkH7tWJ5m4I+1S++c6DH3SMvl7LisyNd2SQ
         MGtg==
X-Received: by 10.68.162.34 with SMTP id xx2mr1687172pbb.120.1404719610071;
        Mon, 07 Jul 2014 00:53:30 -0700 (PDT)
Received: from localhost.localdomain ([117.254.219.20])
        by mx.google.com with ESMTPSA id v9sm19146890pdp.88.2014.07.07.00.53.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Jul 2014 00:53:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252959>

Hi,

[PATCH V6]: Style nits and mistakes corrected. Diff between v6 and v5[8] is at the bottom.
	    Thanks to Matthieu, Ramsay and Ram for their suggestions.

[PATCH V5]: `config_set` now uses a single hashmap. Corrected style nits raised in
			the thread[7]. Thanks to Junio and Matthieu for their suggestions.

[PATCH v4]: Introduced `config_set` construct which points to a ordered set of
	config-files cached as hashmaps. Added relevant API functions. For more
	details see the documentation. Rewrote the git_config_get* family to use
	`config_set` internally. Added tests for both config_set API and git_config_get
	family. Added type specific API functions which parses the found value and
	converts it into a specific type.
	Most of the changes implemented are the result of discussion in [6].
	Thanks to Eric, Ramsay, Junio, Matthieu & Karsten for their suggestions
	and review.

[PATCH v3]: Added flag for NULL values that were causing segfaults in some cases.
	Added test-config for usage examples.
	Minor changes and corrections. Refer to discussion thread[5] for more details.
	Thanks to Matthieu, Jeff and Junio for their valuable suggestions.

[PATCH v2]:Changed the string_list to a struct instead of pointer to a struct.
	Added string-list initilization functions.
	Minor mistakes corrected acoording to review comments[4]. Thanks to
	Eric and Matthieu for their review.

[PATCH V1]:Most of the invaluable suggestions by Eric Sunshine, Torsten Bogershausen and
	Jeff King has been implemented[1]. Complete rewrite of config_cache*() family
	using git_config() as hook as suggested by Jeff. Thanks for the review.

[RFC V2]: Improved according to the suggestions by Eric Sunshine and Torsten Bogershausen.
	Added cache invalidation when config file is changed.[2]
	I am using git_config_set_multivar_in_file() as an update hook.

This is patch is for this year's GSoC. My project is
"Git Config API improvements". The link of my proposal is appended below [3].

The aim of this patch series is to generate a cache for querying values from
the config files in a non-callback manner as the current method reads and
parses the config files every time a value is queried for.

The cache is generated from hooking the update_cache function to the current
parsing and callback mechanism in config.c. It is implemented as an hashmap
using the hashmap-api with variables and its corresponding values list as
its members. The values in the list are sorted in order of increasing priority.
The cache is initialised the first time when any of the new query functions is
called. It is invalidated by using git_config_set_multivar_in_file() as an
update hook.

We add two new functions to the config-api, git_config_get_string() and
git_config_get_string_multi() for querying in a non callback manner from
the cache.

[1] http://marc.info/?t=140172066200006&r=1&w=2
[2] http://git.661346.n2.nabble.com/RFC-PATCH-0-2-Git-config-cache-amp-special-querying-api-utilizing-the-cache-td7611691.html
[3] https://drive.google.com/file/d/0B4suZ-aHqDcnSUZJRXVTTnZUN1E/edit?usp=sharing
[4] http://thread.gmane.org/gmane.comp.version-control.git/251073/focus=251369
[5] http://thread.gmane.org/gmane.comp.version-control.git/251704/
[6] http://thread.gmane.org/gmane.comp.version-control.git/252329/
[7] http://marc.info/?t=140428115200001&r=1&w=2
[8] http://article.gmane.org/gmane.comp.version-control.git/252942/

Tanay Abhra (2):
  config-hash.c
  test-config

 .gitignore                             |   1 +
 Documentation/technical/api-config.txt | 134 +++++++++++++++
 Makefile                               |   2 +
 cache.h                                |  34 ++++
 config-hash.c                          | 295 +++++++++++++++++++++++++++++++++
 config.c                               |   3 +
 t/t1308-config-hash.sh                 | 168 +++++++++++++++++++
 test-config.c                          | 125 ++++++++++++++
 8 files changed, 762 insertions(+)
 create mode 100644 config-hash.c
 create mode 100755 t/t1308-config-hash.sh
 create mode 100644 test-config.c

-- 
1.9.0.GIT

Diff between v6 and v5:

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index bdf86d0..65a6717 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -110,7 +110,7 @@ as well as retrieval for the queried variable, including:
 `int git_config_get_int(const char *key, int *dest)`::
 
 	Finds and parses the value to an integer for the configuration variable
-	`key`. Dies on error; otherwise, stores pointer to the parsed integer in
+	`key`. Dies on error; otherwise, stores the value of the parsed integer in
 	`dest` and returns 0. When the configuration variable `key` is not found,
 	returns 1 without touching `dest`.
 
@@ -118,13 +118,13 @@ as well as retrieval for the queried variable, including:
 
 	Similar to `git_config_get_int` but for unsigned longs.
 
-`int git_config_get_int(const char *key, int *dest)`::
+`int git_config_get_bool(const char *key, int *dest)`::
 
 	Finds and parses the value into a boolean value, for the configuration
 	variable `key`respecting keywords like "true" and "false". Integer
 	values are converted into true/false values (when they are non-zero or
 	zero, respectively). Other values cause a die(). If parsing is successful,
-	stores the pointer to the parsed result in `dest` and returns 0. When the
+	stores the value of the parsed result in `dest` and returns 0. When the
 	configuration variable `key` is not found, returns 1 without touching
 	`dest`.

@@ -236,7 +236,7 @@ Configset API provides functions for the above mentioned work flow, including:
 
 `void git_configset_init(struct config_set *cs)`::
 
-	Initializes the member variables of config_set `cs`.
+	Initializes the config_set `cs`.
 
 `int git_configset_add_file(struct config_set *cs, const char *filename)`::
 
diff --git a/config-hash.c b/config-hash.c
index 4c56bd9..7cf6a96 100644
--- a/config-hash.c
+++ b/config-hash.c
@@ -5,8 +5,8 @@
 
 /*
  * Default config_set that contains key-value pairs from the usual set of config
- * config files (i.e repo specific .git/config, user wide ~/.gitconfig and the
- * global /etc/gitconfig)
+ * config files (i.e repo specific .git/config, user wide ~/.gitconfig, XDG
+ * config file and the global /etc/gitconfig)
  */
 static struct config_set the_config_set;
 
@@ -24,9 +24,12 @@ static int config_hash_entry_cmp(const struct config_hash_entry *e1,
 	return strcmp(e1->key, e2->key);
 }
 
-static void config_hash_init(struct hashmap *config_hash)
+static void configset_init(struct config_set *cs)
 {
-	hashmap_init(config_hash, (hashmap_cmp_fn)config_hash_entry_cmp, 0);
+	if (!cs->hash_initialized) {
+		hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_hash_entry_cmp, 0);
+		cs->hash_initialized = 1;
+	}
 }
 
 static int config_hash_callback(const char *key, const char *value, void *cb)
@@ -36,12 +39,10 @@ static int config_hash_callback(const char *key, const char *value, void *cb)
 	return 0;
 }
 
-static int add_configset_hash(const char *filename, struct config_set *cs)
+int git_configset_add_file(struct config_set *cs, const char *filename)
 {
 	int ret = 0;
-	if (!cs->hash_initialized)
-		config_hash_init(&cs->config_hash);
-	cs->hash_initialized = 1;
+	configset_init(cs);
 	ret = git_config_from_file(config_hash_callback, filename, cs);
 	if (!ret)
 		return 0;
@@ -59,6 +60,10 @@ static struct config_hash_entry *config_hash_find_entry(const char *key,
 	struct config_hash_entry *found_entry;
 	char *normalized_key;
 	int ret;
+	/*
+	 * `key` may come from the user, so normalize it before using it
+	 * for querying entries from the hashmap.
+	 */
 	ret = git_config_parse_key(key, &normalized_key, NULL);
 
 	if (ret)
@@ -81,7 +86,10 @@ static int config_hash_add_value(const char *key, const char *value, struct hash
 {
 	struct config_hash_entry *e;
 	e = config_hash_find_entry(key, config_hash);
-
+	/*
+	 * Since the keys are being fed by git_config*() callback mechanism, they
+	 * are already normalized. So simply add them without any further munging.
+	 */
 	if (!e) {
 		e = xmalloc(sizeof(*e));
 		hashmap_entry_init(e, strhash(key));
@@ -90,10 +98,6 @@ static int config_hash_add_value(const char *key, const char *value, struct hash
 		e->value_list.strdup_strings = 1;
 		hashmap_add(config_hash, e);
 	}
-	/*
-	 * Since the values are being fed by git_config*() callback mechanism, they
-	 * are already normalized. So simply add them without any further munging.
-	 */
 	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
 
 	return 0;
@@ -104,11 +108,6 @@ void git_configset_init(struct config_set *cs)
 	cs->hash_initialized = 0;
 }
 
-int git_configset_add_file(struct config_set *cs, const char *filename)
-{
-	return add_configset_hash(filename, cs);
-}
-
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	struct string_list *values = NULL;
@@ -138,7 +137,7 @@ void git_configset_clear(struct config_set *cs)
 	if (!cs->hash_initialized)
 		return;
 
-	hashmap_iter_init( &cs->config_hash, &iter);
+	hashmap_iter_init(&cs->config_hash, &iter);
 	while ((entry = hashmap_iter_next(&iter))) {
 		free(entry->key);
 		string_list_clear(&entry->value_list, 0);
@@ -222,8 +221,7 @@ static int git_config_check_init(void)
 	int ret = 0;
 	if (the_config_set.hash_initialized)
 		return 0;
-	config_hash_init(&the_config_set.config_hash);
-	the_config_set.hash_initialized = 1;
+	configset_init(&the_config_set);
 	ret = git_config(config_hash_callback, &the_config_set);
 	if (ret >= 0)
 		return 0;
diff --git a/t/t1308-config-hash.sh b/t/t1308-config-hash.sh
index eba7102..ad99f8b 100755
--- a/t/t1308-config-hash.sh
+++ b/t/t1308-config-hash.sh
@@ -4,11 +4,15 @@ test_description='Test git config-hash API in different settings'
 
 . ./test-lib.sh
 
-test_expect_success 'clear default config' '
-	rm -f .git/config
-'
-
-test_expect_success 'initialize default config' '
+#'check section.key value' verifies that the entry for section.key is
+#'value'
+check() {
+	echo "$2" >expected
+	test-config get_value "$1" >actual 2>&1
+	test_cmp actual expected
+}
+
+test_expect_success 'setup default config' '
 	cat >.git/config << EOF
 	[core]
 		penguin = very blue
@@ -47,71 +51,48 @@ test_expect_success 'initialize default config' '
 '
 
 test_expect_success 'get value for a simple key' '
-	echo "very blue" >expect &&
-	test-config get_value core.penguin >actual &&
-	test_cmp expect actual
+	check core.penguin "very blue"
 '
 
 test_expect_success 'get value for a key with value as an empty string' '
-	echo "" >expect &&
-	test-config get_value core.my >actual &&
-	test_cmp expect actual
+	check core.my ""
 '
 
 test_expect_success 'get value for a key with value as NULL' '
-	echo "(NULL)" >expect &&
-	test-config get_value core.foo >actual &&
-	test_cmp expect actual
+	check core.foo "(NULL)"
 '
 
 test_expect_success 'upper case key' '
-	echo "true" >expect &&
-	test-config get_value core.UPPERCASE >actual &&
-	test_cmp expect actual
+	check core.UPPERCASE "true"
 '
 
 test_expect_success 'mixed case key' '
-	echo "true" >expect &&
-	test-config get_value core.MixedCase >actual &&
-	test_cmp expect actual
+	check core.MixedCase "true"
 '
 
 test_expect_success 'key and value with mixed case' '
-	echo "BadPhysics" >expect &&
-	test-config get_value core.Movie >actual &&
-	test_cmp expect actual
+	check core.Movie "BadPhysics"
 '
 
 test_expect_success 'key with case sensitive subsection' '
-	echo "mixed-case" >expect &&
-	echo "upper-case" >>expect &&
-	echo "lower-case" >>expect &&
-	test-config get_value "my.Foo bAr.hi" >actual &&
-	test-config get_value "my.FOO BAR.hi" >>actual &&
-	test-config get_value "my.foo bar.hi" >>actual &&
-	test_cmp expect actual
+	check "my.Foo bAr.hi" "mixed-case" &&
+	check "my.FOO BAR.hi" "upper-case" &&
+	check "my.foo bar.hi" "lower-case"
 '
 
 test_expect_success 'key with case insensitive section header' '
-	echo "ball" >expect &&
-	echo "ball" >>expect &&
-	echo "ball" >>expect &&
-	test-config get_value cores.baz >actual &&
-	test-config get_value Cores.baz >>actual &&
-	test-config get_value CORES.baz >>actual &&
-	test_cmp expect actual
+	check cores.baz "ball" &&
+	check Cores.baz "ball" &&
+	check CORES.baz "ball" &&
+	check coreS.baz "ball"
 '
 
 test_expect_success 'find value with misspelled key' '
-	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
-	test_must_fail test-config get_value "my.fOo Bar.hi" >actual &&
-	test_cmp expect actual
+	check "my.fOo Bar.hi" "Value not found for \"my.fOo Bar.hi\""
 '
 
 test_expect_success 'find value with the highest priority' '
-	echo hask >expect &&
-	test-config get_value "core.baz">actual &&
-	test_cmp expect actual
+	check core.baz "hask"
 '
 
 test_expect_success 'find integer value for a key' '
diff --git a/test-config.c b/test-config.c
index 45ccd0a..dc313c2 100644
--- a/test-config.c
+++ b/test-config.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "hashmap.h"
 #include "string-list.h"
 
 /*
@@ -34,14 +33,16 @@
 
 int main(int argc, char **argv)
 {
-	int i, no_of_files;
-	int ret = 0;
+	int i, val;
 	const char *v;
-	int val;
 	const struct string_list *strptr;
 	struct config_set cs;
 	git_configset_init(&cs);
-	if (argc == 3 && !strcmp(argv[1], "get_value")) {
+
+	if (argc < 2) {
+		fprintf(stderr, "Please, provide a command name on the command-line\n");
+		return 1;
+	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
 		if (!git_config_get_value(argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
@@ -50,7 +51,7 @@ int main(int argc, char **argv)
 			return 0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return -1;
+			return 1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
 		strptr = git_config_get_value_multi(argv[2]);
@@ -65,7 +66,7 @@ int main(int argc, char **argv)
 			return 0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return -1;
+			return 1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
 		if (!git_config_get_int(argv[2], &val)) {
@@ -73,7 +74,7 @@ int main(int argc, char **argv)
 			return 0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return -1;
+			return 1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
 		if (!git_config_get_bool(argv[2], &val)) {
@@ -81,13 +82,12 @@ int main(int argc, char **argv)
 			return 0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return -1;
+			return 1;
 		}
 	} else if (!strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
-			ret = git_configset_add_file(&cs, argv[i]);
-			if (ret)
-				return -1;
+			if (git_configset_add_file(&cs, argv[i]))
+				return 2;
 		}
 		if (!git_configset_get_value(&cs, argv[2], &v)) {
 			if (!v)
@@ -97,14 +97,12 @@ int main(int argc, char **argv)
 			return 0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return -1;
+			return 1;
 		}
-
 	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
 		for (i = 3; i < argc; i++) {
-			ret = git_configset_add_file(&cs, argv[i]);
-			if (ret)
-				return -1;
+			if (git_configset_add_file(&cs, argv[i]))
+				return 2;
 		}
 		strptr = git_configset_get_value_multi(&cs, argv[2]);
 		if (strptr) {
@@ -118,7 +116,7 @@ int main(int argc, char **argv)
 			return 0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return -1;
+			return 1;
 		}
 	}
