From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH] implement reading of submodule .gitmodules
 configuration into cache
Date: Mon, 9 Dec 2013 21:55:02 +0100
Message-ID: <20131209205501.GC9606@sandbox-ub>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
 <5294BB97.7010707@web.de>
 <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
 <9AB10474-6DEF-4FFD-B6B3-ED2AB21424AC@mac.com>
 <xmqqzjopsk9b.fsf@gitster.dls.corp.google.com>
 <20131129223845.GA31636@sandbox-ub>
 <3C71BC83-4DD0-43F8-9E36-88594CA63FC5@mac.com>
 <20131203183301.GB4629@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nick Townsend <nick.townsend@mac.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7rL-00009b-T4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933044Ab3LIUzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:55:15 -0500
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:49693 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582Ab3LIUzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:55:13 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vq7r6-0005is-Uj; Mon, 09 Dec 2013 21:55:07 +0100
Content-Disposition: inline
In-Reply-To: <20131203183301.GB4629@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239094>

This submodule configuration cache allows us to lazily read .gitmodules
configurations by commit into a runtime cache which can then be used to
easily lookup values from it. Currently only the values for path or name
are stored but it can be extended for any value needed.

This cache can be used for all purposes which need knowledge about
submodule configurations.

It is expected that .gitmodules files do not change often between
commits. Thats why we lookup the .gitmodules sha1 from a commit and then
either lookup an already parsed configuration or parse and cache an
unknown one for each sha1. The cache is lazily build on demand for each
requested commit.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Tue, Dec 03, 2013 at 07:33:01PM +0100, Heiko Voigt wrote:
> On Mon, Dec 02, 2013 at 03:55:36PM -0800, Nick Townsend wrote:
> > It seems to me that the question that you are trying to solve is
> > more complex than the problem I faced in git-archive, where we have a
> > single commit of the top-level repository that we are chasing. 
> > Perhaps we should split the work into two pieces:
> > 
> > a. Identifying the complete submodule configuration for a single commit, and
> > b. the complexity of behaviour when fetching and cloning recursively (which 
> >     of course requires a.)
> 
> You are right the latter (b) is a separate topic. So how about I extract the
> submodule config parsing part from the mentioned patch and you can then
> use that patch as a basis for your work? As far as I understand you only
> need to parse the .gitmodules file for one commit and then lookup the
> submodule names from paths right? That would simplify matters and we can
> postpone the caching of multiple commits for the time when I continue on b.

Ok and here is a patch that you can use as basis for your work. I looked
into it and found that its actually easier to use the cache. Storing
everything in a hashmap seems like overkill for your application but it
is prepared for my usecase which actually needs to parse configurations
for multiple commits.

Since this has not been discussed yet some details of my implementation
might change.

The test I implemented is only for demonstration of usage and my quick
manual testing. If we agree on going ahead with my patch I will extend
that to a proper test. Or if anyone has an idea where we can plug that
in to make a useful user interface we can also implement a test based on
that.

Cheers Heiko

 .gitignore                    |   1 +
 Makefile                      |   2 +
 submodule-config-cache.c      |  96 ++++++++++++++++++++++++++++++++
 submodule-config-cache.h      |  33 +++++++++++
 submodule.c                   | 125 ++++++++++++++++++++++++++++++++++++++++++
 submodule.h                   |   4 ++
 test-submodule-config-cache.c |  45 +++++++++++++++
 7 files changed, 306 insertions(+)
 create mode 100644 submodule-config-cache.c
 create mode 100644 submodule-config-cache.h
 create mode 100644 test-submodule-config-cache.c

diff --git a/.gitignore b/.gitignore
index 66199ed..6c91e98 100644
--- a/.gitignore
+++ b/.gitignore
@@ -200,6 +200,7 @@
 /test-sha1
 /test-sigchain
 /test-string-list
+/test-submodule-config-cache
 /test-subprocess
 /test-svn-fe
 /test-urlmatch-normalization
