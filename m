From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 0/4] submodule config lookup API
Date: Thu, 21 May 2015 19:06:16 +0200
Message-ID: <20150521170616.GA22979@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 19:06:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvTvZ-0004UP-8J
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbbEURG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:06:29 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:37187 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbbEURG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:06:26 -0400
Received: from [80.135.94.69] (helo=book.hvoigt.net)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YvTvJ-00028z-Vg; Thu, 21 May 2015 19:06:22 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269611>

This is finally the next iteration of the submodule config api. The last
iteration can be found here:

http://article.gmane.org/gmane.comp.version-control.git/252601

This iteration fixes the lookup of submodules by name
(submodule_from_name()) where one needed to pass in the gitmodule sha1
by mistake. To keep it simple for the user and behave as documented we
should take the commit sha1 which is now fixed here. We now also test
the lookup by name in the api tests.

This should be ready for inclusion.

Cheers Heiko

Here is the interdiff to the last iteration:

diff --git a/submodule-config.c b/submodule-config.c
index 96623ad..177767d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -25,6 +25,11 @@ struct submodule_entry {
 	struct submodule *config;
 };
 
+enum lookup_type {
+	lookup_name,
+	lookup_path,
+};
+
 static struct submodule_cache cache;
 static int is_cache_init;
 
@@ -330,8 +335,32 @@ release_return:
 	return ret;
 }
 
