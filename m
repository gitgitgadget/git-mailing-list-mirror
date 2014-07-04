From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Fri, 04 Jul 2014 10:28:09 +0530
Message-ID: <53B63461.2040300@gmail.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>	<1404280905-26763-2-git-send-email-tanayabh@gmail.com> <vpqoax8m8bh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 04 06:59:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2vae-0007vV-CR
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 06:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbaGDE6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 00:58:44 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56831 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaGDE6n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 00:58:43 -0400
Received: by mail-pa0-f51.google.com with SMTP id hz1so1377811pad.10
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 21:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=T2yoReDpTeJM/QbAGCcVI8qFeIeTRBSC6bzufCQMc7o=;
        b=cs0naGthP0HB84IwMLL17PO4q49raokuIrIgu+dZ2V/8obSbBmyjrkAdiqnqPO0UxF
         UABaSZRXxzvfykReWdvE9RFbluPze2N/tOt82SiTIYk3Ge13CFEVcRGwjg+GZD2o65vN
         75VxBo4qbKXbJo8CELDZNnUuxXZHlNtJ5MKy6QDAhz/DDPFfqWd5FBakwy+9qTWopeeI
         mkfKc+D9iDJ5DuhCS6Z53+CDjj+ErE5aG/bDlGZtYcOsk3tdG6rHTx4XCJTNPtg1TH3B
         rPvuPnzkkx5jQLOBnah62tlkRya/m5XZLQ+peOPMV8z5w3/8HpUx7h2RBuRMAPlCRrbC
         W6eQ==
X-Received: by 10.70.102.10 with SMTP id fk10mr8070937pdb.111.1404449922973;
        Thu, 03 Jul 2014 21:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.221.228])
        by mx.google.com with ESMTPSA id gg3sm42758757pbc.34.2014.07.03.21.58.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Jul 2014 21:58:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqoax8m8bh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252890>

Hi,

I have cooked up a single hashmap implementation. What are your
thoughts about it? I must say it is much cleaner than the
previous attempt and it passes all the tests.
I will send the revised patch tomorrow with the corrected
documentation, till then please say so if you prefer this one
or the multi hashmap one.

Cheers,
Tanay Abhra.

-- >8 --
diff --git a/Makefile b/Makefile
index 07ea105..d503f78 100644
--- a/Makefile
+++ b/Makefile
@@ -777,6 +777,7 @@ LIB_OBJS += commit.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
+LIB_OBJS += config-hash.o
 LIB_OBJS += connect.o
 LIB_OBJS += connected.o
 LIB_OBJS += convert.o
diff --git a/cache.h b/cache.h
index df65231..2a675f6 100644
--- a/cache.h
+++ b/cache.h
@@ -7,6 +7,7 @@
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
+#include "string-list.h"

 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -1325,6 +1326,41 @@ extern int parse_config_key(const char *var,
 			    const char **subsection, int *subsection_len,
 			    const char **key);

+/* config-hash.c */
+
+struct config_set {
+	struct hashmap config_hash;
+	int hash_initialized;
+};
+
+extern struct config_set *git_configset_init(void);
+extern int git_configset_add_file(struct config_set *cs, const char *filename);
+extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
+extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
+extern void git_configset_clear(struct config_set *cs);
+extern void git_configset_iter(struct config_set *cs, config_fn_t fn, void *data);
+extern int git_configset_get_string(struct config_set *cs, const char *key, const char **dest);
+extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
+extern int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
+extern int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
+
+extern int git_config_get_value(const char *key, const char **value);
+extern const struct string_list *git_config_get_value_multi(const char *key);
+extern void git_config_clear(void);
+extern void git_config_iter(config_fn_t fn, void *data);
+extern int git_config_get_string(const char *key, const char **dest);
+extern int git_config_get_int(const char *key, int *dest);
+extern int git_config_get_ulong(const char *key, unsigned long *dest);
+extern int git_config_get_bool(const char *key, int *dest);
+extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
+extern int git_config_get_maybe_bool(const char *key, int *dest);
+extern int git_config_get_pathname(const char *key, const char **dest);
+
+
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);