diff --git a/Makefile b/Makefile
index af847f8..e3d869b 100644
--- a/Makefile
+++ b/Makefile
@@ -572,6 +572,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-string-list
+TEST_PROGRAMS_NEED_X += test-submodule-config-cache
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
@@ -872,6 +873,7 @@ LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
+LIB_OBJS += submodule-config-cache.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
diff --git a/submodule-config-cache.c b/submodule-config-cache.c
new file mode 100644
index 0000000..7253fad
--- /dev/null
+++ b/submodule-config-cache.c
@@ -0,0 +1,96 @@
+#include "cache.h"
+#include "submodule-config-cache.h"
+#include "strbuf.h"
+#include "hash.h"
+
+void submodule_config_cache_init(struct submodule_config_cache *cache)
+{
+	init_hash(&cache->for_name);
+	init_hash(&cache->for_path);
+}
+
+static int free_one_submodule_config(void *ptr, void *data)
+{
+	struct submodule_config *entry = ptr;
+
+	strbuf_release(&entry->path);
+	strbuf_release(&entry->name);
+	free(entry);
+
+	return 0;
+}
+
+void submodule_config_cache_free(struct submodule_config_cache *cache)
+{
+	/* NOTE: its important to iterate over the name hash here
+	 * since paths might have multiple entries */
+	for_each_hash(&cache->for_name, free_one_submodule_config, NULL);
+	free_hash(&cache->for_path);
+	free_hash(&cache->for_name);
+}
+
+static unsigned int hash_sha1_string(const unsigned char *sha1, const char *string)
+{
+	int c;
+	unsigned int hash, string_hash = 5381;
+	memcpy(&hash, sha1, sizeof(hash));
+
+	/* djb2 hash */
+	while ((c = *string++))
+		string_hash = ((string_hash << 5) + hash) + c; /* hash * 33 + c */
+
+	return hash + string_hash;
+}
+
+void submodule_config_cache_update_path(struct submodule_config_cache *cache,
+		struct submodule_config *config)
+{
+	void **pos;
+	int hash = hash_sha1_string(config->gitmodule_sha1, config->path.buf);
+	pos = insert_hash(hash, config, &cache->for_path);
+	if (pos) {
+		config->next = *pos;
+		*pos = config;
+	}
+}
+
+void submodule_config_cache_insert(struct submodule_config_cache *cache, struct submodule_config *config)
+{
+	unsigned int hash;
+	void **pos;
+
+	hash = hash_sha1_string(config->gitmodule_sha1, config->name.buf);
+	pos = insert_hash(hash, config, &cache->for_name);
+	if (pos) {
+		config->next = *pos;
+		*pos = config;
+	}
+}
+
+struct submodule_config *submodule_config_cache_lookup_path(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *path)
+{
+	unsigned int hash = hash_sha1_string(gitmodule_sha1, path);
+	struct submodule_config *config = lookup_hash(hash, &cache->for_path);
+
+	while (config &&
+		(hashcmp(config->gitmodule_sha1, gitmodule_sha1) ||
+		 strcmp(path, config->path.buf)))
+		config = config->next;
+
+	return config;
+}
+
+struct submodule_config *submodule_config_cache_lookup_name(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *name)
+{
+	unsigned int hash = hash_sha1_string(gitmodule_sha1, name);
+	struct submodule_config *config = lookup_hash(hash, &cache->for_name);
+
+	while (config &&
+		(hashcmp(config->gitmodule_sha1, gitmodule_sha1) ||
+		 strcmp(name, config->name.buf)))
+		config = config->next;
+
+	return config;
+}
diff --git a/submodule-config-cache.h b/submodule-config-cache.h
new file mode 100644
index 0000000..7bb79b9
--- /dev/null
+++ b/submodule-config-cache.h
@@ -0,0 +1,33 @@
+#ifndef SUBMODULE_CONFIG_CACHE_H
+#define SUBMODULE_CONFIG_CACHE_H
+
+#include "hash.h"
+#include "strbuf.h"
+
+struct submodule_config_cache {
+	struct hash_table for_path;
+	struct hash_table for_name;
+};
+
+/* one submodule_config_cache entry */
+struct submodule_config {
+	struct strbuf path;
+	struct strbuf name;
+	unsigned char gitmodule_sha1[20];
+	struct submodule_config *next;
+};
+
+void submodule_config_cache_init(struct submodule_config_cache *cache);
+void submodule_config_cache_free(struct submodule_config_cache *cache);
+
+void submodule_config_cache_update_path(struct submodule_config_cache *cache,
+		struct submodule_config *config);
+void submodule_config_cache_insert(struct submodule_config_cache *cache,
+		struct submodule_config *config);
+
+struct submodule_config *submodule_config_cache_lookup_path(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *path);
+struct submodule_config *submodule_config_cache_lookup_name(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *name);
+
+#endif /* SUBMODULE_CONFIG_CACHE_H */
diff --git a/submodule.c b/submodule.c
index 1905d75..fa9e7ea 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "submodule.h"
+#include "submodule-config-cache.h"
 #include "dir.h"
 #include "diff.h"
 #include "commit.h"
@@ -616,6 +617,130 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 	return is_present;
 }
 