-static const struct submodule *config_from_path(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *path)
+static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
+				      unsigned char *gitmodules_sha1)
+{
+	struct strbuf rev = STRBUF_INIT;
+	int ret = 0;
+
+	if (is_null_sha1(commit_sha1)) {
+		hashcpy(gitmodules_sha1, null_sha1);
+		return 1;
+	}
+
+	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	if (get_sha1(rev.buf, gitmodules_sha1) >= 0)
+		ret = 1;
+
+	strbuf_release(&rev);
+	return ret;
+}
+
+/* This does a lookup of a submodule configuration by name or by path
+ * (key) with on-demand reading of the appropriate .gitmodules from
+ * revisions.
+ */
+static const struct submodule *config_from(struct submodule_cache *cache,
+		const unsigned char *commit_sha1, const char *key,
+		enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
 	unsigned long config_size;
@@ -346,7 +375,7 @@ static const struct submodule *config_from_path(struct submodule_cache *cache,
 	 * return the first submodule. Can be used to check whether
 	 * there are any submodules parsed.
 	 */
-	if (!commit_sha1 || !path) {
+	if (!commit_sha1 || !key) {
 		struct hashmap_iter iter;
 		struct submodule_entry *entry;
 
@@ -357,24 +386,27 @@ static const struct submodule *config_from_path(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (is_null_sha1(commit_sha1))
-		return cache_lookup_path(cache, null_sha1, path);
-
-	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
-	if (get_sha1(rev.buf, sha1) < 0)
-		goto free_rev;
+	if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
+		return submodule;
 
-	submodule = cache_lookup_path(cache, sha1, path);
+	switch (lookup_type) {
+		case lookup_name:
+			submodule = cache_lookup_name(cache, sha1, key);
+			break;
+		case lookup_path:
+			submodule = cache_lookup_path(cache, sha1, key);
+			break;
+	}
 	if (submodule)
-		goto free_rev;
+		return submodule;
 
 	config = read_sha1_file(sha1, &type, &config_size);
 	if (!config)
-		goto free_rev;
+		return submodule;
 
 	if (type != OBJ_BLOB) {
 		free(config);
-		goto free_rev;
+		return submodule;
 	}
 
 	/* fill the submodule config into the cache */
@@ -386,13 +418,30 @@ static const struct submodule *config_from_path(struct submodule_cache *cache,
 			&parameter);
 	free(config);
 
-	submodule = cache_lookup_path(cache, sha1, path);
+	switch (lookup_type) {
+		case lookup_name:
+			submodule = cache_lookup_name(cache, sha1, key);
+			break;
+		case lookup_path:
+			submodule = cache_lookup_path(cache, sha1, key);
+			break;
+	}
 
-free_rev:
-	strbuf_release(&rev);
 	return submodule;
 }
 
+static const struct submodule *config_from_path(struct submodule_cache *cache,
+		const unsigned char *commit_sha1, const char *path)
+{
+	return config_from(cache, commit_sha1, path, lookup_path);
+}
+
+static const struct submodule *config_from_name(struct submodule_cache *cache,
+		const unsigned char *commit_sha1, const char *name)
+{
+	return config_from(cache, commit_sha1, name, lookup_name);
+}
+
 static void ensure_cache_init(void)
 {
 	if (is_cache_init)
@@ -418,7 +467,7 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name)
 {
 	ensure_cache_init();
-	return cache_lookup_name(&cache, commit_sha1, name);
+	return config_from_name(&cache, commit_sha1, name);
 }
 
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..58afc83 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -24,6 +24,6 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
-void submodule_free(void);
+void submodule_free();
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 1ba0d64..fc97c33 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -38,7 +38,7 @@ Submodule name: 'submodule' for path 'submodule'
 Submodule name: 'submodule' for path 'submodule'
 EOF
 
-test_expect_success 'test parsing of submodule config' '
+test_expect_success 'test parsing and lookup of submodule config by path' '
 	(cd super &&
 		test-submodule-config \
 			HEAD^ a \
@@ -50,6 +50,18 @@ test_expect_success 'test parsing of submodule config' '
 	)
 '
 
+test_expect_success 'test parsing and lookup of submodule config by name' '
+	(cd super &&
+		test-submodule-config --name \
+			HEAD^ a \
+			HEAD a \
+			HEAD^ submodule \
+			HEAD submodule \
+				>actual &&
+		test_cmp expect actual
+	)
+'
+
 cat >super/expect_error <<EOF
 Submodule name: 'a' for path 'b'
 Submodule name: 'submodule' for path 'submodule'
diff --git a/test-submodule-config.c b/test-submodule-config.c
index eda356e..dab8c27 100644
--- a/test-submodule-config.c
+++ b/test-submodule-config.c
@@ -19,12 +19,15 @@ int main(int argc, char **argv)
 	char **arg = argv;
 	int my_argc = argc;
 	int output_url = 0;
+	int lookup_name = 0;
 
 	arg++;
 	my_argc--;
 	while (starts_with(arg[0], "--")) {
 		if (!strcmp(arg[0], "--url"))
 			output_url = 1;
+		if (!strcmp(arg[0], "--name"))
+			lookup_name = 1;
 		arg++;
 		my_argc--;
 	}
@@ -40,26 +43,29 @@ int main(int argc, char **argv)
 		unsigned char commit_sha1[20];
 		const struct submodule *submodule;
 		const char *commit;
-		const char *path;
+		const char *path_or_name;
 
 		commit = arg[0];
-		path = arg[1];
+		path_or_name = arg[1];
 
 		if (commit[0] == '\0')
 			hashcpy(commit_sha1, null_sha1);
 		else if (get_sha1(commit, commit_sha1) < 0)
 			die_usage(argc, argv, "Commit not found.");
 
-		submodule = submodule_from_path(commit_sha1, path);
+		if (lookup_name) {
+			submodule = submodule_from_name(commit_sha1, path_or_name);
+		} else
+			submodule = submodule_from_path(commit_sha1, path_or_name);
 		if (!submodule)
 			die_usage(argc, argv, "Submodule not found.");
 
 		if (output_url)
 			printf("Submodule url: '%s' for path '%s'\n",
-					submodule->url, path);
+					submodule->url, submodule->path);
 		else
 			printf("Submodule name: '%s' for path '%s'\n",
-					submodule->name, path);
+					submodule->name, submodule->path);
 
 		arg += 2;
 	}

Heiko Voigt (4):
  implement submodule config cache for lookup of submodule names
  extract functions for submodule config set and lookup
  use new config API for worktree configurations of submodules
  do not die on error of parsing fetchrecursesubmodules option

 .gitignore                                       |   1 +
 Documentation/technical/api-submodule-config.txt |  63 +++
 Makefile                                         |   2 +
 builtin/checkout.c                               |   1 +
 builtin/fetch.c                                  |   1 +
 diff.c                                           |   1 +
 submodule-config.c                               | 484 +++++++++++++++++++++++
 submodule-config.h                               |  29 ++
 submodule.c                                      | 122 ++----
 submodule.h                                      |   4 +-
 t/t7411-submodule-config.sh                      | 153 +++++++
 test-submodule-config.c                          |  76 ++++
 12 files changed, 839 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/technical/api-submodule-config.txt
 create mode 100644 submodule-config.c
 create mode 100644 submodule-config.h
 create mode 100755 t/t7411-submodule-config.sh
 create mode 100644 test-submodule-config.c

-- 
2.1.0.rc0.52.gaa544bf