diff --git a/config-hash.c b/config-hash.c
new file mode 100644
index 0000000..e12bf57
--- /dev/null
+++ b/config-hash.c
@@ -0,0 +1,325 @@
+#include "cache.h"
+#include "hashmap.h"
+#include "string-list.h"
+
+
+/*
+ * Default config_set that contains key-value pairs from the usual set of config
+ * config files (i.e repo specific .git/config, user wide ~/.gitconfig and the
+ * global /etc/gitconfig)
+ */
+static struct config_set the_config_set;
+
+struct config_hash_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
+static int config_hash_add_value(const char *, const char *, struct hashmap *);
+
+static int config_hash_entry_cmp(const struct config_hash_entry *e1,
+				 const struct config_hash_entry *e2, const void *unused)
+{
+	return strcmp(e1->key, e2->key);
+}
+
+static void config_hash_init(struct hashmap *config_hash)
+{
+	hashmap_init(config_hash, (hashmap_cmp_fn)config_hash_entry_cmp, 0);
+}
+
+static int config_hash_callback(const char *key, const char *value, void *cb)
+{
+	struct config_set *cs = cb;
+	config_hash_add_value(key, value, &cs->config_hash);
+	return 0;
+}
+
+static int add_configset_hash(const char *filename, struct config_set *cs)
+{
+	int ret = 0;
+	if (!cs->hash_initialized)
+		config_hash_init(&cs->config_hash);
+	cs->hash_initialized = 1;
+	ret = git_config_from_file(config_hash_callback, filename, cs);
+	if (!ret)
+		return 0;
+	else {
+		hashmap_free(&cs->config_hash, 1);
+		cs->hash_initialized = 0;
+		return -1;
+	}
+}
+
+static struct config_hash_entry *config_hash_find_entry(const char *key,
+							struct hashmap *config_hash)
+{
+	struct config_hash_entry k;
+	struct config_hash_entry *found_entry;
+	char *normalized_key;
+	int ret;
+	ret = git_config_parse_key(key, &normalized_key, NULL);
+
+	if (ret)
+		return NULL;
+
+	hashmap_entry_init(&k, strhash(normalized_key));
+	k.key = normalized_key;
+	found_entry = hashmap_get(config_hash, &k, NULL);
+	free(normalized_key);
+	return found_entry;
+}
+
+static struct string_list *configset_get_list(const char *key, struct config_set *cs)
+{
+	struct config_hash_entry *e = config_hash_find_entry(key, &cs->config_hash);
+	return e ? &e->value_list : NULL;
+}
+
+static int config_hash_add_value(const char *key, const char *value, struct hashmap *config_hash)
+{
+	struct config_hash_entry *e;
+	e = config_hash_find_entry(key, config_hash);
+
+	if (!e) {
+		e = xmalloc(sizeof(*e));
+		hashmap_entry_init(e, strhash(key));
+		e->key = xstrdup(key);
+		memset(&e->value_list, 0, sizeof(e->value_list));
+		e->value_list.strdup_strings = 1;
+		hashmap_add(config_hash, e);
+	}
+	/*
+	 * Since the values are being fed by git_config*() callback mechanism, they
+	 * are already normalized. So simply add them without any further munging.
+	 */
+	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+
+	return 0;
+}
+
+struct config_set *git_configset_init(void)
+{
+	struct config_set *cs = xcalloc(1, sizeof(*cs));
+	return cs;
+}
+
+int git_configset_add_file(struct config_set *cs, const char *filename)
+{
+	return add_configset_hash(filename, cs);
+}
+
+int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+{
+	struct string_list *values = NULL;
+	/*
+	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
+	 * queried key in the files of the configset the value returned will the last value
+	 * in the last matching file of the configset
+	 */
+	values = configset_get_list(key, cs);
+
+	if (!values)
+		return 1;
+	assert(values->nr > 0);
+	*value = values->items[values->nr - 1].string;
+	return 0;
+}
+
+const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+{
+	return configset_get_list(key, cs);
+}
+
+/*
+ * Uses the existing git_config() callback function signature to iterate over
+ * keys in the configset.
+ */
+void git_configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+{
+	int i;
+	char *value;
+	struct string_list *strptr;
+	struct config_hash_entry *entry;
+	struct hashmap_iter iter;
+	hashmap_iter_init(&cs->config_hash, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		strptr = &entry->value_list;
+		for (i = 0; i < strptr->nr; i++) {
+			value = strptr->items[i].string;
+			fn(entry->key, value, data);
+		}
+	}
+}
+
+void git_configset_clear(struct config_set *cs)
+{
+	struct config_hash_entry *entry;
+	struct hashmap_iter iter;
+	if (!cs->hash_initialized)
+		return;
+
+	hashmap_iter_init( &cs->config_hash, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		free(entry->key);
+		string_list_clear(&entry->value_list, 0);
+	}
+	hashmap_free(&cs->config_hash, 1);
+}
+
+int git_configset_get_string(struct config_set *cs, const char *key, const char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value))
+		return git_config_string(dest, key, value);
+	else
+		return 1;
+}
+
+int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_int(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_ulong(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_bool(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
+				int *is_bool, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_bool_or_int(key, value, is_bool);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_maybe_bool(key, value);
+		if (*dest == -1)
+			return -1;
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value))
+		return git_config_pathname(dest, key, value);
+	else
+		return 1;
+}
+
+static int git_config_check_init(void)
+{
+	int ret = 0;
+	if (the_config_set.hash_initialized)
+		return 0;
+	config_hash_init(&the_config_set.config_hash);
+	the_config_set.hash_initialized = 1;
+	ret = git_config(config_hash_callback, &the_config_set);
+	if (ret >= 0)
+		return 0;
+	else {
+		hashmap_free(&the_config_set.config_hash, 1);
+		the_config_set.hash_initialized = 0;
+		return -1;
+	}
+}
+
+int git_config_get_value(const char *key, const char **value)
+{
+	git_config_check_init();
+	return git_configset_get_value(&the_config_set, key, value);
+}
+
+const struct string_list *git_config_get_value_multi(const char *key)
+{
+	git_config_check_init();
+	return git_configset_get_value_multi(&the_config_set, key);
+}
+
+void git_config_clear(void)
+{
+	if (!the_config_set.hash_initialized)
+		return;
+	git_configset_clear(&the_config_set);
+	the_config_set.hash_initialized = 0;
+}
+
+void git_config_iter(config_fn_t fn, void *data)
+{
+	git_config_check_init();
+	git_configset_iter(&the_config_set, fn, data);
+}
+
+int git_config_get_string(const char *key, const char **dest)
+{
+	git_config_check_init();
+	return git_configset_get_string(&the_config_set, key, dest);
+}
+
+int git_config_get_int(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_int(&the_config_set, key, dest);
+}
+
+int git_config_get_ulong(const char *key, unsigned long *dest)
+{
+	git_config_check_init();
+	return git_configset_get_ulong(&the_config_set, key, dest);
+}
+
+int git_config_get_bool(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_bool(&the_config_set, key, dest);
+}
+
+int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_bool_or_int(&the_config_set, key, is_bool, dest);
+}
+
+int git_config_get_maybe_bool(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_maybe_bool(&the_config_set, key, dest);
+}
+
+int git_config_get_pathname(const char *key, const char **dest)
+{
+	git_config_check_init();
+	return git_configset_get_pathname(&the_config_set, key, dest);
+}
diff --git a/config.c b/config.c
index a1aef1c..6cffec7 100644
--- a/config.c
+++ b/config.c
@@ -1708,6 +1708,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	lock = NULL;
 	ret = 0;

+	/* Invalidate the config cache */
+	git_config_clear();
+
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-- 
1.9.0.GIT