+struct parse_submodule_config_parameter {
+	unsigned char *gitmodule_sha1;
+	struct submodule_config_cache *cache;
+};
+
+static int name_and_item_from_var(const char *var, struct strbuf *name, struct strbuf *item)
+{
+	/* find the name and add it */
+	strbuf_addstr(name, var + strlen("submodule."));
+	char *end = strrchr(name->buf, '.');
+	if (!end) {
+		strbuf_release(name);
+		return 0;
+	}
+	*end = '\0';
+	if (((end + 1) - name->buf) < name->len)
+		strbuf_addstr(item, end + 1);
+
+	return 1;
+}
+
+static struct submodule_config *lookup_or_create_by_name(struct submodule_config_cache *cache,
+		unsigned char *gitmodule_sha1, const char *name)
+{
+	struct submodule_config *config;
+	config = submodule_config_cache_lookup_name(cache, gitmodule_sha1, name);
+	if (config)
+		return config;
+
+	config = xmalloc(sizeof(*config));
+
+	strbuf_init(&config->name, 1024);
+	strbuf_addstr(&config->name, name);
+
+	strbuf_init(&config->path, 1024);
+
+	hashcpy(config->gitmodule_sha1, gitmodule_sha1);
+	config->next = NULL;
+
+	submodule_config_cache_insert(cache, config);
+
+	return config;
+}
+
+static void warn_multiple_config(struct submodule_config *config, const char *option)
+{
+	warning("%s:.gitmodules, multiple configurations found for submodule.%s.%s. "
+			"Skipping second one!", sha1_to_hex(config->gitmodule_sha1),
+			option, config->name.buf);
+}
+
+static int parse_submodule_config_into_cache(const char *var, const char *value, void *data)
+{
+	struct parse_submodule_config_parameter *me = data;
+	struct submodule_config *submodule_config;
+	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
+
+	/* We only read submodule.<name> entries */
+	if (prefixcmp(var, "submodule."))
+		return 0;
+
+	if (!name_and_item_from_var(var, &name, &item))
+		return 0;
+
+	submodule_config = lookup_or_create_by_name(me->cache, me->gitmodule_sha1, name.buf);
+
+	if (!suffixcmp(var, ".path")) {
+		if (*submodule_config->path.buf != '\0') {
+			warn_multiple_config(submodule_config, "path");
+			return 0;
+		}
+		strbuf_addstr(&submodule_config->path, value);
+		submodule_config_cache_update_path(me->cache, submodule_config);
+	}
+
+	strbuf_release(&name);
+	strbuf_release(&item);
+
+	return 0;
+}
+
+struct submodule_config *get_submodule_config_for_commit_path(struct submodule_config_cache *cache,
+		const unsigned char *commit_sha1, const char *path)
+{
+	struct strbuf rev = STRBUF_INIT;
+	unsigned long config_size;
+	char *config;
+	unsigned char sha1[20];
+	enum object_type type;
+	struct submodule_config *submodule_config = NULL;
+	struct parse_submodule_config_parameter parameter;
+
+
+	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	if (get_sha1(rev.buf, sha1) < 0)
+		goto free_rev;
+
+	submodule_config = submodule_config_cache_lookup_path(cache, sha1, path);
+	if (submodule_config)
+		goto free_rev;
+
+	config = read_sha1_file(sha1, &type, &config_size);
+	if (!config)
+		goto free_rev;
+
+	if (type != OBJ_BLOB) {
+		free(config);
+		goto free_rev;
+	}
+
+	/* fill the submodule config into the cache */
+	parameter.cache = cache;
+	parameter.gitmodule_sha1 = sha1;
+	git_config_from_buf(parse_submodule_config_into_cache, rev.buf,
+			config, config_size, &parameter);
+	free(config);
+
+	submodule_config = submodule_config_cache_lookup_path(cache, sha1, path);
+
+free_rev:
+	strbuf_release(&rev);
+	return submodule_config;
+}
+
 static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
diff --git a/submodule.h b/submodule.h
index 7beec48..a26cc34 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,6 +3,8 @@
 
 struct diff_options;
 struct argv_array;
+struct submodule_config;
+struct submodule_config_cache;
 
 enum {
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
@@ -41,5 +43,7 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+struct submodule_config *get_submodule_config_for_commit_path(struct submodule_config_cache *cache,
+		const unsigned char *commit_sha1, const char *path);
 
 #endif
diff --git a/test-submodule-config-cache.c b/test-submodule-config-cache.c
new file mode 100644
index 0000000..239560f
--- /dev/null
+++ b/test-submodule-config-cache.c
@@ -0,0 +1,45 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "cache.h"
+#include "submodule-config-cache.h"
+#include "submodule.h"
+
+static void die_usage(int argc, char **argv, const char *msg)
+{
+	fprintf(stderr, "%s\n", msg);
+	fprintf(stderr, "Usage: %s <commit> <submodulepath>\n", argv[0]);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	struct submodule_config_cache submodule_config_cache;
+	struct submodule_config *submodule_config;
+	unsigned char commit_sha1[20];
+	const char *commit;
+	const char *path;
+
+	if (argc < 3)
+		die_usage(argc, argv, "Wrong number of arguments.");
+
+	commit = argv[1];
+	path = argv[2];
+
+	if (get_sha1(commit, commit_sha1) < 0)
+		die_usage(argc, argv, "Commit not found.");
+
+	submodule_config_cache_init(&submodule_config_cache);
+
+	submodule_config = get_submodule_config_for_commit_path(&submodule_config_cache,
+				commit_sha1, path);
+	if (!submodule_config)
+		die_usage(argc, argv, "Submodule config not found.");
+
+	printf("Submodule name: '%s' for path '%s'\n", submodule_config->name.buf, path);
+
+	submodule_config_cache_free(&submodule_config_cache);
+
+	return 0;
+}
-- 
1.8.5.1.21.gee0ea2e
